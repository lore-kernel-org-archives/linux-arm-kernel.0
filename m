From: zyw@rock-chips.com (Chris Zhong)
Date: Fri, 20 Nov 2015 16:15:26 +0800
Subject: [PATCH v4 0/13] Add mipi dsi support for rk3288
Message-ID: <1448007339-10966-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3288 MIPI DSI is a Synopsys DesignWare MIPI DSI host controller
IP. This series adds support for a Synopsys DesignWare MIPI DSI host
controller DRM bridge driver and a rockchip MIPI DSI specific DRM
driver.

This series also includes a DRM panel driver for BOE TV080WUM-NL0 panel.
This panel only use the MIPI DSI video mode.

The MIPI DSI feature is tested on rk3288 evb board, backport them to
chrome os kernel v3.14, and it can display normally.

This patchset is base on the patchset from Ying.liu at freescale.com.
<http://www.spinics.net/lists/dri-devel/msg77181.html>

Changes in v4:
use clk_round_rate to check the clock rate in vop_crtc_mode_fixup
remove gpr property from example, since it is noused now.
add the description about ports
eliminate some warnning
Alphabetically arranged the name

Changes in v3:
move the dw_mipi_dsi.txt to Documentation/devicetree/bindings/display/bridge
move dw_mipi_dsi_rockchip.txt to bindings/display/rockchip/
move boe,tv080wum-nl0.txt to bindings/display/panel/

Changes in v2:
add the mipi clk id in a single patch
As Thierry.Reding comment, add a documentation for this panel.

Chris Zhong (11):
  clk: rockchip: add id for mipidsi sclk on rk3288
  clk: rockchip: add mipidsi clocks on rk3288
  drm/rockchip: return a true clock rate to adjusted_mode
  drm/bridge: Add Synopsys DesignWare MIPI DSI host controller driver
  drm: rockchip: Support Synopsys DesignWare MIPI DSI host controller
  Documentation: dt-bindings: Add bindings for rk3288 DW MIPI DSI driver
  ARM: dts: rockchip: add rk3288 mipi_dsi nodes
  of: add vendor prefix for boe
  drm/panel: simple: Add support for BOE TV080WUM-NL0
  drm/panel: simple: Add boe,tv080wum-nl0 simple panel device tree
    binding
  ARM: dts: rockchip: add support mipi panel tv080wum-nl0 for rk3288-evb

Liu Ying (2):
  drm/dsi: Add a helper to get bits per pixel of MIPI DSI pixel format
  Documentation: dt-bindings: Add bindings for Synopsys DW MIPI DSI DRM
    bridge driver

 .../bindings/display/bridge/dw_mipi_dsi.txt        |   80 ++
 .../bindings/display/panel/boe,tv080wum-nl0.txt    |    7 +
 .../display/rockchip/dw_mipi_dsi_rockchip.txt      |   56 ++
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 arch/arm/boot/dts/rk3288-evb.dtsi                  |   20 +-
 arch/arm/boot/dts/rk3288.dtsi                      |   39 +
 drivers/clk/rockchip/clk-rk3288.c                  |    2 +-
 drivers/gpu/drm/bridge/Kconfig                     |   11 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/dw_mipi_dsi.c               | 1056 ++++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c               |   34 +
 drivers/gpu/drm/rockchip/Kconfig                   |   10 +
 drivers/gpu/drm/rockchip/Makefile                  |    1 +
 drivers/gpu/drm/rockchip/dw_mipi_dsi_rockchip.c    |  249 +++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |    8 +
 include/drm/bridge/dw_mipi_dsi.h                   |   27 +
 include/drm/drm_mipi_dsi.h                         |   14 +
 include/dt-bindings/clock/rk3288-cru.h             |    1 +
 18 files changed, 1615 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv080wum-nl0.txt
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
 create mode 100644 drivers/gpu/drm/bridge/dw_mipi_dsi.c
 create mode 100644 drivers/gpu/drm/rockchip/dw_mipi_dsi_rockchip.c
 create mode 100644 include/drm/bridge/dw_mipi_dsi.h

-- 
2.6.3
