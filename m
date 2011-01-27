From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 12:59:31 +0000
Subject: [PATCH 05/10] ARM: clcd: add method for describing display
	capabilities
In-Reply-To: <20110127125714.GD25968@n2100.arm.linux.org.uk>
References: <20110127125714.GD25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiRRj-0003mq-70@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM CLCD PL110 controller in TFT mode provides two output formats
based on whether the controller is in 24bpp mode or not - either 5551
or 888.  PL111 augments this with a 444 and 565 modes.

Some implementations provide an external MUX on the PL110 output to
reassign the bits to achieve 565 mode.

Provide a system of capability flags to allow the CLCD driver to work
out what is supported by each panel and board, and therefore which
display formats are permitted.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/video/amba-clcd.c |   95 +++++++++++++++++++++++++++++++++++++++-----
 include/linux/amba/clcd.h |   82 ++++++++++++++++++++++++++++++--------
 2 files changed, 149 insertions(+), 28 deletions(-)

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index aedbb34..8bd3706 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -120,8 +120,23 @@ static void clcdfb_enable(struct clcd_fb *fb, u32 cntl)
 static int
 clcdfb_set_bitfields(struct clcd_fb *fb, struct fb_var_screeninfo *var)
 {
+	u32 caps;
 	int ret = 0;
 
+	if (fb->panel->caps && fb->board->caps)
+		caps = fb->panel->caps & fb->board->caps;
+	else {
+		/* Old way of specifying what can be used */
+		caps = fb->panel->cntl & CNTL_BGR ?
+			CLCD_CAP_BGR : CLCD_CAP_RGB;
+		/* But mask out 444 modes as they weren't supported */
+		caps &= ~CLCD_CAP_444;
+	}
+
+	/* Only TFT panels can do RGB888/BGR888 */
+	if (!(fb->panel->cntl & CNTL_LCDTFT))
+		caps &= ~CLCD_CAP_888;
+
 	memset(&var->transp, 0, sizeof(var->transp));
 
 	var->red.msb_right = 0;
@@ -133,6 +148,13 @@ clcdfb_set_bitfields(struct clcd_fb *fb, struct fb_var_screeninfo *var)
 	case 2:
 	case 4:
 	case 8:
+		/* If we can't do 5551, reject */
+		caps &= CLCD_CAP_5551;
+		if (!caps) {
+			ret = -EINVAL;
+			break;
+		}
+
 		var->red.length		= var->bits_per_pixel;
 		var->red.offset		= 0;
 		var->green.length	= var->bits_per_pixel;
@@ -140,23 +162,61 @@ clcdfb_set_bitfields(struct clcd_fb *fb, struct fb_var_screeninfo *var)
 		var->blue.length	= var->bits_per_pixel;
 		var->blue.offset	= 0;
 		break;
+
 	case 16:
-		var->red.length = 5;
-		var->blue.length = 5;
+		/* If we can't do 444, 5551 or 565, reject */
+		if (!(caps & (CLCD_CAP_444 | CLCD_CAP_5551 | CLCD_CAP_565))) {
+			ret = -EINVAL;
+			break;
+		}
+
 		/*
-		 * Green length can be 5 or 6 depending whether
-		 * we're operating in RGB555 or RGB565 mode.
+		 * Green length can be 4, 5 or 6 depending whether
+		 * we're operating in 444, 5551 or 565 mode.
 		 */
-		if (var->green.length != 5 && var->green.length != 6)
-			var->green.length = 6;
+		if (var->green.length == 4 && caps & CLCD_CAP_444)
+			caps &= CLCD_CAP_444;
+		if (var->green.length == 5 && caps & CLCD_CAP_5551)
+			caps &= CLCD_CAP_5551;
+		else if (var->green.length == 6 && caps & CLCD_CAP_565)
+			caps &= CLCD_CAP_565;
+		else {
+			/*
+			 * PL110 officially only supports RGB555,
+			 * but may be wired up to allow RGB565.
+			 */
+			if (caps & CLCD_CAP_565) {
+				var->green.length = 6;
+				caps &= CLCD_CAP_565;
+			} else if (caps & CLCD_CAP_5551) {
+				var->green.length = 5;
+				caps &= CLCD_CAP_5551;
+			} else {
+				var->green.length = 4;
+				caps &= CLCD_CAP_444;
+			}
+		}
+
+		if (var->green.length >= 5) {
+			var->red.length = 5;
+			var->blue.length = 5;
+		} else {
+			var->red.length = 4;
+			var->blue.length = 4;
+		}
 		break;
 	case 32:
-		if (fb->panel->cntl & CNTL_LCDTFT) {
-			var->red.length		= 8;
-			var->green.length	= 8;
-			var->blue.length	= 8;
+		/* If we can't do 888, reject */
+		caps &= CLCD_CAP_888;
+		if (!caps) {
+			ret = -EINVAL;
 			break;
 		}
+
+		var->red.length = 8;
+		var->green.length = 8;
+		var->blue.length = 8;
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -168,7 +228,20 @@ clcdfb_set_bitfields(struct clcd_fb *fb, struct fb_var_screeninfo *var)
 	 * the bitfield length defined above.
 	 */
 	if (ret == 0 && var->bits_per_pixel >= 16) {
-		if (fb->panel->cntl & CNTL_BGR) {
+		bool bgr, rgb;
+
+		bgr = caps & CLCD_CAP_BGR && var->blue.offset == 0;
+		rgb = caps & CLCD_CAP_RGB && var->red.offset == 0;
+
+		if (!bgr && !rgb)
+			/*
+			 * The requested format was not possible, try just
+			 * our capabilities.  One of BGR or RGB must be
+			 * supported.
+			 */
+			bgr = caps & CLCD_CAP_BGR;
+
+		if (bgr) {
 			var->blue.offset = 0;
 			var->green.offset = var->blue.offset + var->blue.length;
 			var->red.offset = var->green.offset + var->green.length;
diff --git a/include/linux/amba/clcd.h b/include/linux/amba/clcd.h
index 2e51121..24d26ef 100644
--- a/include/linux/amba/clcd.h
+++ b/include/linux/amba/clcd.h
@@ -53,6 +53,7 @@
 #define CNTL_LCDBPP8		(3 << 1)
 #define CNTL_LCDBPP16		(4 << 1)
 #define CNTL_LCDBPP16_565	(6 << 1)
+#define CNTL_LCDBPP16_444	(7 << 1)
 #define CNTL_LCDBPP24		(5 << 1)
 #define CNTL_LCDBW		(1 << 4)
 #define CNTL_LCDTFT		(1 << 5)
@@ -66,6 +67,32 @@
 #define CNTL_LDMAFIFOTIME	(1 << 15)
 #define CNTL_WATERMARK		(1 << 16)
 
+enum {
+	/* individual formats */
+	CLCD_CAP_RGB444		= (1 << 0),
+	CLCD_CAP_RGB5551	= (1 << 1),
+	CLCD_CAP_RGB565		= (1 << 2),
+	CLCD_CAP_RGB888		= (1 << 3),
+	CLCD_CAP_BGR444		= (1 << 4),
+	CLCD_CAP_BGR5551	= (1 << 5),
+	CLCD_CAP_BGR565		= (1 << 6),
+	CLCD_CAP_BGR888		= (1 << 7),
+
+	/* connection layouts */
+	CLCD_CAP_444		= CLCD_CAP_RGB444 | CLCD_CAP_BGR444,
+	CLCD_CAP_5551		= CLCD_CAP_RGB5551 | CLCD_CAP_BGR5551,
+	CLCD_CAP_565		= CLCD_CAP_RGB565 | CLCD_CAP_BGR565,
+	CLCD_CAP_888		= CLCD_CAP_RGB888 | CLCD_CAP_BGR888,
+
+	/* red/blue ordering */
+	CLCD_CAP_RGB		= CLCD_CAP_RGB444 | CLCD_CAP_RGB5551 |
+				  CLCD_CAP_RGB565 | CLCD_CAP_RGB888,
+	CLCD_CAP_BGR		= CLCD_CAP_BGR444 | CLCD_CAP_BGR5551 |
+				  CLCD_CAP_BGR565 | CLCD_CAP_BGR888,
+
+	CLCD_CAP_ALL		= CLCD_CAP_BGR | CLCD_CAP_RGB,
+};
+
 struct clcd_panel {
 	struct fb_videomode	mode;
 	signed short		width;	/* width in mm */
@@ -73,6 +100,7 @@ struct clcd_panel {
 	u32			tim2;
 	u32			tim3;
 	u32			cntl;
+	u32			caps;
 	unsigned int		bpp:8,
 				fixedtimings:1,
 				grayscale:1;
@@ -97,6 +125,11 @@ struct clcd_board {
 	const char *name;
 
 	/*
+	 * Optional.  Hardware capability flags.
+	 */
+	u32	caps;
+
+	/*
 	 * Optional.  Check whether the var structure is acceptable
 	 * for this display.
 	 */
@@ -155,34 +188,35 @@ struct clcd_fb {
 
 static inline void clcdfb_decode(struct clcd_fb *fb, struct clcd_regs *regs)
 {
+	struct fb_var_screeninfo *var = &fb->fb.var;
 	u32 val, cpl;
 
 	/*
 	 * Program the CLCD controller registers and start the CLCD
 	 */
-	val = ((fb->fb.var.xres / 16) - 1) << 2;
-	val |= (fb->fb.var.hsync_len - 1) << 8;
-	val |= (fb->fb.var.right_margin - 1) << 16;
-	val |= (fb->fb.var.left_margin - 1) << 24;
+	val = ((var->xres / 16) - 1) << 2;
+	val |= (var->hsync_len - 1) << 8;
+	val |= (var->right_margin - 1) << 16;
+	val |= (var->left_margin - 1) << 24;
 	regs->tim0 = val;
 
-	val = fb->fb.var.yres;
+	val = var->yres;
 	if (fb->panel->cntl & CNTL_LCDDUAL)
 		val /= 2;
 	val -= 1;
-	val |= (fb->fb.var.vsync_len - 1) << 10;
-	val |= fb->fb.var.lower_margin << 16;
-	val |= fb->fb.var.upper_margin << 24;
+	val |= (var->vsync_len - 1) << 10;
+	val |= var->lower_margin << 16;
+	val |= var->upper_margin << 24;
 	regs->tim1 = val;
 
 	val = fb->panel->tim2;
-	val |= fb->fb.var.sync & FB_SYNC_HOR_HIGH_ACT  ? 0 : TIM2_IHS;
-	val |= fb->fb.var.sync & FB_SYNC_VERT_HIGH_ACT ? 0 : TIM2_IVS;
+	val |= var->sync & FB_SYNC_HOR_HIGH_ACT  ? 0 : TIM2_IHS;
+	val |= var->sync & FB_SYNC_VERT_HIGH_ACT ? 0 : TIM2_IVS;
 
-	cpl = fb->fb.var.xres_virtual;
+	cpl = var->xres_virtual;
 	if (fb->panel->cntl & CNTL_LCDTFT)	  /* TFT */
 		/* / 1 */;
-	else if (!fb->fb.var.grayscale)		  /* STN color */
+	else if (!var->grayscale)		  /* STN color */
 		cpl = cpl * 8 / 3;
 	else if (fb->panel->cntl & CNTL_LCDMONO8) /* STN monochrome, 8bit */
 		cpl /= 8;
@@ -194,10 +228,22 @@ static inline void clcdfb_decode(struct clcd_fb *fb, struct clcd_regs *regs)
 	regs->tim3 = fb->panel->tim3;
 
 	val = fb->panel->cntl;
-	if (fb->fb.var.grayscale)
+	if (var->grayscale)
 		val |= CNTL_LCDBW;
 
-	switch (fb->fb.var.bits_per_pixel) {
+	if (fb->panel->caps && fb->board->caps &&
+	    var->bits_per_pixel >= 16) {
+		/*
+		 * if board and panel supply capabilities, we can support
+		 * changing BGR/RGB depending on supplied parameters
+		 */
+		if (var->red.offset == 0)
+			val &= ~CNTL_BGR;
+		else
+			val |= CNTL_BGR;
+	}
+
+	switch (var->bits_per_pixel) {
 	case 1:
 		val |= CNTL_LCDBPP1;
 		break;
@@ -217,10 +263,12 @@ static inline void clcdfb_decode(struct clcd_fb *fb, struct clcd_regs *regs)
 		 * custom external wiring.
 		 */
 		if (amba_part(fb->dev) == 0x110 ||
-		    fb->fb.var.green.length == 5)
+		    var->green.length == 5)
 			val |= CNTL_LCDBPP16;
-		else
+		else if (var->green.length == 6)
 			val |= CNTL_LCDBPP16_565;
+		else
+			val |= CNTL_LCDBPP16_444;
 		break;
 	case 32:
 		val |= CNTL_LCDBPP24;
@@ -228,7 +276,7 @@ static inline void clcdfb_decode(struct clcd_fb *fb, struct clcd_regs *regs)
 	}
 
 	regs->cntl = val;
-	regs->pixclock = fb->fb.var.pixclock;
+	regs->pixclock = var->pixclock;
 }
 
 static inline int clcdfb_check(struct clcd_fb *fb, struct fb_var_screeninfo *var)
-- 
1.6.2.5
