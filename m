From: stefan@agner.ch (Stefan Agner)
Date: Sat,  6 Jan 2018 15:25:53 +0100
Subject: [PATCH v2 5/5] pinctrl: imx6ul: add IOMUXC SNVS pinctrl driver for
 i.MX 6ULL
In-Reply-To: <20180106142553.15322-1-stefan@agner.ch>
References: <20180106142553.15322-1-stefan@agner.ch>
Message-ID: <20180106142553.15322-6-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bai Ping <ping.bai@nxp.com>

On i.MX 6ULL, the BOOT_MODEx and TAMPERx pin MUX and CTRL registers
are available in a separate IOMUXC_SNVS module. Add support for the
IOMUXC_SNVS module to the i.MX 6UL pinctrl driver.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/fsl,imx6ul-pinctrl.txt        |  3 +-
 drivers/pinctrl/freescale/pinctrl-imx6ul.c         | 52 ++++++++++++++++++++--
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt
index a81bbf37ed66..7ca4f6118d9a 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt
@@ -4,7 +4,8 @@ Please refer to fsl,imx-pinctrl.txt in this directory for common binding part
 and usage.
 
 Required properties:
-- compatible: "fsl,imx6ul-iomuxc"
+- compatible: "fsl,imx6ul-iomuxc" for main IOMUX controller or
+  "fsl,imx6ull-iomuxc-snvs" for i.MX 6ULL's SNVS IOMUX controller.
 - fsl,pins: each entry consists of 6 integers and represents the mux and config
   setting for one pin.  The first 5 integers <mux_reg conf_reg input_reg mux_val
   input_val> are specified using a PIN_FUNC_ID macro, which can be found in
diff --git a/drivers/pinctrl/freescale/pinctrl-imx6ul.c b/drivers/pinctrl/freescale/pinctrl-imx6ul.c
index 1aeb840aae1d..4580717ade19 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx6ul.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx6ul.c
@@ -150,6 +150,21 @@ enum imx6ul_pads {
 	MX6UL_PAD_CSI_DATA07 = 128,
 };
 
+enum imx6ull_lpsr_pads {
+	MX6ULL_PAD_BOOT_MODE0 = 0,
+	MX6ULL_PAD_BOOT_MODE1 = 1,
+	MX6ULL_PAD_SNVS_TAMPER0 = 2,
+	MX6ULL_PAD_SNVS_TAMPER1 = 3,
+	MX6ULL_PAD_SNVS_TAMPER2 = 4,
+	MX6ULL_PAD_SNVS_TAMPER3 = 5,
+	MX6ULL_PAD_SNVS_TAMPER4 = 6,
+	MX6ULL_PAD_SNVS_TAMPER5 = 7,
+	MX6ULL_PAD_SNVS_TAMPER6 = 8,
+	MX6ULL_PAD_SNVS_TAMPER7 = 9,
+	MX6ULL_PAD_SNVS_TAMPER8 = 10,
+	MX6ULL_PAD_SNVS_TAMPER9 = 11,
+};
+
 /* Pad names for the pinmux subsystem */
 static const struct pinctrl_pin_desc imx6ul_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX6UL_PAD_RESERVE0),
@@ -283,20 +298,49 @@ static const struct pinctrl_pin_desc imx6ul_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX6UL_PAD_CSI_DATA07),
 };
 
-static struct imx_pinctrl_soc_info imx6ul_pinctrl_info = {
+/* pad for i.MX6ULL lpsr pinmux */
+static const struct pinctrl_pin_desc imx6ull_snvs_pinctrl_pads[] = {
+	IMX_PINCTRL_PIN(MX6ULL_PAD_BOOT_MODE0),
+	IMX_PINCTRL_PIN(MX6ULL_PAD_BOOT_MODE1),
+	IMX_PINCTRL_PIN(MX6ULL_PAD_SNVS_TAMPER0),
+	IMX_PINCTRL_PIN(MX6ULL_PAD_SNVS_TAMPER1),
+	IMX_PINCTRL_PIN(MX6ULL_PAD_SNVS_TAMPER2),
+	IMX_PINCTRL_PIN(MX6ULL_PAD_SNVS_TAMPER3),
+	IMX_PINCTRL_PIN(MX6ULL_PAD_SNVS_TAMPER4),
+	IMX_PINCTRL_PIN(MX6ULL_PAD_SNVS_TAMPER5),
+	IMX_PINCTRL_PIN(MX6ULL_PAD_SNVS_TAMPER6),
+	IMX_PINCTRL_PIN(MX6ULL_PAD_SNVS_TAMPER7),
+	IMX_PINCTRL_PIN(MX6ULL_PAD_SNVS_TAMPER8),
+	IMX_PINCTRL_PIN(MX6ULL_PAD_SNVS_TAMPER9),
+};
+
+static const struct imx_pinctrl_soc_info imx6ul_pinctrl_info = {
 	.pins = imx6ul_pinctrl_pads,
 	.npins = ARRAY_SIZE(imx6ul_pinctrl_pads),
 	.gpr_compatible = "fsl,imx6ul-iomuxc-gpr",
 };
 
-static struct of_device_id imx6ul_pinctrl_of_match[] = {
-	{ .compatible = "fsl,imx6ul-iomuxc", },
+static const struct imx_pinctrl_soc_info imx6ull_snvs_pinctrl_info = {
+	.pins = imx6ull_snvs_pinctrl_pads,
+	.npins = ARRAY_SIZE(imx6ull_snvs_pinctrl_pads),
+	.flags = ZERO_OFFSET_VALID,
+};
+
+static const struct of_device_id imx6ul_pinctrl_of_match[] = {
+	{ .compatible = "fsl,imx6ul-iomuxc", .data = &imx6ul_pinctrl_info, },
+	{ .compatible = "fsl,imx6ull-iomuxc-snvs", .data = &imx6ull_snvs_pinctrl_info, },
 	{ /* sentinel */ }
 };
 
 static int imx6ul_pinctrl_probe(struct platform_device *pdev)
 {
-	return imx_pinctrl_probe(pdev, &imx6ul_pinctrl_info);
+	const struct imx_pinctrl_soc_info *pinctrl_info;
+
+	pinctrl_info = of_device_get_match_data(&pdev->dev);
+	if (!pinctrl_info)
+		return -ENODEV;
+
+	return imx_pinctrl_probe(pdev, pinctrl_info);
 }
 
 static struct platform_driver imx6ul_pinctrl_driver = {
-- 
2.15.1
