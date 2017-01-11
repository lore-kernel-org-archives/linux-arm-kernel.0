From: eric.auger@redhat.com (Eric Auger)
Date: Wed, 11 Jan 2017 09:41:53 +0000
Subject: [PATCH v8 17/18] vfio/type1: Check MSI remapping at irq domain level
In-Reply-To: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
References: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1484127714-3263-18-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case the IOMMU translates MSI transactions (typical case
on ARM), we check MSI remapping capability at IRQ domain
level. Otherwise it is checked at IOMMU level.

At this stage the arm-smmu-(v3) still advertise the
IOMMU_CAP_INTR_REMAP capability at IOMMU level. This will be
removed in subsequent patches.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v6: rewrite test
---
 drivers/vfio/vfio_iommu_type1.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 5651faf..ec903a0 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -40,6 +40,7 @@
 #include <linux/mdev.h>
 #include <linux/notifier.h>
 #include <linux/dma-iommu.h>
+#include <linux/irqdomain.h>
 
 #define DRIVER_VERSION  "0.2"
 #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
@@ -1212,7 +1213,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	struct vfio_domain *domain, *d;
 	struct bus_type *bus = NULL, *mdev_bus;
 	int ret;
-	bool resv_msi;
+	bool resv_msi, msi_remap;
 	phys_addr_t resv_msi_base;
 
 	mutex_lock(&iommu->lock);
@@ -1288,8 +1289,10 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	INIT_LIST_HEAD(&domain->group_list);
 	list_add(&group->next, &domain->group_list);
 
-	if (!allow_unsafe_interrupts &&
-	    !iommu_capable(bus, IOMMU_CAP_INTR_REMAP)) {
+	msi_remap = resv_msi ? irq_domain_check_msi_remap() :
+				iommu_capable(bus, IOMMU_CAP_INTR_REMAP);
+
+	if (!allow_unsafe_interrupts && !msi_remap) {
 		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
 		       __func__);
 		ret = -EPERM;
-- 
1.9.1
