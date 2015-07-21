From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 21 Jul 2015 15:50:52 +0200
Subject: [RFC PATCH 10/16] Add DEVM_REGULATOR()
In-Reply-To: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1437486658-28365-11-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/regulator/devres.c         | 18 ++++++++++++++++++
 include/linux/regulator/consumer.h | 10 ++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 6ec1d400adae..ff1328ca8fd6 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -15,7 +15,9 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
 #include <linux/module.h>
+#include <linux/of_platform.h>
 
 #include "internal.h"
 
@@ -498,3 +500,19 @@ void devm_regulator_unregister_notifier(struct regulator *regulator,
 		WARN_ON(rc);
 }
 EXPORT_SYMBOL_GPL(devm_regulator_unregister_notifier);
+
+int devm_acquire_regulator(struct device *dev,
+			   const struct devm_resource *resource)
+{
+	struct regulator *regulator, **regulatorp;
+
+	regulator = devm_regulator_get(dev, resource->name);
+	if (IS_ERR(regulator))
+		return PTR_ERR(regulator);
+
+	regulatorp = dev_get_drvdata(dev) + resource->offset;
+	*regulatorp = regulator;
+
+	return 0;
+}
+EXPORT_SYMBOL(devm_acquire_regulator);
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 2ba4a40919c8..ece4f076f7e3 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -38,6 +38,7 @@
 #include <linux/err.h>
 
 struct device;
+struct devm_resource;
 struct notifier_block;
 struct regmap;
 
@@ -173,6 +174,15 @@ struct regulator *__must_check devm_regulator_get_optional(struct device *dev,
 void regulator_put(struct regulator *regulator);
 void devm_regulator_put(struct regulator *regulator);
 
+int devm_acquire_regulator(struct device *dev,
+			   const struct devm_resource *resource);
+
+#define DEVM_REGULATOR(_struct, _member, _name) {			\
+	.initfunc = devm_acquire_regulator,				\
+	.offset = offsetof_t(struct _struct, _member, struct regulator *),\
+	.name = _name,							\
+}
+
 int regulator_register_supply_alias(struct device *dev, const char *id,
 				    struct device *alias_dev,
 				    const char *alias_id);
-- 
2.4.3
