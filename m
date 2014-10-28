From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 28 Oct 2014 15:38:08 +0100
Subject: [PATCH 2/4] PM / Domains: Don't allow an existing generic PM domain
 data
In-Reply-To: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
References: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1414507090-516-3-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While adding devices to the generic PM domain we allocate data for the
struct generic_pm_domain_data.

Don't allow existing generic_pm_domain_data in this case, since that
indicates the device is already being added from another context. Let's
instead return an error.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7546242..9d511c7 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1423,9 +1423,9 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 
 	spin_lock_irq(&dev->power.lock);
 
-	dev->pm_domain = &genpd->domain;
 	if (dev->power.subsys_data->domain_data) {
-		gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
+		ret = -EINVAL;
+		goto out;
 	} else {
 		gpd_data = gpd_data_new;
 		dev->power.subsys_data->domain_data = &gpd_data->base;
@@ -1433,6 +1433,8 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (td)
 		gpd_data->td = *td;
 
+	dev->pm_domain = &genpd->domain;
+
 	spin_unlock_irq(&dev->power.lock);
 
 	if (genpd->attach_dev)
-- 
1.9.1
