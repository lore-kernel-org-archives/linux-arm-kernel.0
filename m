From: aalonso@freescale.com (Adrian Alonso)
Date: Thu, 16 Jul 2015 15:34:47 -0500
Subject: [PATCH 4/4][v4] ARM: imx: pinctrl-imx7d: add iomuxc-lpsr gpio group
 ids
In-Reply-To: <1437078887-2524-1-git-send-email-aalonso@freescale.com>
References: <1437078887-2524-1-git-send-email-aalonso@freescale.com>
Message-ID: <1437078887-2524-4-git-send-email-aalonso@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Add imx7d SoC iomuxc-lpsr gpio group id's
* Add IOMUXC_LPSR_SUPPORT flag for pinctrl-imx driver to
  support iomuxc-lpsr controller.
* Add fsl,imx7d-pinctrl.txt documentation for encoded
  pad groupd is for iomux-lpsr GPIO1.

Signed-off-by: Adrian Alonso <aalonso@freescale.com>
---
- Version 4: Add devicetreee bindings fsl,imx7d-pinctrl.txt documentation for
  encoded pad groupd is for iomux-lpsr GPIO1.

 .../bindings/pinctrl/fsl,imx7d-pinctrl.txt         | 26 ++++++++++++++++++++++
 drivers/pinctrl/freescale/pinctrl-imx7d.c          | 17 ++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
index 8bbf25d..9c48ce9 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
@@ -25,3 +25,29 @@ PAD_CTL_DSE_X1                  (0 << 0)
 PAD_CTL_DSE_X2                  (1 << 0)
 PAD_CTL_DSE_X3                  (2 << 0)
 PAD_CTL_DSE_X4                  (3 << 0)
+
+IOMUXC-LPSR controller:
+i.MX7D supports two iomux controllers iomuxc and iomuxc-lpsr; LPSR is a power mode
+where NVCC_GPIO1 power rail remains on and GPIO1 under LPSR mode can retain the
+state of GPIO1 pads (GPIO1_07 to GPIO1_00).
+
+To support both controllers "fsl,imx7d-iomuxc" is extended to include the pad group
+id's for GPIO1 and these are encoded in input_val integer so pinctrl parse groups
+can be created for all imx7d_pads.
+
+For example pad group id for GPIO1_IO00 correspod to 155
+
+drivers/pinctrl/freescale/pinctrl-imx7d.c
+enum imx7d_pads {
+	...
+	MX7D_PAD_GPIO1_IO00 = 155,
+	...
+};
+
+In pad definition for GPIO1_IO00 the group id is encoded as 0x009B, while the lower 16 bit
+correspond to input_val.
+
+arch/arm/boot/dts/imx7d-pinfunc.h
+#define MX7D_PAD_GPIO1_IO00__GPIO1_IO0      0x0000 0x0030 0x0000 0x0 0x009B0000
+#define MX7D_PAD_GPIO1_IO00__PWM4_OUT       0x0000 0x0030 0x0000 0x1 0x009B0000
+#define MX7D_PAD_GPIO1_IO00__WDOD1_WDOG_ANY 0x0000 0x0030 0x0000 0x2 0x009B0000
diff --git a/drivers/pinctrl/freescale/pinctrl-imx7d.c b/drivers/pinctrl/freescale/pinctrl-imx7d.c
index 1fa7530..cf89275 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx7d.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx7d.c
@@ -172,6 +172,14 @@ enum imx7d_pads {
 	MX7D_PAD_ENET1_RX_CLK = 152,
 	MX7D_PAD_ENET1_CRS = 153,
 	MX7D_PAD_ENET1_COL = 154,
+	MX7D_PAD_GPIO1_IO00 = 155,
+	MX7D_PAD_GPIO1_IO01 = 156,
+	MX7D_PAD_GPIO1_IO02 = 157,
+	MX7D_PAD_GPIO1_IO03 = 158,
+	MX7D_PAD_GPIO1_IO04 = 159,
+	MX7D_PAD_GPIO1_IO05 = 160,
+	MX7D_PAD_GPIO1_IO06 = 161,
+	MX7D_PAD_GPIO1_IO07 = 162,
 };
 
 /* Pad names for the pinmux subsystem */
@@ -331,11 +339,20 @@ static const struct pinctrl_pin_desc imx7d_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX7D_PAD_ENET1_RX_CLK),
 	IMX_PINCTRL_PIN(MX7D_PAD_ENET1_CRS),
 	IMX_PINCTRL_PIN(MX7D_PAD_ENET1_COL),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO00),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO01),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO02),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO03),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO04),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO05),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO06),
+	IMX_PINCTRL_PIN(MX7D_PAD_GPIO1_IO07),
 };
 
 static struct imx_pinctrl_soc_info imx7d_pinctrl_info = {
 	.pins = imx7d_pinctrl_pads,
 	.npins = ARRAY_SIZE(imx7d_pinctrl_pads),
+	.flags = IOMUXC_LPSR_SUPPORT,
 };
 
 static struct of_device_id imx7d_pinctrl_of_match[] = {
-- 
2.1.4
