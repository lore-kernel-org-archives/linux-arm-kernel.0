From: david@lechnology.com (David Lechner)
Date: Thu,  3 Aug 2017 17:33:44 -0500
Subject: [PATCH v3 0/6] Support for LEGO MINDSTORMS EV3 LCD display
Message-ID: <1501799630-1650-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The goal of this series is to get the built-in LCD of the LEGO MINDSTORMS EV3
working.

v2 changes:
* Wrote a new driver for ST7586 instead of combining it with existing drivers
* Don't touch MIPI DBI code (other than the patch suggested by Noralf)
* New defconfig patch

v3 changes:
* New patch to generalize tinydrm_xrgb8888_to_gray8() so that it can be reused.
* Device tree bindings in separate patch.
* Fixed incorrect device tree binding pin descriptions.
* Added MAINTAINERS entry for drivers/gpu/drm/tinydrm/st7586.c.
* Removed "mipi_dbi_" from function names in st7586.c.
* Moved init and fini to pipe_enable and pipe_disable ops.
* Dropped RGB565 format.
* Made adjustments for the fact the controller cannot be read via SPI.
* Dropped st7586.h - values moved into st7586.c.

David Lechner (6):
  drm/tinydrm: remove call to mipi_dbi_init() from mipi_dbi_spi_init()
  drm/tinydrm: generalize tinydrm_xrgb8888_to_gray8()
  dt-bindings: add binding for Sitronix ST7586 display panels
  drm/tinydrm: add support for LEGO MINDSTORMS EV3 LCD
  ARM: dts: da850-lego-ev3: Add node for LCD display
  ARM: davinci_all_defconfig: enable tinydrm and ST7586

 .../bindings/display/sitronix,st7586.txt           |  26 ++
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/da850-lego-ev3.dts               |  24 ++
 arch/arm/configs/davinci_all_defconfig             |   2 +
 drivers/gpu/drm/tinydrm/Kconfig                    |  10 +
 drivers/gpu/drm/tinydrm/Makefile                   |   1 +
 drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c     |  35 +-
 drivers/gpu/drm/tinydrm/mi0283qt.c                 |   8 +-
 drivers/gpu/drm/tinydrm/mipi-dbi.c                 |  17 +-
 drivers/gpu/drm/tinydrm/repaper.c                  |  21 +-
 drivers/gpu/drm/tinydrm/st7586.c                   | 466 +++++++++++++++++++++
 include/drm/tinydrm/mipi-dbi.h                     |   6 +-
 include/drm/tinydrm/tinydrm-helpers.h              |   3 +-
 13 files changed, 582 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/sitronix,st7586.txt
 create mode 100644 drivers/gpu/drm/tinydrm/st7586.c

-- 
2.7.4
