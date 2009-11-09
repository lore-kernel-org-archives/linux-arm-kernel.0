From: agust@denx.de (Anatolij Gustschin)
Date: Mon,  9 Nov 2009 13:37:13 +0100
Subject: [PATCH 1/2] qong: Add LCD display support
Message-ID: <1257770234-1851-1-git-send-email-agust@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch was tested with Vbest-VGG322403 and
COM57H5M10XRC displays.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/arm/mach-mx3/qong.c |   83 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/qong.c b/arch/arm/mach-mx3/qong.c
index 07858d1..6626cc0 100644
--- a/arch/arm/mach-mx3/qong.c
+++ b/arch/arm/mach-mx3/qong.c
@@ -37,6 +37,8 @@
 #include <mach/board-qong.h>
 #include <mach/imx-uart.h>
 #include <mach/iomux-mx3.h>
+#include <mach/ipu.h>
+#include <mach/mx3fb.h>
 #include "devices.h"
 
 /* FPGA defines */
@@ -249,6 +251,84 @@ static void __init qong_init_fpga(void)
 	qong_init_dnet();
 }
 
+static struct ipu_platform_data mx3_ipu_data = {
+	.irq_base = MXC_IPU_IRQ_START,
+};
+
+static const struct fb_videomode fb_modedb[] = {
+	{
+		/* 320x240 @ 60 Hz Vbest */
+		.name		= "Vbest-VGG322403",
+		.refresh	= 60,
+		.xres		= 320,
+		.yres		= 240,
+		.pixclock	= 156000,
+		.left_margin	= 20,
+		.right_margin	= 38,
+		.upper_margin	= 7,
+		.lower_margin	= 26,
+		.hsync_len	= 30,
+		.vsync_len	= 3,
+		.sync		= FB_SYNC_OE_ACT_HIGH,
+		.vmode		= FB_VMODE_NONINTERLACED,
+		.flag		= 0,
+	}, {
+		/* 640x480 @ 60 Hz Casio COM57H5M10XRC */
+		.name		= "COM57H5M10XRC",
+		.refresh	= 60,
+		.xres		= 640,
+		.yres		= 480,
+		.pixclock	= 40000,
+		.left_margin	= 120,
+		.right_margin	= 10,
+		.upper_margin	= 35,
+		.lower_margin	= 7,
+		.hsync_len	= 30,
+		.vsync_len	= 3,
+		.sync		= FB_SYNC_OE_ACT_HIGH,
+		.vmode		= FB_VMODE_NONINTERLACED,
+		.flag		= 0,
+	},
+};
+
+static struct mx3fb_platform_data mx3fb_pdata = {
+	.dma_dev	= &mx3_ipu.dev,
+	.name		= "Vbest-VGG322403",
+	.mode		= fb_modedb,
+	.num_modes	= ARRAY_SIZE(fb_modedb),
+};
+
+void qong_init_lcd(void)
+{
+	/* Init Display Interface */
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD0, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD1, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD2, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD3, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD4, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD5, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD6, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD7, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD8, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD9, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD10, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD11, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD12, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD13, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD14, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD15, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD16, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_LD17, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_VSYNC3, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_HSYNC, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_FPSHIFT, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_DRDY0, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_D3_REV, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_CONTRAST, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_D3_SPL, IOMUX_CONFIG_FUNC));
+	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_D3_CLS, IOMUX_CONFIG_FUNC));
+}
+
 /*
  * Board specific initialization.
  */
@@ -257,6 +337,9 @@ static void __init mxc_board_init(void)
 	mxc_init_imx_uart();
 	qong_init_nor_mtd();
 	qong_init_fpga();
+	qong_init_lcd();
+	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
+	mxc_register_device(&mx3_fb, &mx3fb_pdata);
 }
 
 static void __init qong_timer_init(void)
-- 
1.5.6.3
