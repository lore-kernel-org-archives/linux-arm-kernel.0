From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 26 Jan 2016 18:06:37 +0000
Subject: [PATCH 4/4] iommu/arm-smmu: Use per-context TLB sync as appropriate
In-Reply-To: <cover.1453830752.git.robin.murphy@arm.com>
References: <cover.1453830752.git.robin.murphy@arm.com>
Message-ID: <fc2ede950aea2e84a0b7cf93e4cd605f0cbdf3c3.1453830752.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TLB synchronisation is a mighty big hammmer to bring down on the
transaction stream, typically stalling all in-flight transactions until
the sync completes. Since in most cases (except at stage 2 on SMMUv1)
a per-context sync operation is available, prefer that over the global
operation when performing TLB maintenance for a single domain, to avoid
unecessarily disrupting ongoing traffic in other contexts.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 18e0e10..bf1895c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -219,6 +219,8 @@
 #define ARM_SMMU_CB_S1_TLBIVAL		0x620
 #define ARM_SMMU_CB_S2_TLBIIPAS2	0x630
 #define ARM_SMMU_CB_S2_TLBIIPAS2L	0x638
+#define ARM_SMMU_CB_TLBSYNC		0x7f0
+#define ARM_SMMU_CB_TLBSTATUS		0x7f4
 #define ARM_SMMU_CB_ATS1PR		0x800
 #define ARM_SMMU_CB_ATSR		0x8f0
 
@@ -546,14 +548,22 @@ static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
 }
 
 /* Wait for any pending TLB invalidations to complete */
-static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
+static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu, int cbndx)
 {
 	int count = 0;
-	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
+	void __iomem *base, __iomem *status;
 
-	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_sTLBGSYNC);
-	while (readl_relaxed(gr0_base + ARM_SMMU_GR0_sTLBGSTATUS)
-	       & sTLBGSTATUS_GSACTIVE) {
+	if (cbndx < 0) {
+		base = ARM_SMMU_GR0(smmu);
+		status = base + ARM_SMMU_GR0_sTLBGSTATUS;
+		writel_relaxed(0, base + ARM_SMMU_GR0_sTLBGSYNC);
+	} else {
+		base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cbndx);
+		status = base + ARM_SMMU_CB_TLBSTATUS;
+		writel_relaxed(0, base + ARM_SMMU_CB_TLBSYNC);
+	}
+
+	while (readl_relaxed(status) & sTLBGSTATUS_GSACTIVE) {
 		cpu_relax();
 		if (++count == TLB_LOOP_TIMEOUT) {
 			dev_err_ratelimited(smmu->dev,
@@ -567,7 +577,13 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
 static void arm_smmu_tlb_sync(void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
-	__arm_smmu_tlb_sync(smmu_domain->smmu);
+	int cbndx = smmu_domain->cfg.cbndx;
+
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2 &&
+	    smmu_domain->smmu->version < ARM_SMMU_V2)
+		cbndx = -1;
+
+	__arm_smmu_tlb_sync(smmu_domain->smmu, cbndx);
 }
 
 static void arm_smmu_tlb_inv_context(void *cookie)
@@ -588,7 +604,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 			       base + ARM_SMMU_GR0_TLBIVMID);
 	}
 
-	__arm_smmu_tlb_sync(smmu);
+	__arm_smmu_tlb_sync(smmu, cfg->cbndx);
 }
 
 static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
@@ -1534,7 +1550,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	reg &= ~(sCR0_BSU_MASK << sCR0_BSU_SHIFT);
 
 	/* Push the button */
-	__arm_smmu_tlb_sync(smmu);
+	__arm_smmu_tlb_sync(smmu, -1);
 	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 }
 
-- 
2.7.0.25.gfc10eb5.dirty
