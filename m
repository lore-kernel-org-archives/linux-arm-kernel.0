From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 31 Aug 2018 15:53:11 +0800
Subject: [PATCH 0/7] Add i.MX6 SoCs mmdc ipg clocks management
Message-ID: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6 SoCs have MMDC driver which will access MMDC registers, and the
register access need to have MMDC IPG clocks enabled, current MMDC
driver does NOT handle the MMDC IPG clocks at all, most of the i.MX6
SoCs clock tree have MMDC0 IPG clock registered and have flag
CLK_IS_CRITICAL set, but some i.MX6 SoCs does NOT register the MMDC IPG
clock at all, it depends on default HW status which is NOT reliable.

To make it more formal, this patch set add all available MMDC IPG clocks
into clock tree, and add optional clocks enable operation in MMDC driver
to make sure IPG clock is enabled before accessing registers, and passing
MMDC IPG clock info from device tree MMDC node.

In order to NOT break old device tree, this patch set does NOT remove
the CLK_IS_CRITIAL flag for MMDC0 IPG clock.

Anson Huang (7):
  ARM: imx: add mmdc ipg clock operation for mmdc
  clk: imx6ul: add mmdc1 ipg clock
  clk: imx6sx: add mmdc1 ipg clock
  clk: imx6sll: add mmdc1 ipg clock
  clk: imx6sl: add mmdc ipg clocks
  clk: imx6q: add mmdc0 ipg clock
  ARM: dts: imx6: add mmdc ipg clock

 arch/arm/boot/dts/imx6qdl.dtsi            |  1 +
 arch/arm/boot/dts/imx6sl.dtsi             |  1 +
 arch/arm/boot/dts/imx6sll.dtsi            |  1 +
 arch/arm/boot/dts/imx6sx.dtsi             |  1 +
 arch/arm/boot/dts/imx6ul.dtsi             |  1 +
 arch/arm/mach-imx/mmdc.c                  | 14 ++++++++++++++
 drivers/clk/imx/clk-imx6q.c               |  1 +
 drivers/clk/imx/clk-imx6sl.c              |  2 ++
 drivers/clk/imx/clk-imx6sll.c             |  1 +
 drivers/clk/imx/clk-imx6sx.c              |  1 +
 drivers/clk/imx/clk-imx6ul.c              |  1 +
 include/dt-bindings/clock/imx6qdl-clock.h |  3 ++-
 include/dt-bindings/clock/imx6sl-clock.h  |  4 +++-
 include/dt-bindings/clock/imx6sll-clock.h |  3 ++-
 include/dt-bindings/clock/imx6sx-clock.h  |  3 ++-
 include/dt-bindings/clock/imx6ul-clock.h  |  3 ++-
 16 files changed, 36 insertions(+), 5 deletions(-)

-- 
2.7.4
