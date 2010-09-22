From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 22 Sep 2010 11:00:19 +0200
Subject: [PATCH v2|RESEND] mx35_3ds: Add the TFT display to the board file
In-Reply-To: <1282645232-23126-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1282645232-23126-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1285146019-20185-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Juergen Beisert <jbe@pengutronix.de>

Add the personality board's display to the board file. Used display is:

Manufacturer: CTP
Type: CLAA070LC0ACW

This is a 800 x 480 wide display with 27 MHz pixel clock and 60 Hz refresh
rate with 18 bit data interface. Sync is based on DE only.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
v1 -> v2
        * removed superfluous comments
        * added S-o-b

 arch/arm/mach-mx3/mach-mx35_3ds.c |   69 +++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index 1dd7baa..60d5753 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -39,10 +39,44 @@
 #include <mach/common.h>
 #include <mach/iomux-mx35.h>
 #include <mach/mxc_ehci.h>
+#include <mach/ipu.h>
+#include <mach/mx3fb.h>
+#include <mach/irqs.h>
 
 #include "devices-imx35.h"
 #include "devices.h"
 
+static const struct fb_videomode fb_personality[] = {
+	{
+		/* 800x480 @ 60 Hz */
+		.name		= "CTP-CLAA070LC0ACW",
+		.refresh	= 60,
+		.xres		= 800,
+		.yres		= 480,
+		.pixclock	= KHZ2PICOS(27000),
+		.left_margin	= 50,
+		.right_margin	= 50,	/* whole line should have 900 clocks */
+		.upper_margin	= 10,
+		.lower_margin	= 10,	/* whole frame should have 500 lines */
+		.hsync_len	= 1,	/* note: DE only display */
+		.vsync_len	= 1,	/* note: DE only display */
+		.sync		= FB_SYNC_CLK_IDLE_EN,
+		.vmode		= FB_VMODE_NONINTERLACED,
+		.flag		= 0,
+	},
+};
+
+static struct ipu_platform_data mx3_ipu_data = {
+	.irq_base = MXC_IPU_IRQ_START,
+};
+
+static struct mx3fb_platform_data mx3fb_pdata = {
+	.dma_dev	= &mx3_ipu.dev,
+	.name		= "CTP-CLAA070LC0ACW",
+	.mode		= fb_personality,
+	.num_modes	= ARRAY_SIZE(fb_personality),
+};
+
 static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
@@ -109,6 +143,38 @@ static struct pad_desc mx35pdk_pads[] = {
 	/* USBH1 */
 	MX35_PAD_I2C2_CLK__USB_TOP_USBH2_PWR,
 	MX35_PAD_I2C2_DAT__USB_TOP_USBH2_OC,
+	/* Display */
+	MX35_PAD_LD0__IPU_DISPB_DAT_0,
+	MX35_PAD_LD1__IPU_DISPB_DAT_1,
+	MX35_PAD_LD2__IPU_DISPB_DAT_2,
+	MX35_PAD_LD3__IPU_DISPB_DAT_3,
+	MX35_PAD_LD4__IPU_DISPB_DAT_4,
+	MX35_PAD_LD5__IPU_DISPB_DAT_5,
+	MX35_PAD_LD6__IPU_DISPB_DAT_6,
+	MX35_PAD_LD7__IPU_DISPB_DAT_7,
+	MX35_PAD_LD8__IPU_DISPB_DAT_8,
+	MX35_PAD_LD9__IPU_DISPB_DAT_9,
+	MX35_PAD_LD10__IPU_DISPB_DAT_10,
+	MX35_PAD_LD11__IPU_DISPB_DAT_11,
+	MX35_PAD_LD12__IPU_DISPB_DAT_12,
+	MX35_PAD_LD13__IPU_DISPB_DAT_13,
+	MX35_PAD_LD14__IPU_DISPB_DAT_14,
+	MX35_PAD_LD15__IPU_DISPB_DAT_15,
+	MX35_PAD_LD16__IPU_DISPB_DAT_16,
+	MX35_PAD_LD17__IPU_DISPB_DAT_17,
+	MX35_PAD_LD18__IPU_DISPB_DAT_18,
+	MX35_PAD_LD19__IPU_DISPB_DAT_19,
+	MX35_PAD_LD20__IPU_DISPB_DAT_20,
+	MX35_PAD_LD21__IPU_DISPB_DAT_21,
+	MX35_PAD_LD22__IPU_DISPB_DAT_22,
+	MX35_PAD_LD23__IPU_DISPB_DAT_23,
+	MX35_PAD_D3_HSYNC__IPU_DISPB_D3_HSYNC,
+	MX35_PAD_D3_FPSHIFT__IPU_DISPB_D3_CLK,
+	MX35_PAD_D3_DRDY__IPU_DISPB_D3_DRDY,
+	MX35_PAD_CONTRAST__IPU_DISPB_CONTR,
+	MX35_PAD_D3_VSYNC__IPU_DISPB_D3_VSYNC,
+	MX35_PAD_D3_REV__IPU_DISPB_D3_REV,
+	MX35_PAD_D3_CLS__IPU_DISPB_D3_CLS,
 };
 
 /* OTG config */
@@ -140,6 +206,9 @@ static void __init mxc_board_init(void)
 	mxc_register_device(&mxc_usbh1, &usb_host_pdata);
 
 	imx35_add_mxc_nand(&mx35pdk_nand_board_info);
+
+	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
+	mxc_register_device(&mx3_fb, &mx3fb_pdata);
 }
 
 static void __init mx35pdk_timer_init(void)
-- 
1.7.2.3
