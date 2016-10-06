From: eric.auger@redhat.com (Eric Auger)
Date: Thu,  6 Oct 2016 08:45:24 +0000
Subject: [PATCH v13 08/15] vfio: Introduce a vfio_dma type field
In-Reply-To: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
References: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1475743531-4780-9-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We introduce a vfio_dma type since we will need to discriminate
different types of dma slots:
- VFIO_IOVA_USER: IOVA region used to map user vaddr
- VFIO_IOVA_RESERVED_MSI: IOVA region reserved to map MSI doorbells

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v9 -> v10:
- renamed VFIO_IOVA_RESERVED into VFIO_IOVA_RESERVED_MSI
- explicitly set type to VFIO_IOVA_USER on dma_map

v6 -> v7:
- add VFIO_IOVA_ANY
- do not introduce yet any VFIO_IOVA_RESERVED handling
---
 drivers/vfio/vfio_iommu_type1.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 2ba1942..a9f8b93 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -53,6 +53,12 @@ module_param_named(disable_hugepages,
 MODULE_PARM_DESC(disable_hugepages,
 		 "Disable VFIO IOMMU support for IOMMU hugepages.");
 
+enum vfio_iova_type {
+	VFIO_IOVA_USER = 0,	/* standard IOVA used to map user vaddr */
+	VFIO_IOVA_RESERVED_MSI,	/* reserved to map MSI doorbells */
+	VFIO_IOVA_ANY,		/* matches any IOVA type */
+};
+
 struct vfio_iommu {
 	struct list_head	domain_list;
 	struct mutex		lock;
@@ -75,6 +81,7 @@ struct vfio_dma {
 	unsigned long		vaddr;		/* Process virtual addr */
 	size_t			size;		/* Map size (bytes) */
 	int			prot;		/* IOMMU_READ/WRITE */
+	enum vfio_iova_type	type;		/* type of IOVA */
 };
 
 struct vfio_group {
@@ -607,6 +614,7 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 	dma->iova = iova;
 	dma->vaddr = vaddr;
 	dma->prot = prot;
+	dma->type = VFIO_IOVA_USER;
 
 	/* Insert zero-sized and grow as we map chunks of it */
 	vfio_link_dma(iommu, dma);
-- 
1.9.1
