From: arun.ramamurthy@broadcom.com (Arun Ramamurthy)
Date: Wed, 1 Apr 2015 13:49:07 -0700
Subject: [PATCH v1 1/3] phy: core: Add devm_of_phy_get_by_index to phy-core
In-Reply-To: <1427921349-18173-1-git-send-email-arun.ramamurthy@broadcom.com>
References: <1427921349-18173-1-git-send-email-arun.ramamurthy@broadcom.com>
Message-ID: <1427921349-18173-2-git-send-email-arun.ramamurthy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some generic drivers, such as ehci, may use multiple phys and for such
drivers referencing phy(s) by name(s) does not make sense. Instead of
inventing new naming schemes and using custom code to iterate through them,
such drivers are better of using nameless phy bindings and using this newly
introduced API to iterate through them.

Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/phy/phy-core.c  | 32 ++++++++++++++++++++++++++++++++
 include/linux/phy/phy.h |  2 ++
 2 files changed, 34 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 3791838..964a84d 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -623,6 +623,38 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
 EXPORT_SYMBOL_GPL(devm_of_phy_get);
 
 /**
+ * devm_of_phy_get_by_index() - lookup and obtain a reference to a phy by index.
+ * @dev: device that requests this phy
+ * @np: node containing the phy
+ * @index: index of the phy
+ *
+ * Gets the phy using _of_phy_get(), and associates a device with it using
+ * devres. On driver detach, release function is invoked on the devres data,
+ * then, devres data is freed.
+ *
+ */
+struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
+				     int index)
+{
+	struct phy **ptr, *phy;
+
+	ptr = devres_alloc(devm_phy_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	phy = _of_phy_get(np, index);
+	if (!IS_ERR(phy)) {
+		*ptr = phy;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return phy;
+}
+EXPORT_SYMBOL_GPL(devm_of_phy_get_by_index);
+
+/**
  * phy_create() - create a new phy
  * @dev: device that is creating the new phy
  * @node: device node of the phy
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index a0197fa..ae2ffaf 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -133,6 +133,8 @@ struct phy *devm_phy_get(struct device *dev, const char *string);
 struct phy *devm_phy_optional_get(struct device *dev, const char *string);
 struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
 			    const char *con_id);
+struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
+				     int index);
 void phy_put(struct phy *phy);
 void devm_phy_put(struct device *dev, struct phy *phy);
 struct phy *of_phy_get(struct device_node *np, const char *con_id);
-- 
2.3.4
