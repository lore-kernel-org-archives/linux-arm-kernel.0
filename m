From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 15:53:57 +0200
Subject: [PATCH v3 00/11] SMP support for Armada 375 and 38x
Message-ID: <1397483648-26611-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Andrew, Gregory, Sebastian,

This patch series adds SMP support for the Armada 375 and 38x. Read
the bottom of the e-mail for details about the patches. Note that this
patch series applies on *top* of the 375/38x coherency and PMSU rework
series.

Changes since v2:

 * Rebased on top of v3.15-rc1. From my side, the patches are ready to
   apply, so unless review comments are made, I will not resend a new
   version of this patch series.

Changes since v1:

 * Use the CPU_METHOD_OF_DECLARE() and the enable-method DT property
   to associate SoCs and the SMP implementation. This avoids the need
   for a .smp_ops field in DT_MACHINE_START. Note that the .smp_ops
   field is avoided on Armada 375 and 38x, but is kept on Armada XP in
   order to remain compatible with old Device Trees.

 * Remove the cpu-reset changes for Armada 375 and Armada 38x, since
   we now have a single compatible string to cover all SOCs.

This branch is also available at:

  https://github.com/MISL-EBU-System-SW/mainline-public/tree/3.15-mvebu/smp

Most of the patches are fairly straight-forward, but here is a short
overview of what's going on:

 * Patches 1 to 5 make some preparatory clean-ups in the Armada XP SMP
   support.

 * Patches 6 and 7 add a few bits needed for the SMP support of Armada
   375 and 38x.

 * Patch 8 is adding the SMP support itself. Since both Armada 375 and
   38x are Cortex-A9, their SMP logic is fairly similar, the only
   difference being how to define the boot address of the secondary
   CPU. Therefore, we've used a single smp_operations implementation.

 * Patch 9 add a workaround for a SMP booting bug affecting Armada 375
   Z1 stepping. It requires using the Crypto SRAM loaded with a few
   instructions of code as a replacement of the BootROM for booting
   the secondary processor. For now, the workaround is unconditionally
   applied on all Armada 375 platforms, but as soon as we get access
   to more recent platforms, we'll add a mvebu-soc-id based test to
   only enable the workaround if needed.

 * Patch 10 and 11 add the necessary Device Tree bits to enable SMP on
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

Thomas Petazzoni (7):
  ARM: mvebu: move Armada XP specific SMP initialization to platsmp.c
  ARM: mvebu: use CPU_METHOD_OF_DECLARE for SMP on Armada XP
  ARM: mvebu: add enable-method property for CPUs
  irqchip: irq-armada-370-xp: do the set_smp_cross_call() in the driver
  irqchip: irq-armada-370-xp: use cpu notifier to initialize secondary
    CPUs
  ARM: mvebu: add Armada 38x compatible string to pmsu
  ARM: mvebu: add SMP support in the Armada 38x device tree

 .../devicetree/bindings/arm/armada-370-xp-pmsu.txt |   9 +-
 Documentation/devicetree/bindings/arm/cpus.txt     |   3 +
 arch/arm/boot/dts/armada-375.dtsi                  |   7 ++
 arch/arm/boot/dts/armada-380.dtsi                  |   2 +
 arch/arm/boot/dts/armada-385.dtsi                  |   2 +
 arch/arm/boot/dts/armada-38x.dtsi                  |  10 +++
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |   1 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   1 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |   1 +
 arch/arm/mach-mvebu/Kconfig                        |   4 +
 arch/arm/mach-mvebu/Makefile                       |   2 +-
 arch/arm/mach-mvebu/armada-370-xp.h                |   2 -
 arch/arm/mach-mvebu/common.h                       |   2 +
 arch/arm/mach-mvebu/headsmp-a9.S                   |  34 +++++++
 arch/arm/mach-mvebu/platsmp-a9.c                   | 100 +++++++++++++++++++++
 arch/arm/mach-mvebu/platsmp.c                      |  21 +++--
 arch/arm/mach-mvebu/pmsu.c                         |  27 +-----
 arch/arm/mach-mvebu/system-controller.c            |  15 +++-
 drivers/irqchip/irq-armada-370-xp.c                |  24 ++++-
 19 files changed, 224 insertions(+), 43 deletions(-)
 create mode 100644 arch/arm/mach-mvebu/headsmp-a9.S
 create mode 100644 arch/arm/mach-mvebu/platsmp-a9.c

-- 
1.8.3.2
