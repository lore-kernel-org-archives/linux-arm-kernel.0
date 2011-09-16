From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 16 Sep 2011 20:51:45 +0300
Subject: [PATCH v3 5/6] iommu/intel: announce supported page sizes
In-Reply-To: <1316195506-9777-1-git-send-email-ohad@wizery.com>
References: <1316195506-9777-1-git-send-email-ohad@wizery.com>
Message-ID: <1316195506-9777-6-git-send-email-ohad@wizery.com>
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
 drivers/iommu/intel-iommu.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c621c98..46c21a2 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3426,6 +3426,24 @@ static struct notifier_block device_nb = {
 	.notifier_call = device_notifier,
 };
 
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
+ * If at some point we'd like to utilize the IOMMU core's new behavior,
+ * we could change this to advertise the real page sizes we support.
+ */
+static unsigned long intel_iommu_pgsizes = ~0xFFFUL;
+
 int __init intel_iommu_init(void)
 {
 	int ret = 0;
@@ -3486,7 +3504,8 @@ int __init intel_iommu_init(void)
 
 	init_iommu_pm_ops();
 
-	register_iommu(&intel_iommu_ops);
+	register_iommu_pgsize(&intel_iommu_ops, &intel_iommu_pgsizes,
+							BITS_PER_LONG);
 
 	bus_register_notifier(&pci_bus_type, &device_nb);
 
-- 
1.7.4.1
