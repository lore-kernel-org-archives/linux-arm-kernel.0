From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Oct 2017 11:06:07 +0200
Subject: [PATCH 00/23] drm/sun4i: Add A83t LVDS support
Message-ID: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is an attempt at supporting the LVDS output in our DRM driver. This
has been tested on the A83T (with DE2), but since everything is basically
in the TCON, it should also be usable on the older SoCs with minor
modifications.

This was the occasion to refactor a bunch of things. The most notable ones
would be the documentation, and split of the UI layers in the mixer code,
and the switch to kfifo for our endpoint parsing code in the driver that
fixes an issue introduced by the switch to BFS.

Let me know what you think,
Maxime

Maxime Ripard (23):
  drm/sun4i: Implement endpoint parsing using kfifo
  drm/sun4i: Realign Makefile padding and reorder it
  drm/sun4i: tcon: Make tcon_set_mux mode argument const
  drm/sun4i: tcon: Make tcon_get_clk_delay mode argument const
  drm/sun4i: tcon: Don't rely on encoders to enable the TCON
  drm/sun4i: tcon: Don't rely on encoders to set the TCON mode
  drm/sun4i: tcon: Move out the tcon0 common setup
  dt-bindings: panel: lvds: Document power-supply property
  drm/panel: lvds: Add support for the power-supply property
  clk: sunxi-ng: Add A83T display clocks
  drm/sun4i: Rename layers to UI planes
  drm/sun4i: sun8i: properly support UI channels
  drm/sun4i: Reorder and document DE2 mixer registers
  drm/sun4i: Create minimal multipliers and dividers
  drm/sun4i: Add LVDS support
  drm/sun4i: Add A83T support
  arm: dts: sun8i: a83t: Add display pipeline
  arm: dts: sun8i: a83t: Enable the PWM
  arm: dts: sun8i: a83t: Add LVDS pins group
  arm: dts: sun8i: a83t: Add the PWM pin group
  arm: dts: sun8i: a711: Add regulator support
  arm: dts: sun8i: a711: Enable USB OTG
  arm: dts: sun8i: a711: Enable the LCD

 Documentation/devicetree/bindings/display/panel/panel-common.txt |   6 +-
 Documentation/devicetree/bindings/display/panel/panel-lvds.txt   |   1 +-
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt    |   3 +-
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts                        | 232 +++++++++++++++++++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/sun8i-a83t.dtsi                                | 100 ++++++++++++++++++++++-
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c                             |  21 +++--
 drivers/gpu/drm/panel/panel-lvds.c                               |  23 +++++-
 drivers/gpu/drm/sun4i/Makefile                                   |  29 +++---
 drivers/gpu/drm/sun4i/sun4i_crtc.c                               |  32 ++++++-
 drivers/gpu/drm/sun4i/sun4i_dotclock.c                           |  10 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                                |  73 +++-------------
 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c                       |   1 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c                           |  15 +---
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c                      |   1 +-
 drivers/gpu/drm/sun4i/sun4i_lvds.c                               | 183 ++++++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun4i_lvds.h                               |  18 ++++-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                                |  29 +------
 drivers/gpu/drm/sun4i/sun4i_tcon.c                               | 326 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 drivers/gpu/drm/sun4i/sun4i_tcon.h                               |  50 +++++++----
 drivers/gpu/drm/sun4i/sun4i_tv.c                                 |  12 +---
 drivers/gpu/drm/sun4i/sun8i_layer.c                              | 134 +------------------------------
 drivers/gpu/drm/sun4i/sun8i_layer.h                              |  36 +--------
 drivers/gpu/drm/sun4i/sun8i_mixer.c                              |  81 ++++++++----------
 drivers/gpu/drm/sun4i/sun8i_mixer.h                              | 101 ++++++++++++----------
 drivers/gpu/drm/sun4i/sun8i_ui.c                                 | 136 ++++++++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun8i_ui.h                                 |  37 ++++++++-
 26 files changed, 1212 insertions(+), 478 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_lvds.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_lvds.h
 delete mode 100644 drivers/gpu/drm/sun4i/sun8i_layer.c
 delete mode 100644 drivers/gpu/drm/sun4i/sun8i_layer.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_ui.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_ui.h

base-commit: 5ffd95d0dc16c6491631b6ca19403c96fd3db5d5
-- 
git-series 0.9.1
