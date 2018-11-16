From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 16 Nov 2018 22:09:04 +0530
Subject: [PATCH v2 00/12] drm/sun4i: Allwinner MIPI-DSI Burst mode support 
Message-ID: <20181116163916.29621-1-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series support MIPI-DSI Burst mode on Allwinner platform, which
is tested in burst supported panel in Pine64-LTS board.

Series fixed few code changes commented in previous version[1] and
it depends on A64 MIPI-DSI series[2]

Changes for v2:
- add separate function for setup_inst_delay computation
- moved instruction loop seletion below delay compuation
- add separate function for dsi_get_timings and call for non-burst mode
- simplify burst mode timings compuatation
- add new patches, for tcon0 probing during dsi_bind
- add code to get the tcon0 divider value
- add multiple functions to get line_num, edge0, edge1
- squash 'enable burst mode' patch into 'Setup burst mode'
- fixed commit message of 'Enable burst mode HBP, HSA_HSE'
  s/enable/disable
- collect Rob R-b tag on panel dt-bindings patch
- panel driver changes,
  - dropped unneeded include files
  - s/fy07024di26a30d/feiyang function, variable names
  - use DRM_DEV_ERROR in panel driver
  - add set_display_on .enable
  - moved regulator enablement to .prepare
  - handle erro statements and release them properly during probe
  - remove panel if mipi_dsi_attach failed
  - fixed MODULE_LICENSE
  - update MAINTAINERS file about the panel
- add comments on dts about exact regulators used in schematics

[1] https://patchwork.kernel.org/cover/10666597/
[2] https://patchwork.kernel.org/cover/10680247/

Any inputs,
Jagan.

Jagan Teki (12):
  drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop N1 instruction
    delay
  drm/sun4i: sun6i_mipi_dsi: Support instruction loop selection
  drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
  drm/sun4i: sun6i_mipi_dsi: Simplify drq set to support all modes
  drm/sun4i: tcon: Export get tcon0 routine
  drm/sun4i: sun6i_mipi_dsi: Probe tcon0 during dsi_bind
  drm/sun4i: sun6i_mipi_dsi: Setup burst mode
  drm/sun4i: sun6i_mipi_dsi: Enable 2byte trail for 4-lane burst mode
  drm/sun4i: sun6i_mipi_dsi: Enable burst mode HBP, HSA_HSE
  dt-bindings: panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel
  drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel
  [DO NOT MERGE] arm64: allwinner: a64: pine64-lts: Enable Feiyang FY07024DI26A30-D DSI
    panel

 .../display/panel/feiyang,fy07024di26a30d.txt |  20 ++
 MAINTAINERS                                   |   6 +
 .../dts/allwinner/sun50i-a64-pine64-lts.dts   |  37 +++
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-feiyang-fy07024di26a30d.c | 286 ++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |   3 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h            |   1 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        | 264 ++++++++++++----
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h        |   1 +
 10 files changed, 567 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
 create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c

-- 
2.18.0.321.gffc6fa0e3
