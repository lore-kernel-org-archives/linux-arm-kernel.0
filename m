From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 10 Jan 2011 12:55:41 +1300
Subject: [PATCH] Fix ep93xx-fb init/exit annotations
Message-ID: <4D2A4AFD.4050008@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix section mismatch errors in the ep93xx-fb driver resulting from
incorrect init/exit annotations.

Reported-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/drivers/video/ep93xx-fb.c b/drivers/video/ep93xx-fb.c
index 0c99de0..b358d04 100644
--- a/drivers/video/ep93xx-fb.c
+++ b/drivers/video/ep93xx-fb.c
@@ -483,7 +483,7 @@ static void ep93xxfb_dealloc_videomem(struct fb_info *info)
 				  info->screen_base, info->fix.smem_start);
 }
 
-static int __init ep93xxfb_probe(struct platform_device *pdev)
+static int __devinit ep93xxfb_probe(struct platform_device *pdev)
 {
 	struct ep93xxfb_mach_info *mach_info = pdev->dev.platform_data;
 	struct fb_info *info;
@@ -598,7 +598,7 @@ failed:
 	return err;
 }
 
-static int ep93xxfb_remove(struct platform_device *pdev)
+static int __devexit ep93xxfb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 	struct ep93xx_fbi *fbi = info->par;
@@ -622,7 +622,7 @@ static int ep93xxfb_remove(struct platform_device *pdev)
 
 static struct platform_driver ep93xxfb_driver = {
 	.probe		= ep93xxfb_probe,
-	.remove		= ep93xxfb_remove,
+	.remove		= __devexit_p(ep93xxfb_remove),
 	.driver = {
 		.name	= "ep93xx-fb",
 		.owner	= THIS_MODULE,
