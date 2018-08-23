From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 23 Aug 2018 13:14:59 +0100
Subject: [PATCH] iommu/io-pgtable-arm: Fix race handling in split_blk_unmap()
Message-ID: <f6700817286f60597f2a93835bf658f3ef3585ef.1535026499.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In removing the pagetable-wide lock, we gained the possibility of the
vanishingly unlikely case where we have a race between two concurrent
unmappers splitting the same block entry. The logic to handle this is
fairly straightforward - whoever loses the race frees their partial
next-level table and instead dereferences the winner's newly-installed
entry in order to fall back to a regular unmap, which intentionally
echoes the pre-existing case of recursively splitting a 1GB block down
to 4KB pages by installing a full table of 2MB blocks first.

Unfortunately, the chump who implemented that logic failed to update the
condition check for that fallback, meaning that if said race occurs at
the last level (where the loser's unmap_idx is valid) then the unmap
won't actually happen. Fix that to properly account for both the race
and recursive cases.

Fixes: 2c3d273eabe8 ("iommu/io-pgtable-arm: Support lockless operation")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 010a254305dd..93b4833cef73 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -575,7 +575,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 		tablep = iopte_deref(pte, data);
 	}
 
-	if (unmap_idx < 0)
+	if (unmap_idx < 0 || pte != blk_pte)
 		return __arm_lpae_unmap(data, iova, size, lvl, tablep);
 
 	io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
-- 
2.17.1.dirty
