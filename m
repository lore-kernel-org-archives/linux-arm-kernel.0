From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 10 Nov 2011 11:32:30 +0200
Subject: [PATCH v4-rebased 6/7] iommu/intel: announce supported page sizes
In-Reply-To: <1320917551-11328-1-git-send-email-ohad@wizery.com>
References: <1320917551-11328-1-git-send-email-ohad@wizery.com>
Message-ID: <1320917551-11328-7-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the IOMMU core know we support arbitrary page sizes (as long as
they're an order of 4KiB).

This way the IOMMU core will retain the existing behavior we're used to;
it will let us map regions that:
- their size is an order of 4KiB
- they are naturally aligned

Note: Intel IOMMU hardware doesn't support arbitrary page sizes,
but the driver does (it splits arbitrary-sized mappings into
the pages supported by the hardware).

To make everything simpler for now, though, this patch effectively tells
the IOMMU core to keep giving this driver the same memory regions it did
before, so nothing is changed as far as it's concerned.

At this point, the page sizes announced remain static within the IOMMU
core. To correctly utilize the pgsize-splitting of the IOMMU core by
this driver, it seems that some core changes should still be done,
because Intel's IOMMU page size capabilities seem to have the potential
to be different between different DMA remapping devices.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 drivers/iommu/intel-iommu.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2a16501..4c780ef 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -78,6 +78,24 @@
 #define LEVEL_STRIDE		(9)
 #define LEVEL_MASK		(((u64)1 << LEVEL_STRIDE) - 1)
 
+/*
+ * This bitmap is used to advertise the page sizes our hardware support
+ * to the IOMMU core, which will then use this information to split
+ * physically contiguous memory regions it is mapping into page sizes
+ * that we support.
+ *
+ * Traditionally the IOMMU core just handed us the mappings directly,
+ * after making sure the size is an order of a 4KiB page and that the
+ * mapping has natural alignment.
+ *
+ * To retain this behavior, we currently advertise that we support
+ * all page sizes that are an order of 4KiB.
+ *
+ * If@some point we'd like to utilize the IOMMU core's new behavior,
+ * we could change this to advertise the real page sizes we support.
+ */
+#define INTEL_IOMMU_PGSIZES	(~0xFFFUL)
+
 static inline int agaw_to_level(int agaw)
 {
 	return agaw + 2;
@@ -4066,6 +4084,7 @@ static struct iommu_ops intel_iommu_ops = {
 	.unmap		= intel_iommu_unmap,
 	.iova_to_phys	= intel_iommu_iova_to_phys,
 	.domain_has_cap = intel_iommu_domain_has_cap,
+	.pgsize_bitmap	= INTEL_IOMMU_PGSIZES,
 };
 
 static void __devinit quirk_iommu_rwbf(struct pci_dev *dev)
-- 
1.7.5.4
