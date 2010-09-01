From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Wed,  1 Sep 2010 08:12:14 -0700
Subject: [PATCH] amba_clcd: Check min clock limits based on selected mode
Message-ID: <1283353934-15790-1-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Check the minimum clock limits based on whether TFT or STN mode
is selected. Some TFT panels have nominal values under the
minimum STN constraints.

Tested on a PL111/TFT LCD combo at hsync_len=3(HSW),
right_margin=3(HBP), and left_margin=22(HFP).

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 include/linux/amba/clcd.h |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/amba/clcd.h b/include/linux/amba/clcd.h
index be33b3a..c1efe89 100644
--- a/include/linux/amba/clcd.h
+++ b/include/linux/amba/clcd.h
@@ -233,14 +233,29 @@ static inline void clcdfb_decode(struct clcd_fb *fb, struct clcd_regs *regs)
 
 static inline int clcdfb_check(struct clcd_fb *fb, struct fb_var_screeninfo *var)
 {
+	u32 hbp, hfp, hsw;
+
+	/*
+	 * These clock constraints are for the pl11x DMA latency. TFT mode
+	 * is slightly faster than STN
+	 */
+	if (fb->panel->cntl & CNTL_LCDTFT) {
+		/* No TFT constraint given for min TFT HFP clocks in TRM */
+		hbp = hfp = (2 + 1);
+		hsw = (2 + 1);
+	} else {
+		hbp = hfp = (5 + 1);
+		hsw = (3 + 1);
+	}
+
 	var->xres_virtual = var->xres = (var->xres + 15) & ~15;
 	var->yres_virtual = var->yres = (var->yres + 1) & ~1;
 
 #define CHECK(e,l,h) (var->e < l || var->e > h)
-	if (CHECK(right_margin, (5+1), 256) ||	/* back porch */
-	    CHECK(left_margin, (5+1), 256) ||	/* front porch */
-	    CHECK(hsync_len, (5+1), 256) ||
-	    var->xres > 4096 ||
+	if (CHECK(right_margin, hbp, 256) ||	/* back porch */
+	    CHECK(left_margin, hfp, 256) ||	/* front porch */
+	    CHECK(hsync_len, hsw, 256) ||
+	    var->xres > 1024 ||
 	    var->lower_margin > 255 ||		/* back porch */
 	    var->upper_margin > 255 ||		/* front porch */
 	    var->vsync_len > 32 ||
-- 
1.7.1.1
