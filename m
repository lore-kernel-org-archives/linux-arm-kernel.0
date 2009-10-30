From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 30 Oct 2009 12:06:16 +0100
Subject: [PATCH] [ARM] pxafb: only take some fields of var in pxafb_pan_display()
Message-ID: <mailman.97.1256901572.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 3a8552e made pxafb pay attention to paramters passed to
pxafb_pan_display(). As Ville Syrj?l? pointed out, this is potentially
dangerous as user could pass in any other screeninfo parameters as well,
and not only such that are relevant for display panning.

This patch fixed that by limiting the arguments actually used to
.xoffset, .yoffset and .vmode & FB_VMODE_YWRAP.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Ville Syrj?l? <syrjala@sci.fi>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Sven Neumann <s.neumann@raumfeld.com>
---
 drivers/video/pxafb.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index a20a7d4..e5ceda5 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -532,12 +532,21 @@ static int pxafb_pan_display(struct fb_var_screeninfo *var,
 			     struct fb_info *info)
 {
 	struct pxafb_info *fbi = (struct pxafb_info *)info;
+	struct fb_var_screeninfo newvar;
 	int dma = DMA_MAX + DMA_BASE;
 
 	if (fbi->state != C_ENABLE)
 		return 0;
 
-	setup_base_frame(fbi, var, 1);
+	/* Only take .xoffset, .yoffset and .vmode & FB_VMODE_YWRAP from what
+	 * was passed in and copy the rest from the old screeninfo. */
+	memcpy(&newvar, &fbi->fb.var, sizeof(newvar));
+	newvar.xoffset = var->xoffset;
+	newvar.yoffset = var->yoffset;
+	newvar.vmode &= ~FB_VMODE_YWRAP;
+	newvar.vmode |= var->vmode & FB_VMODE_YWRAP;
+
+	setup_base_frame(fbi, &newvar, 1);
 
 	if (fbi->lccr0 & LCCR0_SDS)
 		lcd_writel(fbi, FBR1, fbi->fdadr[dma + 1] | 0x1);
-- 
1.6.5
