From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 10 Jun 2014 12:51:26 +0200
Subject: [PATCH 13/24] PM / Domains: Remove genpd_queue_power_off_work() API
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1402397497-26737-14-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no active users of this API. Let's remove it and if future
needs shows up which could consider to have a get/put API instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c |    5 ++++-
 include/linux/pm_domain.h   |    2 --
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2d20766..825e81d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -423,7 +423,7 @@ static bool genpd_abort_poweroff(struct generic_pm_domain *genpd)
  * Queue up the execution of pm_genpd_poweroff() unless it's already been done
  * before.
  */
-void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
+static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
 {
 	queue_work(pm_wq, &genpd->power_off_work);
 }
@@ -730,6 +730,9 @@ static inline int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static inline void
+genpd_queue_power_off_work(struct generic_pm_domain *genpd) {}
+
 static inline void genpd_power_off_work_fn(struct work_struct *work) {}
 
 #define pm_genpd_runtime_suspend	NULL
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index eacf6a1..5cd8000 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -241,10 +241,8 @@ static inline int pm_genpd_name_add_device(const char *domain_name,
 }
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS_RUNTIME
-extern void genpd_queue_power_off_work(struct generic_pm_domain *genpd);
 extern void pm_genpd_poweroff_unused(void);
 #else
-static inline void genpd_queue_power_off_work(struct generic_pm_domain *gpd) {}
 static inline void pm_genpd_poweroff_unused(void) {}
 #endif
 
-- 
1.7.9.5
