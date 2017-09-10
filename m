From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 10 Sep 2017 23:44:19 +0200
Subject: [PATCH 0/5] I2C GPIO to use gpiolibs open drain
Message-ID: <20170910214424.14945-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I recently looked at this driver when testing the I2C GPIO
on the Gemini platform.

It's one of the archectypical places in the kernel where we
have open coded open drain emulation, also without much
explanation. So I went in and fixed it.

The fix is pretty brutal changing all boards and one MFD
device using this, but I like the end result, making the
code much more readable and skipping the intermediate step
of looping through the old GPIO API.

It would be nice to get some testing and ACKs on this if
people agree.

I imagine Wolfram would use the whole thing into the I2C
tree but I could also carry a branch in GPIO to be merged
through the GPIO tree if it is preferred (like e.g. Wolfram
want me to get the heat for any regressions, hehe).

Linus Walleij (5):
  i2c: gpio: Convert to use descriptors
  gpio: Make it possible for consumers to enforce open drain
  i2c: gpio: Enforce open drain through gpiolib
  i2c: gpio: Augment all boardfiles to use open drain
  i2c: gpio: Local vars in probe

 arch/arm/mach-ep93xx/core.c                  |  41 +++---
 arch/arm/mach-ep93xx/edb93xx.c               |  15 +--
 arch/arm/mach-ep93xx/include/mach/platform.h |   4 +-
 arch/arm/mach-ep93xx/simone.c                |  12 +-
 arch/arm/mach-ep93xx/snappercl15.c           |  12 +-
 arch/arm/mach-ep93xx/vision_ep9307.c         |   7 +-
 arch/arm/mach-ixp4xx/avila-setup.c           |  17 ++-
 arch/arm/mach-ixp4xx/dsmg600-setup.c         |  16 ++-
 arch/arm/mach-ixp4xx/fsg-setup.c             |  16 ++-
 arch/arm/mach-ixp4xx/goramo_mlr.c            |  24 +---
 arch/arm/mach-ixp4xx/ixdp425-setup.c         |  16 ++-
 arch/arm/mach-ixp4xx/nas100d-setup.c         |  16 ++-
 arch/arm/mach-ixp4xx/nslu2-setup.c           |  16 ++-
 arch/arm/mach-ks8695/board-acs5k.c           |  15 ++-
 arch/arm/mach-pxa/palmz72.c                  |  14 +-
 arch/arm/mach-pxa/viper.c                    |  27 +++-
 arch/arm/mach-sa1100/simpad.c                |  14 +-
 arch/blackfin/mach-bf533/boards/blackstamp.c |  19 ++-
 arch/blackfin/mach-bf533/boards/ezkit.c      |  18 ++-
 arch/blackfin/mach-bf533/boards/stamp.c      |  18 ++-
 arch/blackfin/mach-bf561/boards/ezkit.c      |  18 ++-
 arch/mips/alchemy/board-gpr.c                |  23 +++-
 arch/mips/ath79/mach-pb44.c                  |  16 ++-
 drivers/gpio/gpiolib.c                       |  13 ++
 drivers/i2c/busses/i2c-gpio.c                | 184 +++++++++++----------------
 drivers/mfd/sm501.c                          |  49 +++----
 include/linux/gpio/consumer.h                |   6 +
 include/linux/i2c-gpio.h                     |   4 -
 28 files changed, 372 insertions(+), 278 deletions(-)

-- 
2.13.5
