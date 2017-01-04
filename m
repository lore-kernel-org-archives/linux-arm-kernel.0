From: eric.auger@redhat.com (Eric Auger)
Date: Wed,  4 Jan 2017 13:32:25 +0000
Subject: [PATCH v5 16/17] vfio/type1: Check MSI remapping at irq domain level
In-Reply-To: <1483536746-2725-1-git-send-email-eric.auger@redhat.com>
References: <1483536746-2725-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1483536746-2725-17-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case the IOMMU does not bypass MSI transactions (typical
case on ARM), we check all MSI controllers are IRQ remapping
capable. If not the IRQ assignment may be unsafe.

At this stage the arm-smmu-(v3) still advertise the
IOMMU_CAP_INTR_REMAP capability at IOMMU level. This will be
removed in subsequent patches.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/vfio/vfio_iommu_type1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index b473ef80..efcf7c3 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -40,6 +40,7 @@
 #include <linux/mdev.h>
 #include <linux/notifier.h>
 #include <linux/dma-iommu.h>
+#include <linux/irqdomain.h>
 
 #define DRIVER_VERSION  "0.2"
 #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
@@ -1285,7 +1286,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	list_add(&group->next, &domain->group_list);
 
 	if (!allow_unsafe_interrupts &&
-	    !iommu_capable(bus, IOMMU_CAP_INTR_REMAP)) {
+	    !iommu_capable(bus, IOMMU_CAP_INTR_REMAP) &&
+	    (resv_msi && !irq_domain_check_msi_remap())) {
 		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
 		       __func__);
 		ret = -EPERM;
-- 
1.9.1
