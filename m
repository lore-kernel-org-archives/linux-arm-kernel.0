From: will.deacon@arm.com (Will Deacon)
Date: Thu,  4 Sep 2014 17:50:02 +0100
Subject: [PATCH 4/7] iommu/arm-smmu: use page shift instead of page size to
 avoid division
In-Reply-To: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
References: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
Message-ID: <1409849405-17347-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arbitrary integer division is not available in all ARM CPUs, so the GCC
may spit out calls to helper functions which are not implemented in
the kernel.

This patch avoids these problems in the SMMU driver by using page shift
instead of page size, so that divisions by the page size (as required
by the vSMMU code) can be expressed as a simple right shift.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7ab3cc4ffbb3..ecad700cd4f4 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -59,7 +59,7 @@
 
 /* SMMU global address space */
 #define ARM_SMMU_GR0(smmu)		((smmu)->base)
-#define ARM_SMMU_GR1(smmu)		((smmu)->base + (smmu)->pagesize)
+#define ARM_SMMU_GR1(smmu)		((smmu)->base + (1 << (smmu)->pgshift))
 
 /*
  * SMMU global address space with conditional offset to access secure
@@ -224,7 +224,7 @@
 
 /* Translation context bank */
 #define ARM_SMMU_CB_BASE(smmu)		((smmu)->base + ((smmu)->size >> 1))
-#define ARM_SMMU_CB(smmu, n)		((n) * (smmu)->pagesize)
+#define ARM_SMMU_CB(smmu, n)		((n) * (1 << (smmu)->pgshift))
 
 #define ARM_SMMU_CB_SCTLR		0x0
 #define ARM_SMMU_CB_RESUME		0x8
@@ -354,7 +354,7 @@ struct arm_smmu_device {
 
 	void __iomem			*base;
 	unsigned long			size;
-	unsigned long			pagesize;
+	unsigned long			pgshift;
 
 #define ARM_SMMU_FEAT_COHERENT_WALK	(1 << 0)
 #define ARM_SMMU_FEAT_STREAM_MATCH	(1 << 1)
@@ -1807,12 +1807,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 
 	/* ID1 */
 	id = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID1);
-	smmu->pagesize = (id & ID1_PAGESIZE) ? SZ_64K : SZ_4K;
+	smmu->pgshift = (id & ID1_PAGESIZE) ? 16 : 12;
 
 	/* Check for size mismatch of SMMU address space from mapped region */
 	size = 1 <<
 		(((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
-	size *= (smmu->pagesize << 1);
+	size *= 2 << smmu->pgshift;
 	if (smmu->size != size)
 		dev_warn(smmu->dev,
 			"SMMU address space size (0x%lx) differs from mapped region size (0x%lx)!\n",
-- 
2.1.0
