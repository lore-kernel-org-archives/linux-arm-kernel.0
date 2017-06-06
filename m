From: stefan@agner.ch (Stefan Agner)
Date: Mon,  5 Jun 2017 23:30:47 -0700
Subject: [PATCH v5 0/3] ARM: dts: imx7: add NAND support
Message-ID: <cover.b62c3a17bd60de48d8fb2ade6dde4f2bc60aaf3c.1496730576.git-series.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This revision alters the clock tree such that the clock required by
the APBH DMA (NAND_USDHC_BUS_CLK_ROOT _after_ gate CCGR20) is available
as an independent clock.

So far the gate CCGR20 was used by the NAND_ROOT_CLK only. A previous
patch added the NAND_ROOT_CLK which also lead to the effect that the
clock gate CCGR20 gets enabled:
https://patchwork.ozlabs.org/patch/551967/

The data sheet seems to indicate that the APBH DMA only uses hclk which
is connected to NAND_USDHC_BUS_CLK_ROOT through gate CCGR20. Tests
seem to confirm this wiring.

By adding a new clock IMX7D_NAND_USDHC_BUS_RAWNAND_CLK we can assign
a clock which also enables the shared CCGR20 gate without changing the
DMA driver. This better reflects the true wiring and encapsulates the
SoC specific clock wiring in the clock tree instead leaking it into
the driver code.

Versions 2 and earlier also included NAND driver changes, which are
already merged.

--
Stefan

Changes since v4:
- Introduce *_RAWNAND_CLK which represent clocks after CCGR20
-
- Add assigned-clocks to set a reasonable parent for raw NAND

Changes since v3:
- Only specify IMX7D_NAND_USDHC_BUS_ROOT_CLK which seems to be sufficent

Changes since v2:
- Dropped driver changes, alreay merged

Changes since v1:
- Make clks_count const
- Introduce IS_IMX7D for i.MX 7 SoC's and make it part of GPMI_IS_MX6

Stefan Agner (3):
  clk: imx7d: create clocks behind rawnand clock gate
  ARM: dts: imx7: add GPMI NAND and APBH DMA
  ARM: dts: imx7-colibri: add NAND support

 arch/arm/boot/dts/imx7-colibri.dtsi     |  9 +++++++-
 arch/arm/boot/dts/imx7s.dtsi            | 32 ++++++++++++++++++++++++++-
 drivers/clk/imx/clk-imx7d.c             |  6 +++--
 include/dt-bindings/clock/imx7d-clock.h |  4 ++-
 4 files changed, 48 insertions(+), 3 deletions(-)

base-commit: e2bb3be2c6c623ff0bad975dc9435531f450f0c5
-- 
git-series 0.9.1
