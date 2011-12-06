From: pawel.moll@arm.com (Pawel Moll)
Date: Tue,  6 Dec 2011 15:43:43 +0000
Subject: [PATCH v4 0/6] Versatile Express DT support
Message-ID: <1323186229-22054-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

Here goes the fourth version of the series, hopefully something that
could be merged for 3.3 (all Revieved-by-s and Acked-by-s welcomed!)

Changes since v3:

* The "core tile" support has been renamed (no real code change)
  to support for "platforms based on a processor" and the DTBs now
  must be now compatible with "arm,vexpress-<tile-model>" and
  "arm,vexpress-<processor>", the latter being the important bit.
  Documentation has been updated accordingly (all language
  suggestions more then welcome).

* Added support code for Cortex-A7 and Cortex-A15 based platforms
  and DTS for V2P-CA15 tile with Test Chip 1.

* ARCH_VEXPRESS_RS1 has been dropped and the addresses in
  Makefile.boot are not modified, so the behaviour of the non-DT
  code is not changed at any time. ARCH_VEXPRESS_DT now enforces
  AUTO_ZRELADDR.

* Compact Flash is now compatible with "arm,vexpress-cf" as well
  as with "ata-generic".

* V2x_PERIPH macros are now (void _iomem *) pointers and the
  V2x_PERIPH_P2V macros were dropped.

* Wrong ARCH_VEXPRESS_DT->OF selection was fixed to ->USE_OF.

* PL310-related Kconfig options were aligned to Will's and Dave's
  changes.

* "make dtbs" compile all provided vexpress-*.dts files now.

Tested on:
- V2P-CA9 with ATAGs
- V2P-CA9 with DT
- V2P-CA5s with DT
- V2P-CA15 with DT
- V2F-2XV6 Cortex-A7 SMM with DT

Series v2 has been also tested by Ryan Harkin and provisionally acked
by Rob Herring.

Thanks for all your help, especially to Dave and Arnd for their
continuous support!

Pawel Moll (6):
  ARM: versatile: Add missing ENDPROC to headsmp.S
  ARM: vexpress: Get rid of MMIO_P2V
  ARM: vexpress: Add DT support for the motherboard
  ARM: vexpress: Motherboard RS1 memory map support
  ARM: vexpress: DT-based support for Cortex-A5 and Cortex-A9 based
    tiles
  ARM: vexpress: DT-based support for Cortex-A7 and Cortex-A15 based
    tiles

 Documentation/devicetree/bindings/arm/vexpress.txt |  118 +++++++++
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |  196 +++++++++++++++
 arch/arm/boot/dts/vexpress-v2m.dtsi                |  195 +++++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts        |  138 +++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts            |  131 ++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca9.dts             |  145 +++++++++++
 arch/arm/include/asm/hardware/arm_timer.h          |    5 +
 arch/arm/mach-realview/platsmp.c                   |    3 +-
 arch/arm/mach-vexpress/Kconfig                     |   68 +++++-
 arch/arm/mach-vexpress/Makefile                    |    2 +
 arch/arm/mach-vexpress/Makefile.boot               |    6 +
 arch/arm/mach-vexpress/core.h                      |   19 ++-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |   52 +---
 arch/arm/mach-vexpress/dt-ca5_ca9.c                |  114 +++++++++
 arch/arm/mach-vexpress/dt-ca7_ca15.c               |   95 +++++++
 arch/arm/mach-vexpress/include/mach/ct-ca9x4.h     |   13 +-
 arch/arm/mach-vexpress/include/mach/debug-macro.S  |   37 +++-
 arch/arm/mach-vexpress/include/mach/irqs.h         |    2 +-
 arch/arm/mach-vexpress/include/mach/motherboard.h  |   58 +++--
 arch/arm/mach-vexpress/include/mach/uncompress.h   |   13 +-
 arch/arm/mach-vexpress/platsmp.c                   |    7 +-
 arch/arm/mach-vexpress/v2m.c                       |  259 ++++++++++++++++++--
 arch/arm/plat-versatile/headsmp.S                  |    1 +
 23 files changed, 1557 insertions(+), 120 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress.txt
 create mode 100644 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
 create mode 100644 arch/arm/boot/dts/vexpress-v2m.dtsi
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca5s.dts
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca9.dts
 create mode 100644 arch/arm/mach-vexpress/dt-ca5_ca9.c
 create mode 100644 arch/arm/mach-vexpress/dt-ca7_ca15.c
