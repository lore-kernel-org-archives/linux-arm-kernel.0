From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Fri, 20 Jan 2017 10:50:55 -0800
Subject: [PATCH v7 3/5] phy: Add set_vbus callback
In-Reply-To: <20170120185057.16206-1-stephen.boyd@linaro.org>
References: <20170120185057.16206-1-stephen.boyd@linaro.org>
Message-ID: <20170120185057.16206-4-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some USB PHYs need to be told about vbus changing state
explicitly. For example the qcom USB HS PHY needs to toggle a bit
when vbus goes from low to high (VBUSVLDEXT) to cause the
"session valid" signal to toggle. This signal will pull up D+
when the phy starts running. If the vbus signal isn't routed to
the PHY this "session valid" signal won't ever toggle, so we have
to toggle it explicitly. This callback is used to do that.

Cc: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

New patch

 drivers/phy/phy-core.c  | 15 +++++++++++++++
 include/linux/phy/phy.h | 10 ++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index a268f4d6f3e9..8b1a6bfa5133 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -357,6 +357,21 @@ int phy_set_mode(struct phy *phy, enum phy_mode mode)
 }
 EXPORT_SYMBOL_GPL(phy_set_mode);
 
+int phy_set_vbus(struct phy *phy, int on)
+{
+	int ret;
+
+	if (!phy || !phy->ops->set_vbus)
+		return 0;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->set_vbus(phy, on);
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_set_vbus);
+
 int phy_reset(struct phy *phy)
 {
 	int ret;
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 78bb0d7f6b11..4d1ebde7fb14 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -36,6 +36,7 @@ enum phy_mode {
  * @power_on: powering on the phy
  * @power_off: powering off the phy
  * @set_mode: set the mode of the phy
+ * @set_vbus: enable/disable vbus in the phy (USB)
  * @reset: resetting the phy
  * @owner: the module owner containing the ops
  */
@@ -45,6 +46,7 @@ struct phy_ops {
 	int	(*power_on)(struct phy *phy);
 	int	(*power_off)(struct phy *phy);
 	int	(*set_mode)(struct phy *phy, enum phy_mode mode);
+	int	(*set_vbus)(struct phy *phy, int on);
 	int	(*reset)(struct phy *phy);
 	struct module *owner;
 };
@@ -138,6 +140,7 @@ int phy_exit(struct phy *phy);
 int phy_power_on(struct phy *phy);
 int phy_power_off(struct phy *phy);
 int phy_set_mode(struct phy *phy, enum phy_mode mode);
+int phy_set_vbus(struct phy *phy, int on);
 int phy_reset(struct phy *phy);
 static inline int phy_get_bus_width(struct phy *phy)
 {
@@ -253,6 +256,13 @@ static inline int phy_set_mode(struct phy *phy, enum phy_mode mode)
 	return -ENOSYS;
 }
 
+static inline int phy_set_vbus(struct phy *phy, int on)
+{
+	if (!phy)
+		return 0;
+	return -ENOSYS;
+}
+
 static inline int phy_reset(struct phy *phy)
 {
 	if (!phy)
-- 
2.10.0.297.gf6727b0
