From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 23 Jun 2011 14:11:52 +0200
Subject: [PATCH 0/4] Nomadik GPIO patches for 3.1, round 1
Message-ID: <1308831112-10250-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This is the pending Nomadik GPIO patches up until I start to muck
around with the generic configuration mechanism, it'd be nice to
get this into the GPIO tree as a base.

[1/4] moves the header file out of <plat/*> and into
<linux/gpio/nomadik.h> which is necessary for single kernel
support across multiple platforms, I don't know how many plats
would collide in <plat/gpio.h> if we don't do this. It's
the first of its kind and create this namespace so I
hope you like it.

[2/4] mainly mess with GPIO-related pinconfig, and need to
go through the GPIO or ux500 tree until we have a pinmux
subsystem. If you don't like it, I can take it into
the ux500 tree. (The rest apply cleanly anyway.)

[3/4] and [4/4] are straightforward improvements.

I expect to send another patch set for the generic config
mechanism once we have decided on a solution for that.

Fredrik Svensson (1):
  gpio/nomadik: remove pull-pinconfig and add SPI2

Linus Walleij (2):
  gpio/nomadik: move the Nomadik GPIO header
  gpio/nomadik: use genirq core to track enablement

Rabin Vincent (1):
  gpio/nomadik: disable clocks when unused

 arch/arm/mach-nomadik/board-nhk8815.c       |    1 +
 arch/arm/mach-nomadik/cpu-8815.c            |    1 +
 arch/arm/mach-nomadik/i2c-8815nhk.c         |    2 +-
 arch/arm/mach-nomadik/include/mach/gpio.h   |    8 ++-
 arch/arm/mach-ux500/board-mop500-pins.c     |    2 +-
 arch/arm/mach-ux500/board-mop500-sdi.c      |    1 +
 arch/arm/mach-ux500/board-u5500-sdi.c       |    2 +-
 arch/arm/mach-ux500/cpu-db5500.c            |    3 +-
 arch/arm/mach-ux500/cpu-db8500.c            |    5 +-
 arch/arm/mach-ux500/devices-common.c        |    3 +-
 arch/arm/mach-ux500/include/mach/gpio.h     |    8 ++-
 arch/arm/mach-ux500/pins-db8500.h           |  142 ++++++++++++++-------------
 arch/arm/plat-nomadik/include/plat/gpio.h   |   96 ------------------
 arch/arm/plat-nomadik/include/plat/pincfg.h |    5 -
 drivers/gpio/gpio-nomadik.c                 |  129 +++++++++++++++++++++---
 include/linux/gpio/nomadik.h                |   87 ++++++++++++++++
 16 files changed, 300 insertions(+), 195 deletions(-)
 delete mode 100644 arch/arm/plat-nomadik/include/plat/gpio.h
 create mode 100644 include/linux/gpio/nomadik.h

-- 
1.7.3.2
