From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jun 2014 18:01:12 +0200
Subject: [PATCH 10/14] misc: vexpress: fix error handling
 vexpress_syscfg_regmap_init()
In-Reply-To: <1402675276-538682-1-git-send-email-arnd@arndb.de>
References: <1402675276-538682-1-git-send-email-arnd@arndb.de>
Message-ID: <1402675276-538682-11-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dan Carpenter <dan.carpenter@oracle.com>

This function should be returning an ERR_PTR() on failure instead of
NULL.  Also there is a use after free bug if regmap_init() fails because
we free "func" and then dereference doing the return.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/vexpress-syscfg.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/vexpress-syscfg.c b/drivers/misc/vexpress-syscfg.c
index 73068e5..3250fc1 100644
--- a/drivers/misc/vexpress-syscfg.c
+++ b/drivers/misc/vexpress-syscfg.c
@@ -199,7 +199,7 @@ static struct regmap *vexpress_syscfg_regmap_init(struct device *dev,
 	func = kzalloc(sizeof(*func) + sizeof(*func->template) * num,
 			GFP_KERNEL);
 	if (!func)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	func->syscfg = syscfg;
 	func->num_templates = num;
@@ -231,10 +231,14 @@ static struct regmap *vexpress_syscfg_regmap_init(struct device *dev,
 	func->regmap = regmap_init(dev, NULL, func,
 			&vexpress_syscfg_regmap_config);
 
-	if (IS_ERR(func->regmap))
+	if (IS_ERR(func->regmap)) {
+		void *err = func->regmap;
+
 		kfree(func);
-	else
-		list_add(&func->list, &syscfg->funcs);
+		return err;
+	}
+
+	list_add(&func->list, &syscfg->funcs);
 
 	return func->regmap;
 }
-- 
1.8.3.2
