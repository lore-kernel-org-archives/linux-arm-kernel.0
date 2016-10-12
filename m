From: eric.auger@redhat.com (Eric Auger)
Date: Wed, 12 Oct 2016 13:22:09 +0000
Subject: [PATCH v14 01/16] iommu/iova: fix __alloc_and_insert_iova_range
In-Reply-To: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
References: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1476278544-3397-2-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the size check within start_pfn and limit_pfn.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

the issue was observed when playing with 1 page iova domain with
higher iova reserved.
---
 drivers/iommu/iova.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index e23001b..ee29dbf 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -147,7 +147,7 @@ move_left:
 	if (!curr) {
 		if (size_aligned)
 			pad_size = iova_get_pad_size(size, limit_pfn);
-		if ((iovad->start_pfn + size + pad_size) > limit_pfn) {
+		if ((iovad->start_pfn + size + pad_size - 1) > limit_pfn) {
 			spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 			return -ENOMEM;
 		}
-- 
1.9.1
