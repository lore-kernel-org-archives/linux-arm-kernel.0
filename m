From: will.deacon@arm.com (Will Deacon)
Date: Fri, 5 Dec 2014 16:35:06 +0000
Subject: [GIT PULL] Automatic DMA configuration for OF-based IOMMU masters
Message-ID: <20141205163506.GQ1630@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Please consider pulling the following series for 3.19. I appreciate that
this is late in the day, but the patches have been around for a while and
have collected all the Acks that they need. Marek has already been finding
the series useful with the Exynos IOMMU, so it seems a pity to hold the
patches up any longer.

Cheers,

Will

--->8

The following changes since commit 5d01410fe4d92081f349b013a2e7a95429e4f2c9:

  Linux 3.18-rc6 (2014-11-23 15:25:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/of-iommu-configure

for you to fetch changes up to a42a7a1fb5f1f9004b023594609dc22da02fc08b:

  iommu: store DT-probed IOMMU data privately (2014-12-05 14:35:52 +0000)

----------------------------------------------------------------
This series adds automatic IOMMU and DMA-mapping configuration for
OF-based DMA masters described using the generic IOMMU devicetree
bindings. Although there is plenty of future work around splitting up
iommu_ops, adding default IOMMU domains and sorting out automatic IOMMU
group creation for the platform_bus, this is already useful enough for
people to port over their IOMMU drivers and start using the new probing
infrastructure (indeed, Marek has patches queued for the Exynos IOMMU).

----------------------------------------------------------------
Marek Szyprowski (1):
      iommu: fix initialization without 'add_device' callback

Robin Murphy (1):
      iommu: store DT-probed IOMMU data privately

Will Deacon (7):
      iommu: provide early initialisation hook for IOMMU drivers
      dma-mapping: replace set_arch_dma_coherent_ops with arch_setup_dma_ops
      iommu: add new iommu_ops callback for adding an OF device
      iommu: provide helper function to configure an IOMMU for an of master
      dma-mapping: detect and configure IOMMU in of_dma_configure
      arm: call iommu_init before of_platform_populate
      arm: dma-mapping: plumb our iommu mapping ops into arch_setup_dma_ops

 arch/arm/include/asm/dma-mapping.h | 12 ++---
 arch/arm/kernel/setup.c            |  2 +
 arch/arm/mm/dma-mapping.c          | 83 ++++++++++++++++++++++++++++++++---
 drivers/iommu/Kconfig              |  2 +-
 drivers/iommu/iommu.c              |  2 +-
 drivers/iommu/of_iommu.c           | 89 ++++++++++++++++++++++++++++++++++++++
 drivers/of/platform.c              | 50 +++++++++++----------
 include/asm-generic/vmlinux.lds.h  |  2 +
 include/linux/dma-mapping.h        | 13 +++---
 include/linux/iommu.h              |  8 ++++
 include/linux/of_iommu.h           | 23 ++++++++++
 11 files changed, 242 insertions(+), 44 deletions(-)
