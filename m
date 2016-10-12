From: eric.auger@redhat.com (Eric Auger)
Date: Wed, 12 Oct 2016 13:22:14 +0000
Subject: [PATCH v14 06/16] iommu/arm-smmu: Implement domain_get_attr for
 DOMAIN_ATTR_MSI_RESV
In-Reply-To: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
References: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1476278544-3397-7-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM smmu and smmu-v3 translate MSI transactions so their driver
are must implement domain_get_attr for DOMAIN_ATTR_MSI_RESV.

This allows to retrieve the size and alignment requirements of
the MSI reserved IOVA window.

Also IOMMU_DMA gets selected since it exposes the API to map the
MSIs.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/Kconfig       | 4 ++--
 drivers/iommu/arm-smmu-v3.c | 7 +++++++
 drivers/iommu/arm-smmu.c    | 7 +++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 8ee54d7..f5e5e4b 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -297,7 +297,7 @@ config SPAPR_TCE_IOMMU
 config ARM_SMMU
 	bool "ARM Ltd. System MMU (SMMU) Support"
 	depends on (ARM64 || ARM) && MMU
-	select IOMMU_API
+	select IOMMU_DMA
 	select IOMMU_IO_PGTABLE_LPAE
 	select ARM_DMA_USE_IOMMU if ARM
 	help
@@ -310,7 +310,7 @@ config ARM_SMMU
 config ARM_SMMU_V3
 	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
 	depends on ARM64
-	select IOMMU_API
+	select IOMMU_DMA
 	select IOMMU_IO_PGTABLE_LPAE
 	select GENERIC_MSI_IRQ_DOMAIN
 	help
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 15c01c3..572cad8 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1559,6 +1559,9 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	if (ret < 0)
 		free_io_pgtable_ops(pgtbl_ops);
 
+	if (domain->type == IOMMU_DOMAIN_UNMANAGED)
+		iommu_calc_msi_resv(domain);
+
 	return ret;
 }
 
@@ -1840,6 +1843,10 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 	case DOMAIN_ATTR_NESTING:
 		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 		return 0;
+	case DOMAIN_ATTR_MSI_RESV:
+		*(struct iommu_domain_msi_resv *)data =
+			smmu_domain->domain.msi_resv;
+		return 0;
 	default:
 		return -ENODEV;
 	}
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ac4aab9..ae20b9c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -943,6 +943,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	domain->geometry.aperture_end = (1UL << ias) - 1;
 	domain->geometry.force_aperture = true;
 
+	if (domain->type == IOMMU_DOMAIN_UNMANAGED)
+		iommu_calc_msi_resv(domain);
+
 	/* Initialise the context bank with our page table cfg */
 	arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
 
@@ -1486,6 +1489,10 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 	case DOMAIN_ATTR_NESTING:
 		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 		return 0;
+	case DOMAIN_ATTR_MSI_RESV:
+		*(struct iommu_domain_msi_resv *)data =
+			smmu_domain->domain.msi_resv;
+		return 0;
 	default:
 		return -ENODEV;
 	}
-- 
1.9.1
