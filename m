From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 26 Mar 2015 13:43:06 +0100
Subject: [PATCH 03/16] iommu: Only allow iommu_map/unmap for paging domains
In-Reply-To: <1427373799-18662-1-git-send-email-joro@8bytes.org>
References: <1427373799-18662-1-git-send-email-joro@8bytes.org>
Message-ID: <1427373799-18662-4-git-send-email-joro@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joerg Roedel <jroedel@suse.de>

Check for the new __IOMMU_DOMAIN_PAGING flag before calling
into the iommu drivers ->map and ->unmap call-backs.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4920605..656b949 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1063,6 +1063,9 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     domain->ops->pgsize_bitmap == 0UL))
 		return -ENODEV;
 
+	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
+		return -EINVAL;
+
 	/* find out the minimum page size supported */
 	min_pagesz = 1 << __ffs(domain->ops->pgsize_bitmap);
 
@@ -1114,6 +1117,9 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 		     domain->ops->pgsize_bitmap == 0UL))
 		return -ENODEV;
 
+	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
+		return -EINVAL;
+
 	/* find out the minimum page size supported */
 	min_pagesz = 1 << __ffs(domain->ops->pgsize_bitmap);
 
-- 
1.9.1
