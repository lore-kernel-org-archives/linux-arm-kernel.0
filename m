From: plaes@plaes.org (Priit Laes)
Date: Sun, 25 Jun 2017 23:45:41 +0300
Subject: [PATCH v4 0/6] ARM: sunxi: Convert sun4i/sun7i series SoCs to
 sunxi-ng CCU
Message-ID: <cover.24b2b13ec5a68552e186ba1637f1328363c3886e.1498422562.git-series.plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This serie brings A10 (sun4i) and A20 (sun7i) SoCs into the
sunxi-ng world.

As mentioned in sun5i conversion, this is pretty much standard
stuff as all the required clocks were already implemented in
the sunxi-ng framework.

Changes from v3:
 - Add support for fixed post-divider support for DIV clocks.
 - Fix wrong clk_ops for SATA. Spotted by Jonathan Liu.
 - Use numeric values for clock indices to make merging somewhat easier
 - Create separate sun7i/a20 specific header.

Changes from v2:
 - Rename driver and relevant files to sun4i-a10-ccu.
 - Drop mmc output and sample clocks for sun4i-a10.
 - Rename CSI ISP clock to SCLK as it is called on other variants.
 - Add comment on why PLL6 is used as AHB parent.
 - Fix parents for out_a/out_b clocks.
 - Stop exporting PLL_PERIPH_SATA gate. Driver takes care of gate.
 - Rework SATA clock handling.
 - Fix ahb gate parents.
 - Simplefb clock fixes (add dependencies for HDMI/LVDS clocks).
 - Fixes for pll-ve and pll-video1 clocks pointed out by Jonathan Liu.
 - Adapt to latest upstream changes from sunxi-next.

Changes from v1:
 - Drop useless comments
 - Add support for A10 / sun4i.
 - Rename driver to sunxi-a10-a20.
 - Add previously unimplemented clocks.
 - Document the audio pll hardcoded post-divider
 - Add Acked-by: Rob Herring <robh@kernel.org> on patch 4

Priit Laes (6):
  clk: sunxi-ng: div: Add support for fixed post-divider
  clk: sunxi-ng: Add sun4i/sun7i CCU driver
  dt-bindings: List devicetree binding for the CCU of Allwinner A20
  dt-bindings: List devicetree binding for the CCU of Allwinner A10
  ARM: sun7i: Convert to CCU
  ARM: sun4i: Convert to CCU

 Documentation/devicetree/bindings/clock/sunxi-ccu.txt |    2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                      |  643 +----
 arch/arm/boot/dts/sun7i-a20.dtsi                      |  719 +-----
 drivers/clk/sunxi-ng/Kconfig                          |   14 +-
 drivers/clk/sunxi-ng/Makefile                         |    1 +-
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c                  | 1446 ++++++++++-
 drivers/clk/sunxi-ng/ccu-sun4i-a10.h                  |   61 +-
 drivers/clk/sunxi-ng/ccu_div.c                        |   12 +-
 drivers/clk/sunxi-ng/ccu_div.h                        |    3 +-
 include/dt-bindings/clock/sun4i-a10-ccu.h             |  200 +-
 include/dt-bindings/clock/sun7i-a20-ccu.h             |   53 +-
 include/dt-bindings/reset/sun4i-a10-ccu.h             |   67 +-
 12 files changed, 2012 insertions(+), 1209 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun4i-a10.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun4i-a10.h
 create mode 100644 include/dt-bindings/clock/sun4i-a10-ccu.h
 create mode 100644 include/dt-bindings/clock/sun7i-a20-ccu.h
 create mode 100644 include/dt-bindings/reset/sun4i-a10-ccu.h

base-commit: 25b1d5e0c166759abba86cd38b5e2e5b6d833876
-- 
git-series 0.9.1
