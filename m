From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 20 Mar 2015 01:19:02 +0800
Subject: [PATCH 0/6] clk: sunxi: Add muxable AHB clock to fix hstimer issues
Message-ID: <1426785548-5932-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for the muxable ahb clock on sun5/7i. The mux
has inputs such as the axi clock, the cpu clock on sun5i, and pll6 with
various dividers. The goal is to have ahb muxed to pll6, which should
be a fixed rate albeit configurable clock. This fixes issues with
cpufreq changing the cpu frequency, which would affect the hstimer
clocked from ahb.

This series is a bit large, but should be included as a fix for 4.0.


Patch 1 adds driver support for the muxable ahb clock.

Patch 2 adds the "cpu" clock to the list of protected clocks, as now
ahb might be muxed away, leaving cpu clock with no real users, and
getting disabled.

Patch 3 rearranges the order in which different types of clocks are
registered. Since our goal is to mux ahb (which is a factor clock)
to pll6 (which is a divs clock) using clock provider assigned-clocks
properties, we must register factor clocks first.

Patch 4 makes divs clocks explicitly specify in the driver which output
is the parent clock, instead of always putting it in last. This is done
to ensure DT bindings compatibility when we add outputs.

Patch 5 adds the new pll6/4 output, which is used on sun7i as an input
to ahb mux.

Patch 6 updates the dtsi files with the new drivers.

The series is also available at https://github.com/wens/linux/commits/sun5i-ahb


Regards
ChenYu


Chen-Yu Tsai (6):
  clk: sunxi: Add muxable ahb factors clock for sun5i and sun7i
  clk: sunxi: Add "cpu" to list of protected clocks for sun5i
  clk: sunxi: Register divs clocks before factor clocks
  clk: sunxi: Make divs clocks specify which output is the parent clock
  clk: sunxi: Add pll6 / 4 clock output to sun4i-a10-pll6
  ARM: dts: sunxi: Update ahb clocks for sun5i and sun7i

 Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
 arch/arm/boot/dts/sun5i.dtsi                      | 10 ++-
 arch/arm/boot/dts/sun7i-a20.dtsi                  | 13 +++-
 drivers/clk/sunxi/clk-sunxi.c                     | 91 +++++++++++++++++++----
 4 files changed, 95 insertions(+), 20 deletions(-)

-- 
2.1.4
