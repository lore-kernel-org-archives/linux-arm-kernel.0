From: pawel.moll@arm.com (Pawel Moll)
Date: Tue,  8 Nov 2011 13:16:03 +0000
Subject: [RFC 0/6] Versatile Express DT support
Message-ID: <1320758169-22668-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This set of patches is a proposal of the Versatile Express DT support.
It's based on the initial idea Dave Martin and myself worked on some
time ago.

The DT-based support for tiles lives in separate files, the motherboard
code was modified as little as possible. The non-DT A9x4 core tile
support is (hopefully) unaffected. The general idea is that non-DT
portions will "evolutionary" disappear over time.

Few comments:

* This series depends on the "of/flattree: Early "find node by alias"
  function" patch I posted some time ago:
  http://article.gmane.org/gmane.linux.drivers.devicetree/9052

* The V2TILE_PERIPH_P2V() and V2M_PERIPH_P2V() that seem to replace
  MMIO_P2V() will disappear one Nico's patches (the ones re-using
  static mappings in ioremap()) are merged.

* The SMP callbacks change is just a temporary "hack" that
  will go away once machine descriptions are aware of them
  (eg. Marc Z.'s "SOC descriptor" patch series).

* I've ignored LCD devices for now - driver doesn't support DT
  yet, but a colleague of mine is working on this.

* The v2p-ca5s.c and v2p-ca9.c are (obviously) very similar...
  I have some ideas how to merge them, Marc Z. is working on TWD
  bindings. Generally the idea is to create the static mapping
  basing on a "MPCore private peripherals" device node.

* After rebasing on top of 3.2-rc1 I started to experience major
  issues with smsc911x driver... The reason is unknown yet, I'm
  trying to figure out what is going on right now.

All comments welcome. It's only RFC for now only, but my goal is to
get as much as possible ready in time for 3.3 merge window. Any
help in achieving this is more then appreciated :-)

Cheers!

Pawel



Pawel Moll (6):
  ARM: vexpress: Get rid of MMIO_P2V
  ARM: vexpress: Remove platform SMP functions from ct_desc
  ARM: vexpress: Add DT support in v2m
  ARM: vexpress: DT-based support for Coretile Express A9x4 (V2P-CA9)
  ARM: vexpress: Initial RS1 memory map support
  ARM: vexpress: DT-based support for Coretile Express A5x2 (V2P-CA5s)

 arch/arm/boot/dts/vexpress-v2m-legacy.dtsi        |  196 +++++++++++++++++++++
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi           |  196 +++++++++++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts           |  121 +++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca9.dts            |  135 ++++++++++++++
 arch/arm/include/asm/hardware/arm_timer.h         |    5 +
 arch/arm/mach-vexpress/Kconfig                    |   26 +++
 arch/arm/mach-vexpress/Makefile                   |    2 +
 arch/arm/mach-vexpress/Makefile.boot              |    6 +-
 arch/arm/mach-vexpress/core.h                     |   30 +++-
 arch/arm/mach-vexpress/ct-ca9x4.c                 |   96 ++++-------
 arch/arm/mach-vexpress/include/mach/ct-ca9x4.h    |   13 +-
 arch/arm/mach-vexpress/include/mach/debug-macro.S |   37 ++++-
 arch/arm/mach-vexpress/include/mach/motherboard.h |   57 +++----
 arch/arm/mach-vexpress/include/mach/uncompress.h  |   13 ++-
 arch/arm/mach-vexpress/platsmp.c                  |   11 +-
 arch/arm/mach-vexpress/v2m.c                      |  166 +++++++++++++++---
 arch/arm/mach-vexpress/v2p-ca5s.c                 |   97 ++++++++++
 arch/arm/mach-vexpress/v2p-ca9.c                  |   97 ++++++++++
 18 files changed, 1163 insertions(+), 141 deletions(-)
 create mode 100644 arch/arm/boot/dts/vexpress-v2m-legacy.dtsi
 create mode 100644 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca5s.dts
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca9.dts
 create mode 100644 arch/arm/mach-vexpress/v2p-ca5s.c
 create mode 100644 arch/arm/mach-vexpress/v2p-ca9.c
