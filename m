From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 19 Feb 2014 15:12:31 +0100
Subject: [Patch v3 00/23] Move DT kirkwood into mach-mvebu
Message-ID: <1392819174-11634-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The process of making most kirkwood boards boot using DT is nearly
complete. We can now move these boards into mach-mvebu, freeing them
of the legacy code needed for none-DT systems. At the same time, they
can become part of ARCH_MULTI_V5.

What i have not addressed is if we want a multi_v4_v5_defconfig, not
multi_v5_defconfig, as raised by Arnd. The only one opinion has been
given so far, and it was No.

This patchset can also be found in:

https://github.com/lunn/linux.git v3.14-rc1-mvebu-v3

Since v2:
The L2 Cache binding has been re-written again. No more wt-override in
the binding, respect CONFIG_CACHE_FEROCEON_L2_WRITETHROUGH
Fixed a few typos in changelogs
Added a few Cc: for maintainers outside of the ARM world.
Added Acked-by:s

Since v1:
mv88f6281gtw_ge switch really does now use DT.
The L2 Cache binding has been re-written.
kirkwood.dtsi changes have been placed into there own patch.
Added mvebu_v5_defconfig
Fixed a few typos in changelogs
Added a few Cc:s

These patches can also be found in:



Andrew Lunn (23):
  ARM: Kirkwood: Give pm.c its own header file.
  irqchip: Orion: Fix getting generic chip pointer.
  ARM: Kirkwood: Convert mv88f6281gtw_ge switch setup to DT
  ARM: Kirkwood: Drop printing the SoC type and revision
  ARM: Kirkwood: Seperate board-dt from common and pcie code.
  ARM: Kirkwood: ioremap the cpu_config register before using it.
  ARM: Kirkwood: ioremap memory control register
  ARM: MVEBU: Add ARCH_MULTI_V7 to SoCs
  ARM: Orion: Move cache-feroceon-l2.h out of plat-orion
  ARM: MM: Add DT binding for Feroceon L2 cache
  ARM: Kirkwood: Instantiate L2 cache from DT.
  ARM: Fix default CPU selection for ARCH_MULTI_V5
  ARM: Fix MULTI_TLB for feroceon
  ARM: MM Enable building Feroceon L2 cache controller with ARCH_MVEBU
  ARM: Move kirkwood DT boards into mach-mvebu
  ARM: MVEBU: Let kirkwood use the system controller for restart
  ARM: MVEBU: Instantiate system controller in kirkwood.dtsi
  drivers: Enable building of Kirkwood drivers for mach-mvebu
  ARM: MVEBU: Enable mvebu-soc-id on Kirkwood
  ARM: config: Add a multi_v5_defconfig
  ARM: MVEBU: Simplifiy headers and make local
  ARM: config: Add mvebu_v5_defconfig
  ARM: Kirkwood: Remove DT support

 .../devicetree/bindings/arm/mrvl/feroceon.txt      |  16 ++
 arch/arm/Kconfig                                   |   2 +-
 arch/arm/boot/dts/Makefile                         |  34 ++--
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     |  62 +++++++
 arch/arm/boot/dts/kirkwood.dtsi                    |  10 ++
 arch/arm/configs/kirkwood_defconfig                |   6 -
 arch/arm/configs/multi_v5_defconfig                | 183 ++++++++++++++++++++
 arch/arm/configs/mvebu_v5_defconfig                | 166 ++++++++++++++++++
 arch/arm/include/asm/hardware/cache-feroceon-l2.h  |  13 ++
 arch/arm/mach-kirkwood/Kconfig                     |  25 ---
 arch/arm/mach-kirkwood/Makefile                    |   6 +-
 arch/arm/mach-kirkwood/board-dt.c                  | 150 ----------------
 arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c     |  50 ------
 arch/arm/mach-kirkwood/common.c                    |   3 +-
 arch/arm/mach-kirkwood/common.h                    |  13 --
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h  |   2 +
 arch/arm/mach-kirkwood/pm.c                        |   9 +-
 arch/arm/mach-kirkwood/pm.h                        |  26 +++
 arch/arm/mach-mv78xx0/common.c                     |   2 +-
 arch/arm/mach-mvebu/Kconfig                        |  28 ++-
 arch/arm/mach-mvebu/Makefile                       |   1 +
 arch/arm/mach-mvebu/kirkwood-pm.c                  |  76 +++++++++
 arch/arm/mach-mvebu/kirkwood-pm.h                  |  26 +++
 arch/arm/mach-mvebu/kirkwood.c                     | 190 +++++++++++++++++++++
 arch/arm/mach-mvebu/kirkwood.h                     |  22 +++
 arch/arm/mach-mvebu/mvebu-soc-id.c                 |   1 +
 arch/arm/mm/Kconfig                                |   2 +-
 arch/arm/mm/cache-feroceon-l2.c                    |  45 ++++-
 arch/arm/mm/proc-feroceon.S                        |   2 +-
 arch/arm/mm/tlb-v4wbi.S                            |   3 +
 .../plat-orion/include/plat/cache-feroceon-l2.h    |  11 --
 drivers/cpufreq/Kconfig.arm                        |   2 +-
 drivers/cpuidle/Kconfig.arm                        |   2 +-
 drivers/irqchip/irq-orion.c                        |   3 +-
 drivers/leds/Kconfig                               |   4 +-
 drivers/phy/Kconfig                                |   2 +-
 drivers/thermal/Kconfig                            |   2 +-
 sound/soc/kirkwood/Kconfig                         |   2 +-
 38 files changed, 905 insertions(+), 297 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mrvl/feroceon.txt
 create mode 100644 arch/arm/configs/multi_v5_defconfig
 create mode 100644 arch/arm/configs/mvebu_v5_defconfig
 create mode 100644 arch/arm/include/asm/hardware/cache-feroceon-l2.h
 delete mode 100644 arch/arm/mach-kirkwood/board-dt.c
 delete mode 100644 arch/arm/mach-kirkwood/board-mv88f6281gtw_ge.c
 create mode 100644 arch/arm/mach-kirkwood/pm.h
 create mode 100644 arch/arm/mach-mvebu/kirkwood-pm.c
 create mode 100644 arch/arm/mach-mvebu/kirkwood-pm.h
 create mode 100644 arch/arm/mach-mvebu/kirkwood.c
 create mode 100644 arch/arm/mach-mvebu/kirkwood.h
 delete mode 100644 arch/arm/plat-orion/include/plat/cache-feroceon-l2.h

-- 
1.8.5.3
