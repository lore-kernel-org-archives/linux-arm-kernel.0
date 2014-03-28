From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 28 Mar 2014 14:06:56 +0100
Subject: [PATCH 00/10] SMP support for Armada 375 and 38x
Message-ID: <1396012026-5997-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Andrew, Gregory, Sebastian,

This patch series adds SMP support for the Armada 375 and 38x. Most of
the patches are fairly straight-forward, but here is a short overview
of what's going on:

 * Patches 1, 2, 3 make some preparatory clean-ups. Actually, patches
   2 and 3 are not directly related to adding Armada 375 and 38x SMP
   support, but they are related to the SMP support of Armada XP.

 * Patches 4, 5 and 6 add a few bits needed for the SMP support.

 * Patch 7 is adding the SMP support itself. Since both Armada 375 and
   38x are Cortex-A9, their SMP logic is fairly similar, the only
   difference being how to define the boot address of the secondary
   CPU. Therefore, we've used a single smp_operations implementation.

 * Patch 8 add a workaround for a SMP booting bug affecting Armada 375
   Z1 stepping. It requires using the Crypto SRAM loaded with a few
   instructions of code as a replacement of the BootROM for booting
   the secondary processor. For now, the workaround is unconditionally
   applied on all Armada 375 platforms, but as soon as we get access
   to more recent platforms, we'll add a mvebu-soc-id based test to
   only enable the workaround if needed.

 * Patch 9 and 10 add the necessary Device Tree bits to enable SMP on
   Armada 375 and 38x.

In terms of dependencies, we will have 4 interconnected patch series:
Armada 375/38x coherency support, the PMSU rework series, the cpuidle
series, and this Armada 375/38x SMP support series. The relations are
as follows

  ---------------        ---------------------
  | pmsu-rework |        | 375/38x coherency |
  ---------------        ---------------------
        ||   ||                 ||
	||   \\____________     ||
	\/                \/    \/
  ---------------        ---------------
  |   cpuidle   |        | 375/38x SMP |
  ---------------        ---------------

In other words, this 375/38x SMP support series needs *both* the
375/38x coherency patch series to be applied, and the pmsu-rework to
be applied.

If needed, I can merge the 375/38x coherency and 375/38x SMP support
together, but I believe shorter patch series are easier to
review. Just let me know what works best for you.

Thanks!

Thomas

Gregory CLEMENT (4):
  ARM: mvebu: add function to set the resume boot address for Armada 375
  ARM: mvebu: add SMP support for Armada 375 and Armada 38x
  ARM: mvebu: add workaround for SMP support for Armada 375 stepping Z1
  ARM: mvebu: add SMP support in the Armada 375 device tree

Thomas Petazzoni (6):
  ARM: mvebu: move Armada XP specific SMP initialization to platsmp.c
  irqchip: irq-armada-370-xp: do the set_smp_cross_call() in the driver
  irqchip: irq-armada-370-xp: use cpu notifier to initialize secondary
    CPUs
  ARM: mvebu: add Armada 375/38x support in cpu-reset
  ARM: mvebu: add Armada 38x compatible string to pmsu
  ARM: mvebu: add SMP support in the Armada 38x device tree

 .../devicetree/bindings/arm/armada-370-xp-pmsu.txt |  9 +-
 .../devicetree/bindings/arm/armada-cpu-reset.txt   |  2 +
 arch/arm/boot/dts/armada-375.dtsi                  |  5 ++
 arch/arm/boot/dts/armada-38x.dtsi                  | 10 +++
 arch/arm/mach-mvebu/Kconfig                        |  4 +
 arch/arm/mach-mvebu/Makefile                       |  2 +-
 arch/arm/mach-mvebu/armada-370-xp.h                |  2 -
 arch/arm/mach-mvebu/armada-375.h                   | 18 ++++
 arch/arm/mach-mvebu/armada-380.h                   | 18 ++++
 arch/arm/mach-mvebu/board-v7.c                     |  2 +
 arch/arm/mach-mvebu/common.h                       |  6 ++
 arch/arm/mach-mvebu/cpu-reset.c                    |  4 +
 arch/arm/mach-mvebu/headsmp-a9.S                   | 34 ++++++++
 arch/arm/mach-mvebu/platsmp-a9.c                   | 95 ++++++++++++++++++++++
 arch/arm/mach-mvebu/platsmp.c                      | 18 ++--
 arch/arm/mach-mvebu/pmsu.c                         | 27 +-----
 arch/arm/mach-mvebu/system-controller.c            | 15 +++-
 drivers/irqchip/irq-armada-370-xp.c                | 24 +++++-
 18 files changed, 252 insertions(+), 43 deletions(-)
 create mode 100644 arch/arm/mach-mvebu/armada-375.h
 create mode 100644 arch/arm/mach-mvebu/armada-380.h
 create mode 100644 arch/arm/mach-mvebu/headsmp-a9.S
 create mode 100644 arch/arm/mach-mvebu/platsmp-a9.c

-- 
1.8.3.2
