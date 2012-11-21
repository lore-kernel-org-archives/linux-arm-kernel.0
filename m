From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 21 Nov 2012 10:39:39 +0100
Subject: [PATCH V4 0/3] Add hardware I/O coherency support for Armada 370/XP
Message-ID: <1353490783-23101-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The purpose of this patch set is to add hardware I/O Coherency support
for Armada 370 and Armada XP. Theses SoCs come with an unit called
coherency fabric. A beginning of the support for this unit have been
introduced with the SMP patch set. This series extend this support:
the coherency fabric unit allows to use the Armada XP and the Armada
370 as nearly coherent architectures.

The third patches enables this new feature and register our own set
of DMA ops, to benefit this hardware enhancement.

The first patches exports dma operation functions needed by to
register our own set of dma ops.

The second patch introduces a new flag for the address decoding
configuration in order to be able to set the memory windows as
shared memory.

This series depend on the SMP patch set (V5 was posted few minutes
earlier)

The git branch called HWIOCC-for-3.8-V3 is also available at
https://github.com/MISL-EBU-System-SW/mainline-public.git.

Changelog:
V3->V4:
- Exposed only the needed dma ops function

V2 -> V3:
- Rebased on to ArmadaXP-SMP-for-3.8-V5
- Use the coherent version of dma ops for .alloc() and .free()

V1 -> V2:
- Rebased on to v3.7-rc5
- Added a new patch to exports the dma ops functions
- Renamed the function for a more generic name mvebu_hwcc
- removed the non SMP case during init
- spelling and wording issues
- updating the binding documentation for coherency fabric

Gregory CLEMENT (3):
  arm: dma mapping: Export a dma ops function arm_dma_set_mask
  arm: plat-orion: Add coherency attribute when setup mbus target
  arm: mvebu: Add hardware I/O Coherency support

 .../devicetree/bindings/arm/coherency-fabric.txt   |    9 ++-
 arch/arm/boot/dts/armada-370-xp.dtsi               |    3 +-
 arch/arm/include/asm/dma-mapping.h                 |    2 +
 arch/arm/mach-mvebu/addr-map.c                     |    3 +
 arch/arm/mach-mvebu/coherency.c                    |   73 ++++++++++++++++++++
 arch/arm/mm/dma-mapping.c                          |    4 +-
 arch/arm/plat-orion/addr-map.c                     |    4 ++
 arch/arm/plat-orion/include/plat/addr-map.h        |    1 +
 8 files changed, 93 insertions(+), 6 deletions(-)

-- 
1.7.9.5
