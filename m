From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Aug 2015 16:48:32 +0100
Subject: [PATCH] iommu/io-pgtable-arm: Unmap and free table when overwriting
 with block
Message-ID: <1439308112-29758-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When installing a block mapping, we unconditionally overwrite a non-leaf
PTE if we find one. However, this can cause a problem if the following
sequence of events occur:

  (1) iommu_map called for a 4k (i.e. PAGE_SIZE) mapping at some address
      - We initialise the page table all the way down to a leaf entry
      - No TLB maintenance is required, because we're going from invalid
        to valid.

  (2) iommu_unmap is called on the mapping installed in (1)
      - We walk the page table to the final (leaf) entry and zero it
      - We only changed a valid leaf entry, so we invalidate leaf-only

  (3) iommu_map is called on the same address as (1), but this time for
      a 2MB (i.e. BLOCK_SIZE) mapping)
      - We walk the page table down to the penultimate level, where we
        find a table entry
      - We overwrite the table entry with a block mapping and return
        without any TLB maintenance and without freeing the memory used
        by the now-orphaned table.

This last step can lead to a walk-cache caching the overwritten table
entry, causing unexpected faults when the new mapping is accessed by a
device. One way to fix this would be to collapse the page table when
freeing the last page at a given level, but this would require expensive
iteration on every map call. Instead, this patch detects the case when
we are overwriting a table entry and explicitly unmaps the table first,
which takes care of both freeing and TLB invalidation.

Cc: <stable@vger.kernel.org>
Reported-by: Brian Starkey <brian.starkey@arm.com>
Tested-by: Brian Starkey <brian.starkey@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Joerg, could you queue this up for 4.3 please? It's a fix, but it's late
in the day for 4.2 and doesn't backport cleanly. Merging it with the Cc
stable tag is probably the easiest thing to do, then I can fix up the
conflicts as they arise.

 drivers/iommu/io-pgtable-arm.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index e4bc2b23ab96..73c07482f487 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -263,6 +263,10 @@ static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
 					   sizeof(pte), DMA_TO_DEVICE);
 }
 
+static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
+			    unsigned long iova, size_t size, int lvl,
+			    arm_lpae_iopte *ptep);
+
 static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 			     unsigned long iova, phys_addr_t paddr,
 			     arm_lpae_iopte prot, int lvl,
@@ -271,10 +275,21 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 	arm_lpae_iopte pte = prot;
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 
-	/* We require an unmap first */
 	if (iopte_leaf(*ptep, lvl)) {
+		/* We require an unmap first */
 		WARN_ON(!selftest_running);
 		return -EEXIST;
+	} else if (iopte_type(*ptep, lvl) == ARM_LPAE_PTE_TYPE_TABLE) {
+		/*
+		 * We need to unmap and free the old table before
+		 * overwriting it with a block entry.
+		 */
+		arm_lpae_iopte *tblp;
+		size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
+
+		tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
+		if (WARN_ON(__arm_lpae_unmap(data, iova, sz, lvl, tblp) != sz))
+			return -EINVAL;
 	}
 
 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
-- 
2.1.4
