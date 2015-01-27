From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 27 Jan 2015 21:13:39 +0100
Subject: [PATCH 2/8] PM / Domains: Remove reference counting for the
 generic_pm_domain_data
In-Reply-To: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
References: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1422389625-11730-3-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reference counting was needed when genpd supported PM domain device
callbacks. Since this option has been removed, let's also remove the
reference counting of the struct generic_pm_domain_data.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 10 ++--------
 include/linux/pm_domain.h   |  1 -
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index f9e7df5..351df5b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1456,7 +1456,6 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 		gpd_data = gpd_data_new;
 		dev->power.subsys_data->domain_data = &gpd_data->base;
 	}
-	gpd_data->refcount++;
 	if (td)
 		gpd_data->td = *td;
 
@@ -1504,7 +1503,6 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 {
 	struct generic_pm_domain_data *gpd_data;
 	struct pm_domain_data *pdd;
-	bool remove = false;
 	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
@@ -1533,10 +1531,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 	pdd = dev->power.subsys_data->domain_data;
 	list_del_init(&pdd->list_node);
 	gpd_data = to_gpd_data(pdd);
-	if (--gpd_data->refcount == 0) {
-		dev->power.subsys_data->domain_data = NULL;
-		remove = true;
-	}
+	dev->power.subsys_data->domain_data = NULL;
 
 	spin_unlock_irq(&dev->power.lock);
 
@@ -1547,8 +1542,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 	genpd_release_lock(genpd);
 
 	dev_pm_put_subsys_data(dev);
-	if (remove)
-		genpd_free_dev_data(dev, gpd_data);
+	genpd_free_dev_data(dev, gpd_data);
 
 	return 0;
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ed60776..e160a0b 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -114,7 +114,6 @@ struct generic_pm_domain_data {
 	struct gpd_timing_data td;
 	struct notifier_block nb;
 	struct mutex lock;
-	unsigned int refcount;
 	int need_restore;
 };
 
-- 
1.9.1
