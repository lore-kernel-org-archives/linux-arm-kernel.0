From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 12 Dec 2011 21:16:28 +0530
Subject: [PATCH 1/2] PM / Domains: Add OF support
In-Reply-To: <1323704789-23923-1-git-send-email-thomas.abraham@linaro.org>
References: <1323704789-23923-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1323704789-23923-2-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A device node pointer is added to generic pm domain structure to associate
the domain with a node in the device tree. The platform code parses the
device tree to find available nodes representing the generic power domain,
instantiates the available domains and initializes them by calling
pm_genpd_init().

Nodes representing the devices include a phandle of the power domain to
which it belongs. As these devices get instantiated, the driver code
checkes for availability of a power domain phandle, converts the phandle
to a device node and uses the new pm_genpd_of_add_device() api to
associate the device with a power domain.

pm_genpd_of_add_device() runs through its list of registered power domains
and matches the OF node of the domain with the one specified as the
parameter. If a match is found, the device is associated with the matched
domain.

Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/base/power/domain.c |   14 +++++++++++++-
 include/linux/pm_domain.h   |   13 +++++++++++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 92e6a90..e895dc9 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1118,14 +1118,26 @@ static void pm_genpd_complete(struct device *dev)
  * @td: Set of PM QoS timing parameters to attach to the device.
  */
 int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
-			  struct gpd_timing_data *td)
+			  struct gpd_timing_data *td, struct device_node *node)
 {
 	struct generic_pm_domain_data *gpd_data;
+	struct generic_pm_domain *gpd = NULL;
 	struct pm_domain_data *pdd;
 	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
+	mutex_lock(&gpd_list_lock);
+	if (node) {
+		list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
+			if (gpd->of_node == node) {
+				genpd = gpd;
+				break;
+			}
+		}
+	}
+	mutex_unlock(&gpd_list_lock);
+
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
 		return -EINVAL;
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index a03a0ad..2ce7cc4 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -11,6 +11,7 @@
 
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/of.h>
 
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
@@ -70,6 +71,7 @@ struct generic_pm_domain {
 	s64 break_even_ns;	/* Power break even for the entire domain. */
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	ktime_t power_off_time;
+	struct device_node *of_node; /* Node in device tree */
 };
 
 static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
@@ -115,12 +117,19 @@ extern struct dev_power_governor simple_qos_governor;
 extern struct generic_pm_domain *dev_to_genpd(struct device *dev);
 extern int __pm_genpd_add_device(struct generic_pm_domain *genpd,
 				 struct device *dev,
-				 struct gpd_timing_data *td);
+				 struct gpd_timing_data *td,
+				 struct device_node *gpd_node);
 
 static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
 				      struct device *dev)
 {
-	return __pm_genpd_add_device(genpd, dev, NULL);
+	return __pm_genpd_add_device(genpd, dev, NULL, NULL);
+}
+
+static inline int pm_genpd_of_add_device(struct device_node *gpd_node,
+					 struct device *dev)
+{
+	return __pm_genpd_add_device(NULL, dev, NULL, gpd_node);
 }
 
 extern int pm_genpd_remove_device(struct generic_pm_domain *genpd,
-- 
1.6.6.rc2
