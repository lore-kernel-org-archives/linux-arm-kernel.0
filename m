From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Wed, 21 Feb 2018 15:59:24 -0700
Subject: [PATCH 14/14] drm/msm/a5xx: Support per-instance pagetables
In-Reply-To: <20180221225924.30737-1-jcrouse@codeaurora.org>
References: <20180221225924.30737-1-jcrouse@codeaurora.org>
Message-ID: <20180221225924.30737-15-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for per-instance pagetables for 5XX targets. Create a support
buffer for preemption to hold the SMMU pagetable information for a preempted
ring, enable TTBR1 to support split pagetables and add the necessary PM4
commands to trigger a pagetable switch at the beginning of a user command.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c     | 55 ++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h     | 17 +++++++
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c | 76 +++++++++++++++++++++++++------
 drivers/gpu/drm/msm/adreno/adreno_gpu.c   | 11 +++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h   |  5 ++
 drivers/gpu/drm/msm/msm_ringbuffer.h      |  1 +
 6 files changed, 152 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index c106606887e2..e5d8df8e8e12 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -140,6 +140,59 @@ static void a5xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 		gpu_write(gpu, REG_A5XX_CP_RB_WPTR, wptr);
 }
 
+static void a5xx_set_pagetable(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
+	struct msm_file_private *ctx)
+{
+	u64 ttbr;
+	u32 asid;
+
+	if (msm_iommu_pasid_info(ctx->aspace->mmu, &ttbr, &asid))
+		return;
+
+	ttbr = ttbr | ((u64) asid) << 48;
+
+	/* Turn off protected mode */
+	OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
+	OUT_RING(ring, 0);
+
+	/* Turn on APIV mode to access critical regions */
+	OUT_PKT4(ring, REG_A5XX_CP_CNTL, 1);
+	OUT_RING(ring, 1);
+
+	/* Make sure the ME is synchronized before staring the update */
+	OUT_PKT7(ring, CP_WAIT_FOR_ME, 0);
+
+	/* Execute the table update */
+	OUT_PKT7(ring, CP_SMMU_TABLE_UPDATE, 3);
+	OUT_RING(ring, lower_32_bits(ttbr));
+	OUT_RING(ring, upper_32_bits(ttbr));
+	OUT_RING(ring, 0);
+
+	/*
+	 * Write the new TTBR0 to the preemption records - this will be used to
+	 * reload the pagetable if the current ring gets preempted out.
+	 */
+	OUT_PKT7(ring, CP_MEM_WRITE, 4);
+	OUT_RING(ring, lower_32_bits(rbmemptr(ring, ttbr0)));
+	OUT_RING(ring, upper_32_bits(rbmemptr(ring, ttbr0)));
+	OUT_RING(ring, lower_32_bits(ttbr));
+	OUT_RING(ring, upper_32_bits(ttbr));
+
+	/* Invalidate the draw state so we start off fresh */
+	OUT_PKT7(ring, CP_SET_DRAW_STATE, 3);
+	OUT_RING(ring, 0x40000);
+	OUT_RING(ring, 1);
+	OUT_RING(ring, 0);
+
+	/* Turn off APRIV */
+	OUT_PKT4(ring, REG_A5XX_CP_CNTL, 1);
+	OUT_RING(ring, 0);
+
+	/* Turn off protected mode */
+	OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
+	OUT_RING(ring, 1);
+}
+
 static void a5xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
 	struct msm_file_private *ctx)
 {
@@ -149,6 +202,8 @@ static void a5xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
 	struct msm_ringbuffer *ring = submit->ring;
 	unsigned int i, ibs = 0;
 
+	a5xx_set_pagetable(gpu, ring, ctx);
+
 	OUT_PKT7(ring, CP_PREEMPT_ENABLE_GLOBAL, 1);
 	OUT_RING(ring, 0x02);
 
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
index 6fb8c2f9b9e4..5070cb17d66c 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
@@ -45,6 +45,9 @@ struct a5xx_gpu {
 
 	atomic_t preempt_state;
 	struct timer_list preempt_timer;
+	struct a5xx_smmu_info *smmu_info;
+	struct drm_gem_object *smmu_info_bo;
+	uint64_t smmu_info_iova;
 };
 
 #define to_a5xx_gpu(x) container_of(x, struct a5xx_gpu, base)
@@ -128,6 +131,20 @@ struct a5xx_preempt_record {
  */
 #define A5XX_PREEMPT_COUNTER_SIZE (16 * 4)
 
+/*
+ * This is a global structure that the preemption code uses to switch in the
+ * pagetable for the preempted process - the code switches in whatever we
+ * after preempting in a new ring.
+ */
+struct a5xx_smmu_info {
+	uint32_t  magic;
+	uint32_t  _pad4;
+	uint64_t  ttbr0;
+	uint32_t  asid;
+	uint32_t  contextidr;
+};
+
+#define A5XX_SMMU_INFO_MAGIC 0x3618CDA3UL
 
 int a5xx_power_init(struct msm_gpu *gpu);
 void a5xx_gpmu_ucode_init(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
index 970c7963ae29..8a6618f51eb8 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
@@ -12,6 +12,7 @@
  */
 
 #include "msm_gem.h"
+#include "msm_mmu.h"
 #include "a5xx_gpu.h"
 
 /*
@@ -145,6 +146,15 @@ void a5xx_preempt_trigger(struct msm_gpu *gpu)
 	a5xx_gpu->preempt[ring->id]->wptr = get_wptr(ring);
 	spin_unlock_irqrestore(&ring->lock, flags);
 
+	/* Do read barrier to make sure we have updated pagetable info */
+	rmb();
+
+	/* Set the SMMU info for the preemption */
+	if (a5xx_gpu->smmu_info) {
+		a5xx_gpu->smmu_info->ttbr0 = ring->memptrs->ttbr0;
+		a5xx_gpu->smmu_info->contextidr = 0;
+	}
+
 	/* Set the address of the incoming preemption record */
 	gpu_write64(gpu, REG_A5XX_CP_CONTEXT_SWITCH_RESTORE_ADDR_LO,
 		REG_A5XX_CP_CONTEXT_SWITCH_RESTORE_ADDR_HI,
@@ -214,9 +224,10 @@ void a5xx_preempt_hw_init(struct msm_gpu *gpu)
 		a5xx_gpu->preempt[i]->rbase = gpu->rb[i]->iova;
 	}
 
-	/* Write a 0 to signal that we aren't switching pagetables */
+	/* Tell the CP where to find the smmu_info buffer*/
 	gpu_write64(gpu, REG_A5XX_CP_CONTEXT_SWITCH_SMMU_INFO_LO,
-		REG_A5XX_CP_CONTEXT_SWITCH_SMMU_INFO_HI, 0);
+		REG_A5XX_CP_CONTEXT_SWITCH_SMMU_INFO_HI,
+		a5xx_gpu->smmu_info_iova);
 
 	/* Reset the preemption state */
 	set_preempt_state(a5xx_gpu, PREEMPT_NONE);
@@ -275,8 +286,43 @@ void a5xx_preempt_fini(struct msm_gpu *gpu)
 		drm_gem_object_unreference(a5xx_gpu->preempt_bo[i]);
 		a5xx_gpu->preempt_bo[i] = NULL;
 	}
+
+	if (a5xx_gpu->smmu_info_bo) {
+		if (a5xx_gpu->smmu_info_iova)
+			msm_gem_put_iova(a5xx_gpu->smmu_info_bo, gpu->aspace);
+		drm_gem_object_unreference_unlocked(a5xx_gpu->smmu_info_bo);
+		a5xx_gpu->smmu_info_bo = NULL;
+	}
 }
 
+static int a5xx_smmu_info_init(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a5xx_gpu *a5xx_gpu = to_a5xx_gpu(adreno_gpu);
+	struct a5xx_smmu_info *ptr;
+	struct drm_gem_object *bo;
+	u64 iova;
+
+	if (!msm_mmu_has_feature(gpu->aspace->mmu,
+			MMU_FEATURE_PER_INSTANCE_TABLES))
+		return 0;
+
+	ptr = msm_gem_kernel_new(gpu->dev, sizeof(struct a5xx_smmu_info),
+		MSM_BO_UNCACHED, gpu->aspace, &bo, &iova);
+
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
+
+	ptr->magic = A5XX_SMMU_INFO_MAGIC;
+
+	a5xx_gpu->smmu_info_bo = bo;
+	a5xx_gpu->smmu_info_iova = iova;
+	a5xx_gpu->smmu_info = ptr;
+
+	return 0;
+}
+
+
 void a5xx_preempt_init(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
@@ -288,17 +334,21 @@ void a5xx_preempt_init(struct msm_gpu *gpu)
 		return;
 
 	for (i = 0; i < gpu->nr_rings; i++) {
-		if (preempt_init_ring(a5xx_gpu, gpu->rb[i])) {
-			/*
-			 * On any failure our adventure is over. Clean up and
-			 * set nr_rings to 1 to force preemption off
-			 */
-			a5xx_preempt_fini(gpu);
-			gpu->nr_rings = 1;
-
-			return;
-		}
+		if (preempt_init_ring(a5xx_gpu, gpu->rb[i]))
+			goto fail;
 	}
 
-	timer_setup(&a5xx_gpu->preempt_timer, a5xx_preempt_timer, 0);
+	if (a5xx_smmu_info_init(gpu))
+		goto fail;
+
+		timer_setup(&a5xx_gpu->preempt_timer, a5xx_preempt_timer, 0);
+
+	return;
+fail:
+	/*
+	 * On any failure our adventure is over. Clean up and
+	 * set nr_rings to 1 to force preemption off
+	 */
+	a5xx_preempt_fini(gpu);
+	gpu->nr_rings = 1;
 }
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index de63ff26a062..cccd437e6ea3 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -552,6 +552,17 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	adreno_gpu_config.ioname = "kgsl_3d0_reg_memory";
 	adreno_gpu_config.irqname = "kgsl_3d0_irq";
 
+	if (adreno_is_a5xx(adreno_gpu)) {
+		/*
+		 * If possible use the TTBR1 virtual address space for all the
+		 * "global" buffer objects which are shared between processes.
+		 * This leaves the lower virtual address space open for
+		 * per-instance pagables if they are available
+		 */
+		adreno_gpu_config.va_start_global = 0xfffffff800000000ULL;
+		adreno_gpu_config.va_end_global = 0xfffffff8ffffffffULL;
+	}
+
 	adreno_gpu_config.va_start = SZ_16M;
 	adreno_gpu_config.va_end = 0xffffffff;
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 8d3d0a924908..1b2021c884f7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -197,6 +197,11 @@ static inline int adreno_is_a530(struct adreno_gpu *gpu)
 	return gpu->revn == 530;
 }
 
+static inline bool adreno_is_a5xx(struct adreno_gpu *gpu)
+{
+	return ((gpu->revn >= 500) & (gpu->revn < 600));
+}
+
 int adreno_get_param(struct msm_gpu *gpu, uint32_t param, uint64_t *value);
 const struct firmware *adreno_request_fw(struct adreno_gpu *adreno_gpu,
 		const char *fwname);
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.h b/drivers/gpu/drm/msm/msm_ringbuffer.h
index cffce094aecb..fd71484d5894 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.h
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.h
@@ -26,6 +26,7 @@
 struct msm_rbmemptrs {
 	volatile uint32_t rptr;
 	volatile uint32_t fence;
+	volatile uint64_t ttbr0;
 };
 
 struct msm_ringbuffer {
-- 
2.16.1
