From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 26 Oct 2018 20:13:19 +0530
Subject: [PATCH v3 00/25] drm/sun4i: Allwinner A64 MIPI-DSI support 
Message-ID: <20181026144344.27778-1-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixed the issues related to work DSI on 2-lane panel
which is reported on previous version[1].

Few comments from previous version still in discussion, but I just
send this version just to group all working changes together.
anyway I will fix in this in next version if any.

PLL_MIPI min rate is still weird, I tried many possible dclock rate
from panel driver to satisfy manual suggested min rate 500MHz but
none working so eventually moved 300MHz. any inputs on this area
are welcome.

All these changes are tested in 2-lane, 4-lane MIPI-DSI panels.

If anyone wants to test, use this repo [2] with WIP-A64-DSI branch.

Any inputs,
Jagan.

[2] https://github.com/amarula/linux-amarula
[1] https://patchwork.kernel.org/cover/10653275/

Jagan Teki (25):
  clk: sunxi-ng: a64: Fix gate bit of DSI DPHY
  clk: sunxi-ng: Add check for minimal rate to NKM PLLs
  clk: sunxi-ng: Add check for maximum rate to NKM PLLs
  drm/sun4i: sun6i_mipi_dsi: Add Allwinner A64 MIPI DSI support
  dt-bindings: sun6i-dsi: Add compatible for A64 MIPI DSI
  drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short write 2 param
    transfer
  drm/sun4i: sun6i_mipi_dsi: Fix VBP size calculation
  drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
  drm/sun4i: sun6i_mipi_dsi: Refactor vertical video start delay
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hbp timing value
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hblk timing calculation
  drm/sun4i: sun6i_mipi_dsi: Add DSI hblk packet overhead
  drm/sun4i: sun6i_mipi_dsi: Fix DSI hfp timing value
  drm/sun4i: sun6i_mipi_dsi: Increase hfp packet overhead
  drm/sun4i: sun6i_mipi_dsi: Set proper vblk timing calculation
  drm/sun4i: sun6i_mipi_dsi: Add support for VCC-DSI voltage regulator
  dt-bindings: panel: Add Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB
    bridge
  drm/panel: Add Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB bridge
  dt-bindings: panel: Add Techstar TS8550B MIPI DSI panel
  drm/panel: Add Techstar TS8550B MIPI-DSI LCD panel
  clk: sunxi-ng: a64: Add min and max rate for PLL_MIPI
  dt-bindings: sun6i-dsi: Add compatible for A64 DPHY
  arm64: dts: allwinner: a64: Add DSI pipeline
  [DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Bananapi S070WV20-CT16 DSI panel
  arm64: dts: allwinner: a64-amarula-relic: Enable Techstar TS8550B
    MIPI-DSI panel

 .../display/panel/bananapi,s070wv20-ct16.txt  |  31 +-
 .../display/panel/techstar,ts8550b.txt        |  20 +
 .../bindings/display/sunxi/sun6i-dsi.txt      |   3 +-
 .../allwinner/sun50i-a64-amarula-relic.dts    |  46 +++
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  42 +++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  45 +++
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c         |   4 +-
 drivers/clk/sunxi-ng/ccu_nkm.c                |  14 +
 drivers/clk/sunxi-ng/ccu_nkm.h                |   2 +
 drivers/gpu/drm/panel/Kconfig                 |  18 +
 drivers/gpu/drm/panel/Makefile                |   2 +
 .../panel/panel-bananapi-s070wv20-icn6211.c   | 336 +++++++++++++++++
 .../gpu/drm/panel/panel-techstar-ts8550b.c    | 346 ++++++++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        | 122 ++++--
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |   8 +
 15 files changed, 1009 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/techstar,ts8550b.txt
 create mode 100644 drivers/gpu/drm/panel/panel-bananapi-s070wv20-icn6211.c
 create mode 100644 drivers/gpu/drm/panel/panel-techstar-ts8550b.c

-- 
2.18.0.321.gffc6fa0e3
