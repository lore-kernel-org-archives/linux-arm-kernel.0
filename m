From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 26 Nov 2015 15:50:14 +0800
Subject: [PATCH v5 0/11] Add mipi dsi support for rk3288
Message-ID: <1448524225-5489-1-git-send-email-zyw@rock-chips.com>
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

Changes in v5:
- change the mipidsi clk to SCLK_MIPIDSI_24M
- modify the mipidsi clk name to SCLK_MIPIDSI_24M
Adviced by Thierry
- use hyphens instead of underscore
- use encoder in drm_bridge
- reformatting the dptdin table
- use readx_poll_timeout to check register
- use msleep to wait
- add a comment to explain how to program phy
- change the program code to symbolic names
- check this for validity of find_panel and clk_prepare_enable
- eliminate the configuration clock
- some optimization for coding style
- modify the clk name to SCLK_MIPIDSI_24M
- add a blank line befor lcd_en

Changes in v4:
- use clk_round_rate to check the clock rate in vop_crtc_mode_fixup
- remove the cfg clk
- remove gpr property from example, since it is noused now.
- add the description about ports
- eliminate some warnning

Changes in v3:
- move the dw_mipi_dsi.txt to Documentation/devicetree/bindings/display/bridge
- move dw_mipi_dsi_rockchip.txt to bindings/display/rockchip/

Changes in v2:
- add the mipi clk id in a single patch

Chris Zhong (9):
  clk: rockchip: add id for mipidsi sclk on rk3288
  clk: rockchip: add mipidsi clocks on rk3288
  drm/rockchip: return a true clock rate to adjusted_mode
  drm: bridge: allow some funcs to be optional
  drm/bridge: Add Synopsys DesignWare MIPI DSI host controller driver
  drm: rockchip: Support Synopsys DesignWare MIPI DSI host controller
  Documentation: dt-bindings: Add bindings for rk3288 DW MIPI DSI driver
  ARM: dts: rockchip: add rk3288 mipi_dsi nodes
  ARM: dts: rockchip: add support mipi panel tv080wum-nl0 for rk3288-evb

Liu Ying (2):
  drm/dsi: Add a helper to get bits per pixel of MIPI DSI pixel format
  Documentation: dt-bindings: Add bindings for DW MIPI DSI

 .../bindings/display/bridge/dw_mipi_dsi.txt        |   74 ++
 .../display/rockchip/dw_mipi_dsi_rockchip.txt      |   56 +
 arch/arm/boot/dts/rk3288-evb.dtsi                  |   20 +-
 arch/arm/boot/dts/rk3288.dtsi                      |   39 +
 drivers/clk/rockchip/clk-rk3288.c                  |    2 +-
 drivers/gpu/drm/bridge/Kconfig                     |   10 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/dw-mipi-dsi.c               | 1084 ++++++++++++++++++++
 drivers/gpu/drm/drm_bridge.c                       |    6 +-
 drivers/gpu/drm/rockchip/Kconfig                   |   10 +
 drivers/gpu/drm/rockchip/Makefile                  |    1 +
 drivers/gpu/drm/rockchip/dw_mipi_dsi_rockchip.c    |  249 +++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |    8 +
 include/drm/bridge/dw_mipi_dsi.h                   |   28 +
 include/drm/drm_mipi_dsi.h                         |   14 +
 include/dt-bindings/clock/rk3288-cru.h             |    1 +
 16 files changed, 1599 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
 create mode 100644 drivers/gpu/drm/bridge/dw-mipi-dsi.c
 create mode 100644 drivers/gpu/drm/rockchip/dw_mipi_dsi_rockchip.c
 create mode 100644 include/drm/bridge/dw_mipi_dsi.h

-- 
2.6.3
