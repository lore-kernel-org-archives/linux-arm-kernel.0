From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Aug 2013 10:04:32 +0200
Subject: [PATCH 2/3] dma: imx-sdma: Add ROM script addresses to driver
In-Reply-To: <1376985873-25776-1-git-send-email-s.hauer@pengutronix.de>
References: <1376985873-25776-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1376985873-25776-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the ROM script addresses for i.MX25, i.MX5x and i.MX6 to the
SDMA driver needed for the driver to work without additional firmware.

The ROM script addresses are SoC specific and in some cases even tapeout
specific. This patch adds the ROM script addresses only for SoCs which
do not have a tapeout specific SDMA ROM, because currently it's unclear
how this case should be handled.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |   7 +-
 drivers/dma/imx-sdma.c                             | 100 ++++++++++++++++++++-
 2 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
index 68cee4f5..4fa814d 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -1,7 +1,12 @@
 * Freescale Smart Direct Memory Access (SDMA) Controller for i.MX
 
 Required properties:
-- compatible : Should be "fsl,<chip>-sdma"
+- compatible : Should be "fsl,imx31-sdma", "fsl,imx31-to1-sdma",
+  "fsl,imx31-to2-sdma", "fsl,imx35-sdma", "fsl,imx35-to1-sdma",
+  "fsl,imx35-to2-sdma", "fsl,imx51-sdma", "fsl,imx53-sdma" or
+  "fsl,imx6q-sdma". The -to variants should be preferred since they
+  allow to determnine the correct ROM script addresses needed for
+  the driver to work without additional firmware.
 - reg : Should contain SDMA registers location and length
 - interrupts : Should contain SDMA interrupt
 - #dma-cells : Must be <3>.
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index e3e7e3f..89a4c74 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -310,6 +310,7 @@ struct sdma_firmware_header {
 struct sdma_driver_data {
 	int chnenbl0;
 	int num_events;
+	struct sdma_script_start_addrs	*script_addrs;
 };
 
 struct sdma_engine {
@@ -333,27 +334,122 @@ struct sdma_driver_data sdma_imx31 = {
 	.num_events = 32,
 };
 
+static struct sdma_script_start_addrs sdma_script_imx25 = {
+	.ap_2_ap_addr = 729,
+	.uart_2_mcu_addr = 904,
+	.per_2_app_addr = 1255,
+	.mcu_2_app_addr = 834,
+	.uartsh_2_mcu_addr = 1120,
+	.per_2_shp_addr = 1329,
+	.mcu_2_shp_addr = 1048,
+	.ata_2_mcu_addr = 1560,
+	.mcu_2_ata_addr = 1479,
+	.app_2_per_addr = 1189,
+	.app_2_mcu_addr = 770,
+	.shp_2_per_addr = 1407,
+	.shp_2_mcu_addr = 979,
+};
+
+struct sdma_driver_data sdma_imx25 = {
+	.chnenbl0 = SDMA_CHNENBL0_IMX35,
+	.num_events = 48,
+	.script_addrs = &sdma_script_imx25,
+};
+
 struct sdma_driver_data sdma_imx35 = {
 	.chnenbl0 = SDMA_CHNENBL0_IMX35,
 	.num_events = 48,
 };
 
+static struct sdma_script_start_addrs sdma_script_imx51 = {
+	.ap_2_ap_addr = 642,
+	.uart_2_mcu_addr = 817,
+	.mcu_2_app_addr = 747,
+	.mcu_2_shp_addr = 961,
+	.ata_2_mcu_addr = 1473,
+	.mcu_2_ata_addr = 1392,
+	.app_2_per_addr = 1033,
+	.app_2_mcu_addr = 683,
+	.shp_2_per_addr = 1251,
+	.shp_2_mcu_addr = 892,
+};
+
+struct sdma_driver_data sdma_imx51 = {
+	.chnenbl0 = SDMA_CHNENBL0_IMX35,
+	.num_events = 48,
+	.script_addrs = &sdma_script_imx51,
+};
+
+static struct sdma_script_start_addrs sdma_script_imx53 = {
+	.ap_2_ap_addr = 642,
+	.app_2_mcu_addr = 683,
+	.mcu_2_app_addr = 747,
+	.uart_2_mcu_addr = 817,
+	.shp_2_mcu_addr = 891,
+	.mcu_2_shp_addr = 960,
+	.uartsh_2_mcu_addr = 1032,
+	.spdif_2_mcu_addr = 1100,
+	.mcu_2_spdif_addr = 1134,
+	.firi_2_mcu_addr = 1193,
+	.mcu_2_firi_addr = 1290,
+};
+
+struct sdma_driver_data sdma_imx53 = {
+	.chnenbl0 = SDMA_CHNENBL0_IMX35,
+	.num_events = 48,
+	.script_addrs = &sdma_script_imx53,
+};
+
+static struct sdma_script_start_addrs sdma_script_imx6q = {
+	.ap_2_ap_addr = 642,
+	.uart_2_mcu_addr = 817,
+	.mcu_2_app_addr = 747,
+	.per_2_per_addr = 6331,
+	.uartsh_2_mcu_addr = 1032,
+	.mcu_2_shp_addr = 960,
+	.app_2_mcu_addr = 683,
+	.shp_2_mcu_addr = 891,
+	.spdif_2_mcu_addr = 1100,
+	.mcu_2_spdif_addr = 1134,
+};
+
+struct sdma_driver_data sdma_imx6q = {
+	.chnenbl0 = SDMA_CHNENBL0_IMX35,
+	.num_events = 48,
+	.script_addrs = &sdma_script_imx6q,
+};
+
 static struct platform_device_id sdma_devtypes[] = {
 	{
+		.name = "imx25-sdma",
+		.driver_data = (unsigned long)&sdma_imx25,
+	}, {
 		.name = "imx31-sdma",
 		.driver_data = (unsigned long)&sdma_imx31,
 	}, {
 		.name = "imx35-sdma",
 		.driver_data = (unsigned long)&sdma_imx35,
 	}, {
+		.name = "imx51-sdma",
+		.driver_data = (unsigned long)&sdma_imx51,
+	}, {
+		.name = "imx53-sdma",
+		.driver_data = (unsigned long)&sdma_imx53,
+	}, {
+		.name = "imx6q-sdma",
+		.driver_data = (unsigned long)&sdma_imx6q,
+	}, {
 		/* sentinel */
 	}
 };
 MODULE_DEVICE_TABLE(platform, sdma_devtypes);
 
 static const struct of_device_id sdma_dt_ids[] = {
-	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
+	{ .compatible = "fsl,imx6q-sdma", .data = &sdma_imx6q, },
+	{ .compatible = "fsl,imx53-sdma", .data = &sdma_imx53, },
+	{ .compatible = "fsl,imx51-sdma", .data = &sdma_imx51, },
 	{ .compatible = "fsl,imx35-sdma", .data = &sdma_imx35, },
+	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdma_dt_ids);
@@ -1434,6 +1530,8 @@ static int __init sdma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_init;
 
+	if (sdma->drvdata->script_addrs)
+		sdma_add_scripts(sdma, sdma->drvdata->script_addrs);
 	if (pdata && pdata->script_addrs)
 		sdma_add_scripts(sdma, pdata->script_addrs);
 
-- 
1.8.4.rc3
