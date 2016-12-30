From: tony@atomide.com (Tony Lindgren)
Date: Fri, 30 Dec 2016 13:10:43 -0800
Subject: [GIT PULL] omap fixes for v4.10-rc cycle
Message-ID: <pull-1483125642-152778>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.10/fixes-rc1

for you to fetch changes up to 1a38de880992764d4bd5bccbd306b87d860e377d:

  ARM: dts: am572x-idk: Add gpios property to control PCIE_RESETn (2016-12-30 10:59:56 -0800)

----------------------------------------------------------------
Fist set of fixes for omaps for v4.10-rc cycle, mostly
to deal with various regressions noticed during the merge
window and to fix various device tree configurations for
boards. Also included is removal of mach-omap2/gpio.c that
is now dead code with device tree based booting that should
be OK for the early -rc cycle:

- A series of fixes to add empty chosen node to fix regressions
  caused for bootloaders that don't create chosen node as the
  decompressor needs the chosen node to merge command line and
  ATAGs into it

- Fix missing logicpd-som-lv-37xx-devkit.dtb entry in Makefile

- Fix regression for am437x timers

- Fix wrong strcat for non-NULL terminated string

- A series of changes to fix tps65217 interrupts to not use
  defines as we don't do that for interrupts

- Two patches to fix USB VBUS detection on am57xx-idk and force it
  to peripheral mode until dwc3 role detection is working

- Add missing dra72-evm-tps65917 missing voltage supplies
  accidentally left out of an earlier patch

- Fix n900 eMMC detection when booted on qemu

- Remove unwanted pr_err on failed memory allocation for
  prm_common.c

- Remove legacy mach-omap2/gpio.c that now is dead code
  since we boot mach-omap2 in device tree only mode

- Fix am572x-idk pcie1 by adding the missing gpio reset pin

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: omap3: Add DTS for Logic PD SOM-LV 37xx Dev Kit

Grygorii Strashko (2):
      ARM: OMAP2+: Remove legacy gpio code
      ARM: omap2+: am437x: rollback to use omap3_gptimer_timer_init()

Javier Martinez Canillas (9):
      ARM: dts: omap2: Add an empty chosen node to top level DTSI
      ARM: dts: omap3: Add an empty chosen node to top level DTSI
      ARM: dts: omap4: Add an empty chosen node to top level DTSI
      ARM: dts: omap5: Add an empty chosen node to top level DTSI
      ARM: dts: am33xx: Add an empty chosen node to top level DTSI
      ARM: dts: am4372: Add an empty chosen node to top level DTSI
      ARM: dts: dm814x: Add an empty chosen node to top level DTSI
      ARM: dts: dm816x: Add an empty chosen node to top level DTSI
      ARM: dts: dra7: Add an empty chosen node to top level DTSI

Kishon Vijay Abraham I (1):
      ARM: dts: am572x-idk: Add gpios property to control PCIE_RESETn

Lokesh Vutla (1):
      ARM: dts: dra72-evm-tps65917: Add voltage supplies to usb_phy, mmc, dss

Maninder Singh (1):
      ARM: omap2+: fixing wrong strcat for Non-NULL terminated string

Markus Elfring (1):
      ARM: OMAP2+: PRM: Delete an error message for a failed memory allocation

Milo Kim (4):
      ARM: dts: am335x: Fix the interrupt name of TPS65217
      dt-bindings: mfd: Remove TPS65217 interrupts
      dt-bindings: power/supply: Update TPS65217 properties
      dt-bindings: input: Specify the interrupt number of TPS65217 power button

Pali Roh?r (1):
      ARM: dts: n900: Mark eMMC slot with no-sdio and no-sd flags

Roger Quadros (2):
      ARM: dts: am57xx-idk: Support VBUS detection on USB2 port
      ARM: dts: am57xx-idk: Put USB2 port in peripheral mode

Tony Lindgren (1):
      Merge branch 'omap-for-v4.10/legacy' into omap-for-v4.10/fixes

 .../bindings/input/tps65218-pwrbutton.txt          |   4 +-
 .../bindings/power/supply/tps65217_charger.txt     |   7 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-bone-common.dtsi          |   8 +-
 arch/arm/boot/dts/am33xx.dtsi                      |   1 +
 arch/arm/boot/dts/am4372.dtsi                      |   1 +
 arch/arm/boot/dts/am571x-idk.dts                   |  10 +-
 arch/arm/boot/dts/am572x-idk.dts                   |  14 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi           |   9 +-
 arch/arm/boot/dts/dm814x.dtsi                      |   1 +
 arch/arm/boot/dts/dm816x.dtsi                      |   1 +
 arch/arm/boot/dts/dra7.dtsi                        |   1 +
 arch/arm/boot/dts/dra72-evm-tps65917.dtsi          |  16 +++
 arch/arm/boot/dts/omap2.dtsi                       |   1 +
 arch/arm/boot/dts/omap3-n900.dts                   |   2 +
 arch/arm/boot/dts/omap3.dtsi                       |   1 +
 arch/arm/boot/dts/omap4.dtsi                       |   1 +
 arch/arm/boot/dts/omap5.dtsi                       |   1 +
 arch/arm/mach-omap2/Makefile                       |   2 +-
 arch/arm/mach-omap2/board-generic.c                |   2 +-
 arch/arm/mach-omap2/gpio.c                         | 160 ---------------------
 arch/arm/mach-omap2/omap_hwmod.c                   |   8 +-
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   4 -
 arch/arm/mach-omap2/prm_common.c                   |   4 +-
 arch/arm/mach-omap2/timer.c                        |   9 +-
 include/dt-bindings/mfd/tps65217.h                 |  26 ----
 26 files changed, 74 insertions(+), 221 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/gpio.c
 delete mode 100644 include/dt-bindings/mfd/tps65217.h
