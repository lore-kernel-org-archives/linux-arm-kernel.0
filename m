From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  7 Apr 2015 19:43:55 +0100
Subject: [PATCH v6 0/4] clk: Provide support for always-on clocks
Message-ID: <1428432239-4114-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lots of platforms contain clocks which if turned off would prove fatal.
The only way to recover from these catastrophic failures is to restart
the board(s).  Now, when a clock provider is registered with the
framework it is possible for a list of always-on clocks to be supplied
which must be kept ungated.  Each clock mentioned in the newly
introduced 'clock-always-on' will be clk_prepare_enable()d where the
normal references will be taken.  This will prevent the common clk
framework from attempting to gate them during the clk_disable_unused()
and disable_clock() procedures.

Changelog:
v5 => v6:
  - Use of_clk_get_from_provider() instead of of_clk_get_by_clkspec()
  - Explicitly describe expected DT values
  - Be pedantic with regards to printk() format specifiers

vX => v5:
  Implementations have changed drastically between versions, thus I
  would like for this set to be thought of independently from its
  predecessors.  The only reason for identifying as 'v5' is ease of
  differentiation on the list, which stems from the confusion caused
  by submitting 'v4' as a separate entity.

Lee Jones (4):
  ARM: sti: stih407-family: Supply defines for CLOCKGEN A0
  ARM: sti: stih410-clocks: Identify critical clocks as always-on
  clk: Provide always-on clock support
  clk: dt: Introduce binding for always-on clock support

 .../devicetree/bindings/clock/clock-bindings.txt   | 38 +++++++++++++++++++
 arch/arm/boot/dts/stih410-clock.dtsi               | 10 +++++
 drivers/clk/clk-conf.c                             | 43 +++++++++++++++++++++-
 include/dt-bindings/clock/stih407-clks.h           |  4 ++
 4 files changed, 94 insertions(+), 1 deletion(-)

-- 
1.9.1
