From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 13:00:32 +0000
Subject: [PATCH 08/10] ARM: versatile: switch Versatile to use consolidated
	CLCD
In-Reply-To: <20110127125714.GD25968@n2100.arm.linux.org.uk>
References: <20110127125714.GD25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiRSi-0003n3-6A@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This switches Versatile platforms to use the consolidated CLCD panel
support, including the display capabilities.  Versatile can support
RGB5551, BGR5551, RGB565 and BGR565 modes.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig               |    1 +
 arch/arm/mach-versatile/core.c |  186 ++++++++--------------------------------
 2 files changed, 36 insertions(+), 151 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3087985..b0d55b9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -256,6 +256,7 @@ config ARCH_VERSATILE
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select PLAT_VERSATILE
+	select PLAT_VERSATILE_CLCD
 	select ARM_TIMER_SP804
 	help
 	  This enables support for ARM Ltd Versatile board.
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 2866c11..b4f1f17 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -50,6 +50,7 @@
 #include <mach/platform.h>
 #include <asm/hardware/timer-sp.h>
 
+#include <plat/clcd.h>
 #include <plat/sched_clock.h>
 
 #include "core.h"
@@ -476,127 +477,7 @@ static struct clk_lookup lookups[] = {
 #define SYS_CLCD_ID_SANYO_2_5	(0x07 << 8)
 #define SYS_CLCD_ID_VGA		(0x1f << 8)
 
-static struct clcd_panel vga = {
-	.mode		= {
-		.name		= "VGA",
-		.refresh	= 60,
-		.xres		= 640,
-		.yres		= 480,
-		.pixclock	= 39721,
-		.left_margin	= 40,
-		.right_margin	= 24,
-		.upper_margin	= 32,
-		.lower_margin	= 11,
-		.hsync_len	= 96,
-		.vsync_len	= 2,
-		.sync		= 0,
-		.vmode		= FB_VMODE_NONINTERLACED,
-	},
-	.width		= -1,
-	.height		= -1,
-	.tim2		= TIM2_BCD | TIM2_IPC,
-	.cntl		= CNTL_LCDTFT | CNTL_LCDVCOMP(1),
-	.bpp		= 16,
-};
-
-static struct clcd_panel sanyo_3_8_in = {
-	.mode		= {
-		.name		= "Sanyo QVGA",
-		.refresh	= 116,
-		.xres		= 320,
-		.yres		= 240,
-		.pixclock	= 100000,
-		.left_margin	= 6,
-		.right_margin	= 6,
-		.upper_margin	= 5,
-		.lower_margin	= 5,
-		.hsync_len	= 6,
-		.vsync_len	= 6,
-		.sync		= 0,
-		.vmode		= FB_VMODE_NONINTERLACED,
-	},
-	.width		= -1,
-	.height		= -1,
-	.tim2		= TIM2_BCD,
-	.cntl		= CNTL_LCDTFT | CNTL_LCDVCOMP(1),
-	.bpp		= 16,
-};
-
-static struct clcd_panel sanyo_2_5_in = {
-	.mode		= {
-		.name		= "Sanyo QVGA Portrait",
-		.refresh	= 116,
-		.xres		= 240,
-		.yres		= 320,
-		.pixclock	= 100000,
-		.left_margin	= 20,
-		.right_margin	= 10,
-		.upper_margin	= 2,
-		.lower_margin	= 2,
-		.hsync_len	= 10,
-		.vsync_len	= 2,
-		.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		.vmode		= FB_VMODE_NONINTERLACED,
-	},
-	.width		= -1,
-	.height		= -1,
-	.tim2		= TIM2_IVS | TIM2_IHS | TIM2_IPC,
-	.cntl		= CNTL_LCDTFT | CNTL_LCDVCOMP(1),
-	.bpp		= 16,
-};
-
-static struct clcd_panel epson_2_2_in = {
-	.mode		= {
-		.name		= "Epson QCIF",
-		.refresh	= 390,
-		.xres		= 176,
-		.yres		= 220,
-		.pixclock	= 62500,
-		.left_margin	= 3,
-		.right_margin	= 2,
-		.upper_margin	= 1,
-		.lower_margin	= 0,
-		.hsync_len	= 3,
-		.vsync_len	= 2,
-		.sync		= 0,
-		.vmode		= FB_VMODE_NONINTERLACED,
-	},
-	.width		= -1,
-	.height		= -1,
-	.tim2		= TIM2_BCD | TIM2_IPC,
-	.cntl		= CNTL_LCDTFT | CNTL_LCDVCOMP(1),
-	.bpp		= 16,
-};
-
-/*
- * Detect which LCD panel is connected, and return the appropriate
- * clcd_panel structure.  Note: we do not have any information on
- * the required timings for the 8.4in panel, so we presently assume
- * VGA timings.
- */
-static struct clcd_panel *versatile_clcd_panel(void)
-{
-	void __iomem *sys_clcd = __io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_CLCD_OFFSET;
-	struct clcd_panel *panel = &vga;
-	u32 val;
-
-	val = readl(sys_clcd) & SYS_CLCD_ID_MASK;
-	if (val == SYS_CLCD_ID_SANYO_3_8)
-		panel = &sanyo_3_8_in;
-	else if (val == SYS_CLCD_ID_SANYO_2_5)
-		panel = &sanyo_2_5_in;
-	else if (val == SYS_CLCD_ID_EPSON_2_2)
-		panel = &epson_2_2_in;
-	else if (val == SYS_CLCD_ID_VGA)
-		panel = &vga;
-	else {
-		printk(KERN_ERR "CLCD: unknown LCD panel ID 0x%08x, using VGA\n",
-			val);
-		panel = &vga;
-	}
-
-	return panel;
-}
+static bool is_sanyo_2_5_lcd;
 
 /*
  * Disable all display connectors on the interface module.
@@ -614,7 +495,7 @@ static void versatile_clcd_disable(struct clcd_fb *fb)
 	/*
 	 * If the LCD is Sanyo 2x5 in on the IB2 board, turn the back-light off
 	 */
-	if (machine_is_versatile_ab() && fb->panel == &sanyo_2_5_in) {
+	if (machine_is_versatile_ab() && is_sanyo_2_5_lcd) {
 		void __iomem *versatile_ib2_ctrl = __io_address(VERSATILE_IB2_CTRL);
 		unsigned long ctrl;
 
@@ -667,7 +548,7 @@ static void versatile_clcd_enable(struct clcd_fb *fb)
 	/*
 	 * If the LCD is Sanyo 2x5 in on the IB2 board, turn the back-light on
 	 */
-	if (machine_is_versatile_ab() && fb->panel == &sanyo_2_5_in) {
+	if (machine_is_versatile_ab() && is_sanyo_2_5_lcd) {
 		void __iomem *versatile_ib2_ctrl = __io_address(VERSATILE_IB2_CTRL);
 		unsigned long ctrl;
 
@@ -678,39 +559,41 @@ static void versatile_clcd_enable(struct clcd_fb *fb)
 #endif
 }
 
-static unsigned long framesize = SZ_1M;
-
+/*
+ * Detect which LCD panel is connected, and return the appropriate
+ * clcd_panel structure.  Note: we do not have any information on
+ * the required timings for the 8.4in panel, so we presently assume
+ * VGA timings.
+ */
 static int versatile_clcd_setup(struct clcd_fb *fb)
 {
-	dma_addr_t dma;
+	void __iomem *sys_clcd = __io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_CLCD_OFFSET;
+	const char *panel_name;
+	u32 val;
 
-	fb->panel		= versatile_clcd_panel();
+	is_sanyo_2_5_lcd = false;
 
-	fb->fb.screen_base = dma_alloc_writecombine(&fb->dev->dev, framesize,
-						    &dma, GFP_KERNEL);
-	if (!fb->fb.screen_base) {
-		printk(KERN_ERR "CLCD: unable to map framebuffer\n");
-		return -ENOMEM;
+	val = readl(sys_clcd) & SYS_CLCD_ID_MASK;
+	if (val == SYS_CLCD_ID_SANYO_3_8)
+		panel_name = "Sanyo TM38QV67A02A";
+	else if (val == SYS_CLCD_ID_SANYO_2_5) {
+		panel_name = "Sanyo QVGA Portrait";
+		is_sanyo_2_5_lcd = true;
+	} else if (val == SYS_CLCD_ID_EPSON_2_2)
+		panel_name = "Epson L2F50113T00";
+	else if (val == SYS_CLCD_ID_VGA)
+		panel_name = "VGA";
+	else {
+		printk(KERN_ERR "CLCD: unknown LCD panel ID 0x%08x, using VGA\n",
+			val);
+		panel_name = "VGA";
 	}
 
-	fb->fb.fix.smem_start	= dma;
-	fb->fb.fix.smem_len	= framesize;
+	fb->panel = versatile_clcd_get_panel(panel_name);
+	if (!fb->panel)
+		return -EINVAL;
 
-	return 0;
-}
-
-static int versatile_clcd_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
-{
-	return dma_mmap_writecombine(&fb->dev->dev, vma,
-				     fb->fb.screen_base,
-				     fb->fb.fix.smem_start,
-				     fb->fb.fix.smem_len);
-}
-
-static void versatile_clcd_remove(struct clcd_fb *fb)
-{
-	dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
-			      fb->fb.screen_base, fb->fb.fix.smem_start);
+	return versatile_clcd_setup_dma(fb, SZ_1M);
 }
 
 static void versatile_clcd_decode(struct clcd_fb *fb, struct clcd_regs *regs)
@@ -724,13 +607,14 @@ static void versatile_clcd_decode(struct clcd_fb *fb, struct clcd_regs *regs)
 
 static struct clcd_board clcd_plat_data = {
 	.name		= "Versatile",
+	.caps		= CLCD_CAP_5551 | CLCD_CAP_565 | CLCD_CAP_888,
 	.check		= clcdfb_check,
 	.decode		= versatile_clcd_decode,
 	.disable	= versatile_clcd_disable,
 	.enable		= versatile_clcd_enable,
 	.setup		= versatile_clcd_setup,
-	.mmap		= versatile_clcd_mmap,
-	.remove		= versatile_clcd_remove,
+	.mmap		= versatile_clcd_mmap_dma,
+	.remove		= versatile_clcd_remove_dma,
 };
 
 static struct pl061_platform_data gpio0_plat_data = {
-- 
1.6.2.5
