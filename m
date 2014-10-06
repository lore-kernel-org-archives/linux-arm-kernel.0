From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon,  6 Oct 2014 22:17:10 +0200
Subject: [PATCH 0/5] regulator: Fix core behaviour for gpio 0
Message-ID: <1412626635-7404-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

currently it is not possible to have a gpio enabled regulator that uses gpio 0.
0 is a valid gpio identifier so it has to be supported.

This series tries to fix this issue by adding a regulator_config field
'ena_gpio_valid' which should be true if ena_gpio is a valid gpio identifier.
Otherwise ena_gpio is ignored.

Patch 1 introduces 'ena_gpio_valid'. Patch 2 updates all drivers that set
ena_gpio. Patch 3 changes the regulator core check for ena_gpio.

Patch 4 and 5 are minor changes to regulator drivers unrelated to the gpio-0
issue.

Best regards,

Markus


Markus Pargmann (5):
  regulator: Add ena_gpio_valid config
  regulator: Set ena_gpio_valid in regulator drivers
  regulator: Fix ena_gpio check
  regulator: Use gpio_is_valid
  regulator: Remove unnecessary ena_gpio initializations

 drivers/regulator/arizona-ldo1.c       | 1 +
 drivers/regulator/core.c               | 2 +-
 drivers/regulator/da9055-regulator.c   | 1 +
 drivers/regulator/fixed.c              | 4 +++-
 drivers/regulator/gpio-regulator.c     | 4 +++-
 drivers/regulator/lp8788-ldo.c         | 2 ++
 drivers/regulator/max8952.c            | 1 +
 drivers/regulator/pfuze100-regulator.c | 1 -
 drivers/regulator/s2mps11.c            | 1 +
 drivers/regulator/s5m8767.c            | 3 +--
 drivers/regulator/tps65090-regulator.c | 1 +
 drivers/regulator/wm8994-regulator.c   | 3 ++-
 include/linux/regulator/driver.h       | 3 +++
 13 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.1.0
