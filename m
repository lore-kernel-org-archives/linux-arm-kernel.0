From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 29 Sep 2017 11:50:56 +0100
Subject: [PATCH 1/8] video: sa1100fb: use devm_kzalloc()
In-Reply-To: <20170929105004.GY20805@n2100.armlinux.org.uk>
References: <20170929105004.GY20805@n2100.armlinux.org.uk>
Message-ID: <E1dxssi-0006im-JD@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_kzalloc() when allocating the private data for the framebuffer
device.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/video/fbdev/sa1100fb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index fc2aaa5aca23..05a80e08dcde 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -1132,12 +1132,11 @@ static struct sa1100fb_info *sa1100fb_init_fbinfo(struct device *dev)
 	struct sa1100fb_info *fbi;
 	unsigned i;
 
-	fbi = kmalloc(sizeof(struct sa1100fb_info) + sizeof(u32) * 16,
-		      GFP_KERNEL);
+	fbi = devm_kzalloc(dev, sizeof(struct sa1100fb_info) + sizeof(u32) * 16,
+			   GFP_KERNEL);
 	if (!fbi)
 		return NULL;
 
-	memset(fbi, 0, sizeof(struct sa1100fb_info));
 	fbi->dev = dev;
 
 	strcpy(fbi->fb.fix.id, SA1100_NAME);
@@ -1292,7 +1291,6 @@ static int sa1100fb_probe(struct platform_device *pdev)
 		iounmap(fbi->base);
 	if (fbi->clk)
 		clk_put(fbi->clk);
-	kfree(fbi);
 	release_mem_region(res->start, resource_size(res));
 	return ret;
 }
-- 
2.7.4
