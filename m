From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 26 Feb 2011 23:19:04 +0800
Subject: [PATCH] ARM: mach-imx: mx25_3ds: add write-protect and card-detect
	for SD
Message-ID: <1298733544-24659-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-imx/mach-mx25_3ds.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index 66b6cdd..561f07f 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -41,6 +41,7 @@
 #include <mach/common.h>
 #include <mach/mx25.h>
 #include <mach/iomux-mx25.h>
+#include <mach/esdhc.h>
 
 #include "devices-imx25.h"
 
@@ -103,6 +104,8 @@ static iomux_v3_cfg_t mx25pdk_pads[] = {
 	MX25_PAD_SD1_DATA1__SD1_DATA1,
 	MX25_PAD_SD1_DATA2__SD1_DATA2,
 	MX25_PAD_SD1_DATA3__SD1_DATA3,
+	MX25_PAD_A14__GPIO_2_0, /* WriteProtect */
+	MX25_PAD_A15__GPIO_2_1, /* CardDetect */
 };
 
 static const struct fec_platform_data mx25_fec_pdata __initconst = {
@@ -200,6 +203,14 @@ static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
 	.phy_mode       = FSL_USB2_PHY_UTMI,
 };
 
+#define SD1_GPIO_WP	IMX_GPIO_NR(2, 0)
+#define SD1_GPIO_CD	IMX_GPIO_NR(2, 1)
+
+static const struct esdhc_platform_data mx25pdk_esdhc_pdata __initconst = {
+	.wp_gpio = SD1_GPIO_WP,
+	.cd_gpio = SD1_GPIO_CD,
+};
+
 static void __init mx25pdk_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx25pdk_pads,
@@ -217,7 +228,7 @@ static void __init mx25pdk_init(void)
 	imx25_add_fec(&mx25_fec_pdata);
 	imx25_add_imx_keypad(&mx25pdk_keymap_data);
 
-	imx25_add_sdhci_esdhc_imx(0, NULL);
+	imx25_add_sdhci_esdhc_imx(0, &mx25pdk_esdhc_pdata);
 }
 
 static void __init mx25pdk_timer_init(void)
-- 
1.7.1
