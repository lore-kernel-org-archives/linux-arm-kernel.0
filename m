From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  8 May 2018 12:05:40 +0200
Subject: [PATCH v3 0/3] led_trigger_register_format and tty triggers
Message-ID: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

while working on a patch that adds led triggers to drivers/tty (patch 3)
I thought that being able to pass a format string (and the respective
parameters) to led_trigger_register_simple instead of a constant string
would be nice. This is implemented in the first patch. The second patch
converts the can leds to this new function which demonstrates nicely the
added benefit for users. Both patches are new in v3.

The third patch finally implements the triggers for the tty framework.
Compared to v2 I reduced the need for #ifdefs, make use of
led_trigger_register_format() and excluded serdev devices from
triggering as suggested by Johan Hovold.

Also code cleanup in the error case is done now and hopefully the kbuild
test robot is happy now.

Best regards
Uwe

Uwe Kleine-K?nig (3):
  leds: triggers: provide led_trigger_register_format()
  can: simplify LED trigger handling
  tty: implement led triggers

 arch/arm/boot/dts/imx25-logitech-baby.dts | 192 ++++++++++++++++++++++
 drivers/leds/led-triggers.c               |  84 +++++++---
 drivers/net/can/led.c                     |  30 +---
 drivers/tty/Kconfig                       |   7 +
 drivers/tty/tty_buffer.c                  |   2 +
 drivers/tty/tty_io.c                      |   3 +
 drivers/tty/tty_port.c                    |  32 +++-
 include/linux/can/dev.h                   |   3 -
 include/linux/leds.h                      |  30 ++--
 include/linux/tty.h                       |  22 +++
 10 files changed, 341 insertions(+), 64 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx25-logitech-baby.dts

-- 
2.17.0
