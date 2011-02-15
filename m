From: jason.chen@freescale.com (jason.chen at freescale.com)
Date: Tue, 15 Feb 2011 16:56:14 +0800
Subject: [PATCH 2/3] ARM i.MX53 LoCo: Add ipu device & framebuffer support
In-Reply-To: <1297760175-19211-1-git-send-email-jason.chen@freescale.com>
References: <1297760175-19211-1-git-send-email-jason.chen@freescale.com>
Message-ID: <1297760175-19211-2-git-send-email-jason.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Chen <b02280@freescale.com>

Signed-off-by: Jason Chen <b02280@freescale.com>
---
 arch/arm/mach-mx5/Kconfig           |    1 +
 arch/arm/mach-mx5/board-mx53_loco.c |   52 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-mx5/clock-mx51-mx53.c |    5 +++-
 3 files changed, 57 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 8afdb75..14840c3 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -147,6 +147,7 @@ config MACH_MX53_LOCO
 	bool "Support MX53 LOCO platforms"
 	select SOC_IMX53
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IMX_IPUV3
 	help
 	  Include support for MX53 LOCO platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 0fea252..8da1cd4 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -23,11 +23,13 @@
 #include <linux/fec.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/mfd/imx-ipu-v3.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx53.h>
+#include <mach/ipu-v3.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -35,12 +37,43 @@
 
 #include "crm_regs.h"
 #include "devices-imx53.h"
+#include "devices.h"
 
 #define LOCO_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
 
 static iomux_v3_cfg_t mx53_loco_pads[] = {
 	MX53_PAD_CSI0_DAT10__UART1_TXD_MUX,
 	MX53_PAD_CSI0_DAT11__UART1_RXD_MUX,
+
+	/* DISPLAY */
+	MX53_PAD_DI0_DISP_CLK__IPU_DI0_DISP_CLK,
+	MX53_PAD_DI0_PIN15__IPU_DI0_PIN15,
+	MX53_PAD_DI0_PIN2__IPU_DI0_PIN2,
+	MX53_PAD_DI0_PIN3__IPU_DI0_PIN3,
+	MX53_PAD_DISP0_DAT0__IPU_DISP0_DAT_0,
+	MX53_PAD_DISP0_DAT1__IPU_DISP0_DAT_1,
+	MX53_PAD_DISP0_DAT2__IPU_DISP0_DAT_2,
+	MX53_PAD_DISP0_DAT3__IPU_DISP0_DAT_3,
+	MX53_PAD_DISP0_DAT4__IPU_DISP0_DAT_4,
+	MX53_PAD_DISP0_DAT5__IPU_DISP0_DAT_5,
+	MX53_PAD_DISP0_DAT6__IPU_DISP0_DAT_6,
+	MX53_PAD_DISP0_DAT7__IPU_DISP0_DAT_7,
+	MX53_PAD_DISP0_DAT8__IPU_DISP0_DAT_8,
+	MX53_PAD_DISP0_DAT9__IPU_DISP0_DAT_9,
+	MX53_PAD_DISP0_DAT10__IPU_DISP0_DAT_10,
+	MX53_PAD_DISP0_DAT11__IPU_DISP0_DAT_11,
+	MX53_PAD_DISP0_DAT12__IPU_DISP0_DAT_12,
+	MX53_PAD_DISP0_DAT13__IPU_DISP0_DAT_13,
+	MX53_PAD_DISP0_DAT14__IPU_DISP0_DAT_14,
+	MX53_PAD_DISP0_DAT15__IPU_DISP0_DAT_15,
+	MX53_PAD_DISP0_DAT16__IPU_DISP0_DAT_16,
+	MX53_PAD_DISP0_DAT17__IPU_DISP0_DAT_17,
+	MX53_PAD_DISP0_DAT18__IPU_DISP0_DAT_18,
+	MX53_PAD_DISP0_DAT19__IPU_DISP0_DAT_19,
+	MX53_PAD_DISP0_DAT20__IPU_DISP0_DAT_20,
+	MX53_PAD_DISP0_DAT21__IPU_DISP0_DAT_21,
+	MX53_PAD_DISP0_DAT22__IPU_DISP0_DAT_22,
+	MX53_PAD_DISP0_DAT23__IPU_DISP0_DAT_23,
 };
 
 static inline void mx53_loco_fec_reset(void)
@@ -62,6 +95,23 @@ static struct fec_platform_data mx53_loco_fec_data = {
 	.phy = PHY_INTERFACE_MODE_RMII,
 };
 
+static struct ipuv3_fb_platform_data loco_fb0_data = {
+	.interface_pix_fmt = IPU_PIX_FMT_RGB565,
+	.flags = IMX_IPU_FB_USE_MODEDB | IMX_IPU_FB_USE_OVERLAY,
+	.display = 0,
+};
+
+static struct ipuv3_fb_platform_data loco_fb1_data = {
+	.interface_pix_fmt = IPU_PIX_FMT_RGB24,
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
@@ -69,6 +119,8 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_imx_uart(0, NULL);
 	mx53_loco_fec_reset();
 	imx53_add_fec(&mx53_loco_fec_data);
+
+	imx_add_ipuv3(&ipu_data);
 }
 
 static void __init mx53_loco_timer_init(void)
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index c66be0e..043572f 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1317,7 +1317,7 @@ static struct clk_lookup mx51_lookups[] = {
 	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
 	_REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
 	_REGISTER_CLOCK(NULL, "mipi_hsp", mipi_hsp_clk)
-	_REGISTER_CLOCK("imx-ipuv3", NULL, ipu_clk)
+	_REGISTER_CLOCK("imx-ipuv3", "ipu", ipu_clk)
 	_REGISTER_CLOCK("imx-ipuv3", "di0", ipu_di0_clk)
 	_REGISTER_CLOCK("imx-ipuv3", "di1", ipu_di1_clk)
 };
@@ -1336,6 +1336,9 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx53-ecspi.0", NULL, ecspi1_clk)
 	_REGISTER_CLOCK("imx53-ecspi.1", NULL, ecspi2_clk)
 	_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
+	_REGISTER_CLOCK("imx-ipuv3", "ipu", ipu_clk)
+	_REGISTER_CLOCK("imx-ipuv3", "di0", ipu_di0_clk)
+	_REGISTER_CLOCK("imx-ipuv3", "di1", ipu_di1_clk)
 };
 
 static void clk_tree_init(void)
-- 
1.7.1
