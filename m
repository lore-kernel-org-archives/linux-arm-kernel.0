From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  4 Dec 2017 13:19:10 +0800
Subject: [PATCH 0/2] clk: sunxi-ng: sun50i: a64: Add 2x fixed post-divider to
 MMC module clocks
Message-ID: <20171204051912.7485-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a small fix to get MMC performance up to proper speeds on the
A64. According to the BSP kernel, the MMC module clocks have a /2 fixed
post-divider between the clock output and the MMC module, like what
we've seen with the "new MMC timing mode" on the A83T, but the A64 does
not have the mode switch.

Sub-par performance was observed on the Banana Pi M64 eMMC. It only
reached half the read throughput of other Banana Pi boards, using a
standard sequential readout with a large block size. After these
patches, the performance is up to spec.

The A64 can also do DDR transfer modes, but the clock delay config
registers in the MMC module are different from what we've seen so
far. One can just force enable DDR modes without tuning the delays,
and it does work. Proper support for this is left for another time.


ChenYu

Chen-Yu Tsai (2):
  clk: sunxi-ng: Support fixed post-dividers on MP style clocks
  clk: sunxi-ng: sun50i: a64: Add 2x fixed post-divider to MMC module
    clocks

 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 57 +++++++++++++++++++++++------------
 drivers/clk/sunxi-ng/ccu_mp.c         | 20 ++++++++++--
 drivers/clk/sunxi-ng/ccu_mp.h         | 24 +++++++++++++++
 3 files changed, 79 insertions(+), 22 deletions(-)

-- 
2.15.0
