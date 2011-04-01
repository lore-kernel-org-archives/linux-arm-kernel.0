From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 1 Apr 2011 16:29:46 -0300
Subject: [PATCH 1/3] ARM: mx5/mx53_loco: Add write-protect and card-detect for
	SD3
Message-ID: <1301686188-14827-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_loco.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 10a1bea..249de6b 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -28,6 +28,7 @@
 #include <mach/hardware.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx53.h>
+#include <mach/esdhc.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -40,6 +41,8 @@
 #define MX53_LOCO_UI1			IMX_GPIO_NR(2, 14)
 #define MX53_LOCO_UI2			IMX_GPIO_NR(2, 15)
 #define LOCO_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
+#define SD3_GPIO_CD			IMX_GPIO_NR(3, 11)
+#define SD3_GPIO_WP			IMX_GPIO_NR(3, 12)
 
 static iomux_v3_cfg_t mx53_loco_pads[] = {
 	/* FEC */
@@ -227,6 +230,11 @@ static const struct imxi2c_platform_data mx53_loco_i2c_data __initconst = {
 	.bitrate = 100000,
 };
 
+static struct esdhc_platform_data sd3_pdata = {
+	.wp_gpio = SD3_GPIO_WP,
+	.cd_gpio = SD3_GPIO_CD,
+};
+
 static void __init mx53_loco_board_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
@@ -238,7 +246,7 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_imx_i2c(0, &mx53_loco_i2c_data);
 	imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
 	imx53_add_sdhci_esdhc_imx(0, NULL);
-	imx53_add_sdhci_esdhc_imx(2, NULL);
+	imx53_add_sdhci_esdhc_imx(2, &sd3_pdata);
 	imx_add_gpio_keys(&loco_button_data);
 }
 
-- 
1.6.0.4
