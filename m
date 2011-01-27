From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 13:01:13 +0000
Subject: [PATCH 10/10] ARM: vexpress: switch Versatile Express to use
	consolidated CLCD
In-Reply-To: <20110127125714.GD25968@n2100.arm.linux.org.uk>
References: <20110127125714.GD25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiRTN-0003nV-1j@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This switches Versatile Express to use the conslidated CLCD panel
support, including the display capabilities.  As Versatile Express uses
a PL111, it can support the full range of pixel formats - 444, 5551,
565 in both RGB and BGR mode.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig                  |    1 +
 arch/arm/mach-vexpress/ct-ca9x4.c |   58 ++++++-------------------------------
 2 files changed, 10 insertions(+), 49 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7ee15c2..4f0e83e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -274,6 +274,7 @@ config ARCH_VEXPRESS
 	select HAVE_PATA_PLATFORM
 	select ICST
 	select PLAT_VERSATILE
+	select PLAT_VERSATILE_CLCD
 	help
 	  This enables support for the ARM Ltd Versatile Express boards.
 
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index e628402..27baed1 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -30,6 +30,8 @@
 
 #include <mach/motherboard.h>
 
+#include <plat/clcd.h>
+
 #define V2M_PA_CS7	0x10000000
 
 static struct map_desc ct_ca9x4_io_desc[] __initdata = {
@@ -80,29 +82,6 @@ static struct sys_timer ct_ca9x4_timer = {
 };
 #endif
 
-static struct clcd_panel xvga_panel = {
-	.mode		= {
-		.name		= "XVGA",
-		.refresh	= 60,
-		.xres		= 1024,
-		.yres		= 768,
-		.pixclock	= 15384,
-		.left_margin	= 168,
-		.right_margin	= 8,
-		.upper_margin	= 29,
-		.lower_margin	= 3,
-		.hsync_len	= 144,
-		.vsync_len	= 6,
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
 static void ct_ca9x4_clcd_enable(struct clcd_fb *fb)
 {
 	v2m_cfg_write(SYS_CFG_MUXFPGA | SYS_CFG_SITE_DB1, 0);
@@ -112,42 +91,23 @@ static void ct_ca9x4_clcd_enable(struct clcd_fb *fb)
 static int ct_ca9x4_clcd_setup(struct clcd_fb *fb)
 {
 	unsigned long framesize = 1024 * 768 * 2;
-	dma_addr_t dma;
-
-	fb->panel = &xvga_panel;
 
-	fb->fb.screen_base = dma_alloc_writecombine(&fb->dev->dev, framesize,
-				&dma, GFP_KERNEL);
-	if (!fb->fb.screen_base) {
-		printk(KERN_ERR "CLCD: unable to map frame buffer\n");
-		return -ENOMEM;
-	}
-	fb->fb.fix.smem_start = dma;
-	fb->fb.fix.smem_len = framesize;
+	fb->panel = versatile_clcd_get_panel("XVGA");
+	if (!fb->panel)
+		return -EINVAL;
 
-	return 0;
-}
-
-static int ct_ca9x4_clcd_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
-{
-	return dma_mmap_writecombine(&fb->dev->dev, vma, fb->fb.screen_base,
-		fb->fb.fix.smem_start, fb->fb.fix.smem_len);
-}
-
-static void ct_ca9x4_clcd_remove(struct clcd_fb *fb)
-{
-	dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
-		fb->fb.screen_base, fb->fb.fix.smem_start);
+	return versatile_clcd_setup_dma(fb, framesize);
 }
 
 static struct clcd_board ct_ca9x4_clcd_data = {
 	.name		= "CT-CA9X4",
+	.caps		= CLCD_CAP_5551 | CLCD_CAP_565,
 	.check		= clcdfb_check,
 	.decode		= clcdfb_decode,
 	.enable		= ct_ca9x4_clcd_enable,
 	.setup		= ct_ca9x4_clcd_setup,
-	.mmap		= ct_ca9x4_clcd_mmap,
-	.remove		= ct_ca9x4_clcd_remove,
+	.mmap		= versatile_clcd_mmap_dma,
+	.remove		= versatile_clcd_remove_dma,
 };
 
 static AMBA_DEVICE(clcd, "ct:clcd", CT_CA9X4_CLCDC, &ct_ca9x4_clcd_data);
-- 
1.6.2.5
