From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Fri, 18 May 2018 15:34:53 -0600
Subject: [PATCH 09/16] drm/msm/gpu: Support using split page tables for kernel
 buffer objects
In-Reply-To: <20180518213500.31595-1-jcrouse@codeaurora.org>
References: <20180518213500.31595-1-jcrouse@codeaurora.org>
Message-ID: <20180518213500.31595-10-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm-smmu based targets can support split pagetables (TTBR0/TTBR1).
This is most useful for implementing per-instance pagetables so that
the "user" pagetable can be swapped out while the "kernel" or
"global" pagetable remains entact.

if the target specifies a global virtual memory range then try to
enable TTBR1 (the "global" pagetable) on the domain and if
successful use the global virtual memory range for allocations
on the default GPU address space - this ensures that the global
allocations make it into the right space. Per-instance pagetables
still need additional support to be enabled but even if they
aren't set up it isn't harmful to just use TTBR1 for all
virtual memory regions and leave the other pagetable unused.

If TTBR1 support isn't enabled then fall back to the "legacy"
virtual address space both kernel and user.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/gpu/drm/msm/msm_gpu.c | 19 +++++++++++++++++--
 drivers/gpu/drm/msm/msm_gpu.h |  4 ++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 2f45bea04221..78e8e56d2499 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -703,7 +703,8 @@ static int get_clocks(struct platform_device *pdev, struct msm_gpu *gpu)
 
 static struct msm_gem_address_space *
 msm_gpu_create_address_space(struct msm_gpu *gpu, struct platform_device *pdev,
-		uint64_t va_start, uint64_t va_end)
+		u64 va_start, u64 va_end,
+		u64 va_global_start, u64 va_global_end)
 {
 	struct iommu_domain *iommu;
 	struct msm_gem_address_space *aspace;
@@ -721,6 +722,19 @@ msm_gpu_create_address_space(struct msm_gpu *gpu, struct platform_device *pdev,
 	iommu->geometry.aperture_start = va_start;
 	iommu->geometry.aperture_end = va_end;
 
+	/* If a va_global range was specified then try to set up split tables */
+	if (va_global_start && va_global_end) {
+		int val = 1;
+
+		ret = iommu_domain_set_attr(iommu, DOMAIN_ATTR_SPLIT_TABLES,
+			&val);
+
+		if (!WARN(ret, "Unable to enable split pagetables for the IOMMU\n")) {
+			iommu->geometry.aperture_start = va_global_start;
+			iommu->geometry.aperture_end = va_global_end;
+		}
+	}
+
 	dev_info(gpu->dev->dev, "%s: using IOMMU\n", gpu->name);
 
 	aspace = msm_gem_address_space_create(&pdev->dev, iommu, "gpu");
@@ -813,7 +827,8 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	msm_devfreq_init(gpu);
 
 	gpu->aspace = msm_gpu_create_address_space(gpu, pdev,
-		config->va_start, config->va_end);
+		config->va_start, config->va_end, config->va_start_global,
+		config->va_end_global);
 
 	if (gpu->aspace == NULL)
 		dev_info(drm->dev, "%s: no IOMMU, fallback to VRAM carveout!\n", name);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index b8241179175a..da58aa6c12c8 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -31,8 +31,8 @@ struct msm_gpu_perfcntr;
 struct msm_gpu_config {
 	const char *ioname;
 	const char *irqname;
-	uint64_t va_start;
-	uint64_t va_end;
+	uint64_t va_start, va_end;
+	uint64_t va_start_global, va_end_global;
 	unsigned int nr_rings;
 };
 
-- 
2.17.0
