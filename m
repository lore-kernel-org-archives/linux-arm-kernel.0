From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 12:58:50 +0000
Subject: [PATCH 03/10] ARM: clcd: clean up CLCD announcement printks
In-Reply-To: <20110127125714.GD25968@n2100.arm.linux.org.uk>
References: <20110127125714.GD25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiRR4-0003mi-M2@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the CLCD announcement printk say which primecell part number
has been found.  Display the revision as an unsigned decimal, and
display only the first 8 hex digits of the base address unless it's
larger.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/video/amba-clcd.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index 1c2c683..aedbb34 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -443,8 +443,8 @@ static int clcdfb_register(struct clcd_fb *fb)
 
 	fb_set_var(&fb->fb, &fb->fb.var);
 
-        printk(KERN_INFO "CLCD: %s hardware, %s display\n",
-               fb->board->name, fb->panel->mode.name);
+	dev_info(&fb->dev->dev, "%s hardware, %s display\n",
+	         fb->board->name, fb->panel->mode.name);
 
 	ret = register_framebuffer(&fb->fb);
 	if (ret == 0)
@@ -486,6 +486,10 @@ static int clcdfb_probe(struct amba_device *dev, struct amba_id *id)
 	fb->dev = dev;
 	fb->board = board;
 
+	dev_info(&fb->dev->dev, "PL%03x rev%u at 0x%08llx\n",
+		amba_part(dev), amba_rev(dev),
+		(unsigned long long)dev->res.start);
+
 	ret = fb->board->setup(fb);
 	if (ret)
 		goto free_fb;
-- 
1.6.2.5
