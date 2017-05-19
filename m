From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 May 2017 17:55:18 +0200
Subject: [PATCH 0/7] Improve cp110 clk support on Marvell Armada 7K/8K
Message-ID: <cover.737145f06ff0191d1a9210bcd141e679bf45fe5f.1495208533.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We got more information about the clock controllers and the clock tree
of the CP110 part that we find in the Marvell Armada 7K/8K SoCs.

The clock tree needs to be fixed, indeed the GOP clock is only the
clock for the GOIP and not for the SDIO, it is fixed in the first
patch.

The second patch does a small improve of the code itself.

The purpose of the third patch is to have an easier way to add new
clocks without breaking the backward compatibility. Indeed, we expect
to continue to have new update on the datasheet and this patch will
allow integrating this change easier and faster.

The forth patch is needed to ease the integration of the pinctrl node
in the device tree.

The fifth patch adds a new clock for the SDIO, it also fixes the clock
tree.

The last two patches modify the device tree to take into account
theses changes. They must be merged through the mvebu tree to avoid
future conflict.

In this series, even if there is some change in the device tree
binding, we paid attention to the backward compatibility, and the
driver can still work with the old device tree.

Thanks,

Gregory

Gregory CLEMENT (6):
  clk: mvebu: cp110 fix name of the GOP gate clock
  clk: mvebu: cp110: make failure labels more meaningful
  clk: mvebu: cp110: do not depend anymore of the *-clock-output-names
  clk: mvebu: cp110: introduce a new binding
  arm64: dts: marvell: remove *-clock-output-names on cp110
  arm64: dts: marvell: use new binding for the system controller on cp110

Konstantin Porotchkin (1):
  clk: mvebu: cp110: add sdio clock to cp-110 system controller

 Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt |  35 +++++-------
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi                       |  54 +++++++------------
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi                        |  48 ++++++-----------
 drivers/clk/mvebu/cp110-system-controller.c                                | 202 +++++++++++++++++++++++++++++++++++++++++++++++++-----------------------
 4 files changed, 196 insertions(+), 143 deletions(-)

base-commit: 2ea659a9ef488125eb46da6eb571de5eae5c43f6
-- 
git-series 0.9.1
