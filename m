From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Tue,  6 Sep 2016 23:38:42 +0200
Subject: [PATCH v5 0/6] meson: Meson8b and GXBB DWMAC glue driver
In-Reply-To: <20160904182320.671-1-martin.blumenstingl@googlemail.com>
References: <20160904182320.671-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160906213848.17785-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a DWMAC glue driver for the PRG_ETHERNET registers found in
Meson8b and GXBB SoCs. Based on the "old" meson6b-dwmac glue driver
the register layout is completely different.
Thus I introduced a separate driver.


Changes since v4:
- DWMAC_MESON now depends on COMMON_CLK because the new glue driver is
  also a clock provider (which requires COMMON_CLK)
- use Meson8b and GXBB in the module description (instead of the
  marketing names S805 and S905)
- fixed a trivial typo (retrive -> retrieve) in the
  get_stmmac_bsp_priv() helper patch
- added a new patch to update the module description of the dwmac-meson
  driver to indicate which SoCs are supported exactly (this patch is
  optional and does not affect the rest of the series)


Joachim Eastwood (1):
  stmmac: introduce get_stmmac_bsp_priv() helper

Martin Blumenstingl (5):
  net: dt-bindings: Document the new Meson8b and GXBB DWMAC bindings
  clk: gxbb: expose MPLL2 clock for use by DT
  net: stmmac: add a glue driver for the Amlogic Meson 8b / GXBB DWMAC
  ARM64: dts: meson-gxbb: use the new GXBB DWMAC glue driver
  net: stmmac: update the module description of the dwmac-meson driver

 .../devicetree/bindings/net/meson-dwmac.txt        |  45 ++-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   8 +-
 drivers/clk/meson/gxbb.h                           |   2 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   6 +-
 drivers/net/ethernet/stmicro/stmmac/Makefile       |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c  |   4 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    | 324 +++++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_platform.h  |   8 +
 include/dt-bindings/clock/gxbb-clkc.h              |   1 +
 9 files changed, 382 insertions(+), 18 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c

-- 
2.9.3
