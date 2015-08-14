From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 14 Aug 2015 16:48:37 +0200
Subject: [GIT PULL 6/9] iommu/tegra-smmu: Changes for v4.3-rc1
In-Reply-To: <1439563720-13189-1-git-send-email-thierry.reding@gmail.com>
References: <1439563720-13189-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1439563720-13189-7-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.3-iommu

for you to fetch changes up to 11cec15bf3fb498206ef63b1fa26c27689e02d0e:

  iommu/tegra-smmu: Parameterize number of TLB lines (2015-08-13 17:05:28 +0200)

This is the pull request with Russell's updates. I've added a patch
on top to unbreak Tegra30, which had been broken since the original
rewrite of the SMMU driver.

Thanks,
Thierry

----------------------------------------------------------------
iommu/tegra-smmu: Changes for v4.3-rc1

A bunch of improvements by Russell King, along with a fix to restore
display support when using the SMMU. This was due to the SMMU driver
writing the wrong value of active TLB lines, effectively disabling the
TLB and causing massive underflows on the display controller because
of the latency introduced by the SMMU.

----------------------------------------------------------------
Russell King (15):
      iommu/tegra-smmu: Fix iova_to_phys() method
      iommu/tegra-smmu: Fix unmap() method
      iommu/tegra-smmu: Factor out common PTE setting
      iommu/tegra-smmu: Add iova_pd_index() and iova_pt_index() helpers
      iommu/tegra-smmu: Fix page table lookup in unmap/iova_to_phys methods
      iommu/tegra-smmu: Store struct page pointer for page tables
      iommu/tegra-smmu: Use kcalloc() to allocate counter array
      iommu/tegra-smmu: Move flush_dcache to tegra-smmu.c
      iommu/tegra-smmu: Split smmu_flush_ptc()
      iommu/tegra-smmu: smmu_flush_ptc() wants device addresses
      iommu/tegra-smmu: Convert to use DMA API
      iommu/tegra-smmu: Remove PageReserved manipulation
      iommu/tegra-smmu: Use __GFP_ZERO to allocate zeroed pages
      iommu/tegra-smmu: Extract tegra_smmu_pte_get_use()
      iommu/tegra-smmu: Factor out tegra_smmu_set_pde()

Thierry Reding (1):
      iommu/tegra-smmu: Parameterize number of TLB lines

 drivers/iommu/tegra-smmu.c      | 306 ++++++++++++++++++++++++++--------------
 drivers/memory/tegra/tegra114.c |  18 +--
 drivers/memory/tegra/tegra124.c |  31 +---
 drivers/memory/tegra/tegra30.c  |  18 +--
 include/soc/tegra/mc.h          |   8 +-
 5 files changed, 202 insertions(+), 179 deletions(-)
