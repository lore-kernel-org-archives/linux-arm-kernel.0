From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 28 Oct 2014 15:38:10 +0100
Subject: [PATCH 4/4] PM / Domains: Let the ->attach_dev() callback return an
 error code
In-Reply-To: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
References: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1414507090-516-5-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Typically an ->attach_dev() callback would fetch some PM resourses.

Those operations, like for example clk_get() may fail with different
errors, including -EPROBE_DEFER. Instead of ignoring these errors and
potentially only print an error message, let's propagate them to give
callers the option to handle them.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 11 +++++++++--
 include/linux/pm_domain.h   |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4e5fcd7..da40769 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1394,12 +1394,19 @@ static int genpd_alloc_dev_data(struct generic_pm_domain *genpd,
 	if (ret)
 		goto err_data;
 
-	if (genpd->attach_dev)
-		genpd->attach_dev(dev);
+	if (genpd->attach_dev) {
+		ret = genpd->attach_dev(dev);
+		if (ret)
+			goto err_attach;
+	}
 
 	dev_pm_qos_add_notifier(dev, &gpd_data->nb);
 	return 0;
 
+ err_attach:
+	spin_lock_irq(&dev->power.lock);
+	dev->power.subsys_data->domain_data = NULL;
+	spin_unlock_irq(&dev->power.lock);
  err_data:
 	kfree(gpd_data);
  err_alloc:
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index e4edde1..70a3bc3 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -72,7 +72,7 @@ struct generic_pm_domain {
 	bool max_off_time_changed;
 	bool cached_power_down_ok;
 	struct gpd_cpuidle_data *cpuidle_data;
-	void (*attach_dev)(struct device *dev);
+	int (*attach_dev)(struct device *dev);
 	void (*detach_dev)(struct device *dev);
 };
 
-- 
1.9.1
