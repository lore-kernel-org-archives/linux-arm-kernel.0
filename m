From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 13 Sep 2011 22:31:25 +0300
Subject: [PATCH v2 3/6] iommu/msm: announce supported page sizes
In-Reply-To: <1315942288-17297-1-git-send-email-ohad@wizery.com>
References: <1315942288-17297-1-git-send-email-ohad@wizery.com>
Message-ID: <1315942288-17297-3-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the IOMMU core know we support 4KB, 64KB, 1MB and 16MB page sizes.

This way the IOMMU core can split any arbitrary-sized physically
contiguous regions (that it needs to map) as needed.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: David Brown <davidb@codeaurora.org>
Cc: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 drivers/iommu/msm_iommu.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index d1733f6..a4ed116 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -676,6 +676,9 @@ fail:
 	return 0;
 }
 
+/* bitmap of the page sizes currently supported */
+static unsigned long msm_iommu_pgsizes = SZ_4K | SZ_64K | SZ_1M | SZ_16M;
+
 static struct iommu_ops msm_iommu_ops = {
 	.domain_init = msm_iommu_domain_init,
 	.domain_destroy = msm_iommu_domain_destroy,
@@ -728,7 +731,10 @@ static void __init setup_iommu_tex_classes(void)
 static int __init msm_iommu_init(void)
 {
 	setup_iommu_tex_classes();
-	register_iommu(&msm_iommu_ops);
+
+	/* we're only using the first 25 bits of the pgsizes bitmap */
+	register_iommu_pgsize(&msm_iommu_ops, &msm_iommu_pgsizes, 25);
+
 	return 0;
 }
 
-- 
1.7.4.1
