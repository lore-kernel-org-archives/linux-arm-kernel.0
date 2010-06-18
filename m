From: l.fu@pengutronix.de (Luotao Fu)
Date: Fri, 18 Jun 2010 09:23:18 +0200
Subject: [PATCH 1/2 V2] pca100: add framebuffer device support and TFT
In-Reply-To: <1275573348-26564-3-git-send-email-l.fu@pengutronix.de>
References: <1275573348-26564-3-git-send-email-l.fu@pengutronix.de>
Message-ID: <1276845799-6122-2-git-send-email-l.fu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this one adds the frambuffer device and a TFT panel to the PhyCard-S
(pca100) board.

Signed-off-by: Luotao Fu <l.fu@pengutronix.de>

---
V2 Changes: removed undefined LVDS_PWR macro.

 arch/arm/mach-mx2/mach-pca100.c |   66 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx2/mach-pca100.c b/arch/arm/mach-mx2/mach-pca100.c
index a87422e..47173d1 100644
--- a/arch/arm/mach-mx2/mach-pca100.c
+++ b/arch/arm/mach-mx2/mach-pca100.c
@@ -49,6 +49,7 @@
 #include <mach/mmc.h>
 #include <mach/mxc_ehci.h>
 #include <mach/ulpi.h>
+#include <mach/imxfb.h>
 
 #include "devices.h"
 
@@ -131,6 +132,30 @@ static int pca100_pins[] = {
 	PD23_AF_USBH2_DATA2,
 	PD24_AF_USBH2_DATA1,
 	PD26_AF_USBH2_DATA5,
+	/* display */
+	PA5_PF_LSCLK,
+	PA6_PF_LD0,
+	PA7_PF_LD1,
+	PA8_PF_LD2,
+	PA9_PF_LD3,
+	PA10_PF_LD4,
+	PA11_PF_LD5,
+	PA12_PF_LD6,
+	PA13_PF_LD7,
+	PA14_PF_LD8,
+	PA15_PF_LD9,
+	PA16_PF_LD10,
+	PA17_PF_LD11,
+	PA18_PF_LD12,
+	PA19_PF_LD13,
+	PA20_PF_LD14,
+	PA21_PF_LD15,
+	PA22_PF_LD16,
+	PA23_PF_LD17,
+	PA26_PF_PS,
+	PA28_PF_HSYNC,
+	PA29_PF_VSYNC,
+	PA31_PF_OE_ACD,
 };
 
 static struct imxuart_platform_data uart_pdata = {
@@ -297,6 +322,45 @@ static int __init pca100_otg_mode(char *options)
 }
 __setup("otg_mode=", pca100_otg_mode);
 
+/* framebuffer info */
+static struct imx_fb_videomode pca100_fb_modes[] = {
+	{
+		.mode = {
+			.name		= "EMERGING-ETV570G0DHU",
+			.refresh	= 60,
+			.xres		= 640,
+			.yres		= 480,
+			.pixclock	= 39722, /* in ps (25.175 MHz) */
+			.hsync_len	= 30,
+			.left_margin	= 114,
+			.right_margin	= 16,
+			.vsync_len	= 3,
+			.upper_margin	= 32,
+			.lower_margin	= 0,
+		},
+		/*
+		 * TFT
+		 * Pixel pol active high
+		 * HSYNC active low
+		 * VSYNC active low
+		 * use HSYNC for ACD count
+		 * line clock disable while idle
+		 * always enable line clock even if no data
+		 */
+		.pcr = 0xf0c08080,
+		.bpp = 16,
+	},
+};
+
+static struct imx_fb_platform_data pca100_fb_data = {
+	.mode = pca100_fb_modes,
+	.num_modes = ARRAY_SIZE(pca100_fb_modes),
+
+	.pwmr		= 0x00A903FF,
+	.lscr1		= 0x00120300,
+	.dmacr		= 0x00020010,
+};
+
 static void __init pca100_init(void)
 {
 	int ret;
@@ -372,6 +436,8 @@ static void __init pca100_init(void)
 		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
 	}
 
+	mxc_register_device(&mxc_fb_device, &pca100_fb_data);
+
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 }
 
-- 
1.7.1
