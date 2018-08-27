From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Mon, 27 Aug 2018 09:11:11 -0600
Subject: [PATCH 8/9] drm/msm/a6xx: Add support for an interconnect path
In-Reply-To: <20180827151112.25211-1-jcrouse@codeaurora.org>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
Message-ID: <20180827151112.25211-9-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for setting the OPP defined bandwidth for a given
GPU frequency value for a6xx. On sdm845 even though the GPU
frequency is set by the GMU but the bus bandwidth quota is
set by the CPU.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 27 +++++++++++++++++++++++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  7 +++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index d0dac4c2e3e7..d63eefc7c74d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -4,6 +4,7 @@
 #include <linux/clk.h>
 #include <linux/iopoll.h>
 #include <linux/pm_opp.h>
+#include <linux/interconnect.h>
 #include <soc/qcom/cmd-db.h>
 
 #include "a6xx_gpu.h"
@@ -65,8 +66,15 @@ static bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
 		A6XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_CLK_OFF));
 }
 
-static int a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
+static void a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
 {
+	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
+	struct dev_pm_opp *opp;
+	u64 ab, ib;
+	int ret;
+
 	gmu_write(gmu, REG_A6XX_GMU_DCVS_ACK_OPTION, 0);
 
 	gmu_write(gmu, REG_A6XX_GMU_DCVS_PERF_SETTING,
@@ -82,7 +90,22 @@ static int a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
 	a6xx_gmu_set_oob(gmu, GMU_OOB_DCVS_SET);
 	a6xx_gmu_clear_oob(gmu, GMU_OOB_DCVS_SET);
 
-	return gmu_read(gmu, REG_A6XX_GMU_DCVS_RETURN);
+	ret = gmu_read(gmu, REG_A6XX_GMU_DCVS_RETURN);
+	if (ret)
+		dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
+
+	/* Set the interconnect bandwidth from the CPU */
+	if (IS_ERR_OR_NULL(gpu->icc_path))
+		return;
+
+	opp = dev_pm_opp_find_freq_exact(&gpu->pdev->dev,
+		gmu->gpu_freqs[index], true);
+	if (!IS_ERR_OR_NULL(opp)) {
+		if (!dev_pm_opp_get_interconnect_bw(opp, "port0", &ab, &ib))
+			icc_set(gpu->icc_path, ab, ib);
+
+		dev_pm_opp_put(opp);
+	}
 }
 
 static bool a6xx_gmu_check_idle_level(struct a6xx_gmu *gmu)
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index da1363a0c54d..2eace9bf32c7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
+#include <linux/interconnect.h>
 #include "adreno_gpu.h"
 #include "msm_gem.h"
 #include "msm_mmu.h"
@@ -694,6 +695,9 @@ static int adreno_get_pwrlevels(struct device *dev,
 
 	DBG("fast_rate=%u, slow_rate=27000000", gpu->fast_rate);
 
+	/* Check for an interconnect path for the bus */
+	gpu->icc_path = of_icc_get(dev, "port0");
+
 	return 0;
 }
 
@@ -732,10 +736,13 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
 {
+	struct msm_gpu *gpu = &adreno_gpu->base;
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
 		release_firmware(adreno_gpu->fw[i]);
 
+	icc_put(gpu->icc_path);
+
 	msm_gpu_cleanup(&adreno_gpu->base);
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 9122ee6e55e4..9c851d03f344 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -20,6 +20,7 @@
 
 #include <linux/clk.h>
 #include <linux/regulator/consumer.h>
+#include <linux/interconnect.h>
 
 #include "msm_drv.h"
 #include "msm_fence.h"
@@ -117,6 +118,8 @@ struct msm_gpu {
 	struct clk *ebi1_clk, *core_clk, *rbbmtimer_clk;
 	uint32_t fast_rate;
 
+	struct icc_path *icc_path;
+
 	/* Hang and Inactivity Detection:
 	 */
 #define DRM_MSM_INACTIVE_PERIOD   66 /* in ms (roughly four frames) */
-- 
2.18.0
