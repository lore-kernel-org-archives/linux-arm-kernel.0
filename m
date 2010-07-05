From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 05 Jul 2010 11:16:54 +0200
Subject: [PATCH 1/3] arm: s5pv210: GONI: add support for framebuffer
In-Reply-To: <1278321416-32524-1-git-send-email-m.szyprowski@samsung.com>
References: <1278321416-32524-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1278321416-32524-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds required platform definitions to enable s3c-fb
driver on GONI board. One framebuffer window in 480x800x16bpp mode is
defined.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig     |    2 +
 arch/arm/mach-s5pv210/mach-goni.c |   39 +++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 5e88941..8ab4bb0 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -59,6 +59,8 @@ config MACH_GONI
 	bool "GONI"
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
+	select S5PV210_SETUP_FB_24BPP
+	select S3C_DEV_FB
 	select S5PC110_DEV_ONENAND
 	help
 	  Machine support for Samsung GONI board
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 88c38e3..05b4a1a 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -12,6 +12,9 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/serial_core.h>
+#include <linux/fb.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -20,11 +23,15 @@
 
 #include <mach/map.h>
 #include <mach/regs-clock.h>
+#include <mach/regs-fb.h>
+#include <mach/gpio.h>
 
+#include <plat/gpio-cfg.h>
 #include <plat/regs-serial.h>
 #include <plat/s5pv210.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
+#include <plat/fb.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -73,7 +80,35 @@ static struct s3c2410_uartcfg goni_uartcfgs[] __initdata = {
 	},
 };
 
+/* Frame Buffer */
+static struct s3c_fb_pd_win goni_fb_win0 = {
+	.win_mode = {
+		.pixclock = 1000000000000ULL / ((16+16+2+480)*(28+3+2+800)*55),
+		.left_margin = 16,
+		.right_margin = 16,
+		.upper_margin = 3,
+		.lower_margin = 28,
+		.hsync_len = 2,
+		.vsync_len = 2,
+		.xres = 480,
+		.yres = 800,
+		.refresh = 55,
+	},
+	.max_bpp = 32,
+	.default_bpp = 16,
+};
+
+static struct s3c_fb_platdata goni_lcd_pdata __initdata = {
+	.win[0]	= &goni_fb_win0,
+	.vidcon0		= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB |
+					VIDCON0_CLKSEL_LCD,
+	.vidcon1		= VIDCON1_INV_VCLK | VIDCON1_INV_VDEN
+				| VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
+	.setup_gpio		= s5pv210_fb_gpio_setup_24bpp,
+};
+
 static struct platform_device *goni_devices[] __initdata = {
+	&s3c_device_fb,
 	&s5pc110_device_onenand,
 };
 
@@ -86,6 +121,10 @@ static void __init goni_map_io(void)
 
 static void __init goni_machine_init(void)
 {
+
+	/* FB */
+	s3c_fb_set_platdata(&goni_lcd_pdata);
+
 	platform_add_devices(goni_devices, ARRAY_SIZE(goni_devices));
 }
 
-- 
1.7.1.569.g6f426
