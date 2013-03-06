From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  6 Mar 2013 17:59:55 +0100
Subject: [PATCH v2 for 3.10] Introduce a Marvell EBU MBus driver
Message-ID: <1362589205-4726-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

As part of the work to write a DT-powered PCIe driver for Marvell SoCs
that sits in drivers/pci/host/, it appeared that including
<mach/addr-map.h> from the PCIe driver to get access to address
decoding windows functions was not acceptable.

In order to fix this problem, this patch set introduces a driver for
the Marvell EBU MBus driver in drivers/bus/mvebu-mbus.c. It
consolidates into a single driver the address decoding code that was
spread in mach-{mvebu,kirkwood,orion5x,mv78xx0,dove}/addr-map.c and
plat-orion/addr-map.c. The driver provides two APIs:

 * A mv_mbus_dram_info() that is used by many Marvell device drivers
   throughout the tree to get the list of DRAM address decoding
   windows they have to set up. This API was previously implemented in
   plat-orion/addr-map.c and is kept unchanged in order to not change
   the drivers.

 * mvebu_mbus_add_window() / mvebu_mbus_del_window() functions to add
   and remove address decoding windows for a given device. Those
   functions have to be called either from the platform code, or from
   device drivers.

The driver can be probed either using Device Tree informations, or
using a legacy mvbus_mbus_init() function call. This allows us to
migrate the five families of Marvell EBU SoCs to use this driver.

Note that this driver is only a consolidation, and that further
improvements to the address decoding handling could be done in the
future (dynamically allocating the physical range using
request_resource(), describing some of the static windows in DT,
etc.). We intentionally do not want those improvements to be done
right now, in order to keep the amount of changes reasonable. The
driver as it is is sufficient to cover the existing needs, and the
needs of the upcoming PCIe driver and Device Bus driver.

Summary of the patch set:

 * Patch 1 makes the compilation of plat-orion/addr-map.c conditional
   on a per-SoC family basis. This allows patches 5 to 9 to
   progressively move each SoC family to use the mvebu-mbus driver
   instead of the mach-<foo>/addr-map.c + plat-orion/addr-map.c
   code. Notice that the plat-orion/addr-map.c code cannot be compiled
   in a kernel that has the mvebu-mbus, due to the namespace conflict
   on the mv_mbus_dram_info() function.

 * Patch 2 and 3 ensures that all places that need to have access to
   the list of DRAM address decoding windows do so by using the public
   mv_mbus_dram_info() rather than directly accessing an internal
   structure.

 * Patch 4 introduces the mvebu-mbus driver itself, with the support
   for all 5 Marvell EBU SoC families. Note that the driver is
   compiled through a blind option, because we don't want the driver
   to be compiled in unless the corresponding sub-architecture has
   been migrated to use it: as explained above, compiling the driver
   conflicts with compiling the plat-orion/addr-map.c code.

 * Patch 5 to 9 moves each Marvell EBU sub-architecture to use the
   mvebu-mbus driver.

 * Patch 10 removes the now unused plat-orion/addr-map.c code.

Changes since v1:

 * Fix the compatible string used in armada-370.dtsi: it was
   incorrectly using marvell,armadaxp-mbus instead of
   marvell,armada370-mbus.

 * Fix the reg = <...> property for Kirkwood and Dove, the address for
   the devices address decoding windows was not correct.

 * Fix a 'git rebase -i' mistake that lead to have some code that
   should have been in PATCH 4 (the driver code) into PATCH 5
   (switching mach-mvebu to use the driver).

 * Fix the Device Tree documentation of the driver, which was giving a
   wrong address.

 * And since I didn't want to do a v2 just to fix my stupid mistakes,
   I also added a big comment at the beginning of the driver's code
   that explains what the driver is doing.

The code has been tested on Armada 370 and Armada XP platforms (by
me), on Kirkwood DT and non-DT platforms (by Andrew Lunn), on Dove DT
platforms (by Sebastian Hesselbarth) and on Orion5x non-DT platforms
(by me).

The code applies on top of the marvell-3.9-fixes-tag I have sent at
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-March/152999.html. For
easier testing, I've pushed a branch at:

  https://github.com/MISL-EBU-System-SW/mainline-public/commits/marvell-mvebu-mbus-v1

Since other drivers will depend on this one, I'd appreciate if this
code could be merged early in the 3.10 cycle.

Thanks for your reviews,

Thomas

Thomas Petazzoni (10):
  arm: plat-orion: only build addr-map.c when needed
  arm: plat-orion: use mv_mbus_dram_info() in PCIe code
  arm: mach-orion5x: use mv_mbus_dram_info() in PCI code
  bus: introduce an Marvell EBU MBus driver
  arm: mach-mvebu: convert to use mvebu-mbus driver
  arm: mach-kirkwood: convert to use mvebu-mbus driver
  arm: mach-dove: convert to use mvebu-mbus driver
  arm: mach-orion5x: convert to use mvebu-mbus driver
  arm: mach-mv78xx0: convert to use the mvebu-mbus driver
  arm: plat-orion: remove addr-map code

 .../devicetree/bindings/arm/mvebu-mbus.txt         |   39 +
 arch/arm/Kconfig                                   |    4 +
 arch/arm/boot/dts/armada-370-xp.dtsi               |    5 -
 arch/arm/boot/dts/armada-370.dtsi                  |    3 +
 arch/arm/boot/dts/armada-xp.dtsi                   |    3 +
 arch/arm/boot/dts/dove.dtsi                        |    3 +-
 arch/arm/boot/dts/kirkwood.dtsi                    |    3 +-
 arch/arm/boot/dts/orion5x-88f5182.dtsi             |   19 +
 .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |    2 +-
 arch/arm/mach-dove/Makefile                        |    2 +-
 arch/arm/mach-dove/addr-map.c                      |  125 ---
 arch/arm/mach-dove/board-dt.c                      |   13 +-
 arch/arm/mach-dove/common.c                        |   39 +-
 arch/arm/mach-dove/common.h                        |    2 +-
 arch/arm/mach-dove/include/mach/dove.h             |    5 +
 arch/arm/mach-kirkwood/Makefile                    |    2 +-
 arch/arm/mach-kirkwood/addr-map.c                  |   91 --
 arch/arm/mach-kirkwood/board-dt.c                  |   19 +-
 arch/arm/mach-kirkwood/common.c                    |   38 +-
 arch/arm/mach-kirkwood/common.h                    |    2 +-
 arch/arm/mach-kirkwood/include/mach/kirkwood.h     |    7 +-
 arch/arm/mach-kirkwood/pcie.c                      |    1 -
 arch/arm/mach-mv78xx0/Makefile                     |    2 +-
 arch/arm/mach-mv78xx0/addr-map.c                   |   93 --
 arch/arm/mach-mv78xx0/common.c                     |   10 +-
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h       |    8 +-
 arch/arm/mach-mv78xx0/pcie.c                       |   21 +-
 arch/arm/mach-mvebu/Kconfig                        |    1 +
 arch/arm/mach-mvebu/Makefile                       |    2 +-
 arch/arm/mach-mvebu/addr-map.c                     |  137 ---
 arch/arm/mach-mvebu/armada-370-xp.c                |    2 +
 arch/arm/mach-mvebu/platsmp.c                      |    2 +
 arch/arm/mach-orion5x/Makefile                     |    2 +-
 arch/arm/mach-orion5x/addr-map.c                   |  155 ----
 arch/arm/mach-orion5x/board-dt.c                   |   24 +-
 arch/arm/mach-orion5x/common.c                     |   49 +-
 arch/arm/mach-orion5x/common.h                     |   13 +-
 arch/arm/mach-orion5x/d2net-setup.c                |    4 +-
 arch/arm/mach-orion5x/db88f5281-setup.c            |   13 +-
 arch/arm/mach-orion5x/dns323-setup.c               |    3 +-
 arch/arm/mach-orion5x/edmini_v2-setup.c            |    4 +-
 arch/arm/mach-orion5x/include/mach/orion5x.h       |    6 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c          |    8 +-
 arch/arm/mach-orion5x/ls-chl-setup.c               |    4 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c               |    4 +-
 arch/arm/mach-orion5x/lsmini-setup.c               |    4 +-
 arch/arm/mach-orion5x/mss2-setup.c                 |    3 +-
 arch/arm/mach-orion5x/mv2120-setup.c               |    3 +-
 arch/arm/mach-orion5x/net2big-setup.c              |    4 +-
 arch/arm/mach-orion5x/pci.c                        |   14 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c       |    4 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c        |    4 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c            |    7 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c     |    4 +-
 arch/arm/mach-orion5x/ts209-setup.c                |    4 +-
 arch/arm/mach-orion5x/ts409-setup.c                |    4 +-
 arch/arm/mach-orion5x/wnr854t-setup.c              |    4 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c           |    4 +-
 arch/arm/plat-orion/Makefile                       |    2 -
 arch/arm/plat-orion/addr-map.c                     |  178 ----
 arch/arm/plat-orion/pcie.c                         |   10 +-
 drivers/bus/Kconfig                                |    7 +
 drivers/bus/Makefile                               |    1 +
 drivers/bus/mvebu-mbus.c                           |  906 ++++++++++++++++++++
 include/linux/mbus.h                               |   28 +-
 65 files changed, 1302 insertions(+), 887 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mvebu-mbus.txt
 create mode 100644 arch/arm/boot/dts/orion5x-88f5182.dtsi
 delete mode 100644 arch/arm/mach-dove/addr-map.c
 delete mode 100644 arch/arm/mach-kirkwood/addr-map.c
 delete mode 100644 arch/arm/mach-mv78xx0/addr-map.c
 delete mode 100644 arch/arm/mach-mvebu/addr-map.c
 delete mode 100644 arch/arm/mach-orion5x/addr-map.c
 delete mode 100644 arch/arm/plat-orion/addr-map.c
 create mode 100644 drivers/bus/mvebu-mbus.c

-- 
1.7.9.5
