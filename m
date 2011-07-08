From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri,  8 Jul 2011 16:27:34 +0800
Subject: [PATCH 6/6] spi/imx: add device tree probe support
In-Reply-To: <1310113654-25887-1-git-send-email-shawn.guo@linaro.org>
References: <1310113654-25887-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1310113654-25887-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds device tree probe support for spi-imx driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |   22 +++++++++++
 drivers/spi/spi-imx.c                              |   38 ++++++++++++++++----
 2 files changed, 53 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
new file mode 100644
index 0000000..9841057
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
@@ -0,0 +1,22 @@
+* Freescale (Enhanced) Configurable Serial Peripheral Interface
+  (CSPI/eCSPI) for i.MX
+
+Required properties:
+- compatible : Should be "fsl,<soc>-cspi" or "fsl,<soc>-ecspi"
+- reg : Offset and length of the register set for the device
+- interrupts : Should contain CSPI/eCSPI interrupt
+- fsl,spi-num-chipselects : Contains the number of the chipselect
+- cs-gpios : Specifies the gpio pins to be used for chipselects.
+
+Example:
+
+ecspi at 70010000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,imx51-ecspi";
+	reg = <0x70010000 0x4000>;
+	interrupts = <36>;
+	fsl,spi-num-chipselects = <2>;
+	cs-gpios = <&gpio3 24 0>, /* GPIO4_24 */
+		   <&gpio3 25 0>; /* GPIO4_25 */
+};
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b9cd31f..8792628 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -34,6 +34,9 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/types.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
 
 #include <mach/spi.h>
 
@@ -606,6 +609,16 @@ static struct platform_device_id spi_imx_devtype[] = {
 	}
 };
 
+static const struct of_device_id spi_imx_dt_ids[] = {
+	{ .compatible = "fsl,imx1-cspi", .data = &imx1_cspi_devtype_data, },
+	{ .compatible = "fsl,imx21-cspi", .data = &imx21_cspi_devtype_data, },
+	{ .compatible = "fsl,imx27-cspi", .data = &imx27_cspi_devtype_data, },
+	{ .compatible = "fsl,imx31-cspi", .data = &imx31_cspi_devtype_data, },
+	{ .compatible = "fsl,imx35-cspi", .data = &imx35_cspi_devtype_data, },
+	{ .compatible = "fsl,imx51-ecspi", .data = &imx51_ecspi_devtype_data, },
+	{ /* sentinel */ }
+};
+
 static void spi_imx_chipselect(struct spi_device *spi, int is_active)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
@@ -739,19 +752,25 @@ static void spi_imx_cleanup(struct spi_device *spi)
 
 static int __devinit spi_imx_probe(struct platform_device *pdev)
 {
-	struct spi_imx_master *mxc_platform_info;
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *of_id =
+			of_match_device(spi_imx_dt_ids, &pdev->dev);
+	struct spi_imx_master *mxc_platform_info =
+			dev_get_platdata(&pdev->dev);
 	struct spi_master *master;
 	struct spi_imx_data *spi_imx;
 	struct resource *res;
 	int i, ret, num_cs;
 
-	mxc_platform_info = dev_get_platdata(&pdev->dev);
-	if (!mxc_platform_info) {
+	if (!np && !mxc_platform_info) {
 		dev_err(&pdev->dev, "can't get the platform data\n");
 		return -EINVAL;
 	}
 
-	num_cs = mxc_platform_info->num_chipselect;
+	ret = of_property_read_u32(np, "fsl,spi-num-chipselects", &num_cs);
+	if (ret < 0)
+		num_cs = mxc_platform_info->num_chipselect;
+
 	master = spi_alloc_master(&pdev->dev,
 			sizeof(struct spi_imx_data) + sizeof(int) * num_cs);
 	if (!master)
@@ -766,9 +785,12 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master = spi_master_get(master);
 
 	for (i = 0; i < master->num_chipselect; i++) {
-		spi_imx->chipselect[i] = mxc_platform_info->chipselect[i];
-		if (spi_imx->chipselect[i] < 0)
+		int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
+		if (cs_gpio < 0)
+			cs_gpio = mxc_platform_info->chipselect[i];
+		if (cs_gpio < 0)
 			continue;
+		spi_imx->chipselect[i] = cs_gpio;
 		ret = gpio_request(spi_imx->chipselect[i], DRIVER_NAME);
 		if (ret) {
 			while (i > 0) {
@@ -790,7 +812,7 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 
 	init_completion(&spi_imx->xfer_done);
 
-	spi_imx->devtype_data =
+	spi_imx->devtype_data = of_id ? of_id->data :
 		(struct spi_imx_devtype_data *) pdev->id_entry->driver_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -838,6 +860,7 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 
 	spi_imx->devtype_data->intctrl(spi_imx, 0);
 
+	master->dev.of_node = pdev->dev.of_node;
 	ret = spi_bitbang_start(&spi_imx->bitbang);
 	if (ret) {
 		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
@@ -900,6 +923,7 @@ static struct platform_driver spi_imx_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .owner = THIS_MODULE,
+		   .of_match_table = spi_imx_dt_ids,
 		   },
 	.id_table = spi_imx_devtype,
 	.probe = spi_imx_probe,
-- 
1.7.4.1
