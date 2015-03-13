From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 13 Mar 2015 16:43:42 +0100
Subject: [PATCH 2/9] PM / Domains: Enable genpd to support ->get|put()
 callbacks
In-Reply-To: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1426261429-31883-3-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To provide users control over whether the power should be maintained,
implement the ->get|put() callbacks for genpd's PM domain.

A usage count variable keeps track of the number of users. A positive
value tells genpd to keep supplying power and also to power up if it's
the first user.

Once the usage count reaches zero, genpd tries to power off its PM
domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 26 +++++++++++++++++++++++++-
 include/linux/pm_domain.h   |  1 +
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 45937f8..7314459 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -495,10 +495,12 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 	 * (2) The domain is waiting for its master to power up.
 	 * (3) One of the domain's devices is being resumed right now.
 	 * (4) System suspend is in progress.
+	 * (5) The usage_count > 0, since it tells us to stay powered.
 	 */
 	if (genpd->status == GPD_STATE_POWER_OFF
 	    || genpd->status == GPD_STATE_WAIT_MASTER
-	    || genpd->resume_count > 0 || genpd->prepared_count > 0)
+	    || genpd->resume_count > 0 || genpd->prepared_count > 0
+	    || atomic_read(&genpd->usage_count) > 0)
 		return 0;
 
 	if (atomic_read(&genpd->sd_count) > 0)
@@ -1377,6 +1379,25 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 
 #endif /* CONFIG_PM_SLEEP */
 
+static int genpd_get(struct dev_pm_domain *domain)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(domain);
+
+	atomic_inc(&genpd->usage_count);
+
+	return pm_genpd_poweron(genpd);
+}
+
+static void genpd_put(struct dev_pm_domain *domain)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(domain);
+
+	if (!atomic_dec_and_test(&genpd->usage_count))
+		return;
+
+	genpd_queue_power_off_work(genpd);
+}
+
 static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
 					struct generic_pm_domain *genpd,
 					struct gpd_timing_data *td)
@@ -1874,10 +1895,13 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->status = is_off ? GPD_STATE_POWER_OFF : GPD_STATE_ACTIVE;
 	init_waitqueue_head(&genpd->status_wait_queue);
 	genpd->poweroff_task = NULL;
+	atomic_set(&genpd->usage_count, 0);
 	genpd->resume_count = 0;
 	genpd->device_count = 0;
 	genpd->max_off_time_ns = -1;
 	genpd->max_off_time_changed = true;
+	genpd->domain.get = genpd_get;
+	genpd->domain.put = genpd_put;
 	genpd->domain.ops.runtime_suspend = pm_genpd_runtime_suspend;
 	genpd->domain.ops.runtime_resume = pm_genpd_runtime_resume;
 	genpd->domain.ops.prepare = pm_genpd_prepare;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index c80d6ac..698ecbe 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -61,6 +61,7 @@ struct generic_pm_domain {
 	enum gpd_status status;	/* Current state of the domain */
 	wait_queue_head_t status_wait_queue;
 	struct task_struct *poweroff_task;	/* Powering off task */
+	atomic_t usage_count;		/* Number of users of the domain */
 	unsigned int resume_count;	/* Number of devices being resumed */
 	unsigned int device_count;	/* Number of devices */
 	unsigned int suspended_count;	/* System suspend device counter */
-- 
1.9.1
