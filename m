From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 22 Nov 2018 22:40:13 +0100
Subject: [PATCH v2 0/4] Meson8b: add the CPU clock post-dividers
Message-ID: <20181122214017.25643-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the successor to my previous series "meson8b: add the CPU_DIV16
clock for the ARM TWD" from [0]. I decided to not send this as v2 of
the original series because the PERIPH clock is not the CPU_DIV16 clock.
It's not clear whether a CPU_DIV16 clock exists.

With this series we get all the CPU_CLK post-dividers as listed in the
public S805 datasheet [1] on pages 31 and 32:
- ABP
- PERIPH (used as input for the ARM global timer and ARM TWD timer)
- AXI
- L2 DRAM

Each of these clocks has a register called "..._CLK_DIS" which is
documented as a "just in case" bit:
"Set to 1 to manually disable the [...] clock when changing the mux
selection. Typically this bit is set to 0 since the clock muxes can
switch without glitches."
Since we're not supposed to touch that register we're using the new
read-only gate clk_ops to ensure that nothing accidentally modifies
these bits.

The result of this is that we can use the PERIPH clock which clocks
the ARM TWD timer. I will send a separate series to add the TWD timer.


changes since v1 at [2]:
- added new patch 2 "clk: meson: clk-regmap: add read-only gate ops"
- switched from CLK_IS_CRITICAL to the new clk_regmap_gate_ro_ops
  so we're consistent with all other read-only clocks
- collected Jerome's Acked-by tags (thanks!)


[0] http://lists.infradead.org/pipermail/linux-amlogic/2018-July/007890.html
[1] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
[2] https://patchwork.kernel.org/cover/10687023/


Martin Blumenstingl (4):
  dt-bindings: clock: meson8b: export the CPU post dividers
  clk: meson: clk-regmap: add read-only gate ops
  clk: meson: meson8b: rename cpu_div2/cpu_div3 to
    cpu_in_div2/cpu_in_div3
  clk: meson: meson8b: add the CPU clock post divider clocks

 drivers/clk/meson/clk-regmap.c           |   5 +
 drivers/clk/meson/clk-regmap.h           |   1 +
 drivers/clk/meson/meson8b.c              | 264 ++++++++++++++++++++++-
 drivers/clk/meson/meson8b.h              |  17 +-
 include/dt-bindings/clock/meson8b-clkc.h |   4 +
 5 files changed, 278 insertions(+), 13 deletions(-)

-- 
2.19.1
