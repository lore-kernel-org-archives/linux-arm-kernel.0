From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 10 Feb 2014 18:35:46 +0800
Subject: [PATCH v4 0/8] Add Allwinner A20 GMAC ethernet support
Message-ID: <1392028554-32545-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the v4 of the remaining Allwinner A20 GMAC glue layer patches.
The stmmac driver changes have been merged through net-next. The
remaining bits are clock and DT patches. The patches should be applied
over my clock renaming patches.

The Allwinner A20 SoC integrates an early version of dwmac
IP from Synopsys. On top of that is a hardware glue layer.
This layer needs to be configured before the dwmac can be
used.

Part of the glue layer is a clock mux, which controls the
source and direction of the TX clock used by GMAC.

Changes since v3:

  * Rework error checking in GMAC clock driver
  * Clarify required parent clock order for GMAC clock in DT bindings
  * Rewrite commit log for "ARM: dts: sun7i: Add ethernet alias for GMAC"
  * Corrected "a20-olinuxino-micro" in commit message
  * Rewrite comments in sun7i dtsi to clarify purpose of dummy clocks
  * Rebase onto Maxime's sunxi-next branch

Changes since v2:

  * Added more comments on GMAC clock driver
  * Drop CLK_SET_PARENT_GATE in GMAC clock driver
  * Use macro for max clock parents
  * Line wrapping

Changes since v1:

  * Added optional reset control to stmmac driver core
  * Added non CONFIG_RESET_CONROLLER routines for the above change
  * Extended callback API, as discussed with Srinivas
  * Used new stmmac_of_data to pass features and callbacks,
    instead of platform data, as discussed
  * Seperated clock module glue layer into clock driver

Cheers,
ChenYu


Chen-Yu Tsai (8):
  clk: sunxi: Add Allwinner A20/A31 GMAC clock unit
  ARM: dts: sun7i: Add GMAC clock node to sun7i DTSI
  ARM: dts: sun7i: Add GMAC controller node to sun7i DTSI
  ARM: dts: sun7i: Add pin muxing options for the GMAC
  ARM: dts: sun7i: cubietruck: Enable the GMAC
  ARM: dts: sun7i: cubieboard2: Enable GMAC instead of EMAC
  ARM: dts: sun7i: a20-olinuxino-micro: Enable GMAC instead of EMAC
  ARM: dts: sun7i: Add ethernet alias for GMAC

 Documentation/devicetree/bindings/clock/sunxi.txt | 30 +++++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts       | 27 +++----
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts        | 12 +++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts   | 27 +++----
 arch/arm/boot/dts/sun7i-a20.dtsi                  | 71 ++++++++++++++++-
 drivers/clk/sunxi/clk-sunxi.c                     | 97 +++++++++++++++++++++++
 6 files changed, 233 insertions(+), 31 deletions(-)

-- 
1.9.rc1
