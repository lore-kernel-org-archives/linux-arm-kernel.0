From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 23 Nov 2018 20:53:05 +0100
Subject: [PATCH 0/6] 32-bit Meson: add the ARM TWD and Global Timers
Message-ID: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32-bit Meson SoCs use Cortex-A9 or Cortex-A5 cores. These come
with the ARM TWD ("Timer Watchdog") which contains a timer and a
watchdog as well as the ARM Global Timer.

This enables the corresponding configs for the 32-bit Meson target.
Additionally this adds and enables the ARM TWD timer. The Global
Timer is added but currently disabled because it's clock input is
the PERIPH clock which is derived from the CPU clock. Thus the rate
of the PERIPH clock will change when changing the CPU frequency.
Unfortunately the Global Timer driver doesn't handle clocks with
changing rates yet (unlike the TWD timer), thus we keep it disabled
for now.

The whole series is inspired by an almost 3 year old patch from
Carlo: [0]


Dependencies:
- I build this on top of my other series "ARM: dts: meson: add the
  timer interrupts and clocks" from [1]
- CLKID_PERIPH requires updated clock driver headers. Neil provided
  a tag which includes the updated headers: [2]
- There is no runtime dependency on the PERIPH clock as we don't
  have CPU frequency scaling support enabled yet. In case the TWD
  timer driver can't find the clock it falls back to auto-detecting
  the clock rate at boot time. This is safe as long as we don't have
  .dts patches in place which allow changing the CPU clock rate. Once
  we enable CPU frequency scaling support for the PERIPH clock becomes
  mandatory so the TWD timer driver knows about changes to the PERIPH
  clock (which is derived from the CPU clock).


[0] https://patchwork.kernel.org/patch/7797581/
[1] https://patchwork.kernel.org/cover/10687005/
[2] http://lists.infradead.org/pipermail/linux-amlogic/2018-November/009136.html


Martin Blumenstingl (6):
  ARM: meson: select HAVE_ARM_TWD and ARM_GLOBAL_TIMER
  ARM: dts: meson: group the Cortex-A5 / Cortex-A9 peripherals
  ARM: dts: meson8: add the ARM TWD timer
  ARM: dts: meson8: add the Cortex-A9 global timer
  ARM: dts: meson8b: add the ARM TWD timer
  ARM: dts: meson8b: add the Cortex-A5 global timer

 arch/arm/boot/dts/meson.dtsi   | 24 ++++++++++++++++--------
 arch/arm/boot/dts/meson8.dtsi  | 32 +++++++++++++++++++++++++++-----
 arch/arm/boot/dts/meson8b.dtsi | 32 +++++++++++++++++++++++++++-----
 arch/arm/mach-meson/Kconfig    |  2 ++
 4 files changed, 72 insertions(+), 18 deletions(-)

-- 
2.19.2
