From: niklas.soderlund+renesas@ragnatech.se (=?UTF-8?q?Niklas=20S=C3=B6derlund?=)
Date: Tue,  8 Mar 2016 03:42:46 +0100
Subject: [PATCH v5 1/9] iommu: Add MMIO mapping type
In-Reply-To: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <1457404974-1800-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robin Murphy <robin.murphy@arm.com>

On some platforms, MMIO regions might need slightly different treatment
compared to mapping regular memory; add the notion of MMIO mappings to
the IOMMU API's memory type flags, so that callers can let the IOMMU
drivers know to do the right thing.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/iommu/io-pgtable-arm.c | 9 +++++++--
 include/linux/iommu.h          | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 381ca5a..9c19989 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -355,7 +355,10 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
 			pte |= ARM_LPAE_PTE_AP_RDONLY;
 
-		if (prot & IOMMU_CACHE)
+		if (prot & IOMMU_MMIO)
+			pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
+				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
+		else if (prot & IOMMU_CACHE)
 			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
 				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
 	} else {
@@ -364,7 +367,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 			pte |= ARM_LPAE_PTE_HAP_READ;
 		if (prot & IOMMU_WRITE)
 			pte |= ARM_LPAE_PTE_HAP_WRITE;
-		if (prot & IOMMU_CACHE)
+		if (prot & IOMMU_MMIO)
+			pte |= ARM_LPAE_PTE_MEMATTR_DEV;
+		else if (prot & IOMMU_CACHE)
 			pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
 		else
 			pte |= ARM_LPAE_PTE_MEMATTR_NC;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a5c539f..34b6432 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -30,6 +30,7 @@
 #define IOMMU_WRITE	(1 << 1)
 #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
 #define IOMMU_NOEXEC	(1 << 3)
+#define IOMMU_MMIO	(1 << 4) /* e.g. things like MSI doorbells */
 
 struct iommu_ops;
 struct iommu_group;
-- 
2.7.2
