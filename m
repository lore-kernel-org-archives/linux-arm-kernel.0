From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 10 Dec 2014 16:48:27 +0100
Subject: [RFC 09/15] phy: add restrack support
In-Reply-To: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
References: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1418226513-14105-10-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PHYs supports different methods of lookup.
The patch adds restrack support only to DT based PHYs.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/phy/phy-core.c   | 90 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/phy/phy.h  |  3 ++
 include/linux/restrack.h |  1 +
 3 files changed, 94 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index ff5eec5..449ec4e 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -22,6 +22,7 @@
 #include <linux/idr.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/restrack.h>
 
 static struct class *phy_class;
 static DEFINE_MUTEX(phy_provider_mutex);
@@ -754,6 +755,8 @@ struct phy_provider *__of_phy_provider_register(struct device *dev,
 	list_add_tail(&phy_provider->list, &phy_provider_list);
 	mutex_unlock(&phy_provider_mutex);
 
+	restrack_up(RESTRACK_TYPE_PHY, dev->of_node, phy_provider);
+
 	return phy_provider;
 }
 EXPORT_SYMBOL_GPL(__of_phy_provider_register);
@@ -804,6 +807,9 @@ void of_phy_provider_unregister(struct phy_provider *phy_provider)
 	if (IS_ERR(phy_provider))
 		return;
 
+	restrack_down(RESTRACK_TYPE_PHY, phy_provider->dev->of_node,
+		      phy_provider);
+
 	mutex_lock(&phy_provider_mutex);
 	list_del(&phy_provider->list);
 	kfree(phy_provider);
@@ -828,6 +834,90 @@ void devm_of_phy_provider_unregister(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_of_phy_provider_unregister);
 
+int of_get_phy_spec(struct device *dev, const char *name,
+		struct of_phandle_args *spec)
+{
+	struct device_node *np = dev->of_node;
+	int idx;
+
+	idx = of_property_match_string(np, "phy-names", name);
+
+	return of_parse_phandle_with_args(np, "phys", "#phy-cells", idx, spec);
+}
+
+struct phy_restrack_desc {
+	struct phy **ptr;
+	const char *name;
+	struct of_phandle_args spec;
+	struct restrack_desc desc;
+};
+
+static int phy_restrack_init(struct device *dev,
+		struct restrack_desc *desc)
+{
+	struct phy_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+	int ret;
+
+	ret = of_get_phy_spec(dev, rd->name, &rd->spec);
+	if (!ret)
+		desc->if_id = rd->spec.np;
+	return ret;
+}
+
+static void phy_restrack_destroy(struct device *dev,
+		struct restrack_desc *desc)
+{
+	struct phy_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+
+	of_node_put(desc->if_id);
+	kfree(rd);
+}
+
+static int phy_restrack_ifup(struct device *dev,
+		struct restrack_desc *desc, void *data)
+{
+	struct phy_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+	struct phy_provider *phy_provider = data;
+
+	*rd->ptr = phy_provider->of_xlate(phy_provider->dev, &rd->spec);
+	return PTR_ERR_OR_ZERO(*rd->ptr);
+}
+
+static void phy_restrack_ifdown(struct device *dev,
+		struct restrack_desc *desc, void *data)
+{
+	struct phy_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+
+	*rd->ptr = ERR_PTR(-EPROBE_DEFER);
+}
+
+static const struct restrack_ops phy_restrack_ops = {
+	.if_type = RESTRACK_TYPE_PHY,
+	.init = phy_restrack_init,
+	.destroy = phy_restrack_destroy,
+	.if_up = phy_restrack_ifup,
+	.if_down = phy_restrack_ifdown,
+};
+
+/**
+ * phy_restrack_desc - phy resource descriptor allocator
+ * @phy: pointer to variable which will be set to phy handle
+ * @name: name of phy
+ *
+ * The function creates resource description for phy, which shall be used
+ * by *restrack_register functions.
+ */
+struct restrack_desc *phy_restrack_desc(struct phy **phy, const char *name)
+{
+	struct phy_restrack_desc *rd;
+
+	RESTRACK_DESC_ALLOC(rd, phy_restrack_ops, phy, name);
+
+	return rd ? &rd->desc : ERR_PTR(-ENOMEM);
+}
+EXPORT_SYMBOL_GPL(phy_restrack_desc);
+
+
 /**
  * phy_release() - release the phy
  * @dev: the dev member within phy
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 8cb6f81..14d176c 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -174,6 +174,9 @@ struct phy_provider *__devm_of_phy_provider_register(struct device *dev,
 void of_phy_provider_unregister(struct phy_provider *phy_provider);
 void devm_of_phy_provider_unregister(struct device *dev,
 	struct phy_provider *phy_provider);
+
+struct restrack_desc;
+struct restrack_desc *phy_restrack_desc(struct phy **phy, const char *name);
 #else
 static inline int phy_pm_runtime_get(struct phy *phy)
 {
diff --git a/include/linux/restrack.h b/include/linux/restrack.h
index 6707dce..411d791 100644
--- a/include/linux/restrack.h
+++ b/include/linux/restrack.h
@@ -7,6 +7,7 @@
 #define RESTRACK_TYPE_REGULATOR 2
 #define RESTRACK_TYPE_GPIO 3
 #define RESTRACK_TYPE_CLOCK 4
+#define RESTRACK_TYPE_PHY 5
 
 struct device;
 struct restrack_ctx;
-- 
1.9.1
