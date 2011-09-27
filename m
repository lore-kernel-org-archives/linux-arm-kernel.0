From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 27 Sep 2011 15:42:51 +0530
Subject: [PATCH 8/9] regulator: helper to extract regulator node based on
	supply name
In-Reply-To: <1317118372-17052-1-git-send-email-rnayak@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
Message-ID: <1317118372-17052-9-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device nodes in DT can associate themselves with one or more
regulators by providing a list of phandles (to regulator nodes)
and corresponding supply names.

For Example:
	devicenode: node at 0x0 {
		...
		...
		vmmc-supply = <&regulator1>;
		vpll-supply = <&regulator1>;
	};

The driver would then do a regulator_get(dev, "vmmc"); to get
regulator1 and do a regulator_get(dev, "vpll"); to get
regulator2.

of_get_regulator() extracts the regulator node for a given
device, based on the supply name.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/regulator/of_regulator.c       |   39 ++++++++++++++++++++++++++++++++
 include/linux/regulator/of_regulator.h |    7 +++++
 2 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 7fa63ff..49dd105 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -14,6 +14,45 @@
 #include <linux/of.h>
 #include <linux/regulator/machine.h>
 
+
+/**
+ * of_get_regulator - get a regulator device node based on supply name
+ * @dev: Device pointer for the consumer (of regulator) device
+ * @supply: regulator supply name
+ *
+ * Extract the regulator device node corresponding to the supply name.
+ * retruns the device node corresponding to the regulator if found, else
+ * returns NULL.
+ */
+struct device_node *of_get_regulator(struct device *dev, const char *supply)
+{
+	struct device_node *regnode = NULL;
+	u32 reghandle;
+	char prop_name[32]; /* 32 is max size of property name */
+	const void *prop;
+	int sz;
+
+	if (!dev)
+		return NULL;
+
+	dev_dbg(dev, "Looking up %s-supply from device tree\n", supply);
+
+	snprintf(prop_name, 32, "%s-supply", supply);
+
+	prop = of_get_property(dev->of_node, prop_name, &sz);
+	if (!prop || sz < 4)
+		return NULL;
+
+	reghandle = be32_to_cpup(prop);
+	regnode = of_find_node_by_phandle(reghandle);
+	if (!regnode) {
+		pr_warn("%s: %s property in node %s references invalid phandle",
+			__func__, prop_name, dev->of_node->full_name);
+		return NULL;
+	}
+	return regnode;
+}
+
 static void of_get_regulation_constraints(struct device_node *np,
 					struct regulator_init_data **init_data)
 {
diff --git a/include/linux/regulator/of_regulator.h b/include/linux/regulator/of_regulator.h
index 3f63be9..edaba1a 100644
--- a/include/linux/regulator/of_regulator.h
+++ b/include/linux/regulator/of_regulator.h
@@ -9,12 +9,19 @@
 #if defined(CONFIG_OF_REGULATOR)
 extern struct regulator_init_data
 	*of_get_regulator_init_data(struct device *dev);
+extern struct device_node *of_get_regulator(struct device *dev,
+	const char *supply);
 #else
 static inline struct regulator_init_data
 	*of_get_regulator_init_data(struct device_node *np)
 {
 	return NULL;
 }
+static inline struct device_node *of_get_regulator(struct device *dev,
+	const char *id)
+{
+	return NULL;
+}
 #endif /* CONFIG_OF_REGULATOR */
 
 #endif /* __LINUX_OF_REG_H */
-- 
1.7.1
