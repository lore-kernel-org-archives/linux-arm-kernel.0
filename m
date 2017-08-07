From: david@lechnology.com (David Lechner)
Date: Mon,  7 Aug 2017 12:39:36 -0500
Subject: [PATCH v4 0/5] Support for LEGO MINDSTORMS EV3 LCD display
Message-ID: <1502127581-10517-1-git-send-email-david@lechnology.com>
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

v4 changes:
* Dropped patch "drm/tinydrm: remove call to mipi_dbi_init()
  from mipi_dbi_spi_init()" since it has been applied.
* correct order for MAINTAINERS entry
* Drop code/dt bindings not used by LEGO EV3 (regulator, backlight, etc)
* Make gpios required
* Use lookup table for pixel packing algorithm
* Don't modify clip when used as function parameter
* Rename dc to a0 since that is what is on the datasheet/LEGO schematic.

David Lechner (5):
  drm/tinydrm: Generalize tinydrm_xrgb8888_to_gray8()
  dt-bindings: add binding for Sitronix ST7586 display panels
  drm/tinydrm: add support for LEGO MINDSTORMS EV3 LCD
  ARM: dts: da850-lego-ev3: Add node for LCD display
  ARM: davinci_all_defconfig: enable tinydrm and ST7586

 .../bindings/display/sitronix,st7586.txt           |  22 ++
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/da850-lego-ev3.dts               |  24 ++
 arch/arm/configs/davinci_all_defconfig             |   2 +
 drivers/gpu/drm/tinydrm/Kconfig                    |  10 +
 drivers/gpu/drm/tinydrm/Makefile                   |   1 +
 drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c     |  42 +-
 drivers/gpu/drm/tinydrm/repaper.c                  |  28 +-
 drivers/gpu/drm/tinydrm/st7586.c                   | 428 +++++++++++++++++++++
 include/drm/tinydrm/tinydrm-helpers.h              |   3 +-
 10 files changed, 534 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/sitronix,st7586.txt
 create mode 100644 drivers/gpu/drm/tinydrm/st7586.c

-- 
2.7.4
