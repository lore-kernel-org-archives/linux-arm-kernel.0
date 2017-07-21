From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 21 Jul 2017 12:41:58 +0100
Subject: [PATCH v2 1/4] iommu/iova: Optimise rbtree searching
In-Reply-To: <cover.1500636791.git.robin.murphy@arm.com>
References: <cover.1500636791.git.robin.murphy@arm.com>
Message-ID: <fadb9d1a7e2c046b7dfc65e4e1f90ee609c19859.1500636791.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Checking the IOVA bounds separately before deciding which direction to
continue the search (if necessary) results in redundantly comparing both
pfns twice each. GCC can already determine that the final comparison op
is redundant and optimise it down to 3 in total, but we can go one
further with a little tweak of the ordering (which makes the intent of
the code that much cleaner as a bonus).

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Zhen Lei <thunder.leizhen@huawei.com>
[rm: rewrote commit message to clarify]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: No change

 drivers/iommu/iova.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 246f14c83944..8f7552dc4e04 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -289,15 +289,12 @@ private_find_iova(struct iova_domain *iovad, unsigned long pfn)
 	while (node) {
 		struct iova *iova = rb_entry(node, struct iova, node);
 
-		/* If pfn falls within iova's range, return iova */
-		if ((pfn >= iova->pfn_lo) && (pfn <= iova->pfn_hi)) {
-			return iova;
-		}
-
 		if (pfn < iova->pfn_lo)
 			node = node->rb_left;
-		else if (pfn > iova->pfn_lo)
+		else if (pfn > iova->pfn_hi)
 			node = node->rb_right;
+		else
+			return iova;	/* pfn falls within iova's range */
 	}
 
 	return NULL;
-- 
2.12.2.dirty
