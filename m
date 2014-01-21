From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 21 Jan 2014 10:25:59 -0300
Subject: [PATCH v3 00/15] Armada 370/XP watchdog support
Message-ID: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Third patchset to extend Orion watchdog driver adding support for
Armada 370/XP SoC. This consists on a small incremental series.

Please take a look at the previous version and the discussion raised:
http://www.spinics.net/lists/arm-kernel/msg302104.html

Changes from v2:

 * Add proper error checking on clk_prepare_enable() and return
   PTR_ERR instead of ENODEV. Suggested by Fabio Estevam.

 * After the usage of the atomic I/O and considering the watchdog core
   does its own serialization, the driver's spinlock was completely
   redundant and was removed. Also suggested by Fabio.

 * Instead of making the driver dependent on PLAT_ORION, added a dependency
   to ARCH_MVEBU. This was proposed by Sebastian and Andrew, given
   we're working on PLAT_ORION removal.

This series is based on v3.13-rc8 and has been tested on:

 * Marvell's Armada XP GP board

Ezequiel Garcia (15):
  ARM: Introduce atomic MMIO modify
  clocksource: orion: Use atomic access for shared registers
  watchdog: orion: Use atomic access for shared registers
  watchdog: orion: Handle IRQ
  watchdog: orion: Make RSTOUT register a separate resource
  watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
  watchdog: orion: Introduce an orion_watchdog device structure
  watchdog: orion: Introduce per-compatible of_device_id data
  watchdog: orion: Add per-compatible clock initialization
  watchdog: orion: Add per-compatible watchdog start implementation
  watchdog: orion: Add support for Armada 370 and Armada XP SoC
  ARM: mvebu: Enable Armada 370/XP watchdog in the devicetree
  ARM: kirkwood: Add RSTOUT 'reg' entry to devicetree
  watchdog: orion: Enable the build on ARCH_MVEBU
  ARM: mvebu: Enable watchdog support in defconfig

 .../devicetree/bindings/watchdog/marvel.txt        |   8 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               |   4 +
 arch/arm/boot/dts/armada-370.dtsi                  |   5 +
 arch/arm/boot/dts/armada-xp.dtsi                   |   6 +
 arch/arm/boot/dts/kirkwood.dtsi                    |   2 +-
 arch/arm/configs/mvebu_defconfig                   |   2 +
 arch/arm/include/asm/io.h                          |   6 +
 arch/arm/kernel/io.c                               |  35 +++
 arch/arm/mach-dove/include/mach/bridge-regs.h      |   1 +
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h  |   1 +
 arch/arm/mach-mv78xx0/include/mach/bridge-regs.h   |   1 +
 arch/arm/mach-orion5x/include/mach/bridge-regs.h   |   1 +
 arch/arm/plat-orion/common.c                       |  10 +-
 drivers/clocksource/time-orion.c                   |  28 +-
 drivers/watchdog/Kconfig                           |   2 +-
 drivers/watchdog/orion_wdt.c                       | 320 ++++++++++++++++-----
 16 files changed, 329 insertions(+), 103 deletions(-)

-- 
1.8.1.5
