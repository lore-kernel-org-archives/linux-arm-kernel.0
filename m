From: matt.porter@linaro.org (Matt Porter)
Date: Fri,  1 Nov 2013 15:45:50 -0400
Subject: [PATCH v2 1/9] phy: add phy_get_bus_width()/phy_set_bus_width() calls
In-Reply-To: <1383335158-19730-1-git-send-email-matt.porter@linaro.org>
References: <1383335158-19730-1-git-send-email-matt.porter@linaro.org>
Message-ID: <1383335158-19730-2-git-send-email-matt.porter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a pair of APIs that allows the generic PHY subsystem to
provide information on the PHY bus width. The PHY provider driver may
use phy_set_bus_width() to set the bus width that the PHY supports.
The controller driver may then use phy_get_bus_width() to fetch the
PHY bus width in order to properly configure the controller.

Signed-off-by: Matt Porter <matt.porter@linaro.org>
---
 include/linux/phy/phy.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 6d72269..e858ce1 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -46,6 +46,7 @@ struct phy_ops {
  * @mutex: mutex to protect phy_ops
  * @init_count: used to protect when the PHY is used by multiple consumers
  * @power_count: used to protect when the PHY is used by multiple consumers
+ * @bus_width: used to specify data width of the PHY bus
  */
 struct phy {
 	struct device		dev;
@@ -55,6 +56,7 @@ struct phy {
 	struct mutex		mutex;
 	int			init_count;
 	int			power_count;
+	int			bus_width;
 };
 
 /**
@@ -127,6 +129,12 @@ int phy_init(struct phy *phy);
 int phy_exit(struct phy *phy);
 int phy_power_on(struct phy *phy);
 int phy_power_off(struct phy *phy);
+static inline int phy_get_bus_width(struct phy *phy) {
+	return phy->bus_width;
+};
+static inline void phy_set_bus_width(struct phy *phy, int bus_width) {
+	phy->bus_width = bus_width;
+};
 struct phy *phy_get(struct device *dev, const char *string);
 struct phy *devm_phy_get(struct device *dev, const char *string);
 void phy_put(struct phy *phy);
@@ -199,6 +207,14 @@ static inline int phy_power_off(struct phy *phy)
 	return -ENOSYS;
 }
 
+static inline int phy_get_bus_width(struct phy *phy) {
+	return -ENOSYS;
+};
+
+static inline void phy_set_bus_width(struct phy *phy, bus_width) {
+	return;
+};
+
 static inline struct phy *phy_get(struct device *dev, const char *string)
 {
 	return ERR_PTR(-ENOSYS);
-- 
1.8.4
