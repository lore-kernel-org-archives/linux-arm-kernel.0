From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Tue, 14 Jul 2015 14:45:25 -0500
Subject: [PATCH 2/4] spi: davinci: Choose correct pre-scaler limit based on SOC
In-Reply-To: <1436903127-6777-1-git-send-email-fcooper@ti.com>
References: <1436903127-6777-1-git-send-email-fcooper@ti.com>
Message-ID: <1436903127-6777-3-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the pre-scaler limit is incorrect. The value differs slightly
for various devices so a single value can't be used. Using the compatible
field select the correct pre-scaler limit.

Add new compatible field value for Keystone devices to support their
unique pre-scaler limit value.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 .../devicetree/bindings/spi/spi-davinci.txt        |  2 +
 drivers/spi/spi-davinci.c                          | 43 ++++++++++++++++++----
 include/linux/platform_data/spi-davinci.h          |  1 +
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
index 12ecfe9..d1e914a 100644
--- a/Documentation/devicetree/bindings/spi/spi-davinci.txt
+++ b/Documentation/devicetree/bindings/spi/spi-davinci.txt
@@ -12,6 +12,8 @@ Required properties:
 - compatible:
 	- "ti,dm6441-spi" for SPI used similar to that on DM644x SoC family
 	- "ti,da830-spi" for SPI used similar to that on DA8xx SoC family
+	- "ti,keystone-spi" for SPI used similar to that on Keystone2 SoC
+		family
 - reg: Offset and length of SPI controller register space
 - num-cs: Number of chip selects. This includes internal as well as
 	GPIO chip selects.
diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index b4605c4..3cf9faa 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -139,6 +139,8 @@ struct davinci_spi {
 	u32			(*get_tx)(struct davinci_spi *);
 
 	u8			*bytes_per_word;
+
+	u8			prescaler_limit;
 };
 
 static struct davinci_spi_config davinci_spi_default_cfg;
@@ -266,7 +268,7 @@ static inline int davinci_spi_get_prescale(struct davinci_spi *dspi,
 	/* Subtract 1 to match what will be programmed into SPI register. */
 	ret = DIV_ROUND_UP(clk_get_rate(dspi->clk), max_speed_hz) - 1;
 
-	if (ret < 0 || ret > 255)
+	if (ret < dspi->prescaler_limit || ret > 255)
 		return -EINVAL;
 
 	return ret;
@@ -833,13 +835,40 @@ rx_dma_failed:
 }
 
 #if defined(CONFIG_OF)
+
+/* OF SPI data structure */
+struct davinci_spi_of_data {
+	u8	version;
+	u8	prescaler_limit;
+};
+
+static const struct davinci_spi_of_data dm6441_spi_data = {
+	.version = SPI_VERSION_1,
+	.prescaler_limit = 2,
+};
+
+static const struct davinci_spi_of_data da830_spi_data = {
+	.version = SPI_VERSION_2,
+	.prescaler_limit = 2,
+};
+
+static const struct davinci_spi_of_data keystone_spi_data = {
+	.version = SPI_VERSION_1,
+	.prescaler_limit = 0,
+};
+
 static const struct of_device_id davinci_spi_of_match[] = {
 	{
 		.compatible = "ti,dm6441-spi",
+		.data = &dm6441_spi_data,
 	},
 	{
 		.compatible = "ti,da830-spi",
-		.data = (void *)SPI_VERSION_2,
+		.data = &da830_spi_data,
+	},
+	{
+		.compatible = "ti,keystone-spi",
+		.data = &keystone_spi_data,
 	},
 	{ },
 };
@@ -858,21 +887,21 @@ static int spi_davinci_get_pdata(struct platform_device *pdev,
 			struct davinci_spi *dspi)
 {
 	struct device_node *node = pdev->dev.of_node;
+	struct davinci_spi_of_data *spi_data;
 	struct davinci_spi_platform_data *pdata;
 	unsigned int num_cs, intr_line = 0;
 	const struct of_device_id *match;
 
 	pdata = &dspi->pdata;
 
-	pdata->version = SPI_VERSION_1;
 	match = of_match_device(davinci_spi_of_match, &pdev->dev);
 	if (!match)
 		return -ENODEV;
 
-	/* match data has the SPI version number for SPI_VERSION_2 */
-	if (match->data == (void *)SPI_VERSION_2)
-		pdata->version = SPI_VERSION_2;
+	spi_data = (struct davinci_spi_of_data *)match->data;
 
+	pdata->version = spi_data->version;
+	pdata->prescaler_limit = spi_data->prescaler_limit;
 	/*
 	 * default num_cs is 1 and all chipsel are internal to the chip
 	 * indicated by chip_sel being NULL or cs_gpios being NULL or
@@ -992,7 +1021,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 
 	dspi->bitbang.chipselect = davinci_spi_chipselect;
 	dspi->bitbang.setup_transfer = davinci_spi_setup_transfer;
-
+	dspi->prescaler_limit = pdata->prescaler_limit;
 	dspi->version = pdata->version;
 
 	dspi->bitbang.flags = SPI_NO_CS | SPI_LSB_FIRST | SPI_LOOP;
diff --git a/include/linux/platform_data/spi-davinci.h b/include/linux/platform_data/spi-davinci.h
index 8dc2fa47..f4edcb0 100644
--- a/include/linux/platform_data/spi-davinci.h
+++ b/include/linux/platform_data/spi-davinci.h
@@ -49,6 +49,7 @@ struct davinci_spi_platform_data {
 	u8			num_chipselect;
 	u8			intr_line;
 	u8			*chip_sel;
+	u8			prescaler_limit;
 	bool			cshold_bug;
 	enum dma_event_q	dma_event_q;
 };
-- 
1.9.1
