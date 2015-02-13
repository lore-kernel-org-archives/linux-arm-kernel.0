From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 13 Feb 2015 17:42:54 +0100
Subject: [PATCH 0/7] ARM: berlin: refactor the clock
Message-ID: <1423845781-7480-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Marvell Berlin SoCs have a chip control register set providing several
individual registers dealing with various controllers (pinctrl, reset,
clk). This chip controller is described by a single DT node since the
individual registers are spread among the chip control register bank.

Marvell Berlin also have a system control register set providing several
individual registers for pinctrl or adc.

A series was sent[1] to correctly handle these two nodes, by introducing
a Berlin mfd controller driver. The series converted the existing
pin-controller and reset drivers to take the changes into account.

Because the Berlin clock driver was still working with the above
modification, Berlin clock reworks were not included into the previous
series. Also the clock reworks change some of the clock framework
functions, so having a dedicated series helps.

This series aims to convert the Berlin clock driver to use the proper
way of dealing with the chip and system controller on Berlin SoCs. To do
this changes were done in the clk-mux and clk-gate helpers so they can
handle regmaps alongside iomem addresses.

This series has been tested on the Marvell Berlin BG2Q DMP.

This series is based on v3.19 and [1].

Thanks!

Antoine

[1] https://lkml.org/lkml/2015/2/11/367


Antoine Tenart (7):
  clk: convert clock mux to accept regmap
  clk: convert clock gate to accept regmap
  clk: berlin: use regmap
  Documentation: bindings: move the Berlin clock documentation
  ARM: berlin: rework the clock node for BG2
  ARM: berlin: rework the clock node for BG2CD
  ARM: berlin: rework the clock node for BG2Q

 .../devicetree/bindings/arm/marvell,berlin.txt     |  35 -------
 .../devicetree/bindings/clock/marvell,berlin.txt   |  31 ++++++
 arch/arm/boot/dts/berlin2.dtsi                     |  43 ++++----
 arch/arm/boot/dts/berlin2cd.dtsi                   |  39 +++----
 arch/arm/boot/dts/berlin2q.dtsi                    |  53 +++++-----
 drivers/clk/berlin/berlin2-avpll.c                 |  72 +++++++------
 drivers/clk/berlin/berlin2-avpll.h                 |  13 ++-
 drivers/clk/berlin/berlin2-div.c                   |  82 +++++----------
 drivers/clk/berlin/berlin2-div.h                   |   4 +-
 drivers/clk/berlin/berlin2-pll.c                   |  16 +--
 drivers/clk/berlin/berlin2-pll.h                   |   7 +-
 drivers/clk/berlin/bg2.c                           | 112 +++++++++++----------
 drivers/clk/berlin/bg2q.c                          |  64 +++++++-----
 drivers/clk/clk-gate.c                             |  94 +++++++++++++----
 drivers/clk/clk-mux.c                              |  72 +++++++++++--
 include/linux/clk-provider.h                       |  51 ++++++++--
 16 files changed, 467 insertions(+), 321 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,berlin.txt

-- 
2.3.0
