From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 May 2016 14:47:00 +0200
Subject: [PATCH 00/20] drm: Add Support for Passive RGB to VGA bridges
Message-ID: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This serie is about adding support for the RGB to VGA bridge found in
the A13-Olinuxino and the CHIP VGA adapter.

Both these boards rely on an entirely passive bridge made out of
resitor ladders that do not require any initialisation. The only thing
needed is to get the timings from the screen if available (and if not,
fall back on XGA standards), set up the display pipeline to output on
the RGB bus with the proper timings, and you're done.

This serie also fixes a bunch of bugs uncovered when trying to
increase the resolution, and hence the pixel clock, of our
pipeline. It also fixes a few bugs in the DRM driver itself that went
unnoticed before.

Let me know what you think,
Maxime

Maxime Ripard (20):
  clk: fixed-factor: Pass clk rates change to the parent
  clk: multiplier: Prevent the multiplier from under / over flowing
  clk: sunxi: tcon-ch1: Do not return a negative error in get_parent
  clk: sunxi: display: Add per-clock flags
  drm/sun4i: request exact rates to our parents
  drm/sun4i: allow dclk to modify its parent rate
  drm/sun4i: rgb: Validate the clock rate
  drm/sun4i: rgb: panel is an error pointer
  drm/sun4i: defer only if we didn't find our panel
  drm/sun4i: remove simplefb at probe
  drm/sun4i: Convert to connector register helpers
  drm/sun4i: Add bridge support
  drm/bridge: Add RGB to VGA bridge support
  ARM: sun5i: a13: Add LCD pins
  ARM: sun5i: Move display blocks to A13
  ARM: sun5i: a13-olinuxino: Enable VGA bridge
  ARM: multi_v7: Enable sun4i DRM driver
  ARM: multi_v7: enable VGA bridge
  ARM: sunxi: Enable sun4i DRM driver
  ARM: sunxi: Enable VGA bridge

 .../bindings/display/bridge/dumb-vga.txt           |  40 +++++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |  34 ++++
 arch/arm/boot/dts/sun5i-a13.dtsi                   | 122 ++++++++++++++
 arch/arm/boot/dts/sun5i-r8.dtsi                    | 120 +------------
 arch/arm/configs/multi_v7_defconfig                |   2 +
 arch/arm/configs/sunxi_defconfig                   |   3 +
 drivers/clk/clk-fixed-factor.c                     |   3 +-
 drivers/clk/clk-multiplier.c                       |  20 ++-
 drivers/clk/sunxi/clk-sun4i-display.c              |   5 +-
 drivers/clk/sunxi/clk-sun4i-tcon-ch1.c             |   3 -
 drivers/gpu/drm/bridge/Kconfig                     |   6 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/dumb-vga.c                  | 186 +++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_dotclock.c             |  31 +++-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |  54 +++---
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |  70 ++++++--
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  59 +++++--
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |   1 +
 18 files changed, 578 insertions(+), 182 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/dumb-vga.txt
 create mode 100644 drivers/gpu/drm/bridge/dumb-vga.c

-- 
2.8.2
