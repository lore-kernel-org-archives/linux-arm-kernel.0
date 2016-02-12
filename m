From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 12 Feb 2016 17:59:56 +0000
Subject: [RFC PATCH 0/4] clk: sunxi: fix DT compatibility issues
Message-ID: <1455300000-18723-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f7d372ba54ea ("clk: sunxi: Refactor A31 PLL6 so that it can be
reused") (in -next) made the A31 PLL6 clock driver more generic, so
that it can drive the PLL8 clock in newer SoCs too.
However the patch broke compatibility with older DTs, which this
series tries to fix.
The approach chosen here is to bring back the old driver under its
old name, while letting the new driver using a different name to be
able to tell them apart.
The old driver should be somewhat deprecated and not used in new DTs
anymore.
The slight disadvantage is that there are now two drivers and two
compatible names for the same hardware (the PLL6 clock), I am not
sure if this is frowned upon or can be tolerated since the new driver
is more generic (drives PLL8 as well) and makes the old one obsolete.
We just need to keep it for compatibility.

The naming for both the functions and compatible names is probably
wrong, I am relying on more sunxi - experienced people here to
suggest better identifiers.

This is only one possible approach to fix this issues, so I am open
to any kind of discussion.

The series is made on top of Maxime's sunxi/for-next branch, so it
somehow reverts the change in question. I am happy to rebase it on
any branch people tell me.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Andre Przywara (4):
  clk: sunxi: rename new sun6i_a31_pll6 clock to sun6i_a31_pll clock
  clk: sunxi: re-add old sun6i_a31_pll6 clock
  clk: sunxi: revert .dtsi changes for DTs with a sun6i_a31_pll6 clock
  DT: Allwinner H3: fix PLL8 clock

 Documentation/devicetree/bindings/clock/sunxi.txt |  2 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                  | 36 ++++++++---------
 arch/arm/boot/dts/sun8i-a23-a33.dtsi              | 25 ++++--------
 arch/arm/boot/dts/sun8i-a23.dtsi                  |  2 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                  |  4 +-
 arch/arm/boot/dts/sun8i-h3.dtsi                   | 31 +++++---------
 drivers/clk/sunxi/clk-sunxi.c                     | 49 ++++++++++++++++++++---
 7 files changed, 84 insertions(+), 65 deletions(-)

-- 
2.6.4
