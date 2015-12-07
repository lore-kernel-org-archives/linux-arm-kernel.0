From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Tue, 8 Dec 2015 00:38:17 +0100
Subject: [PATCH v5 06/11] spi: imx: return error from dma channel request
In-Reply-To: <20151207093236.GB11966@pengutronix.de>
References: <1449334629-4715-1-git-send-email-anton.bondarenko.sama@gmail.com>
 <1449334629-4715-7-git-send-email-anton.bondarenko.sama@gmail.com>
 <20151207093236.GB11966@pengutronix.de>
Message-ID: <56661869.5090503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015-12-07 10:32, Sascha Hauer wrote:
> On Sat, Dec 05, 2015 at 05:57:04PM +0100, Anton Bondarenko wrote:
>> On SDMA initialization return exactly the same error, which is
>> reported by dma_request_slave_channel_reason(), it is a preceding
>> change to defer SPI DMA initialization, if SDMA module is not yet
>> available.
>>
>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>> Signed-off-by: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
>> ---
>>   drivers/spi/spi-imx.c | 27 ++++++++++++++++-----------
>>   1 file changed, 16 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
>> index 3525616..277dd75 100644
>> --- a/drivers/spi/spi-imx.c
>> +++ b/drivers/spi/spi-imx.c
>> @@ -846,10 +846,11 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
>>   	spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2;
>>
>>   	/* Prepare for TX DMA: */
>> -	master->dma_tx = dma_request_slave_channel(dev, "tx");
>> -	if (!master->dma_tx) {
>> -		dev_err(dev, "cannot get the TX DMA channel!\n");
>> -		ret = -EINVAL;
>> +	master->dma_tx = dma_request_slave_channel_reason(dev, "tx");
>> +	if (IS_ERR(master->dma_tx)) {
>> +		dev_info(dev, "cannot get the TX DMA channel!\n");
>
> When changing it can you add the error code to the message? That's
> usually the next thing one wants to know when reading it. Also, isn't
> dev_dbg enough here? Otherwise the driver gets really verbose when it
> actually defers probe.
>
> Sascha
>

Agreed. But the error from spi_imx_sdma_init printed in probe. Anyway, 
I've changed the code as requested in upcoming series V6.

Regards, Anton
