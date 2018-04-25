From: maxime.chevallier@bootlin.com (Maxime Chevallier)
Date: Wed, 25 Apr 2018 13:07:28 +0200
Subject: [PATCH net 0/3] net: mvpp2: Fix hangs when starting some interfaces
 on 7k/8k
Message-ID: <20180425110731.20153-1-maxime.chevallier@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armada 7K / 8K clock management has recently been reworked, see :

commit c7e92def1ef4 ("clk: mvebu: cp110: Fix clock tree representation")

I have been experiencing overall system hangs on MacchiatoBin when starting
the eth1 interface since then. It turns out some clocks dependencies were
missing in the PPv2 and xmdio driver, the clock rework made this visible.

This series adds the missing clocks in the CP-110 DT bindings for these 2
controllers, updating the documentation accordingly. It also adds support
for the missing 'MG Core clock' in mvpp2.

Thanks to Gregory Clement for finding the root cause of this bug.

Maxime Chevallier (3):
  net: mvpp2: Fix clk error path in mvpp2_probe
  net: mvpp2: Fix clock resource by adding missing mg_core_clk
  ARM64: dts: marvell: armada-cp110: Add clocks for the xmdio node

 .../devicetree/bindings/net/marvell-pp2.txt        |  9 ++++---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      |  7 +++--
 drivers/net/ethernet/marvell/mvpp2.c               | 31 +++++++++++++++++-----
 3 files changed, 34 insertions(+), 13 deletions(-)

-- 
2.11.0
