From: stefan@agner.ch (Stefan Agner)
Date: Sat,  9 May 2015 22:39:30 +0200
Subject: [PATCH v6 00/12] ARM: vf610m4: Add Vybrid Cortex-M4 support
Message-ID: <1431203982-13217-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It took me a bit longer than expected to come up with the 6th
revision of the patchset. Support for irq domain hierarchy
for generic chip turned out to be not as easy as thought, the
changes lead to build errors when building without domain
hierarchy, sorry about that Jason.

However, in this patchset I propose adding the helper function
irq_domain_set_info even when there is no irq domain hierarchy
support. People familiar with that code (Jason, Marc), could
you have a look at that and tell me whether that is acceptable?
I also thought about other ways, e.g. create a second map
functions in generic chip which support domain hierarchy only.
But this new helper looks like the most straight forward way
to me...

Otherwise, I stripped down the To list as suggested by Arnd.
Shawn, when the IRQ stuff is ok, could you pick that patchset
up as Arnd suggested? I guess the IRQ stuff still should go
through Jason's tree directly (Patch 1-4)?

The patchset has proven to be working on the Cortex-M4 of the
Vybrid SoC using a Colibri VF61 module. Also compiled with
allmodconfig and without IRQ domain support, which worked fine
this time.

Note: This patchset has dependencies on "ARM: ARMv7-M: Enlarge
vector table up to 256 entries" (Maxime Coquelin), which is in
Russels patch system marked as applied (8340/1).

Changes since v5:
- Remove unnecessary empty lines in Kconfig
- Add non-hierarchy helper irq_domain_set_info
- Rebased on v4.1-rc1

Changes since v4:
- Added ARM_SINGLE_ARMV7M as top-level config symbol for ARMv7-M
  architectures
- Cleaned up unnecessary selects within SOC_VF610
- Added linux,stdout-path to device tree

Changes since v3:
- Added dependency IRQ_DOMAIN_HIERARCHY for ARM_NVIC
- Fix MSCM IR disable function check
- Remove "ARM: imx: depend MXC debug board on 3DS machines",
  the patch has been merged

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

Stefan Agner (12):
  irqdomain: Add non-hierarchy helper irq_domain_set_info
  genirq: generic chip: support hierarchy domain
  irqchip: nvic: support hierarchy irq domain
  irqchip: vf610-mscm: support NVIC parent
  ARM: ARMv7M: define size of vector table for Vybrid
  clocksource: add dependencies for Vybrid pit clocksource
  ARM: unify MMU/!MMU addruart calls
  ARM: introduce ARM_SINGLE_ARMV7M for ARMv7-M platforms
  ARM: efm32: use ARM_SINGLE_ARMV7M
  ARM: vf610: enable Cortex-M4 configuration on Vybrid SoC
  ARM: dts: add support for Vybrid running on Cortex-M4
  ARM: vf610m4: add defconfig for Linux on Vybrids Cortex-M4

 Documentation/devicetree/bindings/arm/fsl.txt |  3 +
 arch/arm/Kconfig                              | 41 ++++++-----
 arch/arm/Kconfig.debug                        |  2 +-
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/vf610m4-colibri.dts         | 99 +++++++++++++++++++++++++++
 arch/arm/boot/dts/vf610m4.dtsi                | 50 ++++++++++++++
 arch/arm/configs/efm32_defconfig              |  1 +
 arch/arm/configs/vf610m4_defconfig            | 42 ++++++++++++
 arch/arm/include/debug/efm32.S                |  2 +-
 arch/arm/kernel/debug.S                       |  2 +-
 arch/arm/mach-imx/Kconfig                     | 38 +++++-----
 arch/arm/mach-imx/Makefile.boot               |  0
 arch/arm/mach-imx/mach-vf610.c                |  1 +
 arch/arm/mm/Kconfig                           |  1 +
 drivers/clocksource/Kconfig                   |  2 +
 drivers/irqchip/Kconfig                       |  1 +
 drivers/irqchip/irq-nvic.c                    | 28 +++++++-
 drivers/irqchip/irq-vf610-mscm-ir.c           | 32 +++++++--
 include/linux/irqdomain.h                     |  8 +--
 kernel/irq/generic-chip.c                     |  5 +-
 kernel/irq/irqdomain.c                        | 21 ++++++
 21 files changed, 328 insertions(+), 52 deletions(-)
 create mode 100644 arch/arm/boot/dts/vf610m4-colibri.dts
 create mode 100644 arch/arm/boot/dts/vf610m4.dtsi
 create mode 100644 arch/arm/configs/vf610m4_defconfig
 create mode 100644 arch/arm/mach-imx/Makefile.boot

-- 
2.4.0
