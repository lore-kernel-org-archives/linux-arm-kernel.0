From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 20 May 2010 08:13:05 +0200
Subject: [PATCH 5/7] ARM: S5PV210: add support for s3c-fb driver on Aquila
	machine
In-Reply-To: <1274335987-1141-1-git-send-email-m.szyprowski@samsung.com>
References: <1274335987-1141-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1274335987-1141-6-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds required platform definitions to enable s3c-fb
driver. Two framebuffer windows in 480x800x16bpp mode are defined.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig       |    2 +
 arch/arm/mach-s5pv210/mach-aquila.c |   49 +++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 9a05e16..073d9c5 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -41,6 +41,8 @@ config MACH_AQUILA
 	bool "Samsung Aquila"
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
+	select S5PV210_SETUP_FB_24BPP
+	select S3C_DEV_FB
 	help
 	  Machine support for the Samsung Aquila target based on S5PC110 SoC
 
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 6a1db39..10bc76e 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/serial_core.h>
+#include <linux/fb.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -20,11 +21,13 @@
 
 #include <mach/map.h>
 #include <mach/regs-clock.h>
+#include <mach/regs-fb.h>
 
 #include <plat/regs-serial.h>
 #include <plat/s5pv210.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
+#include <plat/fb.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -71,7 +74,50 @@ static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 	},
 };
 
+/* Frame Buffer */
+static struct s3c_fb_pd_win aquila_fb_win0 = {
+	.win_mode = {
+		.pixclock = 1000000000000ULL / ((16+16+2+480)*(28+3+2+800)*60),
+		.left_margin = 16,
+		.right_margin = 16,
+		.upper_margin = 3,
+		.lower_margin = 28,
+		.hsync_len = 2,
+		.vsync_len = 2,
+		.xres = 480,
+		.yres = 800,
+	},
+	.max_bpp = 32,
+	.default_bpp = 16,
+};
+
+static struct s3c_fb_pd_win aquila_fb_win1 = {
+	.win_mode = {
+		.pixclock = 1000000000000ULL / ((16+16+2+480)*(28+3+2+800)*60),
+		.left_margin = 16,
+		.right_margin = 16,
+		.upper_margin = 3,
+		.lower_margin = 28,
+		.hsync_len = 2,
+		.vsync_len = 2,
+		.xres = 480,
+		.yres = 800,
+	},
+	.max_bpp = 32,
+	.default_bpp = 16,
+};
+
+static struct s3c_fb_platdata aquila_lcd_pdata __initdata = {
+	.win[0]		= &aquila_fb_win0,
+	.win[1]		= &aquila_fb_win1,
+	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
+	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC |
+			  VIDCON1_INV_VCLK | VIDCON1_INV_VDEN,
+	.setup_gpio	= s5pv210_fb_gpio_setup_24bpp,
+};
+
 static struct platform_device *aquila_devices[] __initdata = {
+	&s3c_device_fb,
 };
 
 static void __init aquila_map_io(void)
@@ -83,6 +129,9 @@ static void __init aquila_map_io(void)
 
 static void __init aquila_machine_init(void)
 {
+	/* FB */
+	s3c_fb_set_platdata(&aquila_lcd_pdata);
+
 	platform_add_devices(aquila_devices, ARRAY_SIZE(aquila_devices));
 }
 
-- 
1.6.4
