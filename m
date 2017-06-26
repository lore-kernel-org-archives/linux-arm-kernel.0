From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Mon, 26 Jun 2017 21:38:45 +0800
Subject: [PATCH 0/5] arm-smmu: performance optimization
Message-ID: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I described the optimization more detail in patch 1 and 2, and patch 3-5 are
the implementation on arm-smmu/arm-smmu-v3 of patch 2.

Patch 1 is v2. In v1, I directly replaced writel with writel_relaxed in
queue_inc_prod. But Robin figured that it may lead SMMU consume stale
memory contents. I thought more than 3 whole days and got this one.

This patchset is based on Robin Murphy's [PATCH v2 0/8] io-pgtable lock removal.

Zhen Lei (5):
  iommu/arm-smmu-v3: put off the execution of TLBI* to reduce lock
    confliction
  iommu: add a new member unmap_tlb_sync into struct iommu_ops
  iommu/arm-smmu-v3: add support for unmap an iova range with only one
    tlb sync
  iommu/arm-smmu: add support for unmap a memory range with only one tlb
    sync
  iommu/io-pgtable: delete member tlb_sync_pending of struct io_pgtable

 drivers/iommu/arm-smmu-v3.c        | 52 ++++++++++++++++++++++++++++++++++----
 drivers/iommu/arm-smmu.c           | 10 ++++++++
 drivers/iommu/io-pgtable-arm-v7s.c | 32 +++++++++++++++--------
 drivers/iommu/io-pgtable-arm.c     | 30 ++++++++++++++--------
 drivers/iommu/io-pgtable.h         |  9 ++-----
 drivers/iommu/iommu.c              |  3 +++
 include/linux/iommu.h              |  1 +
 7 files changed, 104 insertions(+), 33 deletions(-)

-- 
2.5.0
