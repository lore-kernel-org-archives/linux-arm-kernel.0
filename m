From: eric@anholt.net (Eric Anholt)
Date: Wed, 14 Dec 2016 11:46:10 -0800
Subject: [PATCH 00/11] drm/vc4: DSI panel support + Raspberry Pi touchscreen
Message-ID: <20161214194621.16499-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After 9 months of development, I finally got the DSI panel to light up
from poweron, and this is the series for enabling it.  I've included
the whole thing Cced to all the subsystems, as there are some
interesting choices we have to make (how the analog PHY clocks are
represented in common clocks? and how the touchscreen panel is
represented in DT).

There's one commit left out of the series, which is the fix to allow
bcm2835_dma.c's poll-for-completion from IRQ handlers for the DSI1
register write workaround.  However, with the panel's DSI transaction
workaround, we're not triggering our IRQ handler anyway.

Note that patch #11 is not intended to be pushed, it's just a demo.

Eric Anholt (11):
  clk: bcm2835: Don't rate change PLLs on behalf of DSI PLL dividers.
  clk: bcm2835: Register the DSI0/DSI1 pixel clocks.
  clk: bcm2835: Add leaf clock measurement support, disabled by default
  drm/vc4: Set up SCALER_DISPCTRL at boot.
  drm/vc4: Add support for feeding DSI encoders from the pixel valve.
  dt-bindings: Document the VC4 DSI module nodes.
  drm/vc4: Add DSI driver
  dt-bindings: Document the Raspberry Pi Touchscreen nodes.
  drm/panel: Add support for the Raspberry Pi 7" Touchscreen.
  ARM: bcm2835: dt: Add the DSI module nodes and clocks.
  ARM: bcm2835: Enable the Raspberry Pi touchscreen panel.

 .../bindings/clock/brcm,bcm2835-cprman.txt         |   15 +-
 .../devicetree/bindings/display/brcm,bcm-vc4.txt   |   35 +
 .../display/panel/raspberrypi,touchscreen.txt      |   45 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |    8 +
 arch/arm/boot/dts/bcm283x.dtsi                     |   77 +-
 drivers/clk/bcm/clk-bcm2835.c                      |  302 +++-
 drivers/gpu/drm/panel/Kconfig                      |    8 +
 drivers/gpu/drm/panel/Makefile                     |    1 +
 .../gpu/drm/panel/panel-raspberrypi-touchscreen.c  |  509 ++++++
 drivers/gpu/drm/vc4/Kconfig                        |    2 +
 drivers/gpu/drm/vc4/Makefile                       |    1 +
 drivers/gpu/drm/vc4/vc4_crtc.c                     |   33 +-
 drivers/gpu/drm/vc4/vc4_debugfs.c                  |    1 +
 drivers/gpu/drm/vc4/vc4_drv.c                      |    1 +
 drivers/gpu/drm/vc4/vc4_drv.h                      |    5 +
 drivers/gpu/drm/vc4/vc4_dsi.c                      | 1725 ++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_hvs.c                      |   14 +
 drivers/gpu/drm/vc4/vc4_regs.h                     |    5 +
 include/dt-bindings/clock/bcm2835.h                |    2 +
 19 files changed, 2722 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raspberrypi,touchscreen.txt
 create mode 100644 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
 create mode 100644 drivers/gpu/drm/vc4/vc4_dsi.c

-- 
2.11.0
