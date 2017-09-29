From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 29 Sep 2017 11:51:01 +0100
Subject: [PATCH 2/8] video: sa1100fb: use devm_clk_get()
In-Reply-To: <20170929105004.GY20805@n2100.armlinux.org.uk>
References: <20170929105004.GY20805@n2100.armlinux.org.uk>
Message-ID: <E1dxssn-0006iu-Um@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_clk_get() to get the clock for the LCD.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/video/fbdev/sa1100fb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index 05a80e08dcde..1562d7607dd2 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -1230,10 +1230,9 @@ static int sa1100fb_probe(struct platform_device *pdev)
 	if (!fbi)
 		goto failed;
 
-	fbi->clk = clk_get(&pdev->dev, NULL);
+	fbi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(fbi->clk)) {
 		ret = PTR_ERR(fbi->clk);
-		fbi->clk = NULL;
 		goto failed;
 	}
 
@@ -1289,8 +1288,6 @@ static int sa1100fb_probe(struct platform_device *pdev)
  failed:
 	if (fbi)
 		iounmap(fbi->base);
-	if (fbi->clk)
-		clk_put(fbi->clk);
 	release_mem_region(res->start, resource_size(res));
 	return ret;
 }
-- 
2.7.4
