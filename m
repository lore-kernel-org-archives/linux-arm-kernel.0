From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  7 Mar 2017 09:56:19 +0100
Subject: [PATCH 0/15] drm: sun4i: Add support for the HDMI controller
Message-ID: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is an attempt at getting the HDMI controller running.

This HDMI controller is found on a number of old Allwinner SoCs (A10, A10s,
A20, A31).

This driver only supports for now the A10s because it was an easy target,
being very close to the A13 that is already supported by our DRM driver.

There's nothing out of the extraordinary there, except maybe the clock
setup. All the internal clocks (TMDS, DDC) have been modeled using the
common clock framework, the TMDS clock being the parent of the DDC one.

While this might sound overkill, other SoC have a different, external
source for the DDC clock, which will be easier to support through the clock
framework.

It's still a bit rough around the edges, as it doesn't work for all the
modes. This will need to be fixed before being merged obviously.

The IP also supports audio (through an already supported i2s controller,
and some missing configuration in the HDMI controller) and CEC. Both will
come eventually.

Let me know what you think!
Maxime

Maxime Ripard (15):
  clk: divider: Make divider_round_rate take the parent clock
  clk: sunxi-ng: Pass the parent and a pointer to the clocks round rate
  clk: sunxi-ng: div: Switch to divider_round_rate
  clk: sunxi-ng: mux: Don't just rely on the parent for CLK_SET_RATE_PARENT
  clk: sunxi-ng: sun5i: Export video PLLs
  dt-bindings: display: sun4i: Add HDMI display bindings
  dt-bindings: display: sun4i: Add allwinner,tcon-channel property
  drm/sun4i: tcon: Add channel debug
  drm/sun4i: tcon: Pass the encoder to the mode set functions
  drm/sun4i: tcon: Switch mux on only for composite
  drm/sun4i: tcon: Fix tcon channel 1 backporch calculation
  drm/sun4i: tcon: multiply the vtotal when not in interlace
  drm/sun4i: Add HDMI support
  ARM: sun5i: a10s: Add the HDMI controller node
  ARM: sun5i: a10s-olinuxino: Enable HDMI

 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt |  32 +-
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts              |  12 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                             |  34 +-
 arch/arm/boot/dts/sun5i.dtsi                                  |   1 +-
 drivers/clk/clk-divider.c                                     |  18 +-
 drivers/clk/hisilicon/clkdivider-hi6220.c                     |   5 +-
 drivers/clk/meson/clk-cpu.c                                   |   5 +-
 drivers/clk/nxp/clk-lpc32xx.c                                 |   5 +-
 drivers/clk/qcom/clk-alpha-pll.c                              |   5 +-
 drivers/clk/qcom/clk-regmap-divider.c                         |   3 +-
 drivers/clk/sunxi-ng/ccu-sun5i.h                              |   6 +-
 drivers/clk/sunxi-ng/ccu_div.c                                |  28 +-
 drivers/clk/sunxi-ng/ccu_mp.c                                 |   7 +-
 drivers/clk/sunxi-ng/ccu_mult.c                               |  11 +-
 drivers/clk/sunxi-ng/ccu_mux.c                                |  22 +-
 drivers/clk/sunxi-ng/ccu_mux.h                                |   3 +-
 drivers/clk/sunxi-ng/ccu_nkm.c                                |   7 +-
 drivers/gpu/drm/sun4i/Makefile                                |   5 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi.h                            | 124 ++-
 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c                    | 128 ++-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c                        | 449 +++++++-
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c                   | 236 ++++-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                             |   2 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                            |  25 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h                            |   4 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c                              |   2 +-
 drivers/rtc/rtc-ac100.c                                       |   6 +-
 include/dt-bindings/clock/sun5i-ccu.h                         |   3 +-
 include/linux/clk-provider.h                                  |   5 +-
 29 files changed, 1103 insertions(+), 90 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c

base-commit: d1bee31b9da7222c6be3248d1f3b087e8cc9004c
-- 
git-series 0.8.11
