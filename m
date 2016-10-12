From: eric.auger@redhat.com (Eric Auger)
Date: Wed, 12 Oct 2016 13:22:19 +0000
Subject: [PATCH v14 11/16] vfio/type1: Implement recursive
 vfio_find_dma_from_node
In-Reply-To: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
References: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1476278544-3397-12-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch handles the case where a node is encountered, matching
@start and @size arguments but not matching the @type argument.
In that case, we need to skip that node and pursue the search in the
node's leaves. In case @start is inferior to the node's base, we
resume the search on the left leaf. If the recursive search on the left
leaves did not produce any match, we search the right leaves recursively.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>

---

v10: creation
---
 drivers/vfio/vfio_iommu_type1.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 1bd16ff..1f120f9 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -125,7 +125,17 @@ static struct vfio_dma *vfio_find_dma_from_node(struct rb_node *top,
 	if (type == VFIO_IOVA_ANY || dma->type == type)
 		return dma;
 
-	return NULL;
+	/* restart 2 searches skipping the current node */
+	if (start < dma->iova) {
+		dma = vfio_find_dma_from_node(node->rb_left, start,
+					      size, type);
+		if (dma)
+			return dma;
+	}
+	if (start + size > dma->iova + dma->size)
+		dma = vfio_find_dma_from_node(node->rb_right, start,
+					      size, type);
+	return dma;
 }
 
 /**
-- 
1.9.1
