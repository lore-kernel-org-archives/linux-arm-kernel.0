From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 27 Jan 2015 21:13:40 +0100
Subject: [PATCH 3/8] PM / Domains: Don't allow an existing
 generic_pm_domain_data
In-Reply-To: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
References: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1422389625-11730-4-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When adding a device to a genpd, a struct generic_pm_domain_data is
allocated per device.

Verify that there are no existing generic_pm_domain_data for the device
we are about to add, since that tells us it has already been added to a
genpd.

When genpd supported PM domain device callbacks, this was a valid
scenario. Now it isn't so let's return an error code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 351df5b..76eb0c3 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1444,26 +1444,30 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (ret)
 		goto out;
 
-	genpd->device_count++;
-	genpd->max_off_time_changed = true;
-
 	spin_lock_irq(&dev->power.lock);
 
-	dev->pm_domain = &genpd->domain;
 	if (dev->power.subsys_data->domain_data) {
-		gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
-	} else {
-		gpd_data = gpd_data_new;
-		dev->power.subsys_data->domain_data = &gpd_data->base;
+		spin_unlock_irq(&dev->power.lock);
+		ret = -EINVAL;
+		goto out;
 	}
+
+	gpd_data = gpd_data_new;
+	dev->power.subsys_data->domain_data = &gpd_data->base;
+
 	if (td)
 		gpd_data->td = *td;
 
+	dev->pm_domain = &genpd->domain;
+
 	spin_unlock_irq(&dev->power.lock);
 
 	if (genpd->attach_dev)
 		genpd->attach_dev(genpd, dev);
 
+	genpd->device_count++;
+	genpd->max_off_time_changed = true;
+
 	mutex_lock(&gpd_data->lock);
 	gpd_data->base.dev = dev;
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
-- 
1.9.1
