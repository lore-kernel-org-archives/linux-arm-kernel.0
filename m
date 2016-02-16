From: niklas.soderlund+renesas@ragnatech.se (=?UTF-8?q?Niklas=20S=C3=B6derlund?=)
Date: Tue, 16 Feb 2016 21:39:36 +0100
Subject: [PATCH v4 0/8] dmaengine: rcar-dmac: add iommu support for slave
 transfers
Message-ID: <1455655184-14478-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series add iommu support to rcar-dmac. It's tested on Koelsch with
CONFIG_IPMMU_VMSA and by enabling the ipmmu_ds node in r8a7791.dtsi. I verified
operation by interacting with /dev/mmcblk1  which is a device behind the iommu.

The series depends on out of tree patch '[PATCH] dmaengine: use phys_addr_t for
slave configuration' which Vinod now have moved forward whit, thanks!

* Changes since v3
- Folded in a fix from Robin to his patch.
- Added a check to make sure dma_map_resource can not be used to map RAM as
  pointed out by Robin. I use BUG_ON to enforce this. It might not be the best
  method but I saw no other good way since DMA_ERROR_CODE might not be defined
  on all platforms.
- Added comment about that DTS changes will disable 2 DMA channels due to a HW
  (?) but in the DMAC.
- Dropped the use of dma_attrs, no longer needed.
- Collected Acked-by and Reviewed-by from Laurent.
- Various indentation fix ups.

* Changes since v2
- Drop patch to add dma_{map,unmap}_page_attrs.
- Add dma_{map,unmap}_resource to handle the mapping without involving a
  'struct page'. Thanks Laurent and Robin for pointing this out.
- Use size instead of address to keep track of if a mapping exist or not
  since addr == 0 is valid. Thanks Laurent.
- Pick up patch from Robin with Laurents ack (hope it's OK for me to
  attach the ack?) to add IOMMU_MMIO.
- Fix bug in rcar_dmac_device_config where the error check where
  inverted.
- Use DMA_BIDIRECTIONAL in rcar_dmac_device_config since we at that
  point can't be sure what direction the mapping is going to be used.

* Changes since v1
- Add and use a dma_{map,unmap}_page_attrs to be able to map the page
  using attributes DMA_ATTR_NO_KERNEL_MAPPING and
  DMA_ATTR_SKIP_CPU_SYNC. Thanks Laurent.
- Drop check if dmac is part of a iommu group or not, let the DMA
  mapping api handle it.
- Move slave configuration data around in rcar-dmac to avoid code
  duplication.
- Fix build issue reported by 'kbuild test robot' regarding phys_to_page
  not availability on some configurations.
- Add DT information for r8a7791.

* Changes since RFC
- Switch to use the dma-mapping api instead of using the iommu_map()
  directly. Turns out the dma-mapper is much smarter then me...
- Dropped the patch to expose domain->ops->pgsize_bitmap from within the
  iommu api.
- Dropped the patch showing how I tested the RFC.


Niklas S?derlund (7):
  dma-mapping: add {map,unmap}_resource to dma_map_ops
  dma-mapping: add dma_{map,unmap}_resource
  arm: dma-mapping: add {map,unmap}_resource for iommu ops
  dmaengine: rcar-dmac: group slave configuration
  dmaengine: rcar-dmac: add iommu support for slave transfers
  ARM: dts: r8a7790: add iommus to dmac0 and dmac1
  ARM: dts: r8a7791: add iommus to dmac0 and dmac1

Robin Murphy (1):
  iommu: Add MMIO mapping type

 arch/arm/boot/dts/r8a7790.dtsi | 30 ++++++++++++++++
 arch/arm/boot/dts/r8a7791.dtsi | 30 ++++++++++++++++
 arch/arm/mm/dma-mapping.c      | 63 ++++++++++++++++++++++++++++++++
 drivers/dma/sh/rcar-dmac.c     | 81 +++++++++++++++++++++++++++++++++---------
 drivers/iommu/io-pgtable-arm.c |  9 +++--
 include/linux/dma-mapping.h    | 38 ++++++++++++++++++++
 include/linux/iommu.h          |  1 +
 7 files changed, 233 insertions(+), 19 deletions(-)

--
2.7.1
