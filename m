From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 13:00:52 +0000
Subject: [PATCH 09/10] ARM: realview: switch Realview to use consolidated CLCD
In-Reply-To: <20110127125714.GD25968@n2100.arm.linux.org.uk>
References: <20110127125714.GD25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiRT2-0003nA-K4@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This switches Realview platforms to use the consolidated CLCD panel
support, including the display capabilities.  As Realview uses a PL111,
it can support the full range of pixel formats - 444, 5551, 565 in both
RGB and BGR mode.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig              |    1 +
 arch/arm/mach-realview/core.c |  214 +++++++----------------------------------
 2 files changed, 35 insertions(+), 180 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b0d55b9..7ee15c2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -241,6 +241,7 @@ config ARCH_REALVIEW
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select PLAT_VERSATILE
+	select PLAT_VERSATILE_CLCD
 	select ARM_TIMER_SP804
 	select GPIO_PL061 if GPIOLIB
 	help
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 1c6602c..a18a5a6 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -51,6 +51,7 @@
 #include <mach/irqs.h>
 #include <asm/hardware/timer-sp.h>
 
+#include <plat/clcd.h>
 #include <plat/sched_clock.h>
 
 #include "core.h"
@@ -385,157 +386,6 @@ core_initcall(clk_init);
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
-	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
-	.bpp		= 16,
-};
-
-static struct clcd_panel xvga = {
-	.mode		= {
-		.name		= "XVGA",
-		.refresh	= 60,
-		.xres		= 1024,
-		.yres		= 768,
-		.pixclock	= 15748,
-		.left_margin	= 152,
-		.right_margin	= 48,
-		.upper_margin	= 23,
-		.lower_margin	= 3,
-		.hsync_len	= 104,
-		.vsync_len	= 4,
-		.sync		= 0,
-		.vmode		= FB_VMODE_NONINTERLACED,
-	},
-	.width		= -1,
-	.height		= -1,
-	.tim2		= TIM2_BCD | TIM2_IPC,
-	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
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
-	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
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
-	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
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
-	.cntl		= CNTL_LCDTFT | CNTL_BGR | CNTL_LCDVCOMP(1),
-	.bpp		= 16,
-};
-
-/*
- * Detect which LCD panel is connected, and return the appropriate
- * clcd_panel structure.  Note: we do not have any information on
- * the required timings for the 8.4in panel, so we presently assume
- * VGA timings.
- */
-static struct clcd_panel *realview_clcd_panel(void)
-{
-	void __iomem *sys_clcd = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_CLCD_OFFSET;
-	struct clcd_panel *vga_panel;
-	struct clcd_panel *panel;
-	u32 val;
-
-	if (machine_is_realview_eb())
-		vga_panel = &vga;
-	else
-		vga_panel = &xvga;
-
-	val = readl(sys_clcd) & SYS_CLCD_ID_MASK;
-	if (val == SYS_CLCD_ID_SANYO_3_8)
-		panel = &sanyo_3_8_in;
-	else if (val == SYS_CLCD_ID_SANYO_2_5)
-		panel = &sanyo_2_5_in;
-	else if (val == SYS_CLCD_ID_EPSON_2_2)
-		panel = &epson_2_2_in;
-	else if (val == SYS_CLCD_ID_VGA)
-		panel = vga_panel;
-	else {
-		printk(KERN_ERR "CLCD: unknown LCD panel ID 0x%08x, using VGA\n",
-			val);
-		panel = vga_panel;
-	}
-
-	return panel;
-}
-
 /*
  * Disable all display connectors on the interface module.
  */
@@ -565,56 +415,60 @@ static void realview_clcd_enable(struct clcd_fb *fb)
 	writel(val, sys_clcd);
 }
 
+/*
+ * Detect which LCD panel is connected, and return the appropriate
+ * clcd_panel structure.  Note: we do not have any information on
+ * the required timings for the 8.4in panel, so we presently assume
+ * VGA timings.
+ */
 static int realview_clcd_setup(struct clcd_fb *fb)
 {
+	void __iomem *sys_clcd = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_CLCD_OFFSET;
+	const char *panel_name, *vga_panel_name;
 	unsigned long framesize;
-	dma_addr_t dma;
+	u32 val;
 
-	if (machine_is_realview_eb())
+	if (machine_is_realview_eb()) {
 		/* VGA, 16bpp */
 		framesize = 640 * 480 * 2;
-	else
+		vga_panel_name = "VGA";
+	} else {
 		/* XVGA, 16bpp */
 		framesize = 1024 * 768 * 2;
-
-	fb->panel		= realview_clcd_panel();
-
-	fb->fb.screen_base = dma_alloc_writecombine(&fb->dev->dev, framesize,
-						    &dma, GFP_KERNEL | GFP_DMA);
-	if (!fb->fb.screen_base) {
-		printk(KERN_ERR "CLCD: unable to map framebuffer\n");
-		return -ENOMEM;
+		vga_panel_name = "XVGA";
 	}
 
-	fb->fb.fix.smem_start	= dma;
-	fb->fb.fix.smem_len	= framesize;
-
-	return 0;
-}
+	val = readl(sys_clcd) & SYS_CLCD_ID_MASK;
+	if (val == SYS_CLCD_ID_SANYO_3_8)
+		panel_name = "Sanyo TM38QV67A02A";
+	else if (val == SYS_CLCD_ID_SANYO_2_5)
+		panel_name = "Sanyo QVGA Portrait";
+	else if (val == SYS_CLCD_ID_EPSON_2_2)
+		panel_name = "Epson L2F50113T00";
+	else if (val == SYS_CLCD_ID_VGA)
+		panel_name = vga_panel_name;
+	else {
+		pr_err("CLCD: unknown LCD panel ID 0x%08x, using VGA\n", val);
+		panel_name = vga_panel_name;
+	}
 
-static int realview_clcd_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
-{
-	return dma_mmap_writecombine(&fb->dev->dev, vma,
-				     fb->fb.screen_base,
-				     fb->fb.fix.smem_start,
-				     fb->fb.fix.smem_len);
-}
+	fb->panel = versatile_clcd_get_panel(panel_name);
+	if (!fb->panel)
+		return -EINVAL;
 
-static void realview_clcd_remove(struct clcd_fb *fb)
-{
-	dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
-			      fb->fb.screen_base, fb->fb.fix.smem_start);
+	return versatile_clcd_setup_dma(fb, framesize);
 }
 
 struct clcd_board clcd_plat_data = {
 	.name		= "RealView",
+	.caps		= CLCD_CAP_ALL,
 	.check		= clcdfb_check,
 	.decode		= clcdfb_decode,
 	.disable	= realview_clcd_disable,
 	.enable		= realview_clcd_enable,
 	.setup		= realview_clcd_setup,
-	.mmap		= realview_clcd_mmap,
-	.remove		= realview_clcd_remove,
+	.mmap		= versatile_clcd_mmap_dma,
+	.remove		= versatile_clcd_remove_dma,
 };
 
 #ifdef CONFIG_LEDS
-- 
1.6.2.5
