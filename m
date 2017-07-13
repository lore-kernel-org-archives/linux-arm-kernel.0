From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Jul 2017 16:12:55 +0200
Subject: [PATCH 00/18] drm/sun4i: Allwinner MIPI-DSI support
Message-ID: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is an preliminary version of the MIPI-DSI support for the Allwinner
SoCs.

This controller can be found on a number of recent SoCs, such as the
A31, A33 or the A64.

Given the sparse documentation, there's a number of obscure areas, but
the current implementation has been tested with a 4-lanes DSI panel on
an A33.

In order to support properly the DSI controller, we also had to rework a
bit the TCON code to ease the encoders support. The support is a bit rough
around the edges at the time, and some artifacts are still shown on the
screen for some reasons. Wider testing with different display will
hopefully nail those down.

It depends for the moment on the clock protection serie sent by Jerome
Brunet:
http://lists.infradead.org/pipermail/linux-amlogic/2017-June/004059.html

Let me know what you think,
Maxime

Maxime Ripard (18):
  regmap: mmio: Add function to attach a clock
  drm/sun4i: Add if statement instead of depends on
  drm/sun4i: Realign Makefile padding and reorder it
  drm/sun4i: Remove useless atomic_check
  drm/sun4i: tcon: remove unused function
  drm/sun4i: tcon: Don't rely on encoders to enable the TCON
  drm/sun4i: tcon: Don't rely on encoders to set the TCON mode
  drm/sun4i: tcon: Add TRI finish interrupt for vblank
  drm/sun4i: tcon: Adjust dotclock dividers range
  drm/sun4i: tcon: Move out the tcon0 common setup
  dt-bindings: display: Add Allwinner MIPI-DSI bindings
  drm/sun4i: Add Allwinner A31 MIPI-DSI controller support
  dt-bindings: vendor: Add Huarui Lighting
  dt-bindings: panel: Add Huarui LHR050H41 panel documentation
  drm/panel: Add Huarui LHR050H41 panel driver
  arm: dts: sun8i: a33: Add the DSI-related nodes
  arm: dts: sun8i: Add BananaPI M2-Magic DTS
  [DO NOT MERGE] arm: dts: sun8i: bpi-m2m: Add DSI display

 Documentation/devicetree/bindings/display/panel/huarui,lhr050h41.txt |   19 +-
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt        |   85 ++++++-
 Documentation/devicetree/bindings/vendor-prefixes.txt                |    1 +-
 arch/arm/boot/dts/Makefile                                           |    1 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                                     |   50 ++-
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts                         |  360 ++++++++++++++++++++++++-
 drivers/base/regmap/regmap-mmio.c                                    |   24 ++-
 drivers/gpu/drm/panel/Kconfig                                        |    9 +-
 drivers/gpu/drm/panel/Makefile                                       |    1 +-
 drivers/gpu/drm/panel/panel-huarui-lhr050h41.c                       |  444 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/Kconfig                                        |   17 +-
 drivers/gpu/drm/sun4i/Makefile                                       |   31 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c                                   |   33 +-
 drivers/gpu/drm/sun4i/sun4i_dotclock.c                               |   20 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c                           |    1 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c                               |   15 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c                          |    1 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c                                  |    7 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                                    |   37 +--
 drivers/gpu/drm/sun4i/sun4i_tcon.c                                   |  275 ++++++++++++------
 drivers/gpu/drm/sun4i/sun4i_tcon.h                                   |   68 ++--
 drivers/gpu/drm/sun4i/sun4i_tv.c                                     |   20 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c                              |  297 +++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c                               | 1098 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h                               |   67 ++++-
 include/linux/regmap.h                                               |    4 +-
 26 files changed, 2783 insertions(+), 202 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/huarui,lhr050h41.txt
 create mode 100644 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
 create mode 100644 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
 create mode 100644 drivers/gpu/drm/panel/panel-huarui-lhr050h41.c
 create mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c
 create mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
 create mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h

base-commit: d3d855e7c4ffaaa6c2cb221849da65e979d8aa80
-- 
git-series 0.9.1
