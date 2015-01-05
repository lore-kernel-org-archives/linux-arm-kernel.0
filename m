From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 05 Jan 2015 12:48:42 +0100
Subject: [PATCH v5 2/5] regulator: Allow parsing custom properties when using
 simplified DT parsing
In-Reply-To: <1420458525-22576-1-git-send-email-k.kozlowski@samsung.com>
References: <1420458525-22576-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1420458525-22576-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When drivers use simplified DT parsing method (they provide
'regulator_desc.of_match') they still may want to parse custom
properties for some of the regulators. For example some of the
regulators support GPIO enable control.

Add a driver-supplied callback for such case. This way the regulator
core parses common bindings offloading a lot of code from drivers and
still custom properties may be used.

The callback, called for each parsed regulator, may modify the
'regulator_config' initially passed to regulator_register().

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/regulator/core.c         |  2 +-
 drivers/regulator/internal.h     |  2 ++
 drivers/regulator/of_regulator.c | 11 +++++++++++
 include/linux/regulator/driver.h | 13 +++++++++++++
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c13b557a560e..5fae8cabd254 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3635,7 +3635,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	init_data = regulator_of_get_init_data(dev, regulator_desc,
+	init_data = regulator_of_get_init_data(dev, regulator_desc, config,
 					       &rdev->dev.of_node);
 	if (!init_data) {
 		init_data = config->init_data;
diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index 80ba2a35a04b..c74ac8734023 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -38,11 +38,13 @@ struct regulator {
 #ifdef CONFIG_OF
 struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 			         const struct regulator_desc *desc,
+				 struct regulator_config *config,
 				 struct device_node **node);
 #else
 static inline struct regulator_init_data *
 regulator_of_get_init_data(struct device *dev,
 			   const struct regulator_desc *desc,
+			   struct regulator_config *config,
 			   struct device_node **node)
 {
 	return NULL;
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 91eaaf010524..24e812c48d93 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -270,6 +270,7 @@ EXPORT_SYMBOL_GPL(of_regulator_match);
 
 struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 					    const struct regulator_desc *desc,
+					    struct regulator_config *config,
 					    struct device_node **node)
 {
 	struct device_node *search, *child;
@@ -307,6 +308,16 @@ struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 			break;
 		}
 
+		if (desc->of_parse_cb) {
+			if (desc->of_parse_cb(child, desc, config)) {
+				dev_err(dev,
+					"driver callback failed to parse DT for regulator %s\n",
+					child->name);
+				init_data = NULL;
+				break;
+			}
+		}
+
 		of_node_get(child);
 		*node = child;
 		break;
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 5f1e9ca47417..d4ad5b5a02bb 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -21,6 +21,7 @@
 
 struct regmap;
 struct regulator_dev;
+struct regulator_config;
 struct regulator_init_data;
 struct regulator_enable_gpio;
 
@@ -205,6 +206,15 @@ enum regulator_type {
  * @supply_name: Identifying the regulator supply
  * @of_match: Name used to identify regulator in DT.
  * @regulators_node: Name of node containing regulator definitions in DT.
+ * @of_parse_cb: Optional callback called only if of_match is present.
+ *               Will be called for each regulator parsed from DT, during
+ *               init_data parsing.
+ *               The regulator_config passed as argument to the callback will
+ *               be a copy of config passed to regulator_register, valid only
+ *               for this particular call. Callback may freely change the
+ *               config but it cannot store it for later usage.
+ *               Callback should return 0 on success or negative ERRNO
+ *               indicating failure.
  * @id: Numerical identifier for the regulator.
  * @ops: Regulator operations table.
  * @irq: Interrupt number for the regulator.
@@ -251,6 +261,9 @@ struct regulator_desc {
 	const char *supply_name;
 	const char *of_match;
 	const char *regulators_node;
+	int (*of_parse_cb)(struct device_node *,
+			    const struct regulator_desc *,
+			    struct regulator_config *);
 	int id;
 	bool continuous_voltage_range;
 	unsigned n_voltages;
-- 
1.9.1
