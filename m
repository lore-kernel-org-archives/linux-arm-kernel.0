From: eric.auger@redhat.com (Eric Auger)
Date: Thu,  5 Jan 2017 19:04:36 +0000
Subject: [PATCH v6 08/18] iommu/vt-d: Implement reserved region get/put
 callbacks
In-Reply-To: <1483643086-2883-1-git-send-email-eric.auger@redhat.com>
References: <1483643086-2883-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1483643086-2883-9-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch registers the [FEE0_0000h - FEF0_000h] 1MB MSI range
as a reserved region. This will allow to report that range
in the iommu-group sysfs.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

RFCv2 -> RFCv3:
- use get/put_resv_region callbacks.

RFC v1 -> RFC v2:
- fix intel_iommu_add_reserved_regions name
- use IOAPIC_RANGE_START and IOAPIC_RANGE_END defines
- return if the MSI region is already registered;
---
 drivers/iommu/intel-iommu.c | 50 +++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c66c273..4080207 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5184,6 +5184,28 @@ static void intel_iommu_remove_device(struct device *dev)
 	iommu_device_unlink(iommu->iommu_dev, dev);
 }
 
+static void intel_iommu_get_resv_regions(struct device *device,
+					 struct list_head *head)
+{
+	struct iommu_resv_region *reg;
+
+	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
+				      IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
+				      0, IOMMU_RESV_NOMAP);
+	if (!reg)
+		return;
+	list_add_tail(&reg->list, head);
+}
+
+static void intel_iommu_put_resv_regions(struct device *dev,
+					 struct list_head *head)
+{
+	struct iommu_resv_region *entry, *next;
+
+	list_for_each_entry_safe(entry, next, head, list)
+		kfree(entry);
+}
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev)
 {
@@ -5293,19 +5315,21 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
 #endif /* CONFIG_INTEL_IOMMU_SVM */
 
 static const struct iommu_ops intel_iommu_ops = {
-	.capable	= intel_iommu_capable,
-	.domain_alloc	= intel_iommu_domain_alloc,
-	.domain_free	= intel_iommu_domain_free,
-	.attach_dev	= intel_iommu_attach_device,
-	.detach_dev	= intel_iommu_detach_device,
-	.map		= intel_iommu_map,
-	.unmap		= intel_iommu_unmap,
-	.map_sg		= default_iommu_map_sg,
-	.iova_to_phys	= intel_iommu_iova_to_phys,
-	.add_device	= intel_iommu_add_device,
-	.remove_device	= intel_iommu_remove_device,
-	.device_group   = pci_device_group,
-	.pgsize_bitmap	= INTEL_IOMMU_PGSIZES,
+	.capable		= intel_iommu_capable,
+	.domain_alloc		= intel_iommu_domain_alloc,
+	.domain_free		= intel_iommu_domain_free,
+	.attach_dev		= intel_iommu_attach_device,
+	.detach_dev		= intel_iommu_detach_device,
+	.map			= intel_iommu_map,
+	.unmap			= intel_iommu_unmap,
+	.map_sg			= default_iommu_map_sg,
+	.iova_to_phys		= intel_iommu_iova_to_phys,
+	.add_device		= intel_iommu_add_device,
+	.remove_device		= intel_iommu_remove_device,
+	.get_resv_regions	= intel_iommu_get_resv_regions,
+	.put_resv_regions	= intel_iommu_put_resv_regions,
+	.device_group		= pci_device_group,
+	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
 
 static void quirk_iommu_g4x_gfx(struct pci_dev *dev)
-- 
1.9.1
