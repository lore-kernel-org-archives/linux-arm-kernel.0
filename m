From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 18 May 2018 12:31:24 +0200
Subject: [PATCH 3/9] PM / Domains: Drop genpd as in-param for
 pm_genpd_remove_device()
In-Reply-To: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1526639490-12167-4-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to pass a genpd struct to pm_genpd_remove_device(), as we
already have the information about the PM domain (genpd) through the device
structure.

Additionally, we don't allow to remove a PM domain from a device, other
than the one it may have assigned to it, so really it does not make sense
to have a separate in-param for it.

For these reason, drop it and update the current only call to
pm_genpd_remove_device() from amdgpu_acp.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian K?nig <christian.koenig@amd.com>
Cc: David (ChunMing) Zhou <David1.Zhou@amd.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c             | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 2 +-
 include/linux/pm_domain.h               | 5 ++---
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d58aee3..f08fa15 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1475,13 +1475,13 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 
 /**
  * pm_genpd_remove_device - Remove a device from an I/O PM domain.
- * @genpd: PM domain to remove the device from.
  * @dev: Device to be removed.
  */
-int pm_genpd_remove_device(struct generic_pm_domain *genpd,
-			   struct device *dev)
+int pm_genpd_remove_device(struct device *dev)
 {
-	if (!genpd || genpd != genpd_lookup_dev(dev))
+	struct generic_pm_domain *genpd = genpd_lookup_dev(dev);
+
+	if (!genpd)
 		return -EINVAL;
 
 	return genpd_remove_device(genpd, dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index a29362f..1255804 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -513,7 +513,7 @@ static int acp_hw_fini(void *handle)
 	if (adev->acp.acp_genpd) {
 		for (i = 0; i < ACP_DEVS ; i++) {
 			dev = get_mfd_cell_dev(adev->acp.acp_cell[i].name, i);
-			ret = pm_genpd_remove_device(&adev->acp.acp_genpd->gpd, dev);
+			ret = pm_genpd_remove_device(dev);
 			/* If removal fails, dont giveup and try rest */
 			if (ret)
 				dev_err(dev, "remove dev from genpd failed\n");
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 79888fb..42e0d64 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -144,7 +144,7 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
 }
 
 int pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev);
-int pm_genpd_remove_device(struct generic_pm_domain *genpd, struct device *dev);
+int pm_genpd_remove_device(struct device *dev);
 int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 			   struct generic_pm_domain *new_subdomain);
 int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
@@ -167,8 +167,7 @@ static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
 {
 	return -ENOSYS;
 }
-static inline int pm_genpd_remove_device(struct generic_pm_domain *genpd,
-					 struct device *dev)
+static inline int pm_genpd_remove_device(struct device *dev)
 {
 	return -ENOSYS;
 }
-- 
2.7.4
