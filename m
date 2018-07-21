From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 21 Jul 2018 19:37:18 +0200
Subject: [PATCH 0/3] Meson8/Meson8b: add the ARM TWD timer
Message-ID: <20180721173721.31361-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Carlo sent a .dts patch for the ARM TWD (timer watchdog) a long time
ago: [0]
This patch was never applied. While resurrecting it I found out (by
trial and error) that the TWD clock is derived from the CPU clock by
dividing the existing CPU clock by 16. Additionally I found out that
the interrupt is defined incorrectly, leading to an error message
during boot: "GIC: PPI13 is secure or misconfigured".

Amlogic's GPL kernel does not use the TWD timer. However, it seems to
work fine for me and it fixes the following warnings during boot:
  Clockevents: could not switch to one-shot mode:
  Clockevents: could not switch to one-shot mode:
  Clockevents: could not switch to one-shot mode:
  Clockevents: could not switch to one-shot mode:
   dummy_timer is not functional.
   dummy_timer is not functional.
   dummy_timer is not functional.
   dummy_timer is not functional.
  Could not switch to high resolution mode on CPU 0
  Could not switch to high resolution mode on CPU 2
  Could not switch to high resolution mode on CPU 3
  Could not switch to high resolution mode on CPU 1

I chose not to split the interrupt line at 80 chars to make it easier
to read (in my opinion, other .dts are not splitting it either).

NOTE: This series depends on the following clock driver changes: [1]


[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/391928.html
[1] http://lists.infradead.org/pipermail/linux-amlogic/2018-July/007890.html

Martin Blumenstingl (3):
  ARM: meson: select HAVE_ARM_TWD when SMP support is enabled
  ARM: dts: meson8: add the ARM TWD timer
  ARM: dts: meson8b: add the ARM TWD timer

 arch/arm/boot/dts/meson8.dtsi  | 7 +++++++
 arch/arm/boot/dts/meson8b.dtsi | 7 +++++++
 arch/arm/mach-meson/Kconfig    | 1 +
 3 files changed, 15 insertions(+)

-- 
2.18.0
