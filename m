From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Fri, 18 May 2018 15:34:51 -0600
Subject: [PATCH 07/16] drm/msm/gpu: Enable 64 bit mode by default
In-Reply-To: <20180518213500.31595-1-jcrouse@codeaurora.org>
References: <20180518213500.31595-1-jcrouse@codeaurora.org>
Message-ID: <20180518213500.31595-8-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A5XX GPUs can be run in either 32 or 64 bit mode. The GPU registers
and the microcode use 64 bit virtual addressing in either case but the
upper 32 bits are ignored if the GPU is in 32 bit mode. There is no
performance disadvantage to remaining in 64 bit mode even if we are
only generating 32 bit addresses so switch over now to prepare for
using addresses above 4G for targets that support them.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 14 ++++++++++++++
 drivers/gpu/drm/msm/msm_iommu.c       |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index d39400e5bc42..b2c0370072dd 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -741,6 +741,20 @@ static int a5xx_hw_init(struct msm_gpu *gpu)
 		REG_A5XX_RBBM_SECVID_TSB_TRUSTED_BASE_HI, 0x00000000);
 	gpu_write(gpu, REG_A5XX_RBBM_SECVID_TSB_TRUSTED_SIZE, 0x00000000);
 
+	/* Put the GPU into 64 bit by default */
+	gpu_write(gpu, REG_A5XX_CP_ADDR_MODE_CNTL, 0x1);
+	gpu_write(gpu, REG_A5XX_VSC_ADDR_MODE_CNTL, 0x1);
+	gpu_write(gpu, REG_A5XX_GRAS_ADDR_MODE_CNTL, 0x1);
+	gpu_write(gpu, REG_A5XX_RB_ADDR_MODE_CNTL, 0x1);
+	gpu_write(gpu, REG_A5XX_PC_ADDR_MODE_CNTL, 0x1);
+	gpu_write(gpu, REG_A5XX_HLSQ_ADDR_MODE_CNTL, 0x1);
+	gpu_write(gpu, REG_A5XX_VFD_ADDR_MODE_CNTL, 0x1);
+	gpu_write(gpu, REG_A5XX_VPC_ADDR_MODE_CNTL, 0x1);
+	gpu_write(gpu, REG_A5XX_UCHE_ADDR_MODE_CNTL, 0x1);
+	gpu_write(gpu, REG_A5XX_SP_ADDR_MODE_CNTL, 0x1);
+	gpu_write(gpu, REG_A5XX_TPL1_ADDR_MODE_CNTL, 0x1);
+	gpu_write(gpu, REG_A5XX_RBBM_SECVID_TSB_ADDR_MODE_CNTL, 0x1);
+
 	ret = adreno_hw_init(gpu);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index b23d33622f37..fdbe1a8372f0 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -30,7 +30,7 @@ static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
 	struct msm_iommu *iommu = arg;
 	if (iommu->base.handler)
 		return iommu->base.handler(iommu->base.arg, iova, flags);
-	pr_warn_ratelimited("*** fault: iova=%08lx, flags=%d\n", iova, flags);
+	pr_warn_ratelimited("*** fault: iova=%16lx, flags=%d\n", iova, flags);
 	return 0;
 }
 
-- 
2.17.0
