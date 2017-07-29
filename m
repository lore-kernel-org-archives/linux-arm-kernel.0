From: david@lechnology.com (David Lechner)
Date: Sat, 29 Jul 2017 14:17:44 -0500
Subject: [PATCH 0/6] Support for LEGO MINDSTORMS EV3 LCD display
Message-ID: <1501355870-13960-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The goal of this series is to get the built-in LCD of the LEGO MINDSTORMS EV3
working. But, most of the content here is building up the infrastructure to do
that.

The controller used in the EV3 uses MIPI commands, but it uses a different
memory layout. The current tinydrm stuff is hard-coded for RGB565, so most
of the patches are adding support for other memory layouts.

I've also made the one existing tinydrm driver generic so that it can work for
any MIPI display rather than copying a bunch of boiler-plate code for each
panel and/or controller.

Once all of this is done, it is really easy to add a new panel. :-)

David Lechner (6):
  drm/tinydrm: Add parameter for MIPI DCS pixel format
  drm/tinydrm: add helpers for ST7586 controllers
  drm/tinydrm: rename mi028qt module to mipi-panel
  drm/tinydrm: mipi-panel: refactor to use driver id
  drm/tinydrm: add support for LEGO MINDSTORMS EV3 LCD
  ARM: dts: da850-lego-ev3: Add node for LCD display

 .../devicetree/bindings/display/mipi-panel.txt     |  27 ++
 .../bindings/display/multi-inno,mi0283qt.txt       |  27 --
 MAINTAINERS                                        |   6 +-
 arch/arm/boot/dts/da850-lego-ev3.dts               |  24 ++
 drivers/gpu/drm/tinydrm/Kconfig                    |  13 +-
 drivers/gpu/drm/tinydrm/Makefile                   |   2 +-
 drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c     | 148 ++++++++
 drivers/gpu/drm/tinydrm/mi0283qt.c                 | 282 ---------------
 drivers/gpu/drm/tinydrm/mipi-dbi.c                 | 117 ++++--
 drivers/gpu/drm/tinydrm/mipi-panel.c               | 395 +++++++++++++++++++++
 include/drm/tinydrm/mipi-dbi.h                     |   9 +-
 include/drm/tinydrm/st7586.h                       |  34 ++
 include/drm/tinydrm/tinydrm-helpers.h              |   6 +
 include/video/mipi_display.h                       |  16 +-
 14 files changed, 759 insertions(+), 347 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/mipi-panel.txt
 delete mode 100644 Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt
 delete mode 100644 drivers/gpu/drm/tinydrm/mi0283qt.c
 create mode 100644 drivers/gpu/drm/tinydrm/mipi-panel.c
 create mode 100644 include/drm/tinydrm/st7586.h

-- 
2.7.4
