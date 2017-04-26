From: plaes@plaes.org (Priit Laes)
Date: Wed, 26 Apr 2017 22:32:20 +0300
Subject: [PATCH v3 0/5] ARM: sunxi: Convert sun4i/sun7i series SoCs to
 sunxi-ng CCU
Message-ID: <cover.908ce010a25e503bb5ad0967759c723219c6ed0d.1493235134.git-series.plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This serie brings A10 (sun4i) and A20 (sun7i) SoCs into the
sunxi-ng world.

As mentioned in sun5i conversion, this is pretty much standard
stuff as all the required clocks were already implemented in
the sunxi-ng framework.

TODO: Unfortunately there's still an issue with SATA clocks
which will fail unless u-boot has set up the clocks. Clocks
probably need some extra work to handle fixed postdivider
and multiple parents.

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

Priit Laes (5):
  clk: sunxi-ng: Add sun4i/sun7i CCU driver
  dt-bindings: List devicetree binding for the CCU of Allwinner A20
  dt-bindings: List devicetree binding for the CCU of Allwinner A10
  ARM: sun7i: Convert to CCU
  ARM: sun4i: Convert to CCU

 Documentation/devicetree/bindings/clock/sunxi-ccu.txt |    2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                      |  645 +----
 arch/arm/boot/dts/sun7i-a20.dtsi                      |  720 +-----
 drivers/clk/sunxi-ng/Kconfig                          |   14 +-
 drivers/clk/sunxi-ng/Makefile                         |    1 +-
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c                  | 1443 ++++++++++-
 drivers/clk/sunxi-ng/ccu-sun4i-a10.h                  |   60 +-
 include/dt-bindings/clock/sun4i-a10-ccu.h             |  207 +-
 include/dt-bindings/reset/sun4i-a10-ccu.h             |   67 +-
 9 files changed, 1954 insertions(+), 1205 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun4i-a10.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun4i-a10.h
 create mode 100644 include/dt-bindings/clock/sun4i-a10-ccu.h
 create mode 100644 include/dt-bindings/reset/sun4i-a10-ccu.h

base-commit: 4c5e651abcb0fe1c7dd61d4ceb0388cc4a80485f
-- 
git-series 0.9.1
