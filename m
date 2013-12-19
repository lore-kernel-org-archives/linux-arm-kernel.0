From: mporter@linaro.org (Matt Porter)
Date: Thu, 19 Dec 2013 09:23:02 -0500
Subject: [PATCH v8 1/9] phy: add phy_get_bus_width()/phy_set_bus_width() calls
In-Reply-To: <1387462990-12039-1-git-send-email-mporter@linaro.org>
References: <1387462990-12039-1-git-send-email-mporter@linaro.org>
Message-ID: <1387462990-12039-2-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a pair of APIs that allows the generic PHY subsystem to
provide information on the PHY bus width. The PHY provider driver may
use phy_set_bus_width() to set the bus width that the PHY supports.
The controller driver may then use phy_get_bus_width() to fetch the
PHY bus width in order to properly configure the controller.

Signed-off-by: Matt Porter <mporter@linaro.org>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/linux/phy/phy.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 6d72269..e273e5a 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -38,6 +38,14 @@ struct phy_ops {
 };
 
 /**
+ * struct phy_attrs - represents phy attributes
+ * @bus_width: Data path width implemented by PHY
+ */
+struct phy_attrs {
+	u32			bus_width;
+};
+
+/**
  * struct phy - represents the phy device
  * @dev: phy device
  * @id: id of the phy device
@@ -46,6 +54,7 @@ struct phy_ops {
  * @mutex: mutex to protect phy_ops
  * @init_count: used to protect when the PHY is used by multiple consumers
  * @power_count: used to protect when the PHY is used by multiple consumers
+ * @phy_attrs: used to specify PHY specific attributes
  */
 struct phy {
 	struct device		dev;
@@ -55,6 +64,7 @@ struct phy {
 	struct mutex		mutex;
 	int			init_count;
 	int			power_count;
+	struct phy_attrs	attrs;
 };
 
 /**
@@ -127,6 +137,14 @@ int phy_init(struct phy *phy);
 int phy_exit(struct phy *phy);
 int phy_power_on(struct phy *phy);
 int phy_power_off(struct phy *phy);
+static inline int phy_get_bus_width(struct phy *phy)
+{
+	return phy->attrs.bus_width;
+}
+static inline void phy_set_bus_width(struct phy *phy, int bus_width)
+{
+	phy->attrs.bus_width = bus_width;
+}
 struct phy *phy_get(struct device *dev, const char *string);
 struct phy *devm_phy_get(struct device *dev, const char *string);
 void phy_put(struct phy *phy);
@@ -199,6 +217,16 @@ static inline int phy_power_off(struct phy *phy)
 	return -ENOSYS;
 }
 
+static inline int phy_get_bus_width(struct phy *phy)
+{
+	return -ENOSYS;
+}
+
+static inline void phy_set_bus_width(struct phy *phy, int bus_width)
+{
+	return;
+}
+
 static inline struct phy *phy_get(struct device *dev, const char *string)
 {
 	return ERR_PTR(-ENOSYS);
-- 
1.8.4
