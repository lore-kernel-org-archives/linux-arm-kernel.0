From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 19 Apr 2016 17:24:41 +0000
Subject: [PATCH v7 1/7] vfio: introduce a vfio_dma type field
In-Reply-To: <1461086687-2658-1-git-send-email-eric.auger@linaro.org>
References: <1461086687-2658-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1461086687-2658-2-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We introduce a vfio_dma type since we will need to discriminate
different types of dma slots:
- VFIO_IOVA_USER: IOVA region used to map user vaddr
- VFIO_IOVA_RESERVED: IOVA region reserved to map host device PA such
  as MSI doorbells

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v6 -> v7:
- add VFIO_IOVA_ANY
- do not introduce yet any VFIO_IOVA_RESERVED handling
---
 drivers/vfio/vfio_iommu_type1.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 75b24e9..aaf5a6c 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -53,6 +53,16 @@ module_param_named(disable_hugepages,
 MODULE_PARM_DESC(disable_hugepages,
 		 "Disable VFIO IOMMU support for IOMMU hugepages.");
 
+enum vfio_iova_type {
+	VFIO_IOVA_USER = 0,	/* standard IOVA used to map user vaddr */
+	/*
+	 * IOVA reserved to map special host physical addresses,
+	 * MSI frames for instance
+	 */
+	VFIO_IOVA_RESERVED,
+	VFIO_IOVA_ANY,		/* matches any IOVA type */
+};
+
 struct vfio_iommu {
 	struct list_head	domain_list;
 	struct mutex		lock;
@@ -75,6 +85,7 @@ struct vfio_dma {
 	unsigned long		vaddr;		/* Process virtual addr */
 	size_t			size;		/* Map size (bytes) */
 	int			prot;		/* IOMMU_READ/WRITE */
+	enum vfio_iova_type	type;		/* type of IOVA */
 };
 
 struct vfio_group {
-- 
1.9.1
