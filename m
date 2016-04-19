From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Wed, 20 Apr 2016 00:47:45 +0800
Subject: [PATCH v2] sunxi factors clock predivider handling
Message-ID: <1461084466-20889-1-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For allwinner A31 ahb1 and a83t ahb1 clocks have predivider for certain parent.

Currently, it's being handled in clock specific functions. 

A83t ahb1 and a31 ahb1 are similar clocks except a83t parent index 0b10 and 0b11
are pll6/prediv and a31 ahb1 parent index 0x11 is pll6/prediv.
with only this change, code duplication was needed.

To handle this, this patch adds predivider table with parent index, prediv 
shift and width, parents with predivider will have nonzero width.

Rate adjustment is moved from clock specific recalc function to generic factors
recalc. clock specific recalc was currently used only by a31 ahb1.

For getter, it differentiates parents with prediv, with non-zero prediv width.

I've tested this patch on a83t bpi-m3 board. I do not have a31 device.
As there are dependencies on other a83t patches, a83t changes are not included
in this patch, It'll be included in separate patch.


v1->v2 Changes:
1. As 'kbuild test robot' reported build failure due to dependency on patches,
Combined two patches in v1 into single patch.


Vishnu Patekar (1):
  clk: sunxi: predivider handling for factors clock

 drivers/clk/sunxi/clk-factors.c | 31 +++++++++++++++----------------
 drivers/clk/sunxi/clk-factors.h | 10 +++++++++-
 drivers/clk/sunxi/clk-sunxi.c   | 31 +++++++++----------------------
 3 files changed, 33 insertions(+), 39 deletions(-)

-- 
1.9.1
