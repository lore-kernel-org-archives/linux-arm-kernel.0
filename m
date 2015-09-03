From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu,  3 Sep 2015 13:58:28 -0600
Subject: [PATCH v2 1/7] PM / Domains: Allocate memory outside domain locks
In-Reply-To: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1441310314-8857-2-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for supporting IRQ-safe domains, allocate domain data
outside the domain locks. These functions are not called in an atomic
context, so we can always allocate memory using GFP_KERNEL. By
allocating memory before the locks, we can safely lock the domain using
spinlocks instead of mutexes.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Koz?owski <k.kozlowski@samsung.com>
Reviewed-by: Kevin Hilman <khilman@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/base/power/domain.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e45a0ef..ef8d19f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1381,13 +1381,17 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 			   struct generic_pm_domain *subdomain)
 {
-	struct gpd_link *link;
+	struct gpd_link *link, *itr;
 	int ret = 0;
 
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain)
 	    || genpd == subdomain)
 		return -EINVAL;
 
+	link = kzalloc(sizeof(*link), GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+
 	mutex_lock(&genpd->lock);
 	mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
 
@@ -1397,18 +1401,13 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 		goto out;
 	}
 
-	list_for_each_entry(link, &genpd->master_links, master_node) {
-		if (link->slave == subdomain && link->master == genpd) {
+	list_for_each_entry(itr, &genpd->master_links, master_node) {
+		if (itr->slave == subdomain && itr->master == genpd) {
 			ret = -EINVAL;
 			goto out;
 		}
 	}
 
-	link = kzalloc(sizeof(*link), GFP_KERNEL);
-	if (!link) {
-		ret = -ENOMEM;
-		goto out;
-	}
 	link->master = genpd;
 	list_add_tail(&link->master_node, &genpd->master_links);
 	link->slave = subdomain;
@@ -1419,7 +1418,8 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
  out:
 	mutex_unlock(&subdomain->lock);
 	mutex_unlock(&genpd->lock);
-
+	if (ret)
+		kfree(link);
 	return ret;
 }
 
@@ -1510,17 +1510,17 @@ int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
 	if (IS_ERR_OR_NULL(genpd) || state < 0)
 		return -EINVAL;
 
+	cpuidle_data = kzalloc(sizeof(*cpuidle_data), GFP_KERNEL);
+	if (!cpuidle_data)
+		return -ENOMEM;
+
 	mutex_lock(&genpd->lock);
 
 	if (genpd->cpuidle_data) {
 		ret = -EEXIST;
-		goto out;
-	}
-	cpuidle_data = kzalloc(sizeof(*cpuidle_data), GFP_KERNEL);
-	if (!cpuidle_data) {
-		ret = -ENOMEM;
-		goto out;
+		goto err_drv;
 	}
+
 	cpuidle_drv = cpuidle_driver_ref();
 	if (!cpuidle_drv) {
 		ret = -ENODEV;
-- 
2.1.4
