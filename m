From: ritesh.harjani@gmail.com (ritesh.harjani at gmail.com)
Date: Wed, 4 Jun 2014 18:24:47 +0530
Subject: [PATCHv2 0/2] arm:dma-mapping Refactoring iommu dma-mapping code
Message-ID: <1401886489-25498-1-git-send-email-ritesh.harjani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ritesh Harjani <ritesh.harjani@gmail.com>

Hi All, 

This patch series is to refactor iommu related common code from
arch/arm/dma-mapping.c to lib/iommu-helper.c based on the various
discussions with the maintainers/experts [1].

Currently the only user of the common lib/iommu-helper code will
be ARM & ARM64 but later various architecture might try to use this
iommu lib helper functions.

Major change of this refactoring depends on bringing out struct dma_iommu_mapping 
*mapping variable from arch/arm/include/asm/device.h to include/linux/device.h
and by moving out complete structure definition of dma_iommu_mapping to
inclue/linux/iommu-helper.h. This is now done as a separate patch based on Will's
suggestion [2]. This patch series is based on top of that patch.

There are 1/2 more function definitions which I can think of moving out, but
those can be done once this patch series is approved as those are not very
big changes.

Also, this has been tested and verified on ARM hardware with IOMMU support.

Changes from v1:
1. Prefixed iommu_helper_* to all iommu-helper.h function instead of __iommu_*
2. Submitted changes in device.h as a separate patch on top of which this patch
   series is based upon[2].
3. Merged [PATCH 2/4] and [PATCH 3/4] from v1 patch series to [PATCHv2 1/2],
   based on Will Daecon suggestion [3].
4. Removed Change-id value from all v1 patches.

Links:
[1]: https://www.mail-archive.com/iommu at lists.linux-foundation.org/msg03458.html 
[2]: https://lkml.org/lkml/2014/6/4/41
[3]: http://www.spinics.net/lists/arm-kernel/msg336682.html


Ritesh Harjani (2):
  arm: dma-mapping: Refactor attach/detach, alloc/free func
  arm:dma-iommu: Move out complete func defs

 arch/arm/Kconfig             |  42 ++--
 arch/arm/mm/dma-mapping.c    | 572 ++++---------------------------------------
 include/linux/iommu-helper.h |  42 ++++
 lib/iommu-helper.c           | 562 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 673 insertions(+), 545 deletions(-)

-- 
1.8.1.3
