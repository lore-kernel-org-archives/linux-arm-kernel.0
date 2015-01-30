From: stefan@agner.ch (Stefan Agner)
Date: Fri, 30 Jan 2015 11:33:02 +0100
Subject: [PATCH v4 0/3] irqchip: vf610-mscm: add support for MSCM interrupt
 router
Message-ID: <1422613985-11726-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far the MSCM interrupt router was initialized by the boot loader
and configured all interrupts for the Cortex-A5 CPU. There are two
use cases where a proper driver is necessary:
- To run Linux on the Cortex-M4. When the kernel is running on the
  non-preconfigured CPU, the interrupt router need to be configured
  properly.
- To support deeper sleep modes: LPSTOP clears the interrupt router
  configuration, hence a driver needs to restore the configuration
  on resume.

Due to the concernes of using "syscon" for the interrupt router
this 4th version uses device tree bindings which split the MSCM
module into sub-modules.

In detail, the registers inside the MSCM module are grouped:
- 0x40001000-0x4000105C: Processor information e.g. CPU ID
- 0x40001800-0x40001820: CPU2CPU directed interrupt registers
- 0x40001880-0x4000195E: The interrupt router registers
- 0x40001C00-0x40001DDC: ACTZS TrustZone registers

This version of the patchset defines bindings for the first submodule
and combines the second and third submodule into one block. However,
the driver currently does not support the CPU2CPU interrupts. The
fourth submodule is completely left out for now.

Due to this and the better documentation the patchset grew by ~40
lines. I think this bindings honer the quite individual functionality
inside the MSCM better.

Changes since v3
- Splitted MSCM bindings: MSCM CPU configuration and interrupt router
- Use syscon to access the CPU configuration registers
- Renamed the driver (irq-vf610-mscm => irq-vf610-mscm-ir)
- Extended general and property description of the bindings
- Rebased on v3.19-rc6

Changes since v2
- Use two cell layout for MSCM interrupt router
- Move peripheral interrupt properties to base device tree vfxxx.dtsi
- Use generic two cell xlate (irq_domain_xlate_twocell)
- Add syscon to compatible string
- Remove some line breaks for better readability

Changes since v1 (part of Vybrid Cortex-M4 support)
- Rewrite with irqdomain hierarchy
- Implemented as proper irqchip and move to driver/irqchip/
- Doesn't work on Cortex-M4 anymore (NVIC as parent is not yet
  implemented)

Stefan Agner (3):
  irqchip: vf610-mscm-ir: add support for MSCM interrupt router
  irqchip: vf610-mscm: dt-bindings: add MSCM bindings
  ARM: dts: vf610: add Miscellaneous System Control Module (MSCM)

 .../arm/freescale/fsl,vf610-mscm-cpucfg.txt        |  14 ++
 .../bindings/arm/freescale/fsl,vf610-mscm-ir.txt   |  33 ++++
 arch/arm/boot/dts/vf500.dtsi                       | 128 +------------
 arch/arm/boot/dts/vfxxx.dtsi                       |  48 +++++
 arch/arm/mach-imx/Kconfig                          |   1 +
 drivers/irqchip/Kconfig                            |  11 ++
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-vf610-mscm-ir.c                | 206 +++++++++++++++++++++
 8 files changed, 318 insertions(+), 124 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm-cpucfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm-ir.txt
 create mode 100644 drivers/irqchip/irq-vf610-mscm-ir.c

-- 
2.2.2
