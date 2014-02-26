From: denis@eukrea.com (Denis Carikli)
Date: Wed, 26 Feb 2014 10:59:55 +0100
Subject: [PATCHv6][ 1/5] video: mx3fb: Use devm_kzalloc
Message-ID: <1393408800-8946-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace kzalloc by devm_kzalloc and remove the kfree() calls.

Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Eric B?nard <eric@eukrea.com>
Cc: linux-fbdev at vger.kernel.org
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v5->v6:
 - New patch needed by "video: mx3fb: Add device tree suport."
---
 drivers/video/mx3fb.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index 142e860..ee95de8 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -1496,7 +1496,7 @@ static int mx3fb_probe(struct platform_device *pdev)
 	if (!sdc_reg)
 		return -EINVAL;
 
-	mx3fb = kzalloc(sizeof(*mx3fb), GFP_KERNEL);
+	mx3fb = devm_kzalloc(&pdev->dev, sizeof(*mx3fb), GFP_KERNEL);
 	if (!mx3fb)
 		return -ENOMEM;
 
@@ -1542,7 +1542,6 @@ ersdc0:
 	dmaengine_put();
 	iounmap(mx3fb->reg_base);
 eremap:
-	kfree(mx3fb);
 	dev_err(dev, "mx3fb: failed to register fb\n");
 	return ret;
 }
@@ -1561,7 +1560,6 @@ static int mx3fb_remove(struct platform_device *dev)
 	dmaengine_put();
 
 	iounmap(mx3fb->reg_base);
-	kfree(mx3fb);
 	return 0;
 }
 
-- 
1.7.9.5
