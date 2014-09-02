From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  2 Sep 2014 10:15:15 +0200
Subject: [PATCH V2 0/4] clk: mvebu: Improve clock drift
Message-ID: <1409645719-20003-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Jason, Andrew and Sebastian,

Few users reported a timer drift on the Armada 370 based board such as
the mirabox or the Netgear ReadyNAS 102. This is the second series
with few improvements after the review of the 1st version.

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

Gregory

Changelog:

v1 -> v2:
- made the function a370_is_sscg_enabled() a static one
- reword the comment to make clear that the formula in datasheet is
  erroneous
- added a fix_sscg_deviation() callback in order to be able to deal
  with the Dove case which is different from the other mvebu SoCs


Gregory CLEMENT (4):
  clk: mvebu: Fix clk frequency value if SSCG is enabled
  clk: mvebu: armada-370: Fix timer drift caused by the SSCG deviation
  ARM: mvebu: add SSCG to Armada 370 Device Tree
  clk: mvebu: armada-375: Fix the description of the SAR in the comment

 arch/arm/boot/dts/armada-370.dtsi |  4 ++
 drivers/clk/mvebu/armada-370.c    |  8 ++++
 drivers/clk/mvebu/armada-375.c    |  4 +-
 drivers/clk/mvebu/common.c        | 82 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/mvebu/common.h        |  7 ++++
 5 files changed, 103 insertions(+), 2 deletions(-)

-- 
1.9.1
