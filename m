From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 26 Jan 2016 17:13:12 +0000
Subject: [PATCH v3 0/3] io-pgtable ARM short descriptor format
Message-ID: <cover.1453723096.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

As promised, here's v3 based on 4.5-rc1, with all the previous comments
addressed other than the logic of split_blk_unmap() - having looked into
it, trying to simplify that essentially just pushes the complexity out
into map() and complicates the general case. Ultimately it's an awkward
edge case to handle however it's implemented, and keeping it as close as
possible to the LPAE version makes it somewhat easier to reason about.

This is currently just a dependency for the Mediatek IOMMU series[1] -
the ARM SMMU driver support I've been testing with is now much closer to
"proper patch" than "horrible development hack", but still depends on a
bunch of other work in that driver I need to post first.

Thanks,
Robin.

Changes since v2[2]:
- #include dma-mapping.h before I break ARC again...
- Fix PTE type bit swizzling to not collide with XN bit in cont_to_pte().
- Correct init_pte to increment the IOVA, rather than the table pointer,
  when freeing L2 tables being replaced by a supersection entry.
- Rename sync_flag to the much better tlb_sync_pending.
- Acks on patches 2 and 3.

[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/11974
[2]:http://thread.gmane.org/gmane.linux.kernel.iommu/11752

Robin Murphy (3):
  iommu/io-pgtable: Add ARMv7 short descriptor support
  iommu/io-pgtable: Add helper functions for TLB ops
  iommu/io-pgtable: Avoid redundant TLB syncs

 drivers/iommu/Kconfig              |  19 +
 drivers/iommu/Makefile             |   1 +
 drivers/iommu/io-pgtable-arm-v7s.c | 841 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c     |  21 +-
 drivers/iommu/io-pgtable.c         |   5 +-
 drivers/iommu/io-pgtable.h         |  37 +-
 6 files changed, 910 insertions(+), 14 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm-v7s.c

-- 
2.7.0.25.gfc10eb5
