From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Tue,  1 Oct 2013 14:39:06 +0200
Subject: [PATCH 2/6] iommu/arm-smmu: Refine check for proper size of mapped
 region
In-Reply-To: <1380631150-10783-1-git-send-email-andreas.herrmann@calxeda.com>
References: <1380631150-10783-1-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <1380631150-10783-3-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is already a check to print a warning if the size of SMMU
address space (calculated from SMMU register values) is greater than
the size of the mapped memory region (e.g. passed via DT to the
driver).

Adapt this check to print also a warning in case the mapped region is
larger than the SMMU address space.

Such a mismatch could be intentional (to fix wrong register values).
If its not intentional (e.g. due to wrong DT information) this will
very likely cause a malfunction of the driver as SMMU_CB_BASE is
derived from the size of the mapped region. The warning helps to
identify the root cause in this case.

Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 drivers/iommu/arm-smmu.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 548f5d1..d19676c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1700,13 +1700,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	id = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID1);
 	smmu->pagesize = (id & ID1_PAGESIZE) ? SZ_64K : SZ_4K;
 
-	/* Check that we ioremapped enough */
+	/* Check for size mismatch of SMMU address space from mapped region */
 	size = 1 << (((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
 	size *= (smmu->pagesize << 1);
-	if (smmu->size < size)
-		dev_warn(smmu->dev,
-			 "device is 0x%lx bytes but only mapped 0x%lx!\n",
-			 size, smmu->size);
+	if (smmu->size != size)
+		dev_warn(smmu->dev, "SMMU address space size (0x%lx) differs "
+			"from mapped region size (0x%lx)!\n", size, smmu->size);
 
 	smmu->num_s2_context_banks = (id >> ID1_NUMS2CB_SHIFT) &
 				      ID1_NUMS2CB_MASK;
-- 
1.7.9.5
