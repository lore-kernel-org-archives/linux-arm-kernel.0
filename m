From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  7 Dec 2013 01:29:33 +0800
Subject: [PATCH 00/10] net: stmmac: Add sun7i GMAC glue layer
Message-ID: <1386350983-13281-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds Allwinner sun7i support to stmmac.
The Allwinner sun7i SoC A20 integrates an early version of
dwmac IP from Synopsys. On top of that is a hardware glue
layer. This layer needs to be configured before the dwmac
can be used.

The glue layer is implemented with existing callbacks in
stmmac platform data. Hardware feature flags are also passed
to the driver through platform data. As suggested by Maxime,
the platform data is tied to our compatible string.
Minimal modifications to stmmac core are made.

This version of dwmac IP requires store and forward DMA mode.
The relevant device tree property was documented, but not
implemented. The second patch adds this to stmmac platform
driver.

During testing, with stmmac built as a module, loading the
driver fails during the hardware probe phase. The main clock
is not enabled, and the hardware returns bogus results.
The first patch addresses this.

Comments?

Thanks,

wens


Chen-Yu Tsai (10):
  net: stmmac: Enable stmmac main clock when probing hardware
  net: stmmac: Honor DT parameter to force DMA store and forward mode
  net: stmmac: Use platform data tied with compatible strings
  net: stmmac: sunxi platfrom extensions for GMAC in Allwinner A20 SoC's
  ARM: dts: sun7i: Add GMAC controller node to sun7i DTSI
  ARM: dts: sun7i: Add pin muxing options for the GMAC
  ARM: dts: sun7i: cubietruck: Enable the GMAC
  ARM: dts: sun7i: cubieboard2: Enable GMAC instead of EMAC
  ARM: dts: sun7i: olinuxino-micro: Enable GMAC instead of EMAC
  ARM: dts: sun7i: Add ethernet alias for GMAC

 .../bindings/net/allwinner,sun7i-gmac.txt          | 22 +++++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        | 23 +++----
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |  8 +++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    | 23 +++----
 arch/arm/boot/dts/sun7i-a20.dtsi                   | 40 ++++++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig        | 12 ++++
 drivers/net/ethernet/stmicro/stmmac/Makefile       |  1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c  | 76 ++++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  3 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 24 ++++---
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 33 +++++++---
 11 files changed, 215 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/allwinner,sun7i-gmac.txt
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c

-- 
1.8.5.1
