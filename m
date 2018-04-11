From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 11 Apr 2018 22:16:36 +0800
Subject: [PATCH 0/5] Add support in dwmac-sun8i for accessing EMAC clock
Message-ID: <20180411141641.14675-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some Allwinner SoCs, the EMAC clock register is in another device's
emory space, e.g. on A64 it's in the memory space of SRAM controller.

This patchset adds the possibility for the device to export the EMAC
clock register as a single-register regmap.

PATCH 1 adds the device tree binding for dwmac-sun8i to use another
device's regmap.

PATCH 2 and 3 are dwmac-sun8i refactors.

PATCH 4 exports the EMAC clock regmap in the SRAM controller driver.

PATCH 5 enable SRAM controller in the A64 device tree (replaces
syscon), and bind dwmac-sun8i to it.

Chen-Yu Tsai (2):
  net: stmmac: dwmac-sun8i: Use regmap_field for syscon register access
  net: stmmac: dwmac-sun8i: Allow getting syscon regmap from device

Icenowy Zheng (3):
  dt-bindings: allow dwmac-sun8i to use other devices' exported regmap
  drivers: soc: sunxi: export a regmap for EMAC clock reg on A64
  arm64: allwinner: a64: add SRAM controller device tree node

 .../devicetree/bindings/net/dwmac-sun8i.txt        |  5 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 23 +++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  | 85 +++++++++++++++++++---
 drivers/soc/sunxi/sunxi_sram.c                     | 48 +++++++++++-
 4 files changed, 141 insertions(+), 20 deletions(-)

-- 
2.15.1
