From: eric.auger@redhat.com (Eric Auger)
Date: Wed, 12 Oct 2016 13:22:22 +0000
Subject: [PATCH v14 14/16] vfio/type1: Check doorbell safety
In-Reply-To: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
References: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1476278544-3397-15-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On x86 IRQ remapping is abstracted by the IOMMU. On ARM this is abstracted
by the msi controller.

Since we currently have no way to detect whether the MSI controller is
upstream or downstream to the IOMMU we rely on the MSI doorbell information
registered by the interrupt controllers. In case at least one doorbell
does not implement proper isolation, we state the assignment is unsafe
with regard to interrupts. This is a coarse assessment but should allow to
wait for a better system description.

At this point ARM sMMU still advertises IOMMU_CAP_INTR_REMAP. This is
removed in next patch.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v13 -> v15:
- check vfio_msi_resv before checking whether msi doorbell is safe

v9 -> v10:
- coarse safety assessment based on MSI doorbell info

v3 -> v4:
- rename vfio_msi_parent_irq_remapping_capable into vfio_safe_irq_domain
  and irq_remapping into safe_irq_domains

v2 -> v3:
- protect vfio_msi_parent_irq_remapping_capable with
  CONFIG_GENERIC_MSI_IRQ_DOMAIN
---
 drivers/vfio/vfio_iommu_type1.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index e0c97ef..c18ba9d 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -442,6 +442,29 @@ static void vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma)
 }
 
 /**
+ * vfio_msi_resv - Return whether any VFIO iommu domain requires
+ * MSI mapping
+ *
+ * @iommu: vfio iommu handle
+ *
+ * Return: true of MSI mapping is needed, false otherwise
+ */
+static bool vfio_msi_resv(struct vfio_iommu *iommu)
+{
+	struct iommu_domain_msi_resv msi_resv;
+	struct vfio_domain *d;
+	int ret;
+
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		ret = iommu_domain_get_attr(d->domain, DOMAIN_ATTR_MSI_RESV,
+					    &msi_resv);
+		if (!ret)
+			return true;
+	}
+	return false;
+}
+
+/**
  * vfio_set_msi_aperture - Sets the msi aperture on all domains
  * requesting MSI mapping
  *
@@ -945,8 +968,13 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	INIT_LIST_HEAD(&domain->group_list);
 	list_add(&group->next, &domain->group_list);
 
+	/*
+	 * to advertise safe interrupts either the IOMMU or the MSI controllers
+	 * must support IRQ remapping (aka. interrupt translation)
+	 */
 	if (!allow_unsafe_interrupts &&
-	    !iommu_capable(bus, IOMMU_CAP_INTR_REMAP)) {
+	    (!iommu_capable(bus, IOMMU_CAP_INTR_REMAP) &&
+		!(vfio_msi_resv(iommu) && iommu_msi_doorbell_safe()))) {
 		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
 		       __func__);
 		ret = -EPERM;
-- 
1.9.1
