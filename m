From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 28 Nov 2011 21:37:17 +0800
Subject: [PATCH 3/5] regulator: pass device_node to
 of_get_regulator_init_data()
In-Reply-To: <1322487439-27254-1-git-send-email-shawn.guo@linaro.org>
References: <1322487439-27254-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1322487439-27254-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's not always true that the device_node of regulator can be found
at dev->of_node, because in some cases the regulator nodes in device
tree do not even have 'struct device' behind them.

The patch adds device_node as a new parameter to
of_get_regulator_init_data(), so that caller can pass in the node of
regulator directly.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
---
 drivers/regulator/of_regulator.c       |    7 ++++---
 include/linux/regulator/of_regulator.h |    6 ++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index acd7045..6caf641 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -66,18 +66,19 @@ static void of_get_regulation_constraints(struct device_node *np,
  * tree node, returns a pointer to the populated struture or NULL if memory
  * alloc fails.
  */
-struct regulator_init_data *of_get_regulator_init_data(struct device *dev)
+struct regulator_init_data *of_get_regulator_init_data(struct device *dev,
+						struct device_node *node)
 {
 	struct regulator_init_data *init_data;
 
-	if (!dev->of_node)
+	if (!node)
 		return NULL;
 
 	init_data = devm_kzalloc(dev, sizeof(*init_data), GFP_KERNEL);
 	if (!init_data)
 		return NULL; /* Out of memory? */
 
-	of_get_regulation_constraints(dev->of_node, &init_data);
+	of_get_regulation_constraints(node, &init_data);
 	return init_data;
 }
 EXPORT_SYMBOL_GPL(of_get_regulator_init_data);
diff --git a/include/linux/regulator/of_regulator.h b/include/linux/regulator/of_regulator.h
index d83a98d..769704f 100644
--- a/include/linux/regulator/of_regulator.h
+++ b/include/linux/regulator/of_regulator.h
@@ -8,10 +8,12 @@
 
 #if defined(CONFIG_OF)
 extern struct regulator_init_data
-	*of_get_regulator_init_data(struct device *dev);
+	*of_get_regulator_init_data(struct device *dev,
+				    struct device_node *node);
 #else
 static inline struct regulator_init_data
-	*of_get_regulator_init_data(struct device *dev)
+	*of_get_regulator_init_data(struct device *dev,
+				    struct device_node *node)
 {
 	return NULL;
 }
-- 
1.7.4.1
