From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 13 Sep 2011 22:31:24 +0300
Subject: [PATCH v2 2/6] iommu/omap: announce supported page sizes
In-Reply-To: <1315942288-17297-1-git-send-email-ohad@wizery.com>
References: <1315942288-17297-1-git-send-email-ohad@wizery.com>
Message-ID: <1315942288-17297-2-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the IOMMU core know we support 4KB, 64KB, 1MB and 16MB page sizes.

This way the IOMMU core can split any arbitrary-sized physically
contiguous regions (that it needs to map) as needed.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/iommu/omap-iommu.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 7e0188f..403dd6a 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1202,6 +1202,9 @@ static int omap_iommu_domain_has_cap(struct iommu_domain *domain,
 	return 0;
 }
 
+/* bitmap of the page sizes supported by the OMAP IOMMU hardware */
+static unsigned long omap_iommu_pgsizes = SZ_4K | SZ_64K | SZ_1M | SZ_16M;
+
 static struct iommu_ops omap_iommu_ops = {
 	.domain_init	= omap_iommu_domain_init,
 	.domain_destroy	= omap_iommu_domain_destroy,
@@ -1225,7 +1228,8 @@ static int __init omap_iommu_init(void)
 		return -ENOMEM;
 	iopte_cachep = p;
 
-	register_iommu(&omap_iommu_ops);
+	/* we're only using the first 25 bits of the pgsizes bitmap */
+	register_iommu_pgsize(&omap_iommu_ops, &omap_iommu_pgsizes, 25);
 
 	return platform_driver_register(&omap_iommu_driver);
 }
-- 
1.7.4.1
