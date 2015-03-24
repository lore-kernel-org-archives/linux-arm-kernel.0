From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 25 Mar 2015 01:22:06 +0800
Subject: [PATCH v2 0/3] clk: sunxi: Add muxable AHB clock to fix hstimer issues
Message-ID: <1427217729-10017-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v2 of the sun5i muxable AHB clock series.

Changes since v1:

  - Dropped patches 1~3 that are merged
  - Extend comments to clarify what the "base factor clock" refers to,
    and what the divs clocks outputs should be.


This series adds support for the muxable ahb clock on sun5/7i. The mux
has inputs such as the axi clock, the cpu clock on sun5i, and pll6 with
various dividers. The goal is to have ahb muxed to pll6, which should
be a fixed rate albeit configurable clock. This fixes issues with
cpufreq changing the cpu frequency, which would affect the hstimer
clocked from ahb.

Patch 1 makes divs clocks explicitly specify in the driver which output
is the base factor clock, instead of always putting it in last. This is
done to ensure DT bindings compatibility when we add outputs.

Patch 2 adds the new pll6/4 output, which is used on sun7i as an input
to ahb mux.

Patch 3 updates the dtsi files with the new drivers.

The series is also available at

    https://github.com/wens/linux/commits/sun5i-ahb-v2


Regards
ChenYu

Chen-Yu Tsai (3):
  clk: sunxi: Make divs clocks specify which output is the base factor
    clock
  clk: sunxi: Add pll6 / 4 clock output to sun4i-a10-pll6
  ARM: dts: sunxi: Update ahb clocks for sun5i and sun7i

 arch/arm/boot/dts/sun5i.dtsi     | 10 ++++++++--
 arch/arm/boot/dts/sun7i-a20.dtsi | 13 ++++++++++---
 drivers/clk/sunxi/clk-sunxi.c    | 38 ++++++++++++++++++++++++++------------
 3 files changed, 44 insertions(+), 17 deletions(-)

-- 
2.1.4
