From: eric.auger@linaro.org (Eric Auger)
Date: Tue, 19 Apr 2016 16:56:31 +0000
Subject: [PATCH v7 07/10] iommu/dma-reserved-iommu: delete bindings in
 iommu_free_reserved_iova_domain
In-Reply-To: <1461084994-2355-1-git-send-email-eric.auger@linaro.org>
References: <1461084994-2355-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1461084994-2355-8-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now reserved bindings can exist, destroy them when destroying
the reserved iova domain. iommu_map is not supposed to be atomic,
hence the extra complexity in the locking.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---
v6 -> v7:
- remove [PATCH v6 7/7] dma-reserved-iommu: iommu_unmap_reserved and
  destroy the bindings in iommu_free_reserved_iova_domain

v5 -> v6:
- use spin_lock instead of mutex

v3 -> v4:
- previously "iommu/arm-smmu: relinquish reserved resources on
  domain deletion"
---
 drivers/iommu/dma-reserved-iommu.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dma-reserved-iommu.c b/drivers/iommu/dma-reserved-iommu.c
index 426d339..2522235 100644
--- a/drivers/iommu/dma-reserved-iommu.c
+++ b/drivers/iommu/dma-reserved-iommu.c
@@ -157,14 +157,36 @@ void iommu_free_reserved_iova_domain(struct iommu_domain *domain)
 	unsigned long flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&domain->reserved_lock, flags);
-
-	rid = (struct reserved_iova_domain *)domain->reserved_iova_cookie;
-	if (!rid) {
-		ret = -EINVAL;
-		goto unlock;
+	while (1) {
+		struct iommu_reserved_binding *b;
+		struct rb_node *node;
+		dma_addr_t iova;
+		size_t size;
+
+		spin_lock_irqsave(&domain->reserved_lock, flags);
+
+		rid = (struct reserved_iova_domain *)
+				domain->reserved_iova_cookie;
+		if (!rid) {
+			ret = -EINVAL;
+			goto unlock;
+		}
+
+		node = rb_first(&domain->reserved_binding_list);
+		if (!node)
+			break;
+		b = rb_entry(node, struct iommu_reserved_binding, node);
+
+		iova = b->iova;
+		size = b->size;
+
+		while (!kref_put(&b->kref, reserved_binding_release))
+			;
+		spin_unlock_irqrestore(&domain->reserved_lock, flags);
+		iommu_unmap(domain, iova, size);
 	}
 
+	domain->reserved_binding_list = RB_ROOT;
 	domain->reserved_iova_cookie = NULL;
 unlock:
 	spin_unlock_irqrestore(&domain->reserved_lock, flags);
-- 
1.9.1
