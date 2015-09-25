From: anton_bondarenko@mentor.com (Anton Bondarenko)
Date: Fri, 25 Sep 2015 19:57:12 +0200
Subject: [PATCH v2 5/8] spi: imx: Add support for loopback for ECSPI
 controllers
In-Reply-To: <cover.1442923630.git.anton_bondarenko@mentor.com>
References: <cover.1442923630.git.anton_bondarenko@mentor.com>
Message-ID: <ca96561d8010acf587a93d0f357774bf77efbe16.1442923630.git.anton_bondarenko@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for ECSPI loopback for IMX51,IMX53 and IMX6Q using TEST register.

Signed-off-by: Mohsin Kazmi <mohsin_kazmi@mentor.com>
Signed-off-by: Anton Bondarenko <anton_bondarenko@mentor.com>
---
 drivers/spi/spi-imx.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 41c9cef..4b3c16e 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -265,6 +265,9 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_STAT		0x18
 #define MX51_ECSPI_STAT_RR		(1 <<  3)
 
+#define MX51_ECSPI_TEST			0x20
+#define MX51_ECSPI_LOOP			BIT(31)
+
 /* MX51 eCSPI */
 static unsigned int mx51_ecspi_clkdiv(unsigned int fin, unsigned int fspi,
 				      unsigned int *fres)
@@ -338,6 +341,7 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, dma = 0;
 	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
 	u32 delay;
+	u32 lpb = 0;
 
 	/*
 	 * The hardware seems to have a race condition when changing modes. The
@@ -370,8 +374,12 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	if (config->mode & SPI_CS_HIGH)
 		cfg |= MX51_ECSPI_CONFIG_SSBPOL(config->cs);
 
+	if (config->mode & SPI_LOOP)
+		lpb |= MX51_ECSPI_LOOP;
+
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
+	writel(lpb, spi_imx->base + MX51_ECSPI_TEST);
 
 	/*
 	 * Wait until the changes in the configuration register CONFIGREG
@@ -1252,6 +1260,9 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx = spi_master_get_devdata(master);
 	spi_imx->bitbang.master = master;
 
+	spi_imx->devtype_data = of_id ? of_id->data :
+		(struct spi_imx_devtype_data *)pdev->id_entry->driver_data;
+
 	for (i = 0; i < master->num_chipselect; i++) {
 		int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
 		if (!gpio_is_valid(cs_gpio) && mxc_platform_info)
@@ -1276,12 +1287,13 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master->cleanup = spi_imx_cleanup;
 	spi_imx->bitbang.master->prepare_message = spi_imx_prepare_message;
 	spi_imx->bitbang.master->unprepare_message = spi_imx_unprepare_message;
-	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA |
+				SPI_CS_HIGH;
 
-	init_completion(&spi_imx->xfer_done);
+	if (is_imx5x_ecspi(spi_imx))
+		spi_imx->bitbang.master->mode_bits |= SPI_LOOP;
 
-	spi_imx->devtype_data = of_id ? of_id->data :
-		(struct spi_imx_devtype_data *) pdev->id_entry->driver_data;
+	init_completion(&spi_imx->xfer_done);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	spi_imx->base = devm_ioremap_resource(&pdev->dev, res);
-- 
2.5.2
