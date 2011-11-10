From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 10 Nov 2011 11:32:27 +0200
Subject: [PATCH v4-rebased 3/7] iommu/omap: announce supported page sizes
In-Reply-To: <1320917551-11328-1-git-send-email-ohad@wizery.com>
References: <1320917551-11328-1-git-send-email-ohad@wizery.com>
Message-ID: <1320917551-11328-4-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the IOMMU core know we support 4KiB, 64KiB, 1MiB and 16MiB page sizes.

This way the IOMMU core can split any arbitrary-sized physically
contiguous regions (that it needs to map) as needed.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Hiroshi DOYU <hdoyu@nvidia.com>
---
 drivers/iommu/omap-iommu.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index ad80b1d..08cf7ec 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -33,6 +33,9 @@
 	     (__i < (n)) && (cr = __iotlb_read_cr((obj), __i), true);	\
 	     __i++)
 
+/* bitmap of the page sizes currently supported */
+#define OMAP_IOMMU_PGSIZES	(SZ_4K | SZ_64K | SZ_1M | SZ_16M)
+
 /**
  * struct omap_iommu_domain - omap iommu domain
  * @pgtable:	the page table
@@ -1207,6 +1210,7 @@ static struct iommu_ops omap_iommu_ops = {
 	.unmap		= omap_iommu_unmap,
 	.iova_to_phys	= omap_iommu_iova_to_phys,
 	.domain_has_cap	= omap_iommu_domain_has_cap,
+	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
 };
 
 static int __init omap_iommu_init(void)
-- 
1.7.5.4
