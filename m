From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon,  4 May 2015 23:04:13 +0200
Subject: [PATCH v2 0/3] clk: si5351: Fixes for v4.1-rc1
Message-ID: <1430773456-15203-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike, Stephen,

this is v2 of dealing with recently reported clk-si5351 issues. Compared
to v1 [1], I decided to first split-off the pure fixes and postpone the
improvements to a later patch set. Patches 1 and 3 should go though clk
fixes while patch 2 should be taken by mvebu maintainers.

This fixes are intended for v4.1-rc1 and deal with issues where DT claimed
parent clocks are not properly detected starting with v4.0. Looking at the
code of clk-si5351, I just realized that the way the driver deals with
parent clocks is utter nonsense. Russell King also mentioned that passing
struct clk though platform_data shouldn't be done at all.

Therefore, this 3 patches rework parent clock handling of clk-si5351 to
make use of (a) named parent clocks, (b) devm_clk_get() for both DT- and
platform_data passed parent clocks, and (c) properly clk_prepare_enable()
valid parent clocks.

However, I do have a stripped down backport of the fix for stable v4.0
that just fixes the real issue, i.e. DT based probing and missing
clk_prepare_enable(). If you agree with this fixes for v4.1-rc1 we should
consider the backport for v4.0 stable.

Overall changes compared to v1:
- Postpone improvement patch ("clk: si5351: Reset PLL after rate change")
  for later patch set.
- Reword parent clock check error message. (Suggested by Fabio Estevam)

Sebastian

[1] https://lkml.org/lkml/2015/4/30/688

Sebastian Hesselbarth (3):
  clk: si5351: Mention clock-names in the binding documentation
  ARM: dove: Add clock-names to CuBox Si5351 clk generator
  clk: si5351: Do not pass struct clk in platform_data

 .../devicetree/bindings/clock/silabs,si5351.txt    |  4 +-
 arch/arm/boot/dts/dove-cubox.dts                   |  1 +
 drivers/clk/clk-si5351.c                           | 63 +++++++++++++++-------
 include/linux/platform_data/si5351.h               |  4 --
 4 files changed, 49 insertions(+), 23 deletions(-)

---
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Jean-Francois Moine <moinejf@free.fr>
Cc: Michael Welling <mwelling@ieee.org>
Cc: Russell King <rmk+linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-clk at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
-- 
2.1.0
