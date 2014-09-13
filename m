From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 13 Sep 2014 21:52:58 +0800
Subject: [PATCH 0/3] ARM: sun8i: Add DMA controller support
Message-ID: <1410616381-30226-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for the DMA controller found in the Allwinner
A23 SoC. It is the same hardware as found in the A31 (sun6i) SoC. In
addition to reduced physical channels and endpoints, the controller
in the A23 requires an undocumented register to be toggled. That
seems to allow memory bus access.

This series is based on my earlier "clk: sun6i: Unify AHB1 clock and
fix rate calculation" series, which removes the clock muxing calls from
the sun6i-dma driver. The default PLL6 pre-divider for AHB1 on the A23
results in an exceedingly high clock rate for AHB1, and the system hangs.
Also, on the A23, the dma controller happily works even when AHB1 is
clocked from AXI.


Patch 1 changes the channel count macros into runtime data binded to
the DT compatible strings. It also gets rid of some hardcoded values
in the interrupt handler.

Patch 2 adds the channel number data for the A23 (sun8i), as well as
the undocumented register quirk.

Patch 3 adds the dma controller node, and related dma resources, to the
DT.


Cheers
ChenYu


Chen-Yu Tsai (3):
  dmaengine: sun6i: support parameterized compatible strings
  dmaengine: sun6i: Add support for Allwinner A23 (sun8i) variant
  ARM: dts: sun8i: Add DMA controller node

 .../devicetree/bindings/dma/sun6i-dma.txt          |   2 +-
 arch/arm/boot/dts/sun8i-a23.dtsi                   |  19 ++++
 drivers/dma/Kconfig                                |   4 +-
 drivers/dma/sun6i-dma.c                            | 116 ++++++++++++++-------
 4 files changed, 103 insertions(+), 38 deletions(-)

-- 
2.1.0
