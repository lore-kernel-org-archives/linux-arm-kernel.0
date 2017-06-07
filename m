From: jiada_wang@mentor.com (Jiada Wang)
Date: Wed, 7 Jun 2017 01:51:24 -0700
Subject: [PATCH linux-next v4 4/4] spi: imx: Add support for SPI Slave mode
In-Reply-To: <20170607084125.3eizzs6c773xjssi@pengutronix.de>
References: <20170605033809.13726-1-jiada_wang@mentor.com>
 <20170605033809.13726-5-jiada_wang@mentor.com>
 <20170607084125.3eizzs6c773xjssi@pengutronix.de>
Message-ID: <5937BE8C.307@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha

On 06/07/2017 01:41 AM, Sascha Hauer wrote:
> On Mon, Jun 05, 2017 at 12:38:09PM +0900, Jiada Wang wrote:
>> Previously i.MX SPI controller only works in Master mode.
>> This patch adds support to i.MX51, i.MX53 and i.MX6 ECSPI
>> controller to work also in Slave mode.
>>
>> Currently SPI Slave mode support patch has the following limitations:
>> 1. The stale data in RXFIFO will be dropped when the Slave does any new
>>     transfer.
>> 2. One transfer can be finished only after all transfer->len data been
>>     transferred to master device
>> 3. Slave device only accepts transfer->len data. Any data longer than this
>>     from master device will be dropped. Any data shorter than this from
>>     master will cause SPI to stuck due to mentioned HW limitation 2.
>> 4. Only PIO transfer is supported in Slave mode.
>>
>> Following HW limitation applies:
>> 1.  ECSPI has a HW issue when works in Slave mode, after 64
>>      words written to TXFIFO, even TXFIFO becomes empty,
>>      ECSPI_TXDATA keeps shift out the last word data,
>>      so we have to disable ECSPI when in slave mode after the
>>      transfer completes
>> 2.  Due to Freescale errata ERR003775 "eCSPI: Burst completion by Chip
>>      Select (SS) signal in Slave mode is not functional" burst size must
>>      be set exactly to the size of the transfer. This limit SPI transaction
>>      with maximum 2^12 bits. This errata affects i.MX53 and i.MX6 ECSPI
>>      controllers.
>>
>> Signed-off-by: Jiada Wang<jiada_wang@mentor.com>
>> ---
>>   drivers/spi/spi-imx.c | 228 +++++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 198 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
>> index 5034f89..3db3809 100644
>> --- a/drivers/spi/spi-imx.c
>> +++ b/drivers/spi/spi-imx.c
>> @@ -53,9 +53,13 @@
>>   /* generic defines to abstract from the different register layouts */
>>   #define MXC_INT_RR	(1<<  0) /* Receive data ready interrupt */
>>   #define MXC_INT_TE	(1<<  1) /* Transmit FIFO empty interrupt */
>> +#define MXC_INT_RDR	BIT(4) /* Receive date threshold interrupt */
>>
>>   /* The maximum  bytes that a sdma BD can transfer.*/
>>   #define MAX_SDMA_BD_BYTES  (1<<  15)
>> +/* The maximum bytes that IMX53_ECSPI can transfer in slave mode.*/
>> +#define MX53_MAX_TRANSFER_BYTES		512
>> +
>>   struct spi_imx_config {
>>   	unsigned int speed_hz;
>>   	unsigned int bpw;
>> @@ -79,7 +83,9 @@ struct spi_imx_devtype_data {
>>   	void (*trigger)(struct spi_imx_data *);
>>   	int (*rx_available)(struct spi_imx_data *);
>>   	void (*reset)(struct spi_imx_data *);
>> +	void (*disable)(struct spi_imx_data *);
>>   	bool has_dmamode;
>> +	bool has_slavemode;
>>   	unsigned int fifo_size;
>>   	enum spi_imx_devtype devtype;
>>   };
>> @@ -107,6 +113,11 @@ struct spi_imx_data {
>>   	const void *tx_buf;
>>   	unsigned int txfifo; /* number of words pushed in tx FIFO */
>>
>> +	/* Slave mode */
>> +	bool slave_mode;
>> +	bool slave_aborted;
>> +	unsigned int slave_burst;
>> +
>>   	/* DMA */
>>   	bool usedma;
>>   	u32 wml;
>> @@ -223,6 +234,9 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
>>   	if (!transfer)
>>   		return false;
>>
>> +	if (spi_imx->slave_mode)
>> +		return false;
>> +
>>   	bpw = transfer->bits_per_word;
>>   	if (!bpw)
>>   		bpw = spi->bits_per_word;
>> @@ -266,6 +280,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
>>   #define MX51_ECSPI_INT		0x10
>>   #define MX51_ECSPI_INT_TEEN		(1<<   0)
>>   #define MX51_ECSPI_INT_RREN		(1<<   3)
>> +#define MX51_ECSPI_INT_RDREN		(1<<   4)
>>
>>   #define MX51_ECSPI_DMA      0x14
>>   #define MX51_ECSPI_DMA_TX_WML(wml)	((wml)&  0x3f)
>> @@ -282,6 +297,46 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
>>   #define MX51_ECSPI_TESTREG	0x20
>>   #define MX51_ECSPI_TESTREG_LBC	BIT(31)
>>
>> +static void mx53_ecspi_rx_slave(struct spi_imx_data *spi_imx)
>> +{
>> +	u32 val = be32_to_cpu(readl(spi_imx->base + MXC_CSPIRXDATA));
>> +
>> +	if (spi_imx->rx_buf) {
>> +		int n_bytes = spi_imx->slave_burst % sizeof(val);
>> +
>> +		if (n_bytes) {
>> +			memcpy(spi_imx->rx_buf,
>> +			       ((u8 *)&val) + sizeof(val) - n_bytes, n_bytes);
>> +		} else {
>> +			*((u32 *)spi_imx->rx_buf) = val;
>> +			n_bytes = sizeof(val);
>> +		}
>> +
>> +		spi_imx->rx_buf += n_bytes;
>> +		spi_imx->slave_burst -= n_bytes;
>> +	}
>> +}
> You can do the same optimization you have done for mx53_ecspi_tx_slave()
> for mx53_ecspi_rx_slave() aswell.
>
> Otherwise the patch looks fine to me now.
I will submit updated patch set after rebase to have your latest change
to spi-imx.

Thanks,
Jiada

>
> Sascha
>
>
