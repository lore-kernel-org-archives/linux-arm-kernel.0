From: robin.murphy@arm.com (Robin Murphy)
Date: Mon,  3 Jul 2017 14:52:24 +0100
Subject: [PATCH] iommu/io-pgtable: Sanitise map/unmap addresses
Message-ID: <6ba078ad1dfbdb6e74256d533c0feaf4f56e8cf4.1499089895.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It may be an egregious error to attempt to use addresses outside the
range of the pagetable format, but that still doesn't mean we should
merrily wreak havoc by silently mapping/unmapping whatever truncated
portions of them might happen to correspond to real addresses.

Add some up-front checks to sanitise our inputs so that buggy callers
don't invite potential memory corruption.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 6 ++++++
 drivers/iommu/io-pgtable-arm.c     | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 7753b33d041d..e0bfe8ba4c9d 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -475,6 +475,9 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
 	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
 		return 0;
 
+	if (WARN_ON(upper_32_bits(iova) || upper_32_bits(paddr)))
+		return -ERANGE;
+
 	ret = __arm_v7s_map(data, iova, paddr, size, prot, 1, data->pgd);
 	/*
 	 * Synchronise all PTE updates for the new mapping before there's
@@ -655,6 +658,9 @@ static int arm_v7s_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	size_t unmapped;
 
+	if (WARN_ON(upper_32_bits(iova)))
+		return 0;
+
 	unmapped = __arm_v7s_unmap(data, iova, size, 1, data->pgd);
 	if (unmapped)
 		io_pgtable_tlb_sync(&data->iop);
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f73120f2cfbc..ebf9152c2422 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -448,6 +448,10 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
 		return 0;
 
+	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
+		    paddr >= (1ULL << data->iop.cfg.oas)))
+		return -ERANGE;
+
 	prot = arm_lpae_prot_to_pte(data, iommu_prot);
 	ret = __arm_lpae_map(data, iova, paddr, size, prot, lvl, ptep);
 	/*
@@ -606,6 +610,9 @@ static int arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 	arm_lpae_iopte *ptep = data->pgd;
 	int lvl = ARM_LPAE_START_LVL(data);
 
+	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias)))
+		return 0;
+
 	unmapped = __arm_lpae_unmap(data, iova, size, lvl, ptep);
 	if (unmapped)
 		io_pgtable_tlb_sync(&data->iop);
-- 
2.12.2.dirty
