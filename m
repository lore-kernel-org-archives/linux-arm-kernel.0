From: s.neumann@raumfeld.com (Sven Neumann)
Date: Wed, 6 May 2009 16:22:50 +0200
Subject: [PATCH] ARM: pxafb: Use the passed fb_var_screeninfo struct in pxafb_pan_display()
Message-ID: <mailman.88.1256193287.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxafb_pan_display() used to ignore the fb_var_screeninfo parameter. Now
pass it to setup_base_frame() instead of pulling default values out of
fb_info.

Signed-off-by: Sven Neumann <s.neumann@raumfeld.com>
Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 drivers/video/pxafb.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 1820c4a..a20a7d4 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -80,7 +80,8 @@
 static int pxafb_activate_var(struct fb_var_screeninfo *var,
 				struct pxafb_info *);
 static void set_ctrlr_state(struct pxafb_info *fbi, u_int state);
-static void setup_base_frame(struct pxafb_info *fbi, int branch);
+static void setup_base_frame(struct pxafb_info *fbi,
+                             struct fb_var_screeninfo *var, int branch);
 static int setup_frame_dma(struct pxafb_info *fbi, int dma, int pal,
 			   unsigned long offset, size_t size);
 
@@ -536,7 +537,7 @@ static int pxafb_pan_display(struct fb_var_screeninfo *var,
 	if (fbi->state != C_ENABLE)
 		return 0;
 
-	setup_base_frame(fbi, 1);
+	setup_base_frame(fbi, var, 1);
 
 	if (fbi->lccr0 & LCCR0_SDS)
 		lcd_writel(fbi, FBR1, fbi->fdadr[dma + 1] | 0x1);
@@ -1052,9 +1053,10 @@ static int setup_frame_dma(struct pxafb_info *fbi, int dma, int pal,
 	return 0;
 }
 
-static void setup_base_frame(struct pxafb_info *fbi, int branch)
+static void setup_base_frame(struct pxafb_info *fbi,
+                             struct fb_var_screeninfo *var,
+                             int branch)
 {
-	struct fb_var_screeninfo *var = &fbi->fb.var;
 	struct fb_fix_screeninfo *fix = &fbi->fb.fix;
 	int nbytes, dma, pal, bpp = var->bits_per_pixel;
 	unsigned long offset;
@@ -1332,7 +1334,7 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
 #endif
 		setup_parallel_timing(fbi, var);
 
-	setup_base_frame(fbi, 0);
+	setup_base_frame(fbi, var, 0);
 
 	fbi->reg_lccr0 = fbi->lccr0 |
 		(LCCR0_LDM | LCCR0_SFM | LCCR0_IUM | LCCR0_EFM |
-- 
1.6.5
