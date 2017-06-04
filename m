From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon,  5 Jun 2017 00:01:38 +0800
Subject: [PATCH v2 00/11] Support for H3 Composite Output support
Message-ID: <20170604160149.30230-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H3 SoC features a TV Encoder like the one in Allwinner A13,
which can only output TV Composite signal.

The display pipeline of H3 is also special -- it has two mixers and
two TCONs, of which the connection can be swapped. The TCONs do not
have channel 0 (as they are all connected to internal bridges, TVE
and HDMI TX).

Add support for the display pipeline and the TVE in H3, in order to
make it possible to display something with mainline kernel with H3.

The image quality of TVE is bad, so HDMI is a better output -- this
patchset also prepared the mixers and TCONs for HDMI output, and
the HDMI controller driver is already done by Jernej Skrabec.

So if possible, please apply PATCH 1~5 and 8,9 as soon as possible,
so that Jernej can submit his HDMI patches.

Currently the jack detection feature of the TVE is still not so
clear -- so it's not implemented in this version. Thus the TV
output shouldn't be defaultly enabled now.

Icenowy Zheng (11):
  dt-bindings: update the binding for Allwinner H3 TVE support
  drm: sun4i: add support for H3 mixers
  drm: sun4i: ignore swapped mixer<->tcon connection for DE2
  drm: sun4i: add support for H3's TCON0/1
  drm: sun4i: add compatible for H3 display engine
  drm: sun4i: add color space correction support for DE2 mixer
  drm: sun4i: add support for the TV encoder in H3 SoC
  clk: sunxi-ng: allow CLK_DE to set CLK_PLL_DE for H3
  clk: sunxi-ng: export CLK_PLL_DE for H3
  ARM: sun8i: h3: add display engine pipeline for TVE
  [DO NOT MERGE] ARM: sun8i: h3: enable TV output on Orange Pi PC

 .../bindings/display/sunxi/sun4i-drm.txt           |  37 +++-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |  12 ++
 arch/arm/boot/dts/sun8i-h3.dtsi                    | 186 +++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |   2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.h                |   3 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |  46 +++++
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 | 113 ++++++++++---
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |   3 +
 drivers/gpu/drm/sun4i/sun4i_tv.c                   |  35 +++-
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |  53 ++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.h                |   6 +-
 include/dt-bindings/clock/sun8i-h3-ccu.h           |   2 +
 12 files changed, 463 insertions(+), 35 deletions(-)

-- 
2.12.2
