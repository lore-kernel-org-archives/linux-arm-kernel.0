From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun,  2 Sep 2018 09:26:16 +0200
Subject: [PATCH 00/27] Allwinner H6 DE3 and HDMI support
Message-ID: <20180902072643.4917-1-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for Display Engine 3.0 and HDMI 2.0a, which
can be found on H6 SoC.

Display Engine 3.0 in comparison to 2.0 mostly adds features needed for
displaying and processing 10-bit and AFBC formats, which are not yet
supported by this series.

This series is based on linux-next at next-20180828, which has working
R40 display pipeline support. I'll rebase series on later linux-next, if
needed, once R40 display pipeline support is reintroduced.

I suggest all patches go through allwinner tree, except DRM patches,
which should go through drm-misc tree.

Last detail, PineH64 model A schematic has DDC_EN signal, which enables
DDC voltage level shifter. TL Lim, PINE64 founder, said that this
signal is not actually present on PineH64 model A board. It is, however
present on PineH64 model B engineering samples, but it will be removed
in production version. Because of that, I didn't include any code for
it.

Please take a look.

Best regards,
Jernej

Icenowy Zheng (7):
  dt-bindings: sunxi-sram: add binding for Allwinner H6 SRAM C
  arm64: allwinner: h6: add system controller device tree node
  dt-bindings: bus: add H6 DE3 bus binding
  dt-bindings: display: sunxi: add DT binding for Allwinner H6 DW HDMI
  drm: sun4i: add quirks for TCON TOP
  dt-bindings: display: sun4i-drm: document H6 TCON TOP
  drm: sun4i: add support for H6 TCON TOP

Jernej Skrabec (20):
  clk: sunxi-ng: Adjust MP clock parent rate when allowed
  clk: sunxi-ng: Use u64 for calculation of NM rate
  clk: sunxi-ng: h6: Set video PLLs limits
  dt-bindings: clock: sun8i-de2: Add H6 DE3 clock description
  clk: sunxi-ng: Add support for H6 DE3 clocks
  dt-bindings: display: sun4i-drm: Add H6 display engine compatibles
  drm/sun4i: Add compatible for H6 display engine
  drm/sun4i: Rework DE2 register defines
  drm/sun4i: Add basic support for DE3
  drm/sun4i: Add support for H6 DE3 mixer 0
  drm/bridge/synopsys: dw-hdmi: Enable workaround for v2.12a
  drm/sun4i: Not all DW HDMI controllers has scrambled addresses
  drm/sun4i: dw-hdmi: Make mode_valid function configurable
  drm/sun4i: dw-hdmi: Add quirk for setting TMDS clock
  drm/sun4i: Add support for H6 DW HDMI controller
  drm/sun4i: Add support for Synopsys HDMI PHY
  drm/sun4i: Add support for H6 HDMI PHY
  drm/sun4i: Initialize registers in tcon-top driver
  arm64: dts: sun50i: h6: Add HDMI pipeline
  arm64: dts: sun50i: h6: Enable HDMI output on Pine H64 board

 .../bindings/bus/sun50i-de2-bus.txt           |   9 +-
 .../devicetree/bindings/clock/sun8i-de2.txt   |   5 +-
 .../bindings/display/sunxi/sun4i-drm.txt      |  30 ++-
 .../devicetree/bindings/sram/sunxi-sram.txt   |   4 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  25 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 224 ++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c          |   4 +
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c          |  65 +++++
 drivers/clk/sunxi-ng/ccu-sun8i-de2.h          |   1 +
 drivers/clk/sunxi-ng/ccu_mp.c                 |  64 ++++-
 drivers/clk/sunxi-ng/ccu_nm.c                 |  18 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |   1 +
 drivers/gpu/drm/sun4i/sun4i_drv.c             |   1 +
 drivers/gpu/drm/sun4i/sun8i_csc.c             |  96 +++++++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c         |  45 +++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h         |  14 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c        | 178 +++++++++++++-
 drivers/gpu/drm/sun4i/sun8i_mixer.c           |  44 +++-
 drivers/gpu/drm/sun4i/sun8i_mixer.h           |  61 +++--
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c        |  58 ++++-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c        |  47 ++--
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h        |  37 +--
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c       |  45 ++--
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.h       |  28 +--
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c        |  55 +++--
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h        |  25 +-
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c       |  85 +++++--
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h       |  68 ++++--
 include/dt-bindings/clock/sun8i-de2.h         |   3 +
 include/dt-bindings/reset/sun8i-de2.h         |   1 +
 30 files changed, 1127 insertions(+), 214 deletions(-)

-- 
2.18.0
