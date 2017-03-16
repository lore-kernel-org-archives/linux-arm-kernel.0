From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri, 17 Mar 2017 04:47:40 +0800
Subject: [PATCH v2 0/8] Initial Allwinner Display Engine 2.0 Support
Message-ID: <20170316204748.8596-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is the initial patchset for Allwinner DE2 support.

It contains the support of clocks in DE2 and the mixers in DE2.

The SoC used to develop this patchset is V3s, as V3s is the simplest
one of the SoCs that have DE2.
(Allwinner V3s features only one mixer, although its clock control
unit contains support for second mixer's clock; and its only video
output is RGB LCD, which is already supported in our TCON driver)

The last patch is only a testing patch, it shouldn't be merged; and
for the patch to be really usable, the RFC fix of the TCON driver [1]
is needed.

No HDMI, TV encoder or other internal bridges' support is included
in this patchset, which makes it currently not usable on H3.

Thanks to Jean-Francois Moine and Jernej Skrabec for their efforts
to discover the internal of DE2!

[1] https://lists.freedesktop.org/archives/dri-devel/2016-December/126264.html

Icenowy Zheng (8):
  dt-bindings: add binding for the Allwinner DE2 CCU
  clk: sunxi-ng: add support for DE2 CCU
  dt-bindings: add bindings for DE2 on V3s SoC
  drm/sun4i: add support for sun8i DE2 mixers and display engines
  drm/sun4i: tcon: add support for V3s TCON
  ARM: dts: sun8i: add DE2 nodes for V3s SoC
  ARM: dts: sun8i: add pinmux for LCD pins of V3s SoC
  ARM: dts: sun8i: enable LCD panel of Lichee Pi Zero

 .../devicetree/bindings/clock/sun8i-de2.txt        |  31 ++
 .../bindings/display/sunxi/sun4i-drm.txt           |  37 +-
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts      |  36 ++
 arch/arm/boot/dts/sun8i-v3s.dtsi                   |  96 +++++
 drivers/clk/sunxi-ng/Kconfig                       |   5 +
 drivers/clk/sunxi-ng/Makefile                      |   1 +
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c               | 204 +++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-de2.h               |  28 ++
 drivers/gpu/drm/sun4i/Kconfig                      |   9 +
 drivers/gpu/drm/sun4i/Makefile                     |   3 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 |  14 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.h                 |   2 +
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |   4 +-
 drivers/gpu/drm/sun4i/sun4i_drv.h                  |   1 +
 drivers/gpu/drm/sun4i/sun4i_layer.c                |  94 ++++-
 drivers/gpu/drm/sun4i/sun4i_layer.h                |   3 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |   7 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c                | 385 +++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.h                | 166 +++++++++
 include/dt-bindings/clock/sun8i-de2.h              |  54 +++
 include/dt-bindings/reset/sun8i-de2.h              |  50 +++
 21 files changed, 1203 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/sun8i-de2.txt
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-de2.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-de2.h
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_mixer.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_mixer.h
 create mode 100644 include/dt-bindings/clock/sun8i-de2.h
 create mode 100644 include/dt-bindings/reset/sun8i-de2.h

-- 
2.12.0
