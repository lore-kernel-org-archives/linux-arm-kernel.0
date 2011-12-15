From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 15 Dec 2011 14:02:32 +0000
Subject: [PATCH v6 0/9] Versatile Express DT support
Message-ID: <1323957761-13553-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This is the last (at least this year) version of the patches. I've added
Tested-by: Tixy to the patches that hasn't change since v5. I didn't add
Arnd's and Rob's Acked-bys as the code changed significantly since. If
still applicable, I'll add then on the first opportunity.

Arnd, Russell, if you think that the code is ready enough for 3.3, please
pull from this branch based on today's tip (v3.2-rc5+):

8<---------------------------------------------------------------------
The following changes since commit 55b02d2f4445ad625213817a1736bf2884d32547:

  Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied/linux (2011-12-14 19:45:40 -0800)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git vexpress-dt
8<---------------------------------------------------------------------

I also have a "vexpress-dt-rmk-devel-stable" branch there, based on
today's Russell's devel-stable. The only difference is "handle_irq"
added to DT machine description.

If there are still some issues I'll address them once I'm back from
holiday (today it's the last day before I loose all access to the
Internet for a month).

Changes since v5:

* As suggested by Russell, DT-based local timers take precedence over
  statically defined ones (so the twd_base if overwritten).

* Minor redactorial changes in DT-based SMP initialization (the logic
  stays the same).

* Added last missing device node to the V2M trees: "arm,vexpress-vram".

* Similarly to "arm,vexpress-cf" added "arm,vexpress-psram" to the
  relevant node, just in case we need to detect it in future.

Tested on:
- V2P-CA9 with ATAGs (both with a ATAGs-only and ATAGs+DT kernels).
- V2P-CA9 with DT
- V2P-CA5s with DT
- V2P-CA15 with DT
- V2F-2XV6 Cortex-A7 SMM with DT

Thanks to all involved for your help!
8<---------------------------------------------------------------------

Pawel Moll (9):
  ARM: versatile: Add missing ENDPROC to headsmp.S
  ARM: vexpress: Get rid of MMIO_P2V
  ARM: versatile: Map local timers using Device Tree when possible
  ARM: vexpress: Use FDT data in platform SMP calls
  ARM: vexpress: Add Device Tree support
  ARM: vexpress: Motherboard RS1 memory map support
  ARM: vexpress: Add Device Tree for V2P-CA5s core tile
  ARM: vexpress: Add Device Tree for V2P-CA9 core tile
  ARM: vexpress: Add Device Tree for V2P-CA15 core tile (TC1 variant)

 Documentation/devicetree/bindings/arm/vexpress.txt |  144 ++++++++++
 arch/arm/Kconfig                                   |    2 +-
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |  201 ++++++++++++++
 arch/arm/boot/dts/vexpress-v2m.dtsi                |  200 ++++++++++++++
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
 arch/arm/mach-vexpress/platsmp.c                   |  153 ++++++++++-
 arch/arm/mach-vexpress/v2m.c                       |  282 ++++++++++++++++++--
 arch/arm/mm/Kconfig                                |    2 +-
 arch/arm/plat-versatile/headsmp.S                  |    1 +
 arch/arm/plat-versatile/localtimer.c               |   12 +
 23 files changed, 1621 insertions(+), 120 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress.txt
 create mode 100644 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
 create mode 100644 arch/arm/boot/dts/vexpress-v2m.dtsi
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca5s.dts
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca9.dts

-- 
1.7.5.4
