From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Wed,  8 Mar 2017 12:46:38 -0500
Subject: [PATCH 2/2] [kernel] ARM: lpc32xx: drop CLCD configuration
In-Reply-To: <20170308174638.25578-1-slemieux.tyco@gmail.com>
References: <20170308174638.25578-1-slemieux.tyco@gmail.com>
Message-ID: <20170308174638.25578-3-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liam Beguin <lbeguin@tycoint.com>

Drop the CLCD configurations and custom functions
since it's now done using the devicetree.

Signed-off-by: Liam Beguin <lbeguin@tycoint.com>
Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
 arch/arm/mach-lpc32xx/phy3250.c | 70 -----------------------------------------
 1 file changed, 70 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 6c52bd32610e..97bffd9324f3 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -24,8 +24,6 @@
 #include <linux/irq.h>
 #include <linux/dma-mapping.h>
 #include <linux/gpio.h>
-#include <linux/amba/bus.h>
-#include <linux/amba/clcd.h>
 #include <linux/amba/pl08x.h>
 #include <linux/amba/mmci.h>
 #include <linux/of.h>
@@ -45,73 +43,6 @@
 #include <mach/board.h>
 #include "common.h"
 
-/*
- * AMBA LCD controller
- */
-static struct clcd_panel conn_lcd_panel = {
-	.mode		= {
-		.name		= "QVGA portrait",
-		.refresh	= 60,
-		.xres		= 240,
-		.yres		= 320,
-		.pixclock	= 191828,
-		.left_margin	= 22,
-		.right_margin	= 11,
-		.upper_margin	= 2,
-		.lower_margin	= 1,
-		.hsync_len	= 5,
-		.vsync_len	= 2,
-		.sync		= 0,
-		.vmode		= FB_VMODE_NONINTERLACED,
-	},
-	.width		= -1,
-	.height		= -1,
-	.tim2		= (TIM2_IVS | TIM2_IHS),
-	.cntl		= (CNTL_BGR | CNTL_LCDTFT | CNTL_LCDVCOMP(1) |
-				CNTL_LCDBPP16_565),
-	.bpp		= 16,
-};
-#define PANEL_SIZE (3 * SZ_64K)
-
-static int lpc32xx_clcd_setup(struct clcd_fb *fb)
-{
-	dma_addr_t dma;
-
-	fb->fb.screen_base = dma_alloc_wc(&fb->dev->dev, PANEL_SIZE, &dma,
-					  GFP_KERNEL);
-	if (!fb->fb.screen_base) {
-		printk(KERN_ERR "CLCD: unable to map framebuffer\n");
-		return -ENOMEM;
-	}
-
-	fb->fb.fix.smem_start = dma;
-	fb->fb.fix.smem_len = PANEL_SIZE;
-	fb->panel = &conn_lcd_panel;
-
-	return 0;
-}
-
-static int lpc32xx_clcd_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
-{
-	return dma_mmap_wc(&fb->dev->dev, vma, fb->fb.screen_base,
-			   fb->fb.fix.smem_start, fb->fb.fix.smem_len);
-}
-
-static void lpc32xx_clcd_remove(struct clcd_fb *fb)
-{
-	dma_free_wc(&fb->dev->dev, fb->fb.fix.smem_len, fb->fb.screen_base,
-		    fb->fb.fix.smem_start);
-}
-
-static struct clcd_board lpc32xx_clcd_data = {
-	.name		= "Phytec LCD",
-	.check		= clcdfb_check,
-	.decode		= clcdfb_decode,
-	.setup		= lpc32xx_clcd_setup,
-	.mmap		= lpc32xx_clcd_mmap,
-	.remove		= lpc32xx_clcd_remove,
-};
-
 static struct pl08x_channel_data pl08x_slave_channels[] = {
 	{
 		.bus_id = "nand-slc",
@@ -161,7 +92,6 @@ static struct lpc32xx_mlc_platform_data lpc32xx_mlc_data = {
 static const struct of_dev_auxdata lpc32xx_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("arm,pl022", 0x20084000, "dev:ssp0", NULL),
 	OF_DEV_AUXDATA("arm,pl022", 0x2008C000, "dev:ssp1", NULL),
-	OF_DEV_AUXDATA("arm,pl110", 0x31040000, "dev:clcd", &lpc32xx_clcd_data),
 	OF_DEV_AUXDATA("arm,pl080", 0x31000000, "pl08xdmac", &pl08x_pd),
 	OF_DEV_AUXDATA("arm,pl18x", 0x20098000, "20098000.sd",
 		       &lpc32xx_mmci_data),
-- 
2.11.0
