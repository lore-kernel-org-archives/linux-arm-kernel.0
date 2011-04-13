From: weitway@gmail.com (weitway at gmail.com)
Date: Wed, 13 Apr 2011 23:53:34 +0800
Subject: [PATCH 5/7] ARM i.MX53 loco: Add framebuffer support
In-Reply-To: <1302710016-3569-1-git-send-email-weitway@gmail.com>
References: <1302710016-3569-1-git-send-email-weitway@gmail.com>
Message-ID: <1302710016-3569-5-git-send-email-weitway@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Chen <b02280@freescale.com>

Signed-off-by: Jason Chen <Jason.Chen@freescale.com>
---
 arch/arm/mach-mx5/Kconfig           |    1 +
 arch/arm/mach-mx5/board-mx53_loco.c |   24 ++++++++++++++++++++++++
 arch/arm/mach-mx5/clock-mx51-mx53.c |    3 +++
 3 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 175d6f1..5d141a7 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -166,6 +166,7 @@ config MACH_MX53_LOCO
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select IMX_HAVE_PLATFORM_IMX_IPUV3
 	help
 	  Include support for MX53 LOCO platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 0a18f8d..a499917 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -23,11 +23,13 @@
 #include <linux/fec.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <video/imx-ipu-v3.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx53.h>
+#include <mach/ipu-v3.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -36,6 +38,9 @@
 #include "crm_regs.h"
 #include "devices-imx53.h"
 
+#define LOCO_DISP0_PWR			IMX_GPIO_NR(3, 24)
+#define LOCO_DISP0_DET_INT		IMX_GPIO_NR(3, 31)
+#define LOCO_DISP0_RESET		IMX_GPIO_NR(5, 0)
 #define LOCO_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
 
 static iomux_v3_cfg_t mx53_loco_pads[] = {
@@ -203,6 +208,23 @@ static const struct imxi2c_platform_data mx53_loco_i2c_data __initconst = {
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
@@ -215,6 +237,8 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
 	imx53_add_sdhci_esdhc_imx(0, NULL);
 	imx53_add_sdhci_esdhc_imx(2, NULL);
+
+	imx53_add_ipuv3(&ipu_data);
 }
 
 static void __init mx53_loco_timer_init(void)
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 652ace4..213ec33 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1468,6 +1468,9 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
 	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
 	_REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
+	_REGISTER_CLOCK("imx-ipuv3", NULL, ipu_clk)
+	_REGISTER_CLOCK("imx-ipuv3", "di0", ipu_di0_clk)
+	_REGISTER_CLOCK("imx-ipuv3", "di1", ipu_di1_clk)
 };
 
 static void clk_tree_init(void)
-- 
1.7.1
