From: robin.murphy@arm.com (Robin Murphy)
Date: Fri,  4 Dec 2015 17:52:58 +0000
Subject: [PATCH 1/5] iommu/io-pgtable-arm: Avoid dereferencing bogus PTEs
In-Reply-To: <cover.1449246988.git.robin.murphy@arm.com>
References: <cover.1449246988.git.robin.murphy@arm.com>
Message-ID: <ad5898fd59575d0e2a8dccabafde71650f44e2a8.1449246988.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the case of corrupted page tables, or when an invalid size is given,
__arm_lpae_unmap() may recurse beyond the maximum number of levels.
Unfortunately the detection of this error condition only happens *after*
calculating a nonsense offset from something which might not be a valid
table pointer and dereferencing that to see if it is a valid PTE.

Make things a little more robust by checking the level is valid before
doing anything which depends on it being so.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 7df9777..366a354 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -486,11 +486,13 @@ static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 	void *cookie = data->iop.cookie;
 	size_t blk_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
 
+	/* Something went horribly wrong and we ran out of page table */
+	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
+		return 0;
+
 	ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
 	pte = *ptep;
-
-	/* Something went horribly wrong and we ran out of page table */
-	if (WARN_ON(!pte || (lvl == ARM_LPAE_MAX_LEVELS)))
+	if (WARN_ON(!pte))
 		return 0;
 
 	/* If the size matches this level, we're in the right place */
-- 
1.9.1
