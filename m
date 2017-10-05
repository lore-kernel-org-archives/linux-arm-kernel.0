From: andrzej.p@samsung.com (Andrzej Pietrasiewicz)
Date: Thu, 05 Oct 2017 14:11:50 +0200
Subject: [PATCHv3 1/2] drivers: phy: add calibrate method
In-Reply-To: <1507205511-23048-1-git-send-email-andrzej.p@samsung.com>
References: <6935498c-9788-14e6-844f-f9e8288026dc@samsung.com>
 <1507205511-23048-1-git-send-email-andrzej.p@samsung.com>
 <CGME20171005121201eucas1p269da2155c4257777b0c3a5b210c651f8@eucas1p2.samsung.com>
Message-ID: <1507205511-23048-2-git-send-email-andrzej.p@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some quirky UDCs (like dwc3 on exynos) need to have heir phys calibrated
e.g. for using super speed.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
---
 drivers/phy/phy-core.c  | 15 +++++++++++++++
 include/linux/phy/phy.h | 10 ++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index a268f4d..b4964b0 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -372,6 +372,21 @@ int phy_reset(struct phy *phy)
 }
 EXPORT_SYMBOL_GPL(phy_reset);
 
+int phy_calibrate(struct phy *phy)
+{
+	int ret;
+
+	if (!phy || !phy->ops->calibrate)
+		return 0;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->calibrate(phy);
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_calibrate);
+
 /**
  * _of_phy_get() - lookup and obtain a reference to a phy by phandle
  * @np: device_node for which to get the phy
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index e694d40..87580c8 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -39,6 +39,7 @@ enum phy_mode {
  * @power_off: powering off the phy
  * @set_mode: set the mode of the phy
  * @reset: resetting the phy
+ * @calibrate: calibrate the phy
  * @owner: the module owner containing the ops
  */
 struct phy_ops {
@@ -48,6 +49,7 @@ struct phy_ops {
 	int	(*power_off)(struct phy *phy);
 	int	(*set_mode)(struct phy *phy, enum phy_mode mode);
 	int	(*reset)(struct phy *phy);
+	int	(*calibrate)(struct phy *phy);
 	struct module *owner;
 };
 
@@ -141,6 +143,7 @@ static inline void *phy_get_drvdata(struct phy *phy)
 int phy_power_off(struct phy *phy);
 int phy_set_mode(struct phy *phy, enum phy_mode mode);
 int phy_reset(struct phy *phy);
+int phy_calibrate(struct phy *phy);
 static inline int phy_get_bus_width(struct phy *phy)
 {
 	return phy->attrs.bus_width;
@@ -262,6 +265,13 @@ static inline int phy_reset(struct phy *phy)
 	return -ENOSYS;
 }
 
+static inline int phy_calibrate(struct phy *phy)
+{
+	if (!phy)
+		return 0;
+	return -ENOSYS;
+}
+
 static inline int phy_get_bus_width(struct phy *phy)
 {
 	return -ENOSYS;
-- 
1.9.1
