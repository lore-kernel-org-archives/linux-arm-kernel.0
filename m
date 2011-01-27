From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 13:00:11 +0000
Subject: [PATCH 07/10] ARM: integrator: switch Integrator platforms to use
	consolidated CLCD
In-Reply-To: <20110127125714.GD25968@n2100.arm.linux.org.uk>
References: <20110127125714.GD25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiRSN-0003mz-Oi@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This switches integrator platforms to use the consolidated CLCD
panel support, including the display capabilities.  These capabilities
prevent the unsupported BGR565 mode being selected, while still
allowing RGB5551, BGR5551 and RGB565 modes.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/Kconfig         |    1 +
 arch/arm/mach-integrator/impd1.c         |    5 ++
 arch/arm/mach-integrator/integrator_cp.c |   65 ++++-------------------------
 3 files changed, 15 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index 769b0f1..d701d32 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -13,6 +13,7 @@ config ARCH_INTEGRATOR_CP
 	bool "Support Integrator/CP platform"
 	select ARCH_CINTEGRATOR
 	select ARM_TIMER_SP804
+	select PLAT_VERSATILE_CLCD
 	help
 	  Include support for the ARM(R) Integrator CP platform.
 
diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index 5db574f..8cbb75a 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -121,6 +121,7 @@ static struct clcd_panel vga = {
 	.height		= -1,
 	.tim2		= TIM2_BCD | TIM2_IPC,
 	.cntl		= CNTL_LCDTFT | CNTL_LCDVCOMP(1),
+	.caps		= CLCD_CAP_5551,
 	.connector	= IMPD1_CTRL_DISP_VGA,
 	.bpp		= 16,
 	.grayscale	= 0,
@@ -149,6 +150,7 @@ static struct clcd_panel svga = {
 	.tim2		= TIM2_BCD,
 	.cntl		= CNTL_LCDTFT | CNTL_LCDVCOMP(1),
 	.connector	= IMPD1_CTRL_DISP_VGA,
+	.caps		= CLCD_CAP_5551,
 	.bpp		= 16,
 	.grayscale	= 0,
 };
@@ -175,6 +177,7 @@ static struct clcd_panel prospector = {
 	.height		= -1,
 	.tim2		= TIM2_BCD,
 	.cntl		= CNTL_LCDTFT | CNTL_LCDVCOMP(1),
+	.caps		= CLCD_CAP_5551,
 	.fixedtimings	= 1,
 	.connector	= IMPD1_CTRL_DISP_LCD,
 	.bpp		= 16,
@@ -206,6 +209,7 @@ static struct clcd_panel ltm10c209 = {
 	.height		= -1,
 	.tim2		= TIM2_BCD,
 	.cntl		= CNTL_LCDTFT | CNTL_LCDVCOMP(1),
+	.caps		= CLCD_CAP_5551,
 	.fixedtimings	= 1,
 	.connector	= IMPD1_CTRL_DISP_LCD,
 	.bpp		= 16,
@@ -279,6 +283,7 @@ static void impd1fb_clcd_remove(struct clcd_fb *fb)
 
 static struct clcd_board impd1_clcd_data = {
 	.name		= "IM-PD/1",
+	.caps		= CLCD_CAP_5551 | CLCD_CAP_888,
 	.check		= clcdfb_check,
 	.decode		= clcdfb_decode,
 	.disable	= impd1fb_clcd_disable,
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 8600902..9c02037 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -42,6 +42,8 @@
 
 #include <asm/hardware/timer-sp.h>
 
+#include <plat/clcd.h>
+
 #include "common.h"
 
 #define INTCP_PA_FLASH_BASE		0x24000000
@@ -449,30 +451,6 @@ static struct amba_device aaci_device = {
 /*
  * CLCD support
  */
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
-	.grayscale	= 0,
-};
-
 /*
  * Ensure VGA is selected.
  */
@@ -500,49 +478,24 @@ static void cp_clcd_enable(struct clcd_fb *fb)
 		   CM_CTRL_n24BITEN, val);
 }
 
-static unsigned long framesize = SZ_1M;
-
 static int cp_clcd_setup(struct clcd_fb *fb)
 {
-	dma_addr_t dma;
-
-	fb->panel = &vga;
-
-	fb->fb.screen_base = dma_alloc_writecombine(&fb->dev->dev, framesize,
-						    &dma, GFP_KERNEL);
-	if (!fb->fb.screen_base) {
-		printk(KERN_ERR "CLCD: unable to map framebuffer\n");
-		return -ENOMEM;
-	}
-
-	fb->fb.fix.smem_start	= dma;
-	fb->fb.fix.smem_len	= framesize;
-
-	return 0;
-}
-
-static int cp_clcd_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
-{
-	return dma_mmap_writecombine(&fb->dev->dev, vma,
-				     fb->fb.screen_base,
-				     fb->fb.fix.smem_start,
-				     fb->fb.fix.smem_len);
-}
+	fb->panel = versatile_clcd_get_panel("VGA");
+	if (!fb->panel)
+		return -EINVAL;
 
-static void cp_clcd_remove(struct clcd_fb *fb)
-{
-	dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
-			      fb->fb.screen_base, fb->fb.fix.smem_start);
+	return versatile_clcd_setup_dma(fb, SZ_1M);
 }
 
 static struct clcd_board clcd_data = {
 	.name		= "Integrator/CP",
+	.caps		= CLCD_CAP_5551 | CLCD_CAP_RGB565 | CLCD_CAP_888,
 	.check		= clcdfb_check,
 	.decode		= clcdfb_decode,
 	.enable		= cp_clcd_enable,
 	.setup		= cp_clcd_setup,
-	.mmap		= cp_clcd_mmap,
-	.remove		= cp_clcd_remove,
+	.mmap		= versatile_clcd_mmap_dma,
+	.remove		= versatile_clcd_remove_dma,
 };
 
 static struct amba_device clcd_device = {
-- 
1.6.2.5
