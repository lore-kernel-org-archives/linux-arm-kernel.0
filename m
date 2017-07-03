From: philippe.cornu@st.com (Philippe CORNU)
Date: Mon, 3 Jul 2017 10:41:20 +0200
Subject: [PATCH v5 0/7] STM32 DSI HOST
Message-ID: <1499071287-10414-1-git-send-email-philippe.cornu@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Version 5:
- bridge/synopsis/dw-mipi-dsi.c: Improve the direct call to panel
  bridge post_disable() & related comments (Archit Taneja)
- stm/ltdc.c: fix leak of pixel clock enable in some error
  paths (Eric Anholt)
- bindings/display/bridge/dw_mipi_dsi.txt: add pixel clock & remove
  "driver" (Rob Herring, Archit Taneja)
- bindings/display/st,stm32-ltdc.txt: remove "driver" (Rob Herring,
  Archit Taneja)

Version 4:
- bridge/synopsis/dw-mipi-dsi.c: Add panel-bridge support (-45 lines,
  but no so easy to do) and is_panel_bridge for a better clean up, add
  stm copyright/remove dpms_mode/remove drm_of.h/improve clk
  management/add mode_valid (thanks to comments of Archit Taneja), use
  "DesignWare" instead of "Designware (thanks to comments of Neil
  Armstrong)
- bridge/synopsis/Kconfig: Remove help section to hide it in menuconfig
  (thanks to comments of Archit Taneja)
- include/drm/bridge/dw_mipi_dsi.h: Remove drmP.h (thanks to comments
  of Archit Taneja)
- bindings/display/bridge/dw_mipi_dsi.txt: Improve optional property
  explanations (thanks to comments of Neil Armstrong)
- stm/ltdc.c: Add is_panel_bridge for a better clean up/remove
  drm_encoder_helper_add() (thanks to comments of Eric Anholt)
- stm/dw_mipi_dsi-stm.c: remove math64.h/use DRM_WARN/remove warnings
  (thanks to comments of Archit Taneja), minor alignment fix (thanks to
  comments of Neil Armstrong)
- bindings/display/st,stm32-ltdc.txt: use graph binding in the 
  example/improve ports usage doc (thanks to comments of Rob Herring),
  use "DSI" instead of "dsi" where relevant (thanks to comments of Neil
  Armstrong)

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

Philippe CORNU (7):
  drm/stm: ltdc: Fix leak of px clk enable in some error paths
  drm/stm: ltdc: Add panel-bridge support
  dt-bindings: display: Add Synopsys DW MIPI DSI host controller
  drm/bridge/synopsys: Add MIPI DSI host controller bridge
  dt-bindings: display: stm32: remove st-display-subsystem parent node
    requirement
  dt-bindings: display: stm32: Add DSI controller
  drm/stm: Add STM32 DSI controller driver

 .../bindings/display/bridge/dw_mipi_dsi.txt        |  32 +
 .../devicetree/bindings/display/st,stm32-ltdc.txt  | 105 ++-
 drivers/gpu/drm/bridge/synopsys/Kconfig            |   6 +
 drivers/gpu/drm/bridge/synopsys/Makefile           |   2 +
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      | 979 +++++++++++++++++++++
 drivers/gpu/drm/stm/Kconfig                        |   9 +-
 drivers/gpu/drm/stm/Makefile                       |   2 +
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c              | 352 ++++++++
 drivers/gpu/drm/stm/ltdc.c                         | 220 +----
 drivers/gpu/drm/stm/ltdc.h                         |   3 +-
 include/drm/bridge/dw_mipi_dsi.h                   |  39 +
 11 files changed, 1566 insertions(+), 183 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
 create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
 create mode 100644 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
 create mode 100644 include/drm/bridge/dw_mipi_dsi.h

-- 
1.9.1
