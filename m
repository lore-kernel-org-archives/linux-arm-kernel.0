From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 23 Feb 2012 18:00:05 +0000
Subject: [GIT PULL] Versatile Express DT support
Message-ID: <1330020005.2727.11.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Olof,

Please pull the Versatile Express DT patches, rebased on top of
v3.3-rc4. I think I addressed all the comments I received:
- fixed the difference between DT and non-DT machine name (missing '-')
- as probing DEBUG_LL UART address proved to be unsafe, it is now
determined based on a PERIPHBASE register, which can be safely checked
- DTS don't include skeleton.dtsi any more, so there is no bogus memory
node
- changed TWD bindings to be in line with Marc Zygier's series
- as the static mappings are now reused, all pointer arithmetic was
replaced with ioremap()s

First patch causes one trivial conflict with depends/rmk/for-armsoc (for
your reference, I resolved it in vexpress-dt-rmk-for-armsoc branch)

Thanks!

Pawel

The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:

  Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)

are available in the git repository at:
  git://git.linaro.org/people/pawelmoll/linux.git vexpress-dt-v3.3-rc4

Pawel Moll (8):
      ARM: vexpress: Get rid of MMIO_P2V
      ARM: versatile: Map local timers using Device Tree when possible
      ARM: vexpress: Use FDT data in platform SMP calls
      ARM: vexpress: Add Device Tree support
      ARM: vexpress: Motherboard RS1 memory map support
      ARM: vexpress: Add Device Tree for V2P-CA5s core tile
      ARM: vexpress: Add Device Tree for V2P-CA9 core tile
      ARM: vexpress: Add Device Tree for V2P-CA15 core tile (TC1 variant)

 Documentation/devicetree/bindings/arm/vexpress.txt |  146 ++++++++++
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |  201 ++++++++++++++
 arch/arm/boot/dts/vexpress-v2m.dtsi                |  200 ++++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts        |  157 +++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts            |  162 +++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca9.dts             |  192 +++++++++++++
 arch/arm/include/asm/hardware/arm_timer.h          |    5 +
 arch/arm/mach-vexpress/Kconfig                     |   47 +++-
 arch/arm/mach-vexpress/Makefile.boot               |    6 +
 arch/arm/mach-vexpress/core.h                      |   11 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |   58 ++---
 arch/arm/mach-vexpress/include/mach/ct-ca9x4.h     |    3 -
 arch/arm/mach-vexpress/include/mach/debug-macro.S  |   30 ++-
 arch/arm/mach-vexpress/include/mach/irqs.h         |    2 +-
 arch/arm/mach-vexpress/include/mach/motherboard.h  |   58 +++--
 arch/arm/mach-vexpress/include/mach/uncompress.h   |   22 ++-
 arch/arm/mach-vexpress/platsmp.c                   |  160 +++++++++++-
 arch/arm/mach-vexpress/v2m.c                       |  281 ++++++++++++++++++--
 arch/arm/plat-versatile/localtimer.c               |   26 ++
 19 files changed, 1656 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress.txt
 create mode 100644 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
 create mode 100644 arch/arm/boot/dts/vexpress-v2m.dtsi
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca5s.dts
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca9.dts
