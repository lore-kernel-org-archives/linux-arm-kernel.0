From: marex@denx.de (Marek Vasut)
Date: Fri, 24 Aug 2012 04:42:41 +0200
Subject: [PATCH] mxs/spi: Add SPI slave mode operation DT prop
Message-ID: <1345776161-9778-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows user to select the slave mode of operation of the controller.
This is by no means standard, see the binding documentation for details,
there is plenty of them. Sadly, such knowledge is not provided in the chip
documentation. Hopefully, this mode of operation might come useful for
people who do know very well what they are doing, otherwise this should
never be touched.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
---
 Documentation/devicetree/bindings/spi/mxs-spi.txt |   16 +++++++++++++
 drivers/spi/spi-mxs.c                             |   25 +++++++++++++--------
 include/linux/spi/mxs-spi.h                       |    1 +
 3 files changed, 33 insertions(+), 9 deletions(-)

NOTE1: I think I'll be crucified for bringing this up ;-)
NOTE2: I wonder if bringing such option in is good idea, but I hope it is.
       This thing seems to be useful at least to some people.
NOTE3: This at least documents the actual way of how to use the SPI slave mode
       on the MX28. The documentation for MX28 provided by Freescale is severely
       lacking in this matter. Some information (CPOL and CPHA note) were
       therefore retrieved from STMP36xx manual, which seems to have similar SSP
       IP core. The rest of the information (that the clock must run at much
       higher speed) was retrieved by performing long going slave work.
       Freescale only immersed themself in management shenanigans and were in
       the end not helpful at all. I hope someone will find the supplied
       information useful, even if this patch was only to be archived in the
       kernel list archives.

diff --git a/Documentation/devicetree/bindings/spi/mxs-spi.txt b/Documentation/devicetree/bindings/spi/mxs-spi.txt
index e2e1395..16c7287 100644
--- a/Documentation/devicetree/bindings/spi/mxs-spi.txt
+++ b/Documentation/devicetree/bindings/spi/mxs-spi.txt
@@ -9,6 +9,22 @@ Required properties:
 Optional properties:
 - clock-frequency : Input clock frequency to the SPI block in Hz.
 		    Default is 160000000 Hz.
+- fsl,slave-mode : Enable the slave mode operation of the controller.
+		   USE THIS OPTION WITH UTMOST CAUTION, READ ON FOR DETAILS!
+		   The i.MX23/i.MX28 controller can do SPI slave mode and
+		   behaves very closely as it does in master mode, but:
+		   - This is by no mean standard mode of operation, please
+		     use only if you do know what you're doing.
+		   - If the SPI master generates clock at n MHz, the speed
+		     of the SPI slave controller must be at least 4-8 times
+		     faster, this is due to the controller samples the CLK
+		     line multiple times in one clock pulse to be able to
+		     reliably deploy data. Otherwise, no data are received
+		     at all. Successful test was done with:
+		     - Master controller @ 120MHz, master device @ 30MHz
+		     - Slave controller @ 240MHz, slave device @ 120MHz
+		   - The CPOL and CPHA bits must be set.
+		   - The DMA has to wait indefinitelly for the arriving data.
 
 Example:
 
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index c965cc6..746359e 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -61,6 +61,7 @@
 struct mxs_spi {
 	struct mxs_ssp		ssp;
 	struct completion	c;
+	bool			slave_mode;
 };
 
 static int mxs_spi_setup_transfer(struct spi_device *dev,
@@ -95,7 +96,8 @@ static int mxs_spi_setup_transfer(struct spi_device *dev,
 		     BF_SSP_CTRL1_WORD_LENGTH
 		     (BV_SSP_CTRL1_WORD_LENGTH__EIGHT_BITS) |
 		     ((dev->mode & SPI_CPOL) ? BM_SSP_CTRL1_POLARITY : 0) |
-		     ((dev->mode & SPI_CPHA) ? BM_SSP_CTRL1_PHASE : 0),
+		     ((dev->mode & SPI_CPHA) ? BM_SSP_CTRL1_PHASE : 0) |
+		     (spi->slave_mode ? BM_SSP_CTRL1_SLAVE_MODE : 0),
 		     ssp->base + HW_SSP_CTRL1(ssp));
 
 	writel(0x0, ssp->base + HW_SSP_CMD0);
@@ -287,16 +289,20 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
 	dmaengine_submit(desc);
 	dma_async_issue_pending(ssp->dmach);
 
-	ret = wait_for_completion_timeout(&spi->c,
+	if (spi->slave_mode)
+		ret = wait_for_completion_killable(&spi->c);
+	else {
+		ret = wait_for_completion_timeout(&spi->c,
 				msecs_to_jiffies(SSP_TIMEOUT));
 
-	if (!ret) {
-		dev_err(ssp->dev, "DMA transfer timeout\n");
-		ret = -ETIMEDOUT;
-		goto err;
-	}
+		if (!ret) {
+			dev_err(ssp->dev, "DMA transfer timeout\n");
+			ret = -ETIMEDOUT;
+			goto err;
+		}
 
-	ret = 0;
+		ret = 0;
+	}
 
 err:
 	for (--sg_count; sg_count >= 0; sg_count--) {
@@ -410,7 +416,7 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 		 * DMA only: 2.164808 seconds, 473.0KB/s
 		 * Combined: 1.676276 seconds, 610.9KB/s
 		 */
-		if (t->len <= 256) {
+		if ((t->len <= 256) && !spi->slave_mode) {
 			writel(BM_SSP_CTRL1_DMA_ENABLE,
 				ssp->base + HW_SSP_CTRL1(ssp) +
 				STMP_OFFSET_REG_CLR);
@@ -561,6 +567,7 @@ static int __devinit mxs_spi_probe(struct platform_device *pdev)
 	ssp->dma_channel = dma_channel;
 
 	init_completion(&spi->c);
+	spi->slave_mode = of_property_read_bool(np, "fsl,slave-mode");
 
 	ret = devm_request_irq(&pdev->dev, irq_err, mxs_ssp_irq_handler, 0,
 			       DRIVER_NAME, ssp);
diff --git a/include/linux/spi/mxs-spi.h b/include/linux/spi/mxs-spi.h
index 61ae130..6c6ae34 100644
--- a/include/linux/spi/mxs-spi.h
+++ b/include/linux/spi/mxs-spi.h
@@ -94,6 +94,7 @@
 #define  BM_SSP_CTRL1_DMA_ENABLE		(1 << 13)
 #define  BM_SSP_CTRL1_PHASE			(1 << 10)
 #define  BM_SSP_CTRL1_POLARITY			(1 << 9)
+#define  BM_SSP_CTRL1_SLAVE_MODE		(1 << 8)
 #define  BP_SSP_CTRL1_WORD_LENGTH		4
 #define  BM_SSP_CTRL1_WORD_LENGTH		(0xf << 4)
 #define  BF_SSP_CTRL1_WORD_LENGTH(v)		\
-- 
1.7.10.4
