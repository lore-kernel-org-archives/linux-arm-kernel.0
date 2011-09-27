From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Sep 2011 09:27:37 +0100
Subject: [PATCH 3/9] clk: amba-clcd: convert to clk_prepare()/clk_unprepare()
Message-ID: <E1R8T0r-0003wQ-7S@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/video/amba-clcd.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index cf03ad0..2cda6ba 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -447,6 +447,10 @@ static int clcdfb_register(struct clcd_fb *fb)
 		goto out;
 	}
 
+	ret = clk_prepare(fb->clk);
+	if (ret)
+		goto free_clk;
+
 	fb->fb.device		= &fb->dev->dev;
 
 	fb->fb.fix.mmio_start	= fb->dev->res.start;
@@ -456,7 +460,7 @@ static int clcdfb_register(struct clcd_fb *fb)
 	if (!fb->regs) {
 		printk(KERN_ERR "CLCD: unable to remap registers\n");
 		ret = -ENOMEM;
-		goto free_clk;
+		goto clk_unprep;
 	}
 
 	fb->fb.fbops		= &clcdfb_ops;
@@ -530,6 +534,8 @@ static int clcdfb_register(struct clcd_fb *fb)
 	fb_dealloc_cmap(&fb->fb.cmap);
  unmap:
 	iounmap(fb->regs);
+ clk_unprep:
+	clk_unprepare(fb->clk);
  free_clk:
 	clk_put(fb->clk);
  out:
@@ -595,6 +601,7 @@ static int clcdfb_remove(struct amba_device *dev)
 	if (fb->fb.cmap.len)
 		fb_dealloc_cmap(&fb->fb.cmap);
 	iounmap(fb->regs);
+	clk_unprepare(fb->clk);
 	clk_put(fb->clk);
 
 	fb->board->remove(fb);
-- 
1.7.4.4
