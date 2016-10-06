From: eric.auger@redhat.com (Eric Auger)
Date: Thu,  6 Oct 2016 08:45:29 +0000
Subject: [PATCH v13 13/15] vfio/type1: Check doorbell safety
In-Reply-To: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
References: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1475743531-4780-14-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On x86 IRQ remapping is abstracted by the IOMMU. On ARM this is abstracted
by the msi controller.

Since we currently have no way to detect whether the MSI controller is
upstream or downstream to the IOMMU we rely on the MSI doorbell information
registered by the interrupt controllers. In case at least one doorbell
does not implement proper isolation, we state the assignment is unsafe
with regard to interrupts. This is a coase assessment but should allow to
wait for a better system description.

At this point ARM sMMU still advertises IOMMU_CAP_INTR_REMAP. This is
removed in next patch.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v9 -> v10:
- coarse safety assessment based on MSI doorbell info

v3 -> v4:
- rename vfio_msi_parent_irq_remapping_capable into vfio_safe_irq_domain
  and irq_remapping into safe_irq_domains

v2 -> v3:
- protect vfio_msi_parent_irq_remapping_capable with
  CONFIG_GENERIC_MSI_IRQ_DOMAIN
---
 drivers/vfio/vfio_iommu_type1.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c2f8bd9..dc3ee5d 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -37,6 +37,7 @@
 #include <linux/vfio.h>
 #include <linux/workqueue.h>
 #include <linux/dma-iommu.h>
+#include <linux/msi-doorbell.h>
 
 #define DRIVER_VERSION  "0.2"
 #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
@@ -921,8 +922,13 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	INIT_LIST_HEAD(&domain->group_list);
 	list_add(&group->next, &domain->group_list);
 
+	/*
+	 * to advertise safe interrupts either the IOMMU or the MSI controllers
+	 * must support IRQ remapping (aka. interrupt translation)
+	 */
 	if (!allow_unsafe_interrupts &&
-	    !iommu_capable(bus, IOMMU_CAP_INTR_REMAP)) {
+	    (!iommu_capable(bus, IOMMU_CAP_INTR_REMAP) &&
+		!msi_doorbell_safe())) {
 		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
 		       __func__);
 		ret = -EPERM;
-- 
1.9.1
