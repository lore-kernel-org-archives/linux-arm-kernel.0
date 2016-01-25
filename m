From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 25 Jan 2016 21:15:36 +0800
Subject: [PATCH RFC 00/11] clk: sunxi: factors clk clean up and refactor
Message-ID: <1453727747-23307-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series cleans up and reworks parts of sunxi's factors clk. The goal
is to support non-standard formulas for clock rate calculation, such as
pre-dividers on some parents, or all power-of-2 dividers. One such clock
is the AHB1 clock on A31/A31s.

Patch 1 is Maxime's patch adding an unregister function for composite
clocks. Patches 3 and 4 use this, so it is included for completeness.

Patch 2 makes the config tables for factors clk constant. These contain
the shift and width for the factors. They are used to manipulate the
clk register values. There should be no reason to change them in-flight.

Patch 3 adds a proper error path for the factors clk register function(),
so we don't leak memory when a call fails.

Patch 4 adds an unregister function for factors clks.

Patch 5 adds an error patch to sunxi_factors_clk_setup()

Patch 6 packs the parameters passed to get_factors callbacks in a struct.
This makes it easier to extend factors clk without having to edit all
the function definitions, and also makes the lines shorter.

Patch 7 makes factors clk support custom formulas for calculating clock
rates. On the clock rounding/setting side, we only need to teach
get_factors about different parent clocks. On the recalc side, we add
support for custom .recalc callbacks for clocks that need them.

Patch 8 drops .round_rate from factors clk ops. Since only one of
.round_rate and .determine_rate is needed, and the clk core prefers the
latter, remove .round_rate.

Patch 9 rewrites sun6i-a31-ahb1-clk using factors clk with the new custom
formula support. sun6i-a31-ahb1 has a pre-divider on one of its parents.

Patch 10 rewrite sun6i-ar100 using factors clk.

Patch 11 rewrites sun8i-a23-mbus-clk using the simpler composite clk.
While this patch is doing the reverse, i.e. rewriting a factors clk into
a composite clk, it is included because some changes overlap. I'm not
sure whether this approach is worthwhile, as it actually adds more code,
though it might make it easier to understand.


Regards
ChenYu


Chen-Yu Tsai (10):
  clk: sunxi: factors: Make struct clk_factors_config table const
  clk: sunxi: factors: Add clk cleanup in sunxi_factors_register() error
    path
  clk: sunxi: factors: Add unregister function
  clk: sunxi: unmap registers in sunxi_factors_clk_setup if register
    call fails
  clk: sunxi: factors: Consolidate get_factors parameters into a struct
  clk: sunxi: factors: Support custom formulas
  clk: sunxi: factors: Drop round_rate from clk ops
  clk: sunxi: rewrite sun6i-a31-ahb1-clk using factors clk with custom
    recalc
  clk: sunxi: rewrite sun6i-ar100 using factors clk
  clk: sunxi: rewrite sun8i-a23-mbus-clk using the simpler composite clk

Maxime Ripard (1):
  clk: composite: Add unregister function

 drivers/clk/clk-composite.c         |  15 +
 drivers/clk/sunxi/clk-factors.c     | 127 ++++++---
 drivers/clk/sunxi/clk-factors.h     |  25 +-
 drivers/clk/sunxi/clk-mod0.c        |  22 +-
 drivers/clk/sunxi/clk-sun6i-ar100.c | 235 ++++------------
 drivers/clk/sunxi/clk-sun8i-mbus.c  | 126 +++++----
 drivers/clk/sunxi/clk-sun9i-core.c  |  85 ++----
 drivers/clk/sunxi/clk-sunxi.c       | 540 +++++++++++++-----------------------
 include/linux/clk-provider.h        |   1 +
 9 files changed, 492 insertions(+), 684 deletions(-)

-- 
2.7.0
