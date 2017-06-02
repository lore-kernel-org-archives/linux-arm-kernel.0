From: philippe.cornu@st.com (Philippe CORNU)
Date: Fri, 2 Jun 2017 16:37:09 +0200
Subject: [PATCH v3 0/6] STM32 DSI HOST
Message-ID: <1496414235-20098-1-git-send-email-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Version 3:
- stm/ltdc: Use panel-bridge (-170 lines), thanks to comments of Eric Anholt,
  Boris Brezillon, Archit Taneja & Andrzej Hajda.
- Synopsys dsi: Add dw_mipi_dsi.h (forgotten in v2), thanks to comments of
  Neil Armstrong.
- Synopsys dsi/dw-mipi-dsi.c: add dw_mipi_dsi_dphy_init() &
  dw_mipi_dsi_dphy_enable() to better manage DW phy-dedicated regs, remove
  dw_mipi_dsi_mode enum, remove stm32 patch for lpm, remove pllref (manage in
  the vendor phy) thanks to comments of Archit Taneja. Add mode_flags to phy
  parameters to better adjust lane mbps according to dsi burst and non burst
  modes todos in caps.
- stm/dw_mipi_dsi-stm.c: Add pllref management.
- dt-bindings/display/stm: Split dt-bindings patch in two (parent node
  removal/ dsi), add required nodes (port & panel/bridge), updates thanks to
  comments of Rob Herring.
- dt-bindings/display/Synopsys dsi: remove port as part of the vendor
  documentation, add panel/bridge node, update dt-bindings thanks to comments
  of Rob Herring.
- Add more people from Hisilicon & Rockchip.

Version 2:
- Add a generic Synopsys DesignWare MIPI DSI bridge driver following
  comments from Neil Armstrong & Archit Taneja.
- Use drm_of_find_panel_or_bridge() thanks to Eric Anholt comments
- Update dt-bindings thanks to Rob Herring comments

Version 1:
- Initial commit

The purpose of this set of patches is to add the mipi dsi host driver
to the stm32 family.

This mipi dsi host driver is based on the Rockchip version of the
Synopsys Designware mipi dsi driver (rockchip/dw-mipi-dsi.c)
modified for the stm32 family:
    - replace Rockchip digital & phy specific extensions with stm32's ones.
    - add a bridge

Philippe CORNU (6):
  drm/stm: ltdc: Add panel-bridge support
  dt-bindings: display: Add Synopsys DW MIPI DSI DRM bridge driver
  drm/bridge/synopsys: Add MIPI DSI host controller bridge
  dt-bindings: display: stm32: remove st-display-subsystem parent node
    requirement
  dt-bindings: display: stm32: Add DSI host driver
  drm/stm: Add STM32 DSI host driver

 .../bindings/display/bridge/dw_mipi_dsi.txt        |   30 +
 .../devicetree/bindings/display/st,stm32-ltdc.txt  |   84 +-
 drivers/gpu/drm/bridge/synopsys/Kconfig            |    9 +
 drivers/gpu/drm/bridge/synopsys/Makefile           |    2 +
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      | 1022 ++++++++++++++++++++
 drivers/gpu/drm/stm/Kconfig                        |   10 +-
 drivers/gpu/drm/stm/Makefile                       |    2 +
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c              |  353 +++++++
 drivers/gpu/drm/stm/ltdc.c                         |  208 +---
 drivers/gpu/drm/stm/ltdc.h                         |    2 +-
 include/drm/bridge/dw_mipi_dsi.h                   |   42 +
 11 files changed, 1585 insertions(+), 179 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
 create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
 create mode 100644 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
 create mode 100644 include/drm/bridge/dw_mipi_dsi.h

-- 
1.9.1
