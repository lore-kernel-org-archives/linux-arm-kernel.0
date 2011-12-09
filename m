From: pawel.moll@arm.com (Pawel Moll)
Date: Fri,  9 Dec 2011 19:03:43 +0000
Subject: [PATCH v5 0/9] Versatile Express DT support
Message-ID: <1323457432-4800-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good Evening,

As usually it took more time than I though, but the changes are
quite extensive:

Changes since v4:

* Breaking news: we have a "generic" vexpress machine now!

* TWD DT-based initialization was moved to platform's local timers
  file

* SCU (and generally SMP) initialization was moved to platsmp.c
  file; when there is no memory-mapped SCU (A7/A15) the number
  of available cores is worked in generic way from the tree
  ("cpus" node)

* ... and there was very little left in the "tile" file, so it
  just nicely folded into v2m.c.

* Main compatible value is now "arm,vexpress", so we are back in
  the point we started :-)

* The tiles' trees are now separate patches, but I may fold them
  into one if this is preferred.

Tested on:
- V2P-CA9 with ATAGs
- V2P-CA9 with DT
- V2P-CA5s with DT
- V2P-CA15 with DT
- V2F-2XV6 Cortex-A7 SMM with DT

Previous versions have been tested by Ryan Harkin and provisionally
acked by Rob Herring and Arnd Bergmann.

Thanks for all your help, especially to Dave and Arnd for their
continuous support!


Pawel Moll (9):
  ARM: versatile: Add missing ENDPROC to headsmp.S
  ARM: vexpress: Get rid of MMIO_P2V
  ARM: vexpress: Add Device Tree support
  ARM: vexpress: Motherboard RS1 memory map support
  ARM: versatile: Map local timers using Device Tree when possible
  ARM: vexpress: Use FDT data in platform SMP calls
  ARM: vexpress: Add Device Tree for V2P-CA5s core tile
  ARM: vexpress: Add Device Tree for V2P-CA9 core tile
  ARM: vexpress: Add Device Tree for V2P-CA15 core tile (TC1 variant)

 Documentation/devicetree/bindings/arm/vexpress.txt |  144 ++++++++++
 arch/arm/Kconfig                                   |    2 +-
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |  196 ++++++++++++++
 arch/arm/boot/dts/vexpress-v2m.dtsi                |  195 ++++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts        |  155 +++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts            |  160 +++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca9.dts             |  190 +++++++++++++
 arch/arm/include/asm/hardware/arm_timer.h          |    5 +
 arch/arm/mach-realview/platsmp.c                   |    3 +-
 arch/arm/mach-vexpress/Kconfig                     |   45 +++-
 arch/arm/mach-vexpress/Makefile.boot               |    6 +
 arch/arm/mach-vexpress/core.h                      |    9 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |   48 +---
 arch/arm/mach-vexpress/include/mach/ct-ca9x4.h     |   13 +-
 arch/arm/mach-vexpress/include/mach/debug-macro.S  |   37 +++-
 arch/arm/mach-vexpress/include/mach/irqs.h         |    2 +-
 arch/arm/mach-vexpress/include/mach/motherboard.h  |   58 +++--
 arch/arm/mach-vexpress/include/mach/uncompress.h   |   13 +-
 arch/arm/mach-vexpress/platsmp.c                   |  151 ++++++++++-
 arch/arm/mach-vexpress/v2m.c                       |  282 ++++++++++++++++++--
 arch/arm/mm/Kconfig                                |    2 +-
 arch/arm/plat-versatile/headsmp.S                  |    1 +
 arch/arm/plat-versatile/localtimer.c               |   12 +
 23 files changed, 1609 insertions(+), 120 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress.txt
 create mode 100644 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
 create mode 100644 arch/arm/boot/dts/vexpress-v2m.dtsi
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca5s.dts
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca9.dts

-- 
1.7.5.4
