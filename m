From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 17 Mar 2018 17:28:45 +0800
Subject: [PATCH net-next 00/12] ARM: sun8i: r40: Add Ethernet support
Message-ID: <20180317092857.4396-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for the DWMAC based Ethernet controller found
on the Allwinner R40 SoC. The controller is either a DWMAC clone or
DWMAC core with its registers rearranged. This is already supported by
the dwmac-sun8i driver. The glue layer control registers, unlike other
sun8i family SoCs, is not in the system controller region, but in the
clock control unit, like with the older A20 and A31 SoCs.

Mark (Brown), could you take a look at the regmap bits in patches 2 and
7? While we reuse the bindings for dwmac-sun8i using a syscon phandle
reference, we need some custom plumbing for the clock driver to export
a regmap that only allows access to the GMAC register to the dwmac-sun8i
driver. An alternative would be to allow drivers to register custom
syscon devices with their own regmap and locking.

Patch 1 converts the CLK_OF_DECLARE style clock driver to a platform
one, so the regmap introduced later has a struct device to tie to.

Patch 2 adds a regmap that is exported by the clock driver for the
dwmac-sun8i driver to use.

Patch 3 and 4 clean up the dwmac-sun8i binding.

Patch 5 adds device tree binding for Allwinner R40's Ethernet
controller.

Patch 6 converts regmap access of the syscon region in the dwmac-sun8i
driver to regmap_field, in anticipation of different field widths on
the R40.

Patch 7 introduces custom plumbing in the dwmac-sun8i driver to fetch
a regmap from the clock module, by looking up a device via a phandle,
then getting the regmap associated with that device.

Patch 8 adds support for different or absent TX/RX delay chain ranges
to the dwmac-sun8i driver.

Patch 9 adds support for the R40's ethernet controller.

Patch 10 cleans up the Bananapi M2 Ultra device tree file.

Patch 11 adds a GMAC device node and RGMII mode pinmux setting for the
R40.

Patch 12 enables Ethernet on the Bananapi M2 Ultra.


Please have a look.

Regards
ChenYu

Chen-Yu Tsai (10):
  dt-bindings: net: dwmac-sun8i: Clean up clock delay chain descriptions
  dt-bindings: net: dwmac-sun8i: Sort syscon compatibles by alphabetical
    order
  dt-bindings: net: dwmac-sun8i: Add binding for GMAC on Allwinner R40
    SoC
  net: stmmac: dwmac-sun8i: Use regmap_field for syscon register access
  net: stmmac: dwmac-sun8i: Allow getting syscon regmap from CCU device
  net: stmmac: dwmac-sun8i: Support different ranges for TX/RX delay
    chains
  net: stmmac: dwmac-sun8i: Add support for GMAC on Allwinner R40 SoC
  ARM: dts: sun8i: r40: bananapi-m2-ultra: Sort device node dereferences
  ARM: dts: sun8i: r40: Add device node and RGMII pinmux node for GMAC
  ARM: dts: sun8i: r40: bananapi-m2-ultra: Enable GMAC ethernet
    controller

Icenowy Zheng (2):
  clk: sunxi-ng: r40: rewrite init code to a platform driver
  clk: sunxi-ng: r40: export a regmap to access the GMAC register

 .../devicetree/bindings/net/dwmac-sun8i.txt        |  17 ++-
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  99 ++++++++++------
 arch/arm/boot/dts/sun8i-r40.dtsi                   |  34 ++++++
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c               |  70 +++++++++--
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  | 128 +++++++++++++++++----
 5 files changed, 278 insertions(+), 70 deletions(-)

-- 
2.16.2
