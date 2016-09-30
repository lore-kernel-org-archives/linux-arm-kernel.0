From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Sep 2016 14:13:47 +0200
Subject: [PATCH v4 0/5] drm: Add Support for Passive RGB to VGA bridges
Message-ID: <20160930121352.30184-1-maxime.ripard@free-electrons.com>
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

Changes from v3:
  - Depends on OF in Kconfig
  - Fixed typos in the driver comments
  - Removed the mention of a "passive" bridge in the bindings doc
  - Made the strcuture const
  - Removed the nops and best_encoders implementations
  - Removed the call to drm_bridge_enable in the sun4i driver

Changes from v2:
  - Changed the compatible as suggested
  - Rebased on top 4.8

Changes from v1:
  - Switch to using a vga-connector
  - Use drm_encoder bridge pointer instead of doing our own
  - Report the connector status as unknown instead of connected by
    default, and as connected only if we can retrieve the EDID.
  - Switch to of_i2c_get_adapter by node, and put the reference when done
  - Rebased on linux-next	      

Maxime Ripard (5):
  drm/sun4i: rgb: Remove the bridge enable/disable functions
  drm/bridge: Add RGB to VGA bridge support
  ARM: sun5i: a13-olinuxino: Enable VGA bridge
  ARM: multi_v7: enable VGA bridge
  ARM: sunxi: Enable VGA bridge

 .../bindings/display/bridge/rgb-to-vga-bridge.txt  |  48 +++++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |  54 +++++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm/configs/sunxi_defconfig                   |   1 +
 drivers/gpu/drm/bridge/Kconfig                     |   7 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/rgb-to-vga.c                | 239 +++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |   6 -
 8 files changed, 351 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/rgb-to-vga-bridge.txt
 create mode 100644 drivers/gpu/drm/bridge/rgb-to-vga.c

-- 
2.9.3
