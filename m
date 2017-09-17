From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Sep 2017 11:38:59 +0200
Subject: [PATCH 0/7] I2C GPIO to use gpiolibs open drain
Message-ID: <20170917093906.16325-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This augments the I2C GPIO driver to use open drain emulation
or hardware support for open drain from the GPIO driver.

This version layers Geert Uytterhoeven's idea to use explicit
sda-gpios and scl-gpios for the GPIO lines, and strongly
encourage the (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN) flags to be
used in all device trees.

We have collected ACKs from the ARM SoC maintainers and the
MFD maintainer and are looking for testers to try this out.

Geert Uytterhoeven (1):
  dt-bindings: i2c: i2c-gpio: Add support for named gpios

Linus Walleij (6):
  i2c: gpio: Convert to use descriptors
  gpio: Make it possible for consumers to enforce open drain
  i2c: gpio: Enforce open drain through gpiolib
  i2c: gpio: Augment all boardfiles to use open drain
  i2c: gpio: Local vars in probe
  i2c: gpio: Add support for named gpios in DT

 Documentation/devicetree/bindings/i2c/i2c-gpio.txt |  32 +++-
 arch/arm/mach-ep93xx/core.c                        |  41 ++--
 arch/arm/mach-ep93xx/edb93xx.c                     |  15 +-
 arch/arm/mach-ep93xx/include/mach/platform.h       |   4 +-
 arch/arm/mach-ep93xx/simone.c                      |  12 +-
 arch/arm/mach-ep93xx/snappercl15.c                 |  12 +-
 arch/arm/mach-ep93xx/vision_ep9307.c               |   7 +-
 arch/arm/mach-ixp4xx/avila-setup.c                 |  17 +-
 arch/arm/mach-ixp4xx/dsmg600-setup.c               |  16 +-
 arch/arm/mach-ixp4xx/fsg-setup.c                   |  16 +-
 arch/arm/mach-ixp4xx/goramo_mlr.c                  |  24 +--
 arch/arm/mach-ixp4xx/ixdp425-setup.c               |  16 +-
 arch/arm/mach-ixp4xx/nas100d-setup.c               |  16 +-
 arch/arm/mach-ixp4xx/nslu2-setup.c                 |  16 +-
 arch/arm/mach-ks8695/board-acs5k.c                 |  15 +-
 arch/arm/mach-pxa/palmz72.c                        |  14 +-
 arch/arm/mach-pxa/viper.c                          |  27 ++-
 arch/arm/mach-sa1100/simpad.c                      |  14 +-
 arch/blackfin/mach-bf533/boards/blackstamp.c       |  19 +-
 arch/blackfin/mach-bf533/boards/ezkit.c            |  18 +-
 arch/blackfin/mach-bf533/boards/stamp.c            |  18 +-
 arch/blackfin/mach-bf561/boards/ezkit.c            |  18 +-
 arch/mips/alchemy/board-gpr.c                      |  23 ++-
 arch/mips/ath79/mach-pb44.c                        |  16 +-
 drivers/gpio/gpiolib.c                             |  13 ++
 drivers/i2c/busses/i2c-gpio.c                      | 213 ++++++++++-----------
 drivers/mfd/sm501.c                                |  49 ++---
 include/linux/gpio/consumer.h                      |   6 +
 include/linux/i2c-gpio.h                           |   4 -
 29 files changed, 423 insertions(+), 288 deletions(-)

-- 
2.13.5
