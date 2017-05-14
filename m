From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 15 May 2017 00:30:32 +0800
Subject: [PATCH v7 00/13] Initial Allwinner Display Engine 2.0 Support
Message-ID: <20170514163045.40366-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is the initial patchset for Allwinner DE2 support.

It contains the support of clocks in DE2 and the mixers in DE2.

The SoC used to develop this patchset is V3s, as V3s is the simplest
one of the SoCs that have DE2.

(Allwinner V3s features only one mixer, and its only video output is
RGB LCD, which is already supported in our TCON driver)

The last patch is only a testing patch, it shouldn't be merged; and
for the patch to be really usable, the RFC fix of the TCON driver [1]
is needed.

No HDMI, TV encoder or other internal bridges' support is included
in this patchset, which makes it currently not usable on H3. (For TVE
I have some code that made it working; for HDMI there is a driver by
Jernej Skrabec which is based on the dw-hdmi common code.)

Thanks to Jean-Francois Moine and Jernej Skrabec for their efforts
to discover the internal of DE2!

[1] https://lists.freedesktop.org/archives/dri-devel/2016-December/126264.html

Icenowy Zheng (13):
  dt-bindings: add binding for the Allwinner DE2 CCU
  clk: sunxi-ng: add support for DE2 CCU
  dt-bindings: add bindings for DE2 on V3s SoC
  drm/sun4i: return only planes for layers created
  drm/sun4i: abstract a engine type
  drm/sun4i: add a dedicated module for sun4i-backend and sun4i-layer
  drm/sun4i: add a Kconfig option for sun4i-backend
  drm/sun4i: add support for Allwinner DE2 mixers
  drm/sun4i: Add compatible string for V3s display engine
  drm/sun4i: tcon: add support for V3s TCON
  ARM: sun8i: v3s: add device nodes for DE2 display pipeline
  ARM: sun8i: v3s: add pinmux for LCD pins of V3s SoC
  [DO NOT MERGE] ARM: sun8i: v3s: enable LCD panel of Lichee Pi Zero

 .../devicetree/bindings/clock/sun8i-de2.txt        |  31 ++
 .../bindings/display/sunxi/sun4i-drm.txt           |  26 +-
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts      |  36 ++
 arch/arm/boot/dts/sun8i-v3s.dtsi                   |  96 +++++
 drivers/clk/sunxi-ng/Kconfig                       |   5 +
 drivers/clk/sunxi-ng/Makefile                      |   1 +
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c               | 260 +++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-de2.h               |  28 ++
 drivers/gpu/drm/sun4i/Kconfig                      |  20 +
 drivers/gpu/drm/sun4i/Makefile                     |   9 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c              |  72 ++--
 drivers/gpu/drm/sun4i/sun4i_backend.h              |  17 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 |  32 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.h                 |   5 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |   6 +-
 drivers/gpu/drm/sun4i/sun4i_drv.h                  |   2 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c                |  21 +-
 drivers/gpu/drm/sun4i/sun4i_layer.h                |   6 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  43 ++-
 drivers/gpu/drm/sun4i/sun4i_tv.c                   |   9 +-
 drivers/gpu/drm/sun4i/sun8i_layer.c                | 134 +++++++
 drivers/gpu/drm/sun4i/sun8i_layer.h                |  36 ++
 drivers/gpu/drm/sun4i/sun8i_mixer.c                | 412 +++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.h                | 137 +++++++
 drivers/gpu/drm/sun4i/sunxi_engine.h               | 111 ++++++
 include/dt-bindings/clock/sun8i-de2.h              |  18 +
 include/dt-bindings/reset/sun8i-de2.h              |  14 +
 27 files changed, 1485 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/sun8i-de2.txt
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-de2.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-de2.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_layer.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_layer.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_mixer.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_mixer.h
 create mode 100644 drivers/gpu/drm/sun4i/sunxi_engine.h
 create mode 100644 include/dt-bindings/clock/sun8i-de2.h
 create mode 100644 include/dt-bindings/reset/sun8i-de2.h

-- 
2.12.2
