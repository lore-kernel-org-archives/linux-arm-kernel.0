From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 13 Sep 2011 22:31:26 +0300
Subject: [PATCH v2 4/6] iommu/amd: announce supported page sizes
In-Reply-To: <1315942288-17297-1-git-send-email-ohad@wizery.com>
References: <1315942288-17297-1-git-send-email-ohad@wizery.com>
Message-ID: <1315942288-17297-4-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the IOMMU core know we support arbitrary page sizes (as long as
they're an order of 4KB).

This way the IOMMU core will retain the existing behavior we're used to;
it will let us map regions that:
- their size is an order of 4KB
- they are naturally aligned

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Joerg Roedel <Joerg.Roedel@amd.com>
---
 drivers/iommu/amd_iommu.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a14f8dc..17fa0fc 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2488,12 +2488,31 @@ static unsigned device_dma_ops_init(void)
 }
 
 /*
+ * This bitmap is used to advertise the page sizes our hardware support
+ * to the IOMMU core, which will then use this information to split
+ * physically contiguous memory regions it is mapping into page sizes
+ * that we support.
+ *
+ * Traditionally the IOMMU core just handed us the mappings directly,
+ * after making sure the size is an order of a 4KB page and that the
+ * mapping has natural alignment.
+ *
+ * To retain this behavior, we currently advertise that we support
+ * all page sizes that are an order of 4KB.
+ *
+ * If at some point we'd like to utilize the IOMMU core's new behavior,
+ * we could change this to advertise the real page sizes we support.
+ */
+static unsigned long amd_iommu_pgsizes = ~0xFFFUL;
+
+/*
  * The function which clues the AMD IOMMU driver into dma_ops.
  */
 
 void __init amd_iommu_init_api(void)
 {
-	register_iommu(&amd_iommu_ops);
+	register_iommu_pgsize(&amd_iommu_ops, &amd_iommu_pgsizes,
+						BITS_PER_LONG);
 }
 
 int __init amd_iommu_init_dma_ops(void)
-- 
1.7.4.1
