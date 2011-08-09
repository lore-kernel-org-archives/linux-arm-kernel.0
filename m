From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Tue, 9 Aug 2011 09:43:32 +0530
Subject: [PATCH 12/15] spi/s3c64xx: Add support DMA engine API
In-Reply-To: <CABb+yY3-d0xTO+s0cCPXPW8qGpTH5G2U+bp-0z4Se47eVvJ__w@mail.gmail.com>
References: <1311744697-10264-1-git-send-email-boojin.kim@samsung.com>
	<1311744697-10264-13-git-send-email-boojin.kim@samsung.com>
	<CABb+yY3-d0xTO+s0cCPXPW8qGpTH5G2U+bp-0z4Se47eVvJ__w@mail.gmail.com>
Message-ID: <CAGOxZ53BRa1=Bnb==jNg_dD0XT2pMSPo=QoHF++LnT6r5kO_Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 8, 2011 at 11:17 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Wed, Jul 27, 2011 at 11:01 AM, Boojin Kim <boojin.kim@samsung.com> wrote:
>> This patch adds to support DMA generic API to transfer raw
>> SPI data. Basiclly the spi driver uses DMA generic API if
>> architecture supports it. Otherwise, uses Samsung specific
>> S3C-PL330 APIs.
>>
>> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>> ---
>> ?drivers/spi/spi_s3c64xx.c | ?141 ++++++++++++++++++++++-----------------------
>> ?1 files changed, 69 insertions(+), 72 deletions(-)
>>
>> diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
>> index 8945e20..a4cf76a 100644
>> --- a/drivers/spi/spi_s3c64xx.c
>> +++ b/drivers/spi/spi_s3c64xx.c
>> @@ -172,6 +172,9 @@ struct s3c64xx_spi_driver_data {
>> ? ? ? ?unsigned ? ? ? ? ? ? ? ? ? ? ? ?state;
>> ? ? ? ?unsigned ? ? ? ? ? ? ? ? ? ? ? ?cur_mode, cur_bpw;
>> ? ? ? ?unsigned ? ? ? ? ? ? ? ? ? ? ? ?cur_speed;
>> + ? ? ? unsigned ? ? ? ? ? ? ? ? ? ? ? ?rx_ch;
>> + ? ? ? unsigned ? ? ? ? ? ? ? ? ? ? ? ?tx_ch;
>> + ? ? ? struct samsung_dma_ops ? ? ? ? ?*ops;
>> ?};
>>
>> ?static struct s3c2410_dma_client s3c64xx_spi_dma_client = {
>> @@ -227,6 +230,38 @@ static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
>> ? ? ? ?writel(val, regs + S3C64XX_SPI_CH_CFG);
>> ?}
>>
>> +static void s3c64xx_spi_dma_rxcb(void *data)
>> +{
>> + ? ? ? struct s3c64xx_spi_driver_data *sdd
>> + ? ? ? ? ? ? ? = (struct s3c64xx_spi_driver_data *)data;
> void* doesn't need typecasting (same for all such occurances)
> IIRC someone already pointed it out?
>
>
>> + ? ? ? unsigned long flags;
>> +
>> + ? ? ? spin_lock_irqsave(&sdd->lock, flags);
>> +
>> + ? ? ? sdd->state &= ~RXBUSY;
>> + ? ? ? /* If the other done */
>> + ? ? ? if (!(sdd->state & TXBUSY))
>> + ? ? ? ? ? ? ? complete(&sdd->xfer_completion);
>> +
>> + ? ? ? spin_unlock_irqrestore(&sdd->lock, flags);
>> +}
>> +
>> +static void s3c64xx_spi_dma_txcb(void *data)
>> +{
>> + ? ? ? struct s3c64xx_spi_driver_data *sdd
>> + ? ? ? ? ? ? ? = (struct s3c64xx_spi_driver_data *)data;
>> + ? ? ? unsigned long flags;
>> +
>> + ? ? ? spin_lock_irqsave(&sdd->lock, flags);
>> +
>> + ? ? ? sdd->state &= ~TXBUSY;
>> + ? ? ? /* If the other done */
>> + ? ? ? if (!(sdd->state & RXBUSY))
>> + ? ? ? ? ? ? ? complete(&sdd->xfer_completion);
>> +
>> + ? ? ? spin_unlock_irqrestore(&sdd->lock, flags);
>> +}
>> +
>> ?static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct spi_device *spi,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct spi_transfer *xfer, int dma_mode)
>> @@ -234,6 +269,7 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
>> ? ? ? ?struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
>> ? ? ? ?void __iomem *regs = sdd->regs;
>> ? ? ? ?u32 modecfg, chcfg;
>> + ? ? ? struct samsung_dma_prep_info info;
>>
>> ? ? ? ?modecfg = readl(regs + S3C64XX_SPI_MODE_CFG);
>> ? ? ? ?modecfg &= ~(S3C64XX_SPI_MODE_TXDMA_ON | S3C64XX_SPI_MODE_RXDMA_ON);
>> @@ -259,10 +295,14 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
>> ? ? ? ? ? ? ? ?chcfg |= S3C64XX_SPI_CH_TXCH_ON;
>> ? ? ? ? ? ? ? ?if (dma_mode) {
>> ? ? ? ? ? ? ? ? ? ? ? ?modecfg |= S3C64XX_SPI_MODE_TXDMA_ON;
>> - ? ? ? ? ? ? ? ? ? ? ? s3c2410_dma_config(sdd->tx_dmach, sdd->cur_bpw / 8);
>> - ? ? ? ? ? ? ? ? ? ? ? s3c2410_dma_enqueue(sdd->tx_dmach, (void *)sdd,
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? xfer->tx_dma, xfer->len);
>> - ? ? ? ? ? ? ? ? ? ? ? s3c2410_dma_ctrl(sdd->tx_dmach, S3C2410_DMAOP_START);
>> + ? ? ? ? ? ? ? ? ? ? ? info.cap = DMA_SLAVE;
>> + ? ? ? ? ? ? ? ? ? ? ? info.direction = DMA_TO_DEVICE;
>> + ? ? ? ? ? ? ? ? ? ? ? info.buf = xfer->tx_dma;
>> + ? ? ? ? ? ? ? ? ? ? ? info.len = xfer->len;
>> + ? ? ? ? ? ? ? ? ? ? ? info.fp = s3c64xx_spi_dma_txcb;
>> + ? ? ? ? ? ? ? ? ? ? ? info.fp_param = sdd;
>> + ? ? ? ? ? ? ? ? ? ? ? sdd->ops->prepare(sdd->tx_ch, &info);
>> + ? ? ? ? ? ? ? ? ? ? ? sdd->ops->trigger(sdd->tx_ch);
>> ? ? ? ? ? ? ? ?} else {
>> ? ? ? ? ? ? ? ? ? ? ? ?switch (sdd->cur_bpw) {
>> ? ? ? ? ? ? ? ? ? ? ? ?case 32:
>> @@ -294,10 +334,14 @@ static void enable_datapath(struct s3c64xx_spi_driver_data *sdd,
>> ? ? ? ? ? ? ? ? ? ? ? ?writel(((xfer->len * 8 / sdd->cur_bpw) & 0xffff)
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| S3C64XX_SPI_PACKET_CNT_EN,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?regs + S3C64XX_SPI_PACKET_CNT);
>> - ? ? ? ? ? ? ? ? ? ? ? s3c2410_dma_config(sdd->rx_dmach, sdd->cur_bpw / 8);
>> - ? ? ? ? ? ? ? ? ? ? ? s3c2410_dma_enqueue(sdd->rx_dmach, (void *)sdd,
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? xfer->rx_dma, xfer->len);
>> - ? ? ? ? ? ? ? ? ? ? ? s3c2410_dma_ctrl(sdd->rx_dmach, S3C2410_DMAOP_START);
>> + ? ? ? ? ? ? ? ? ? ? ? info.cap = DMA_SLAVE;
>> + ? ? ? ? ? ? ? ? ? ? ? info.direction = DMA_FROM_DEVICE;
>> + ? ? ? ? ? ? ? ? ? ? ? info.buf = xfer->rx_dma;
>> + ? ? ? ? ? ? ? ? ? ? ? info.len = xfer->len;
>> + ? ? ? ? ? ? ? ? ? ? ? info.fp = s3c64xx_spi_dma_rxcb;
>> + ? ? ? ? ? ? ? ? ? ? ? info.fp_param = sdd;
>> + ? ? ? ? ? ? ? ? ? ? ? sdd->ops->prepare(sdd->rx_ch, &info);
>> + ? ? ? ? ? ? ? ? ? ? ? sdd->ops->trigger(sdd->rx_ch);
>> ? ? ? ? ? ? ? ?}
>> ? ? ? ?}
>>
>> @@ -483,46 +527,6 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
>> ? ? ? ?}
>> ?}
>>
>> -static void s3c64xx_spi_dma_rxcb(struct s3c2410_dma_chan *chan, void *buf_id,
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?int size, enum s3c2410_dma_buffresult res)
>> -{
>> - ? ? ? struct s3c64xx_spi_driver_data *sdd = buf_id;
>> - ? ? ? unsigned long flags;
>> -
>> - ? ? ? spin_lock_irqsave(&sdd->lock, flags);
>> -
>> - ? ? ? if (res == S3C2410_RES_OK)
>> - ? ? ? ? ? ? ? sdd->state &= ~RXBUSY;
>> - ? ? ? else
>> - ? ? ? ? ? ? ? dev_err(&sdd->pdev->dev, "DmaAbrtRx-%d\n", size);
>> -
>> - ? ? ? /* If the other done */
>> - ? ? ? if (!(sdd->state & TXBUSY))
>> - ? ? ? ? ? ? ? complete(&sdd->xfer_completion);
>> -
>> - ? ? ? spin_unlock_irqrestore(&sdd->lock, flags);
>> -}
>> -
>> -static void s3c64xx_spi_dma_txcb(struct s3c2410_dma_chan *chan, void *buf_id,
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?int size, enum s3c2410_dma_buffresult res)
>> -{
>> - ? ? ? struct s3c64xx_spi_driver_data *sdd = buf_id;
>> - ? ? ? unsigned long flags;
>> -
>> - ? ? ? spin_lock_irqsave(&sdd->lock, flags);
>> -
>> - ? ? ? if (res == S3C2410_RES_OK)
>> - ? ? ? ? ? ? ? sdd->state &= ~TXBUSY;
>> - ? ? ? else
>> - ? ? ? ? ? ? ? dev_err(&sdd->pdev->dev, "DmaAbrtTx-%d \n", size);
>> -
>> - ? ? ? /* If the other done */
>> - ? ? ? if (!(sdd->state & RXBUSY))
>> - ? ? ? ? ? ? ? complete(&sdd->xfer_completion);
>> -
>> - ? ? ? spin_unlock_irqrestore(&sdd->lock, flags);
>> -}
>> -
>> ?#define XFER_DMAADDR_INVALID DMA_BIT_MASK(32)
>>
>> ?static int s3c64xx_spi_map_mssg(struct s3c64xx_spi_driver_data *sdd,
>> @@ -697,12 +701,10 @@ static void handle_msg(struct s3c64xx_spi_driver_data *sdd,
>> ? ? ? ? ? ? ? ? ? ? ? ?if (use_dma) {
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?if (xfer->tx_buf != NULL
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?&& (sdd->state & TXBUSY))
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? s3c2410_dma_ctrl(sdd->tx_dmach,
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? S3C2410_DMAOP_FLUSH);
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? sdd->ops->stop(sdd->tx_ch);
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?if (xfer->rx_buf != NULL
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?&& (sdd->state & RXBUSY))
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? s3c2410_dma_ctrl(sdd->rx_dmach,
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? S3C2410_DMAOP_FLUSH);
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? sdd->ops->stop(sdd->rx_ch);
>> ? ? ? ? ? ? ? ? ? ? ? ?}
>>
>> ? ? ? ? ? ? ? ? ? ? ? ?goto out;
>> @@ -742,24 +744,19 @@ out:
>>
>> ?static int acquire_dma(struct s3c64xx_spi_driver_data *sdd)
>> ?{
>> - ? ? ? if (s3c2410_dma_request(sdd->rx_dmach,
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &s3c64xx_spi_dma_client, NULL) < 0) {
>> - ? ? ? ? ? ? ? dev_err(&sdd->pdev->dev, "cannot get RxDMA\n");
>> - ? ? ? ? ? ? ? return 0;
>> - ? ? ? }
>> - ? ? ? s3c2410_dma_set_buffdone_fn(sdd->rx_dmach, s3c64xx_spi_dma_rxcb);
>> - ? ? ? s3c2410_dma_devconfig(sdd->rx_dmach, S3C2410_DMASRC_HW,
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? sdd->sfr_start + S3C64XX_SPI_RX_DATA);
>> -
>> - ? ? ? if (s3c2410_dma_request(sdd->tx_dmach,
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &s3c64xx_spi_dma_client, NULL) < 0) {
>> - ? ? ? ? ? ? ? dev_err(&sdd->pdev->dev, "cannot get TxDMA\n");
>> - ? ? ? ? ? ? ? s3c2410_dma_free(sdd->rx_dmach, &s3c64xx_spi_dma_client);
>> - ? ? ? ? ? ? ? return 0;
>> - ? ? ? }
>> - ? ? ? s3c2410_dma_set_buffdone_fn(sdd->tx_dmach, s3c64xx_spi_dma_txcb);
>> - ? ? ? s3c2410_dma_devconfig(sdd->tx_dmach, S3C2410_DMASRC_MEM,
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? sdd->sfr_start + S3C64XX_SPI_TX_DATA);
>> +
>> + ? ? ? struct samsung_dma_info info;
>> + ? ? ? sdd->ops = samsung_dma_get_ops();
>> +
>> + ? ? ? info.cap = DMA_SLAVE;
>> + ? ? ? info.client = &s3c64xx_spi_dma_client;
>> + ? ? ? info.direction = DMA_FROM_DEVICE;
>> + ? ? ? info.fifo = sdd->sfr_start + S3C64XX_SPI_RX_DATA;
>> + ? ? ? info.width = sdd->cur_bpw / 8;
>> + ? ? ? sdd->rx_ch = sdd->ops->request(sdd->rx_dmach, &info);
>> + ? ? ? info.direction = DMA_TO_DEVICE;
>> + ? ? ? info.fifo = sdd->sfr_start + S3C64XX_SPI_TX_DATA;
>> + ? ? ? sdd->tx_ch = sdd->ops->request(sdd->tx_dmach, &info);
>>
>> ? ? ? ?return 1;
>> ?}
>> @@ -800,8 +797,8 @@ static void s3c64xx_spi_work(struct work_struct *work)
>> ? ? ? ?spin_unlock_irqrestore(&sdd->lock, flags);
>>
>> ? ? ? ?/* Free DMA channels */
>> - ? ? ? s3c2410_dma_free(sdd->tx_dmach, &s3c64xx_spi_dma_client);
>> - ? ? ? s3c2410_dma_free(sdd->rx_dmach, &s3c64xx_spi_dma_client);
>> + ? ? ? sdd->ops->release(sdd->rx_ch, &s3c64xx_spi_dma_client);
>> + ? ? ? sdd->ops->release(sdd->tx_ch, &s3c64xx_spi_dma_client);
>> ?}
>
> Btw, this spi driver is for S3C64xx(with pl080) and S5P(with pl330)
> series, both of which
> have DMAENGINE drivers. May be it could be directly switched to using
> those, rather than
> via Samsung's wrapper driver.
> Or am I overlooking something ?
Exactly, spi_s3c64xx.c (including Sound driver) can not be used with
pl080 and pl330 (DMAENGINE drivers) as it is.
Recently I was trying to use PL080 DMAENGINE driver, and i was ended
up using some #ifdef in the spi driver.
something like
#ifdef CONFIG_PL080
sdd->tx_dmac.bus_id = dmatx_res->name;
sdd->rx_dmac.bus_id = dmarx_res->name;
#else
sdd->tx_dmac.bus_id = dmatx_res->start;
sdd->tx_dmac.bus_id = dmatx_res->start;
#endif

This is because, Pl080 handle the channel as a char *(name) and pl330
expect the channel to be enum (a number).

I think the solution could be changes in the either of these drivers
to follow some symmetry or we will be ending up with
two client driver for the same device or writing up some unnecessary
warper code or finally using some #ifdef.

Please suggest if you guys have any other idea/approach to handle such
kind of situation.

Below is the git diff of spi_s3c64xx driver using with PL080 DMAENGINE driver.
This patch is against kgene's next-samsung-dma-v4
------------------------------------------------------------------------------------------------------------------
diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
index a4cf76a..f7b9c37 100644
--- a/drivers/spi/spi_s3c64xx.c
+++ b/drivers/spi/spi_s3c64xx.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
+#include <linux/amba/pl08x.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>

@@ -165,8 +166,13 @@ struct s3c64xx_spi_driver_data {
 	struct work_struct              work;
 	struct list_head                queue;
 	spinlock_t                      lock;
+#ifdef CONFIG_DMADEV_PL080
+	struct pl08x_channel_data	rx_dmach;
+	struct pl08x_channel_data	tx_dmach;
+#else
 	enum dma_ch                     rx_dmach;
 	enum dma_ch                     tx_dmach;
+#endif
 	unsigned long                   sfr_start;
 	struct completion               xfer_completion;
 	unsigned                        state;
@@ -753,10 +759,18 @@ static int acquire_dma(struct
s3c64xx_spi_driver_data *sdd)
 	info.direction = DMA_FROM_DEVICE;
 	info.fifo = sdd->sfr_start + S3C64XX_SPI_RX_DATA;
 	info.width = sdd->cur_bpw / 8;
+#ifdef CONFIG_DMADEV_PL080
+	sdd->rx_ch = sdd->ops->request(sdd->rx_dmach.bus_id, &info);
+#else
 	sdd->rx_ch = sdd->ops->request(sdd->rx_dmach, &info);
+#endif
 	info.direction = DMA_TO_DEVICE;
 	info.fifo = sdd->sfr_start + S3C64XX_SPI_TX_DATA;
-	sdd->tx_ch = sdd->ops->request(sdd->tx_dmach, &info);
+#ifdef CONFIG_DMADEV_PL080
+	sdd->tx_ch = sdd->ops->request(sdd->tx_dmach.bus_id, &info);
+#else
+		sdd->tx_ch = sdd->ops->request(sdd->tx_dmach, &info);
+#endif

 	return 1;
 }
@@ -982,7 +996,6 @@ static int __init s3c64xx_spi_probe(struct
platform_device *pdev)
 	}

 	/* Check for availability of necessary resource */
-
 	dmatx_res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (dmatx_res == NULL) {
 		dev_err(&pdev->dev, "Unable to get SPI-Tx dma resource\n");
@@ -1015,9 +1028,13 @@ static int __init s3c64xx_spi_probe(struct
platform_device *pdev)
 	sdd->cntrlr_info = sci;
 	sdd->pdev = pdev;
 	sdd->sfr_start = mem_res->start;
+#ifdef CONFIG_DMADEV_PL080
+	sdd->tx_dmach.bus_id = dmatx_res->name;
+	sdd->rx_dmach.bus_id = dmarx_res->name;
+#else
 	sdd->tx_dmach = dmatx_res->start;
 	sdd->rx_dmach = dmarx_res->start;
-
+#endif
 	sdd->cur_bpw = 8;

 	master->bus_num = pdev->id;
@@ -1105,7 +1122,6 @@ static int __init s3c64xx_spi_probe(struct
platform_device *pdev)
 	dev_dbg(&pdev->dev, "\tIOmem=[0x%x-0x%x]\tDMA=[Rx-%d, Tx-%d]\n",
 					mem_res->end, mem_res->start,
 					sdd->rx_dmach, sdd->tx_dmach);
-
 	return 0;

 err8:
----------------------------------------------------------------------------------------------------------------------

Regards,
Alim



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
