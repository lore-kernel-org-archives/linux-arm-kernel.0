From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Jan 2014 14:31:09 +0100
Subject: [PATCH 3/5] ARM: integrator: use managed resources for the IM-PD1
In-Reply-To: <1390397471-6802-1-git-send-email-linus.walleij@linaro.org>
References: <1390397471-6802-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1390397471-6802-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch the IM-PD1 driver to use managed resources and cut down
on boilerplate.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/impd1.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index 9f82f9dcbb98..aeeae0d79a18 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -307,25 +307,23 @@ static struct impd1_device impd1_devs[] = {
 static int impd1_probe(struct lm_device *dev)
 {
 	struct impd1_module *impd1;
-	int i, ret;
+	int i;
 
 	if (dev->id != module_id)
 		return -EINVAL;
 
-	if (!request_mem_region(dev->resource.start, SZ_4K, "LM registers"))
+	if (!devm_request_mem_region(&dev->dev, dev->resource.start,
+				     SZ_4K, "LM registers"))
 		return -EBUSY;
 
-	impd1 = kzalloc(sizeof(struct impd1_module), GFP_KERNEL);
-	if (!impd1) {
-		ret = -ENOMEM;
-		goto release_lm;
-	}
+	impd1 = devm_kzalloc(&dev->dev, sizeof(struct impd1_module),
+			     GFP_KERNEL);
+	if (!impd1)
+		return -ENOMEM;
 
-	impd1->base = ioremap(dev->resource.start, SZ_4K);
-	if (!impd1->base) {
-		ret = -ENOMEM;
-		goto free_impd1;
-	}
+	impd1->base = devm_ioremap(&dev->dev, dev->resource.start, SZ_4K);
+	if (!impd1->base)
+		return -ENOMEM;
 
 	lm_set_drvdata(dev, impd1);
 
@@ -353,14 +351,6 @@ static int impd1_probe(struct lm_device *dev)
 	}
 
 	return 0;
-
- free_impd1:
-	if (impd1 && impd1->base)
-		iounmap(impd1->base);
-	kfree(impd1);
- release_lm:
-	release_mem_region(dev->resource.start, SZ_4K);
-	return ret;
 }
 
 static int impd1_remove_one(struct device *dev, void *data)
@@ -371,16 +361,10 @@ static int impd1_remove_one(struct device *dev, void *data)
 
 static void impd1_remove(struct lm_device *dev)
 {
-	struct impd1_module *impd1 = lm_get_drvdata(dev);
-
 	device_for_each_child(&dev->dev, NULL, impd1_remove_one);
 	integrator_impd1_clk_exit(dev->id);
 
 	lm_set_drvdata(dev, NULL);
-
-	iounmap(impd1->base);
-	kfree(impd1);
-	release_mem_region(dev->resource.start, SZ_4K);
 }
 
 static struct lm_driver impd1_driver = {
-- 
1.8.4.2
