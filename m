From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 10 Jun 2014 12:51:25 +0200
Subject: [PATCH 12/24] PM / Domains: Remove pm_genpd_syscore_switch() API
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1402397497-26737-13-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pm_genpd_syscore_poweroff() API and pm_genpd_syscore_poweron() API
makes the pm_genpd_syscore_switch() API redundant.

Moreover, since there are no active users, let's just remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c |   17 ++++++++++++++---
 include/linux/pm_domain.h   |   16 ++++------------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3b29477..2d20766 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1293,13 +1293,13 @@ static void pm_genpd_complete(struct device *dev)
 }
 
 /**
- * pm_genpd_syscore_switch - Switch power during system core suspend or resume.
+ * genpd_syscore_switch - Switch power during system core suspend or resume.
  * @dev: Device that normally is marked as "always on" to switch power for.
  *
  * This routine may only be called during the system core (syscore) suspend or
  * resume phase for devices whose "always on" flags are set.
  */
-void pm_genpd_syscore_switch(struct device *dev, bool suspend)
+static void genpd_syscore_switch(struct device *dev, bool suspend)
 {
 	struct generic_pm_domain *genpd;
 
@@ -1315,7 +1315,18 @@ void pm_genpd_syscore_switch(struct device *dev, bool suspend)
 		genpd->suspended_count--;
 	}
 }
-EXPORT_SYMBOL_GPL(pm_genpd_syscore_switch);
+
+void pm_genpd_syscore_poweroff(struct device *dev)
+{
+	genpd_syscore_switch(dev, true);
+}
+EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweroff);
+
+void pm_genpd_syscore_poweron(struct device *dev)
+{
+	genpd_syscore_switch(dev, false);
+}
+EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 
 #else
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 0e6205e..eacf6a1 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -249,21 +249,13 @@ static inline void pm_genpd_poweroff_unused(void) {}
 #endif
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS_SLEEP
-extern void pm_genpd_syscore_switch(struct device *dev, bool suspend);
+extern void pm_genpd_syscore_poweroff(struct device *dev);
+extern void pm_genpd_syscore_poweron(struct device *dev);
 #else
-static inline void pm_genpd_syscore_switch(struct device *dev, bool suspend) {}
+static inline void pm_genpd_syscore_poweroff(struct device *dev) {}
+static inline void pm_genpd_syscore_poweron(struct device *dev) {}
 #endif
 
-static inline void pm_genpd_syscore_poweroff(struct device *dev)
-{
-	pm_genpd_syscore_switch(dev, true);
-}
-
-static inline void pm_genpd_syscore_poweron(struct device *dev)
-{
-	pm_genpd_syscore_switch(dev, false);
-}
-
 /* OF power domain providers */
 struct of_device_id;
 
-- 
1.7.9.5
