From: will.deacon@arm.com (Will Deacon)
Date: Thu,  6 Feb 2014 18:09:28 +0000
Subject: [PATCH 0/5] iommu/arm-smmu: fixes for 3.14
Message-ID: <1391710173-4343-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is the set of fixes I plan to send to Joerg for 3.14. There a quite
a few scary looking commits here, for a number of reasons:

  - Andreas Herrmann took the driver for a run with a real SATA
    controller, which caused the new mutex-based locking to explode
    since we require mappings in atomic context

  - Yifan fixed an issue with the page table creation, which then caused
    breakages with the way in which we flush descriptors out to the
    table walker

  - I ran the driver on a system where the SMMU is hooked into a
    coherent interconnect for table walks, and noticed a shareability
    mismatch between the CPU and the SMMU

These issues are all fixed here and have been tests on both arm and
arm64 based systems.

All feedback welcome,

Will


Will Deacon (4):
  iommu/arm-smmu: really fix page table locking
  iommu/arm-smmu: fix table flushing during initial allocations
  iommu/arm-smmu: set CBARn.BPSHCFG to NSH for s1-s2-bypass contexts
  iommu/arm-smmu: fix compilation issue when !CONFIG_ARM_AMBA

Yifan Zhang (1):
  iommu/arm-smmu: fix pud/pmd entry fill sequence

 drivers/iommu/arm-smmu.c | 103 ++++++++++++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 42 deletions(-)

-- 
1.8.2.2
