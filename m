From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 27 Jan 2015 21:13:38 +0100
Subject: [PATCH 1/8] PM / Domains: Rename __pm_genpd_alloc|free_dev_data()
In-Reply-To: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
References: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1422389625-11730-2-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a step to get consistent names of functions in genpd, rename
the internal __pm_genpd_alloc|free_dev_data() into
gendp_alloc|free_dev_data().

As discussed on the linux-pm list, let's move towards the following
name rules:

Internal functions:
genpd_*
_genpd_*
__genpd_*

External functions:
pm_genpd_*
_pm_genpd_*
__pm_genpd_*

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index c5280f2..f9e7df5 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1384,7 +1384,7 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 
 #endif /* CONFIG_PM_SLEEP */
 
-static struct generic_pm_domain_data *__pm_genpd_alloc_dev_data(struct device *dev)
+static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev)
 {
 	struct generic_pm_domain_data *gpd_data;
 
@@ -1398,8 +1398,8 @@ static struct generic_pm_domain_data *__pm_genpd_alloc_dev_data(struct device *d
 	return gpd_data;
 }
 
-static void __pm_genpd_free_dev_data(struct device *dev,
-				     struct generic_pm_domain_data *gpd_data)
+static void genpd_free_dev_data(struct device *dev,
+				struct generic_pm_domain_data *gpd_data)
 {
 	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
 	kfree(gpd_data);
@@ -1423,7 +1423,7 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
 		return -EINVAL;
 
-	gpd_data_new = __pm_genpd_alloc_dev_data(dev);
+	gpd_data_new = genpd_alloc_dev_data(dev);
 	if (!gpd_data_new)
 		return -ENOMEM;
 
@@ -1477,7 +1477,7 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	genpd_release_lock(genpd);
 
 	if (gpd_data != gpd_data_new)
-		__pm_genpd_free_dev_data(dev, gpd_data_new);
+		genpd_free_dev_data(dev, gpd_data_new);
 
 	return ret;
 }
@@ -1548,7 +1548,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 
 	dev_pm_put_subsys_data(dev);
 	if (remove)
-		__pm_genpd_free_dev_data(dev, gpd_data);
+		genpd_free_dev_data(dev, gpd_data);
 
 	return 0;
 
-- 
1.9.1
