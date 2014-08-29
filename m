From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 29 Aug 2014 13:43:36 +0200
Subject: [PATCH 0/4] clk:mvebu: Improve clock drift
Message-ID: <1409312620-20631-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Jason, Andrew and Sebastian,

Few users reported a timer drift on the Armada 370 based board such as
the mirabox or the Netgear ReadyNAS 102.

The reason is that when the SSCG (Spread Spectrum Clock Generator) is
enabled, it shifts the frequency of the clock. The percentage is no
more than 1% but when the clock is used for a timer it leads to a
clock drift.

This series allows to correct the affected clock when the SSCG is
enabled. This drift can happen on all the mvebu SoC on the cpu clock
block (ie cpu, ddr and l2 cache). Currently the only notable effect is
for the Armada 370 because this SoC use the l2cache clock as source
for the timer. That's why even if the series allow any of the mvebu
SoC to benefit to this correction, Armada 370 is the only user of it.

The first 2 patches should go through the clk subsystem, whereas the
third one should go to the arm-soc through the mvebu tree.

The last one is just to fix a typo I found while I was reading the clk
code.

Thanks,


Gregory CLEMENT (4):
  clk: mvebu: Fix clk frequency value if SSCG is enabled
  clk: mvebu: armada-370: Fix timer drift caused by the SSCG deviation
  ARM: mvebu: add SSCG to Armada 370 Device Tree
  clk: mvebu: armada-375: Fix the description of the SAR in the comment

 arch/arm/boot/dts/armada-370.dtsi |  4 +++
 drivers/clk/mvebu/armada-370.c    |  7 ++++
 drivers/clk/mvebu/armada-375.c    |  4 +--
 drivers/clk/mvebu/common.c        | 74 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/mvebu/common.h        |  1 +
 5 files changed, 88 insertions(+), 2 deletions(-)

-- 
1.9.1
