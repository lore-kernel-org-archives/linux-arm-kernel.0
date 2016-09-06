From: robin.murphy@arm.com (Robin Murphy)
Date: Tue,  6 Sep 2016 16:33:51 +0100
Subject: [PATCH v6 18/20] iommu/arm-smmu: Set domain geometry
In-Reply-To: <cover.1473173789.git.robin.murphy@arm.com>
References: <cover.1473173789.git.robin.murphy@arm.com>
Message-ID: <c2c7b81e4b7965e0c4e289d54ba930cd28a1ab48.1473173789.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For non-aperture-based IOMMUs, the domain geometry seems to have become
the de-facto way of indicating the input address space size. That is
quite a useful thing from the users' perspective, so let's do the same.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 2 ++
 drivers/iommu/arm-smmu.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1f350a50b35d..be293b5aa896 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1546,6 +1546,8 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 		return -ENOMEM;
 
 	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
+	domain->geometry.aperture_end = (1UL << ias) - 1;
+	domain->geometry.force_aperture = true;
 	smmu_domain->pgtbl_ops = pgtbl_ops;
 
 	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index aaf7d92448a3..2e20cdc362e0 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -938,6 +938,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 
 	/* Update the domain's page sizes to reflect the page table format */
 	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
+	domain->geometry.aperture_end = (1UL << ias) - 1;
+	domain->geometry.force_aperture = true;
 
 	/* Initialise the context bank with our page table cfg */
 	arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
-- 
2.8.1.dirty
