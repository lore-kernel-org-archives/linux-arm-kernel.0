From: weitway@gmail.com (weitway at gmail.com)
Date: Mon, 25 Apr 2011 21:40:39 +0800
Subject: [PATCH 5/9] ARM i.MX53 loco: Add framebuffer support
Message-ID: <1303738839-27659-1-git-send-email-weitway@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Chen <b02280@freescale.com>

Signed-off-by: Jason Chen <Jason.Chen@freescale.com>
Signed-off-by: Jason Chen <Jason.Chen@linaro.org>
---
 arch/arm/mach-mx5/Kconfig           |    1 +
 arch/arm/mach-mx5/board-mx53_loco.c |   23 +++++++++++++++++++++++
 arch/arm/mach-mx5/clock-mx51-mx53.c |    9 ++++++---
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index a512364..4f38f4e 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -200,6 +200,7 @@ config MACH_MX53_LOCO
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_GPIO_KEYS
+	select IMX_HAVE_PLATFORM_IMX_IPUV3
 	help
 	  Include support for MX53 LOCO platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 1b947e8..5232c41 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -22,10 +22,12 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <video/imx-ipu-v3.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx53.h>
+#include <mach/ipu-v3.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -37,6 +39,8 @@
 #define MX53_LOCO_POWER			IMX_GPIO_NR(1, 8)
 #define MX53_LOCO_UI1			IMX_GPIO_NR(2, 14)
 #define MX53_LOCO_UI2			IMX_GPIO_NR(2, 15)
+#define LOCO_DISP0_DET_INT		IMX_GPIO_NR(3, 31)
+#define LOCO_DISP0_RESET		IMX_GPIO_NR(5, 0)
 #define LOCO_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
 
 static iomux_v3_cfg_t mx53_loco_pads[] = {
@@ -225,6 +229,23 @@ static const struct imxi2c_platform_data mx53_loco_i2c_data __initconst = {
 	.bitrate = 100000,
 };
 
+static struct ipuv3_fb_platform_data loco_fb0_data = {
+	.interface_pix_fmt = IPU_PIX_FMT_RGB565,
+	.flags = IMX_IPU_FB_USE_MODEDB | IMX_IPU_FB_USE_OVERLAY,
+	.display = 0,
+};
+
+static struct ipuv3_fb_platform_data loco_fb1_data = {
+	.interface_pix_fmt = IPU_PIX_FMT_RGB565,
+	.flags = IMX_IPU_FB_USE_MODEDB,
+	.display = 1,
+};
+
+static struct imx_ipuv3_platform_data ipu_data = {
+	.fb_head0_platform_data = &loco_fb0_data,
+	.fb_head1_platform_data = &loco_fb1_data,
+};
+
 static void __init mx53_loco_board_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
@@ -238,6 +259,8 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_sdhci_esdhc_imx(0, NULL);
 	imx53_add_sdhci_esdhc_imx(2, NULL);
 	imx_add_gpio_keys(&loco_button_data);
+
+	imx53_add_ipuv3(0, &ipu_data);
 }
 
 static void __init mx53_loco_timer_init(void)
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 6b89c1b..a3d38bd 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1452,9 +1452,9 @@ static struct clk_lookup mx51_lookups[] = {
 	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
 	_REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
 	_REGISTER_CLOCK(NULL, "mipi_hsp", mipi_hsp_clk)
-	_REGISTER_CLOCK("imx-ipuv3", NULL, ipu_clk)
-	_REGISTER_CLOCK("imx-ipuv3", "di0", ipu_di0_clk)
-	_REGISTER_CLOCK("imx-ipuv3", "di1", ipu_di1_clk)
+	_REGISTER_CLOCK("imx-ipuv3.0", NULL, ipu_clk)
+	_REGISTER_CLOCK("imx-ipuv3.0", "di0", ipu_di0_clk)
+	_REGISTER_CLOCK("imx-ipuv3.0", "di1", ipu_di1_clk)
 	_REGISTER_CLOCK(NULL, "gpc_dvfs", gpc_dvfs_clk)
 };
 
@@ -1476,6 +1476,9 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
 	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
 	_REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
+	_REGISTER_CLOCK("imx-ipuv3.0", NULL, ipu_clk)
+	_REGISTER_CLOCK("imx-ipuv3.0", "di0", ipu_di0_clk)
+	_REGISTER_CLOCK("imx-ipuv3.0", "di1", ipu_di1_clk)
 };
 
 static void clk_tree_init(void)
-- 
1.7.1
