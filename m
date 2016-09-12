From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 12 Sep 2016 17:13:58 +0100
Subject: [PATCH v7 20/22] iommu/arm-smmu: Set domain geometry
In-Reply-To: <cover.1473695704.git.robin.murphy@arm.com>
References: <cover.1473695704.git.robin.murphy@arm.com>
Message-ID: <f5e1003cbd75f426ed8f89715923c90cb18f6603.1473695704.git.robin.murphy@arm.com>
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
index 0c45c1e02e04..15c01c3cd540 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1551,6 +1551,8 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 		return -ENOMEM;
 
 	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
+	domain->geometry.aperture_end = (1UL << ias) - 1;
+	domain->geometry.force_aperture = true;
 	smmu_domain->pgtbl_ops = pgtbl_ops;
 
 	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f143dbc549b9..fa892d25004d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -940,6 +940,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 
 	/* Update the domain's page sizes to reflect the page table format */
 	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
+	domain->geometry.aperture_end = (1UL << ias) - 1;
+	domain->geometry.force_aperture = true;
 
 	/* Initialise the context bank with our page table cfg */
 	arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
-- 
2.8.1.dirty
