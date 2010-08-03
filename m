From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Tue,  3 Aug 2010 09:03:58 -0700
Subject: [PATCH 1/2] amba_pl022: Fix driver clock enable/disable balance issues
In-Reply-To: <1280851439-25468-1-git-send-email-wellsk40@gmail.com>
References: <1280851439-25468-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1280851439-25468-2-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

The pl022 clock enable and disable calls can become unbalanced. This
code prevents clk_disable() from being called until clk_enable()
has been called first.

Note the LCP32xx arch (and probably other archs too) requires clocks
for the AMBA peripheral enabled prior to any register access. This
patch alone won't prevent register access without an active clock.
---
 drivers/video/amba-clcd.c |   10 ++++++++--
 include/linux/amba/clcd.h |    1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index afe21e6..1c2c683 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -80,7 +80,10 @@ static void clcdfb_disable(struct clcd_fb *fb)
 	/*
 	 * Disable CLCD clock source.
 	 */
-	clk_disable(fb->clk);
+	if (fb->clk_enabled) {
+		fb->clk_enabled = false;
+		clk_disable(fb->clk);
+	}
 }
 
 static void clcdfb_enable(struct clcd_fb *fb, u32 cntl)
@@ -88,7 +91,10 @@ static void clcdfb_enable(struct clcd_fb *fb, u32 cntl)
 	/*
 	 * Enable the CLCD clock source.
 	 */
-	clk_enable(fb->clk);
+	if (!fb->clk_enabled) {
+		fb->clk_enabled = true;
+		clk_enable(fb->clk);
+	}
 
 	/*
 	 * Bring up by first enabling..
diff --git a/include/linux/amba/clcd.h b/include/linux/amba/clcd.h
index ca16c38..7bbf26a 100644
--- a/include/linux/amba/clcd.h
+++ b/include/linux/amba/clcd.h
@@ -142,6 +142,7 @@ struct clcd_fb {
 	struct fb_info		fb;
 	struct amba_device	*dev;
 	struct clk		*clk;
+	bool			clk_enabled;
 	struct clcd_panel	*panel;
 	struct clcd_board	*board;
 	void			*board_data;
-- 
1.7.1.1
