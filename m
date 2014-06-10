From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 10 Jun 2014 12:51:31 +0200
Subject: [PATCH 18/24] PM / Domains: Remove default_stop_ok() API
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1402397497-26737-19-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are currently no need to export default_stop_ok() as an API,
instead let's keep it local to the domain governor.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain_governor.c |    7 ++-----
 include/linux/pm_domain.h            |    9 +--------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index a089e3b..d88a62e 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -42,7 +42,7 @@ static int dev_update_qos_constraint(struct device *dev, void *data)
  * default_stop_ok - Default PM domain governor routine for stopping devices.
  * @dev: Device to check.
  */
-bool default_stop_ok(struct device *dev)
+static bool default_stop_ok(struct device *dev)
 {
 	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
 	unsigned long flags;
@@ -229,10 +229,7 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
 
 #else /* !CONFIG_PM_RUNTIME */
 
-bool default_stop_ok(struct device *dev)
-{
-	return false;
-}
+static inline bool default_stop_ok(struct device *dev) { return false; }
 
 #define default_power_down_ok	NULL
 #define always_on_power_down_ok	NULL
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 5cd8000..e94d8ae 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -116,8 +116,6 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
 	return to_gpd_data(dev->power.subsys_data->domain_data);
 }
 
-extern struct dev_power_governor simple_qos_governor;
-
 extern struct generic_pm_domain *dev_to_genpd(struct device *dev);
 extern int __pm_genpd_add_device(struct generic_pm_domain *genpd,
 				 struct device *dev,
@@ -146,8 +144,7 @@ extern void pm_genpd_init(struct generic_pm_domain *genpd,
 extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
 extern int pm_genpd_name_poweron(const char *domain_name);
 
-extern bool default_stop_ok(struct device *dev);
-
+extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
 #else
 
@@ -220,10 +217,6 @@ static inline int pm_genpd_name_poweron(const char *domain_name)
 {
 	return -ENOSYS;
 }
-static inline bool default_stop_ok(struct device *dev)
-{
-	return false;
-}
 #define simple_qos_governor NULL
 #define pm_domain_always_on_gov NULL
 #endif
-- 
1.7.9.5
