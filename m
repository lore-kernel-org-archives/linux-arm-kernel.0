From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 30 Apr 2015 19:45:50 +0200
Subject: [PATCH 0/4] clk: si5351: Some fixes
Message-ID: <1430415954-29517-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For Si5351 clock driver, Michael Welling and Jean-Francois Moine reported
issues with recent v4.x kernels due to broken/missing/wrong parent clock
claming. This patch set now deals with the issues reported.

Patch 1 amends the binding documentation mention clock-names property
for the "xtal" and "clkin" parent clock inputs of Si5351 variants.

Patch 2 adds the clock-names property for the SolidRun CuBox using Si5351
with a fixed oscillator connected to "xtal" input.

Patch 3 reworks the way we claim parent clocks by using devm_clk_get()
for both DT and platform_data based registration. Also, properly check
for errors returned by devm_clk_get() and prepare/enable the parent clocks.

Patch 4 introduces a function to reset PLLs on rate change. This should
improve generated clock output stability. I currently have no scope at hand
to actually test that properly, so there may be more issues remaining.

@Michael, Jean-Francois: Please test and report if there are still
issues remaining.

Sebastian

Sebastian Hesselbarth (4):
  clk: si5351: Mention clock-names in the binding documentation
  ARM: dove: Add clock-names to CuBox Si5351 clk generator
  clk: si5351: Do not pass struct clk in platform_data
  clk: si5351: Reset PLL after rate change

 .../devicetree/bindings/clock/silabs,si5351.txt    |  4 +-
 arch/arm/boot/dts/dove-cubox.dts                   |  1 +
 drivers/clk/clk-si5351.c                           | 87 +++++++++++++++++-----
 include/linux/platform_data/si5351.h               |  4 -
 4 files changed, 73 insertions(+), 23 deletions(-)

---
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Jean-Francois Moine <moinejf@free.fr>
Cc: Michael Welling <mwelling@ieee.org>
Cc: Russell King <rmk+linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-clk at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
-- 
2.1.0
