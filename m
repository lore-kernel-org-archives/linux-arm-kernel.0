From: padma.kvr@gmail.com (Padmavathi Venna)
Date: Thu,  6 Nov 2014 15:21:49 +0530
Subject: [PATCH] spi: s3c64xx: add support for exynos7 SPI controller
Message-ID: <1415267509-16653-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos7 SPI controller supports only the auto Selection of
CS toggle mode and Exynos7 SoC includes six SPI controllers.
Add support for these changes in Exynos7 SPI controller driver.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 .../devicetree/bindings/spi/spi-samsung.txt        |    2 +-
 drivers/spi/Kconfig                                |    2 +-
 drivers/spi/spi-s3c64xx.c                          |   32 ++++++++++++++++---
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index 1e8a857..6dbdeb3 100644
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -9,7 +9,7 @@ Required SoC Specific Properties:
     - samsung,s3c2443-spi: for s3c2443, s3c2416 and s3c2450 platforms
     - samsung,s3c6410-spi: for s3c6410 platforms
     - samsung,s5pv210-spi: for s5pv210 and s5pc110 platforms
-    - samsung,exynos4210-spi: for exynos4 and exynos5 platforms
+    - samsung,exynos7-spi: for exynos7 platforms
 
 - reg: physical base address of the controller and length of memory mapped
   region.
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 84e7c9e..de2d33d 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -444,7 +444,7 @@ config SPI_S3C24XX_FIQ
 
 config SPI_S3C64XX
 	tristate "Samsung S3C64XX series type SPI"
-	depends on PLAT_SAMSUNG
+	depends on (PLAT_SAMSUNG || ARCH_EXYNOS)
 	select S3C64XX_PL080 if ARCH_S3C64XX
 	help
 	  SPI driver for Samsung S3C64XX and newer SoCs.
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 480133e..59e07cf 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -33,8 +33,9 @@
 
 #include <linux/platform_data/spi-s3c64xx.h>
 
-#define MAX_SPI_PORTS		3
+#define MAX_SPI_PORTS		6
 #define S3C64XX_SPI_QUIRK_POLL		(1 << 0)
+#define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
 
 /* Registers and bit-fields */
 
@@ -78,6 +79,7 @@
 
 #define S3C64XX_SPI_SLAVE_AUTO			(1<<1)
 #define S3C64XX_SPI_SLAVE_SIG_INACT		(1<<0)
+#define S3C64XX_SPI_SLAVE_NSC_CNT_2		(2<<4)
 
 #define S3C64XX_SPI_INT_TRAILING_EN		(1<<6)
 #define S3C64XX_SPI_INT_RX_OVERRUN_EN		(1<<5)
@@ -717,7 +719,12 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	enable_datapath(sdd, spi, xfer, use_dma);
 
 	/* Start the signals */
-	writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
+		writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+	else
+		writel(readl(sdd->regs + S3C64XX_SPI_SLAVE_SEL)
+			| S3C64XX_SPI_SLAVE_AUTO | S3C64XX_SPI_SLAVE_NSC_CNT_2,
+			sdd->regs + S3C64XX_SPI_SLAVE_SEL);
 
 	spin_unlock_irqrestore(&sdd->lock, flags);
 
@@ -866,13 +873,15 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	}
 
 	pm_runtime_put(&sdd->pdev->dev);
-	writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
+		writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
 	return 0;
 
 setup_exit:
 	pm_runtime_put(&sdd->pdev->dev);
 	/* setup() returns with device de-selected */
-	writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
+		writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
 
 	if (gpio_is_valid(spi->cs_gpio))
 		gpio_free(spi->cs_gpio);
@@ -946,7 +955,8 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
 
 	sdd->cur_speed = 0;
 
-	writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
+		writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
 
 	/* Disable Interrupts - we use Polling if not DMA mode */
 	writel(0, regs + S3C64XX_SPI_INT_EN);
@@ -1341,6 +1351,15 @@ static struct s3c64xx_spi_port_config exynos5440_spi_port_config = {
 	.quirks		= S3C64XX_SPI_QUIRK_POLL,
 };
 
+static struct s3c64xx_spi_port_config exynos7_spi_port_config = {
+	.fifo_lvl_mask	= { 0x1ff, 0x7F, 0x7F, 0x7F, 0x7F, 0x1ff},
+	.rx_lvl_offset	= 15,
+	.tx_st_done	= 25,
+	.high_speed	= true,
+	.clk_from_cmu	= true,
+	.quirks		= S3C64XX_SPI_QUIRK_CS_AUTO,
+};
+
 static struct platform_device_id s3c64xx_spi_driver_ids[] = {
 	{
 		.name		= "s3c2443-spi",
@@ -1374,6 +1393,9 @@ static const struct of_device_id s3c64xx_spi_dt_match[] = {
 	{ .compatible = "samsung,exynos5440-spi",
 			.data = (void *)&exynos5440_spi_port_config,
 	},
+	{ .compatible = "samsung,exynos7-spi",
+			.data = (void *)&exynos7_spi_port_config,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, s3c64xx_spi_dt_match);
-- 
1.7.4.4
