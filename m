From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 27 Jan 2015 21:13:41 +0100
Subject: [PATCH 4/8] PM / Domains: Don't check for an existing device when
 adding a new
In-Reply-To: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
References: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1422389625-11730-5-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When adding a device to a genpd, we no longer need to walk genpd's list
of existing devices to verify it hasn't already been added.

Instead we can now rely on the verification of not allowing existing
generic_pm_domain_data for a device, since that has the same meaning.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 76eb0c3..88198ba 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1415,7 +1415,6 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 			  struct gpd_timing_data *td)
 {
 	struct generic_pm_domain_data *gpd_data_new, *gpd_data = NULL;
-	struct pm_domain_data *pdd;
 	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
@@ -1434,12 +1433,6 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 		goto out;
 	}
 
-	list_for_each_entry(pdd, &genpd->dev_list, list_node)
-		if (pdd->dev == dev) {
-			ret = -EINVAL;
-			goto out;
-		}
-
 	ret = dev_pm_get_subsys_data(dev);
 	if (ret)
 		goto out;
-- 
1.9.1
