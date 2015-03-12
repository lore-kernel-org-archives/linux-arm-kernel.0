From: stefan@agner.ch (Stefan Agner)
Date: Fri, 13 Mar 2015 00:36:08 +0100
Subject: [PATCH v3 00/12] ARM: vf610m4: Add Vybrid Cortex-M4 support
Message-ID: <1426203380-7155-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This version of the patchset does not contain the interrupt router
driver anymore (MSCM IR). The driver has been merged inbetween:
https://lkml.org/lkml/2015/3/8/6

This patchset extends the NVIC driver to support irq domain
hierarchy and the MSCM IR driver to support NVIC as a parent irq
controller.

I'm happy with the outcome of the MSCM driver, the irq domain
hierarchy support has proven to work with GIC and NVIC as
intendet.

As in v2, this version also doesn't add any ARCH or SOC anymore.
Instead, it allows to select ARCH_MULTIPLATFORM in the !MMU case
and add ARCH_MULTI_V7M as a new CPU choice. This change is based
on patches found in Arnd's git tree, however, it tries to allow
MULTIPLATFORM with !MMU in a way which should not allow to make
other selections than before (except ARCH_MULTI_V7M of course).
This makes ARCH_MXC and SOC_VF610 available for the !MMU CPU V7M.
With a small change, SOC_VF610 is now selectable when the CPU
ARCH_MULTI_V7M is selected, and hence allows to build a kernel
for the Cortex-M4 CPU too.

The patchset has proven to be working on the Cortex-M4 of the
Vybrid SoC using a Colibri VF61 module.

Changes since v2:
- Update MSCM patches to merged version of MSCM interrupt router
- Use the GPLv2/X11 dual license in the new device tree files
- Drop SD controller in device tree (initramfs works now and is
  probably more appropriate for most cases)
- Disable GPIO nodes since the A5 is using them
- Drop CONFIG_ prefixes in Kconfig changes for MXC_DEBUG_BOARD
- Drop vector table resizing in favor of Maxime Coquelin's patch
  (https://lkml.org/lkml/2015/2/20/399)
- Remove !MMU dependency for ARCH_EFM32 since its part of
  ARCH_MULTI_V7M
- Rebased on v4.0-rc1

Changes since v1:
- Remove MSCM driver
- Support irq domain hierarchy with NVIC irq controller
- Extend MSCM interrupt router with NVIC as parent in the irq
  domain hierarchy 
- Rebased on v3.19-rc1 with MSCM driver
- NVIC: Register only the amount of IRQ's which vectors are
  available for

Changes since RFC:
- Unified addruart calls for MMU/!MMU
- Add MSCM support along with routable IRQ support in NVIC
- Rebased on Shawns for-next tree which made some changes
  obsolete (mainly the Vybrid SoC device tree files in for-next
  are already prepared for Cortex-M4 support)
- Removed SRC_GPR3 hack, this is now part of a mini boot-loader:
  https://github.com/falstaff84/vf610m4bootldr

Arnd Bergmann (1):
  ARM: efm32: move into multiplatform

Stefan Agner (11):
  genirq: generic chip: support hierarchy domain
  irqchip: nvic: support hierarchy irq domain
  irqchip: vf610-mscm: support NVIC parent
  ARM: ARMv7M: define size of vector table for Vybrid
  clocksource: add dependencies for Vybrid pit clocksource
  ARM: unify MMU/!MMU addruart calls
  ARM: imx: depend MXC debug board on 3DS machines
  ARM: allow MULTIPLATFORM with !MMU
  ARM: vf610: enable Cortex-M4 on Vybrid SoC
  ARM: dts: add support for Vybrid running on Cortex-M4
  ARM: vf610m4: add defconfig for Linux on Vybrids Cortex-M4

 Documentation/devicetree/bindings/arm/fsl.txt |  3 +
 arch/arm/Kconfig                              | 54 +++++++--------
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/vf610m4-colibri.dts         | 98 +++++++++++++++++++++++++++
 arch/arm/boot/dts/vf610m4.dtsi                | 50 ++++++++++++++
 arch/arm/configs/efm32_defconfig              |  2 +
 arch/arm/configs/vf610m4_defconfig            | 43 ++++++++++++
 arch/arm/include/debug/efm32.S                |  2 +-
 arch/arm/kernel/debug.S                       |  2 +-
 arch/arm/mach-imx/Kconfig                     | 37 ++++++----
 arch/arm/mach-imx/Makefile.boot               |  0
 arch/arm/mach-imx/mach-vf610.c                |  1 +
 arch/arm/mm/Kconfig                           |  1 +
 drivers/clocksource/Kconfig                   |  2 +
 drivers/irqchip/irq-nvic.c                    | 28 +++++++-
 drivers/irqchip/irq-vf610-mscm-ir.c           | 32 +++++++--
 kernel/irq/generic-chip.c                     |  5 +-
 17 files changed, 306 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm/boot/dts/vf610m4-colibri.dts
 create mode 100644 arch/arm/boot/dts/vf610m4.dtsi
 create mode 100644 arch/arm/configs/vf610m4_defconfig
 create mode 100644 arch/arm/mach-imx/Makefile.boot

-- 
2.3.1
