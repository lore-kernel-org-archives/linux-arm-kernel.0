From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 4 Nov 2014 14:57:16 +0100
Subject: [PATCH v6 1/1] iommu-api: Add map_sg function
In-Reply-To: <1414256116-26933-2-git-send-email-ohaugan@codeaurora.org>
References: <1414256116-26933-1-git-send-email-ohaugan@codeaurora.org>
 <1414256116-26933-2-git-send-email-ohaugan@codeaurora.org>
Message-ID: <20141104135716.GA14512@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 25, 2014 at 09:55:16AM -0700, Olav Haugan wrote:
>  drivers/iommu/amd_iommu.c      |  1 +
>  drivers/iommu/arm-smmu.c       |  1 +
>  drivers/iommu/exynos-iommu.c   |  1 +
>  drivers/iommu/intel-iommu.c    |  1 +
>  drivers/iommu/iommu.c          | 25 +++++++++++++++++++++++++
>  drivers/iommu/ipmmu-vmsa.c     |  1 +
>  drivers/iommu/msm_iommu.c      |  1 +
>  drivers/iommu/omap-iommu.c     |  1 +
>  drivers/iommu/shmobile-iommu.c |  1 +
>  drivers/iommu/tegra-smmu.c     |  1 +
>  include/linux/iommu.h          | 22 ++++++++++++++++++++++
>  11 files changed, 56 insertions(+)

Applied to the core branch in my tree, with the patch below on-top of
it. Thanks, Olav.

>From 38ec010d9b04ed94845f8ff6f10d33eb6bbfe180 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel@suse.de>
Date: Tue, 4 Nov 2014 14:53:51 +0100
Subject: [PATCH] iommu: Do more input validation in iommu_map_sg()

The IOMMU-API works on page boundarys, unlike the DMA-API
which can work with sub-page buffers. The sg->offset
field does not make sense on the IOMMU level, so force it to
be 0. Do some error-path consolidation while at it.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 46727ce..08c53c5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1127,26 +1127,33 @@ EXPORT_SYMBOL_GPL(iommu_unmap);
 size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			 struct scatterlist *sg, unsigned int nents, int prot)
 {
-	int ret;
+	struct scatterlist *s;
 	size_t mapped = 0;
 	unsigned int i;
-	struct scatterlist *s;
+	int ret;
 
 	for_each_sg(sg, s, nents, i) {
 		phys_addr_t phys = page_to_phys(sg_page(s));
-		size_t page_len = s->offset + s->length;
 
-		ret = iommu_map(domain, iova + mapped, phys, page_len, prot);
-		if (ret) {
-			/* undo mappings already done */
-			iommu_unmap(domain, iova, mapped);
-			mapped = 0;
-			break;
-		}
-		mapped += page_len;
+		/* We are mapping on page boundarys, so offset must be 0 */
+		if (s->offset)
+			goto out_err;
+
+		ret = iommu_map(domain, iova + mapped, phys, s->length, prot);
+		if (ret)
+			goto out_err;
+
+		mapped += s->length;
 	}
 
 	return mapped;
+
+out_err:
+	/* undo mappings already done */
+	iommu_unmap(domain, iova, mapped);
+
+	return 0;
+
 }
 EXPORT_SYMBOL_GPL(default_iommu_map_sg);
 
-- 
1.8.4.5
