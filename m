From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 10 Nov 2011 11:11:37 +0000
Subject: [PATCH] spi/s3c64xx: Log error interrupts
Message-ID: <1320923497-26465-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although the hardware supports interrupts we're not currently using them
at all since for small transfers the overhead is greater than that for
busy waiting and for large transfers we have interrupts from the DMA.
This means that if the hardware reports an error (especially one which
might not stall transfer) we might miss it.

Take a first pass at dealing with such errors by enabling the interrupt
if we can and logging the errors if they happen. Ideally we'd report the
error via the affected transfer but since we're in master mode it's very
difficult to trigger errors at present and this code is much simpler.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/spi/spi-s3c64xx.c |   57 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index dcf7e10..8172173 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/workqueue.h>
+#include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
@@ -153,6 +154,7 @@ struct s3c64xx_spi_dma_data {
  * @tx_dmach: Controller's DMA channel for Tx.
  * @sfr_start: BUS address of SPI controller regs.
  * @regs: Pointer to ioremap'ed controller registers.
+ * @irq: interrupt
  * @xfer_completion: To indicate completion of xfer task.
  * @cur_mode: Stores the active configuration of the controller.
  * @cur_bpw: Stores the active bits per word settings.
@@ -171,6 +173,7 @@ struct s3c64xx_spi_driver_data {
 	struct list_head                queue;
 	spinlock_t                      lock;
 	unsigned long                   sfr_start;
+	int				irq;
 	struct completion               xfer_completion;
 	unsigned                        state;
 	unsigned                        cur_mode, cur_bpw;
@@ -930,6 +933,33 @@ setup_exit:
 	return err;
 }
 
+static irqreturn_t s3c64xx_spi_irq(int irq, void *data)
+{
+	struct s3c64xx_spi_driver_data *sdd = data;
+	struct spi_master *spi = sdd->master;
+	unsigned int val;
+
+	val = readl(sdd->regs + S3C64XX_SPI_PENDING_CLR);
+
+	val &= S3C64XX_SPI_PND_RX_OVERRUN_CLR |
+		S3C64XX_SPI_PND_RX_UNDERRUN_CLR |
+		S3C64XX_SPI_PND_TX_OVERRUN_CLR |
+		S3C64XX_SPI_PND_TX_UNDERRUN_CLR;
+
+	writel(val, sdd->regs + S3C64XX_SPI_PENDING_CLR);
+
+	if (val & S3C64XX_SPI_PND_RX_OVERRUN_CLR)
+		dev_err(&spi->dev, "RX overrun\n");
+	if (val & S3C64XX_SPI_PND_RX_UNDERRUN_CLR)
+		dev_err(&spi->dev, "RX underrun\n");
+	if (val & S3C64XX_SPI_PND_TX_OVERRUN_CLR)
+		dev_err(&spi->dev, "TX overrun\n");
+	if (val & S3C64XX_SPI_PND_TX_UNDERRUN_CLR)
+		dev_err(&spi->dev, "TX underrun\n");
+
+	return IRQ_HANDLED;
+}
+
 static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
 {
 	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
@@ -970,7 +1000,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 	struct s3c64xx_spi_driver_data *sdd;
 	struct s3c64xx_spi_info *sci;
 	struct spi_master *master;
-	int ret;
+	int ret, irq;
 	char clk_name[16];
 
 	if (pdev->id < 0) {
@@ -1006,6 +1036,12 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_warn(&pdev->dev, "Failed to get IRQ: %d\n", irq);
+		return irq;
+	}
+
 	master = spi_alloc_master(&pdev->dev,
 				sizeof(struct s3c64xx_spi_driver_data));
 	if (master == NULL) {
@@ -1100,10 +1136,21 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 	INIT_WORK(&sdd->work, s3c64xx_spi_work);
 	INIT_LIST_HEAD(&sdd->queue);
 
+	ret = request_irq(sdd->irq, s3c64xx_spi_irq, 0, "spi-s3c64xx", sdd);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "Failed to request IRQ: %d\n",
+			ret);
+		goto err8;
+	}
+
+	writel(S3C64XX_SPI_INT_RX_OVERRUN_EN | S3C64XX_SPI_INT_RX_UNDERRUN_EN |
+	       S3C64XX_SPI_INT_TX_OVERRUN_EN | S3C64XX_SPI_INT_TX_UNDERRUN_EN,
+	       sdd->regs + S3C64XX_SPI_INT_EN);
+
 	if (spi_register_master(master)) {
 		dev_err(&pdev->dev, "cannot register SPI master\n");
 		ret = -EBUSY;
-		goto err8;
+		goto err9;
 	}
 
 	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d "
@@ -1115,6 +1162,8 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 
 	return 0;
 
+err9:
+	free_irq(sdd->irq, sdd);
 err8:
 	destroy_workqueue(sdd->workqueue);
 err7:
@@ -1153,6 +1202,10 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 
 	spi_unregister_master(master);
 
+	writel(0, sdd->regs + S3C64XX_SPI_INT_EN);
+
+	free_irq(sdd->irq, sdd);
+
 	destroy_workqueue(sdd->workqueue);
 
 	clk_disable(sdd->src_clk);
-- 
1.7.7.2
