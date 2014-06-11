From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Jun 2014 15:36:56 +0200
Subject: [GIT PULL 1/1] ARM: SoC updates for 3.16 (part 2)
Message-ID: <6225322.NFUspysEqN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 3c2580173e3bc820a8f8c0db968f757b8eca7fe5:

  Merge tag 'sunxi-core-for-3.16-2' of https://github.com/mripard/linux into next/soc (2014-05-23 21:57:23 +0200)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/soc2-for-3.16

for you to fetch changes up to bbea06f3efbae5776e6c285fea59fd249eec44ff:

  ARM: keystone: Drop use of meminfo since its not available anymore (2014-06-05 22:20:54 +0200)

----------------------------------------------------------------
ARM: SoC updates for 3.16 (part 2)

This is a small follow-up to the larger ARM SoC updates merged
last week, almost entirely for the keystone platform.

The main change here is to use the new dma-ranges parsing code
that came in through Russell's ARM tree. This allows the keystone
platform to do cache-coherent DMA and to finally support all the
available physical memory when LPAE is enabled.

Aside from this, the keystone reset driver has been rewritten,
and there is a small bug fix to allow building the orion5x platform
again.

----------------------------------------------------------------
Arnd Bergmann (4):
      Merge tag 'dt-dma-properties-for-arm' of git://git.kernel.org/.../ssantosh/linux-keystone into depends/dma-ranges
      Merge branch 'depends/dma-ranges' into next/soc
      Merge tag 'keystone-soc' of git://git.kernel.org/.../ssantosh/linux-keystone into next/soc
      ARM: orion5x: fix mvebu_mbus_dt_init call

Brian Norris (1):
      ARM: configs: keystone: add MTD_SPI_NOR (new dependency for M25P80)

Ivan Khoronzhuk (3):
      ARM: keystone: remove redundant reset stuff
      ARM: dts: keystone: update reset node to work with reset driver
      ARM: configs: keystone: enable reset driver support

Lad Prabhakar (1):
      ARM: configs: keystone: drop CONFIG_COMMON_CLK_DEBUG

Olof Johansson (1):
      Merge tag 'keystone-soc-2' of git://git.kernel.org/.../ssantosh/linux-keystone into next/soc2

Santosh Shilimkar (3):
      ARM: keystone: Switch over to coherent memory address space
      ARM: keystone: Update the dma offset for non-dt platform devices
      ARM: keystone: Drop use of meminfo since its not available anymore

 arch/arm/boot/dts/keystone.dtsi         |  14 +++-
 arch/arm/configs/integrator_defconfig   |   1 -
 arch/arm/configs/keystone_defconfig     |   5 +-
 arch/arm/configs/sunxi_defconfig        |   1 -
 arch/arm/configs/vt8500_v6_v7_defconfig |   1 -
 arch/arm/include/asm/dma-mapping.h      |  25 +++++++-
 arch/arm/mach-keystone/keystone.c       | 100 ++++++++++++++++++++---------
 arch/arm/mach-keystone/memory.h         |  24 +++++++
 arch/arm/mach-keystone/platsmp.c        |  18 +++++-
 arch/arm/mach-orion5x/board-dt.c        |   2 +-
 arch/arm/mm/dma-mapping.c               |   4 +-
 drivers/of/address.c                    | 110 ++++++++++++++++++++++++++++++++
 drivers/of/platform.c                   |  65 +++++++++++++++++--
 include/linux/device.h                  |   2 +
 include/linux/dma-mapping.h             |   7 ++
 include/linux/of_address.h              |  14 ++++
 16 files changed, 347 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm/mach-keystone/memory.h
