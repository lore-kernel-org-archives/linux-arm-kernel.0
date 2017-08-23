From: plaes@plaes.org (Priit Laes)
Date: Wed, 23 Aug 2017 20:23:28 +0300
Subject: [PATCH v7 0/5] ARM: sunxi: Convert sun4i/sun7i series SoCs to
 sunxi-ng CCU
Message-ID: <cover.2a284ee63f45063ec7c0720b1098860e0b516c6d.1503507503.git-series.plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This serie brings A10 (sun4i) and A20 (sun7i) SoCs into the
sunxi-ng world. With this patchset we now support all the clocks
in sun4i/sun7i SoCs.

In order to make cross-tree merges bisectable, changes to device
trees are currently using clock index as numbers instead of defines.

Changes from v6:
 - Use correct mask for audio PLL (Olliver Schinagl, Jonathan Liu)
 - Rename SUNXI_A10_CCU kconfig variable to SUN4I_A10_CCU
 - Drop applied div clock postdivider patch (Icenowy Zheng)

Changes from v5:
 - Added reviewed-by tags for Wens (A10/A20 dts bindings)
 - Fix hdmi clock parents (Jonathan Liu)
 - Add missing TVE0/1 reset bits (Olliver Schinagl)
 - Fix divider clock's fixed postdivider logic again (Maxime Ripard)
 - Set CLK_SET_RATE_PARENT for main hdmi and gpu clocks (Jonathan Liu)

Changes from v4:
 - Add CLK_SET_RATE_PARENT to "sata" clock.
 - Add proper postdivider support for divider clock.

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

Priit Laes (5):
  clk: sunxi-ng: Add sun4i/sun7i CCU driver
  dt-bindings: List devicetree binding for the CCU of Allwinner A20
  dt-bindings: List devicetree binding for the CCU of Allwinner A10
  ARM: sun7i: Convert to CCU
  ARM: sun4i: Convert to CCU

 Documentation/devicetree/bindings/clock/sunxi-ccu.txt |    2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                      |  646 +----
 arch/arm/boot/dts/sun7i-a20.dtsi                      |  719 +-----
 drivers/clk/sunxi-ng/Kconfig                          |   13 +-
 drivers/clk/sunxi-ng/Makefile                         |    1 +-
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c                  | 1456 ++++++++++-
 drivers/clk/sunxi-ng/ccu-sun4i-a10.h                  |   61 +-
 include/dt-bindings/clock/sun4i-a10-ccu.h             |  200 +-
 include/dt-bindings/clock/sun7i-a20-ccu.h             |   53 +-
 include/dt-bindings/reset/sun4i-a10-ccu.h             |   69 +-
 10 files changed, 2012 insertions(+), 1208 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun4i-a10.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun4i-a10.h
 create mode 100644 include/dt-bindings/clock/sun4i-a10-ccu.h
 create mode 100644 include/dt-bindings/clock/sun7i-a20-ccu.h
 create mode 100644 include/dt-bindings/reset/sun4i-a10-ccu.h

base-commit: 85c46c1a085cab2fea2df1de0fe8adfbcf1ef1ae
-- 
git-series 0.9.1
