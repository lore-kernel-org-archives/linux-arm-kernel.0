From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun,  4 Sep 2016 20:23:15 +0200
Subject: [PATCH v4 0/5] meson: Meson8b and GXBB DWMAC glue driver
In-Reply-To: <20160828161637.9941-1-martin.blumenstingl@googlemail.com>
References: <20160828161637.9941-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160904182320.671-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a DWMAC glue driver for the PRG_ETHERNET registers found in
Meson8b and GXBB SoCs. Based on the "old" meson6b-dwmac glue driver
the register layout is completely different.
Thus I introduced a separate driver.


Changes since v3:
- remove (unnecessary) usage of CLK_IS_BASIC flag
- use WARN_ON(IS_ERR(...)) instead of WARN_ON(PTR_ERR_OR_ZERO(...))
- let devm_ioremap_resource() check the result returned by
  platform_get_resource()
- added David Miller's ACKs to the patches which would be relevant for
  the net-next tree (patches 1, 3 and 4) as per
  http://lists.infradead.org/pipermail/linux-amlogic/2016-September/000995.html
- fixed typo in copyright year

Joachim Eastwood (1):
  stmmac: introduce get_stmmac_bsp_priv() helper

Martin Blumenstingl (4):
  net: dt-bindings: Document the new Meson8b and GXBB DWMAC bindings
  clk: gxbb: expose MPLL2 clock for use by DT
  net: stmmac: add a glue driver for the Amlogic Meson 8b / GXBB DWMAC
  ARM64: dts: meson-gxbb: use the new GXBB DWMAC glue driver

 .../devicetree/bindings/net/meson-dwmac.txt        |  45 ++-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   8 +-
 drivers/clk/meson/gxbb.h                           |   2 +-
 drivers/net/ethernet/stmicro/stmmac/Makefile       |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    | 324 +++++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_platform.h  |   8 +
 include/dt-bindings/clock/gxbb-clkc.h              |   1 +
 7 files changed, 377 insertions(+), 13 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c

-- 
2.9.3
