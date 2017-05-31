From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 31 May 2017 15:41:44 +0200
Subject: [PATCH v2 00/11] Improve cp110 clk support on Marvell Armada 7K/8K
Message-ID: <cover.d3a417499f4e5f039deaa27832bf6eccdd090a6f.1496237893.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We got more information about the clock controllers and the clock tree
of the CP110 part that we find in the Marvell Armada 7K/8K SoCs.

The main change in this second version is about the binding
documentation: all the documentation related changes are now move in
their own patches. It allows to provide a stable -dt branch for theses
changes. I also added the acked-by from Rob Herring.

However the last two patches modifying the device tree _must_ be
merged through the mvebu tree to avoid future conflict (especially
with the recent ICU series sent by Thomas Petazzoni).

For the record:

The clock tree needs to be fixed, indeed the GOP clock is only the
clock for the GOIP and not for the SDIO, it is fixed in the first
patch.

The third patch does a small improve of the code itself.

The purpose of the fifth patch is to have an easier way to add new
clocks without breaking the backward compatibility. Indeed, we expect
to continue to have new update on the datasheet and this patch will
allow integrating this change easier and faster.

The  patch 7 is needed to ease the integration of the pinctrl node
in the device tree.

The patch 9 adds a new clock for the SDIO, it also fixes the clock
tree.

In this series, even if there is some change in the device tree
binding, we paid attention to the backward compatibility, and the
driver can still work with the old device tree.

Thanks,

Gregory

Gregory CLEMENT (10):
  dt-bindings: cp110: fix name of the GOP gate clock
  clk: mvebu: cp110 fix name of the GOP gate clock
  clk: mvebu: cp110: make failure labels more meaningful
  dt-bindings: cp110: do not depend anymore of the *-clock-output-names
  clk: mvebu: cp110: do not depend anymore of the *-clock-output-names
  dt-bindings: cp110: introduce a new binding
  clk: mvebu: cp110: introduce a new binding
  dt-bindings: cp110: add sdio clock to cp-110 system controller
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
