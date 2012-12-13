From: dromede@gmail.com (dromede at gmail.com)
Date: Thu, 13 Dec 2012 19:49:15 +0100
Subject: [PATCH] [ARM] scoop.c: Use devm_xxx functions in scoop_probe()
Message-ID: <1355424555-13504-1-git-send-email-dromede@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marko Katic <dromede.gmail.com>

Use devm_kzalloc and devm_ioremap and reduce the
amount of error  handling and deallocation code.

Signed-off-by: Marko Katic <dromede@gmail.com>
---
 arch/arm/common/scoop.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
index 0c616d5..1901b4e 100644
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -187,19 +187,18 @@ static int __devinit scoop_probe(struct platform_device *pdev)
 	if (!mem)
 		return -EINVAL;
 
-	devptr = kzalloc(sizeof(struct scoop_dev), GFP_KERNEL);
+	devptr = devm_kzalloc(&pdev->dev, sizeof(struct scoop_dev), GFP_KERNEL);
+
 	if (!devptr)
 		return -ENOMEM;
 
 	spin_lock_init(&devptr->scoop_lock);
 
 	inf = pdev->dev.platform_data;
-	devptr->base = ioremap(mem->start, resource_size(mem));
+	devptr->base = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
 
-	if (!devptr->base) {
-		ret = -ENOMEM;
-		goto err_ioremap;
-	}
+	if (!devptr->base)
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, devptr);
 
@@ -234,12 +233,9 @@ static int __devinit scoop_probe(struct platform_device *pdev)
 
 	if (devptr->gpio.base != -1)
 		temp = gpiochip_remove(&devptr->gpio);
+
 err_gpio:
 	platform_set_drvdata(pdev, NULL);
-err_ioremap:
-	iounmap(devptr->base);
-	kfree(devptr);
-
 	return ret;
 }
 
@@ -260,8 +256,6 @@ static int __devexit scoop_remove(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, NULL);
-	iounmap(sdev->base);
-	kfree(sdev);
 
 	return 0;
 }
-- 
1.7.10.4
