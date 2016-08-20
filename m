From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 20 Aug 2016 11:35:34 +0200
Subject: [PATCH v2 0/4] meson: Meson8b and GXBB DWMAC glue driver
In-Reply-To: <20160815164100.27766-1-martin.blumenstingl@googlemail.com>
References: <20160815164100.27766-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160820093538.9707-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a DWMAC glue driver for the PRG_ETHERNET registers found in
Meson8b and GXBB SoCs. Based on the "old" meson6b-dwmac glue driver
the register layout is completely different.
Thus I introduced a separate driver.

Changes since v1:
- make clkin1 mandatory because the internal mux expects two clocks
  (in other words: this makes the driver consistent with how the
  hardware actually works)
- expose the MPLL2 clock for use by DT so we can pass it to the ethmac
- added a .remove function to the glue driver which disables and
  unprepares the clocks on driver removal


Martin Blumenstingl (4):
  net: dt-bindings: Document the new Meson8b and GXBB DWMAC bindings
  clk: gxbb: expose MPLL2 clock for use by DT
  net: stmmac: add a glue driver for the Amlogic Meson 8b / GXBB DWMAC
  ARM64: dts: meson-gxbb: use the new GXBB DWMAC glue driver

 .../devicetree/bindings/net/meson-dwmac.txt        |  45 ++-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   8 +-
 drivers/clk/meson/gxbb.h                           |   2 +-
 drivers/net/ethernet/stmicro/stmmac/Makefile       |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    | 329 +++++++++++++++++++++
 include/dt-bindings/clock/gxbb-clkc.h              |   1 +
 6 files changed, 374 insertions(+), 13 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c

-- 
2.9.3
