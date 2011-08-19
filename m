From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 19 Aug 2011 11:53:39 +0200
Subject: [PATCH 0/4 v4] pin controller subsystem v4
Message-ID: <1313747619-32222-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This is the fourth iteration of the pin controller subsystem, most
changes are described in the first patch, copied here for reference:

ChangeLog v3->v4:
- Define a number space per controller instead of globally,
  Stephen and Grant requested the same thing so now maps need to
  define target controller, and the radix tree of pin descriptors
  is a property on each pin controller device.

- Add a compulsory pinctrl device entry to the pinctrl mapping
  table. This must match the pinctrl device, like "pinctrl.0"

- Split the file core.c in two: core.c and pinmux.c where the
  latter carry all pinmux stuff, the core is for generic pin
  control, and use local headers to access functionality between
  files. It is now possible to implement a "blank" pin controller
  without pinmux capabilities. This split will make new additions
  like pindrive.c, pinbias.c etc possible for combined drivers
  and chunks of functionality which is a GoodThing(TM).

- Rewrite the interaction with the GPIO subsystem - the pin
  controller descriptor now handles this by defining an offset
  into the GPIO numberspace for its handled pin range. This is
  used to look up the apropriate pin controller for a GPIO pin.
  Then that specific GPIO range is matched 1-1 for the target
  controller instance.

- Fixed a number of review comments from Joe Perches.

- Broke out a header file pinctrl.h for the core pin handling
  stuff that will be reused by other stuff than pinmux.

- Fixed some erroneous EXPORT() stuff.

- Remove mispatched U300 Kconfig and Makefile entries

- Fixed a number of review comments from Stephen Warren, not all
  of them - still WIP. But I think the new mapping that will
  specify which function goes to which pin mux controller address
  50% of your concerns (else beat me up).

Linus Walleij (4):
  drivers: create a pinmux subsystem v4
  pinmux: add a driver for the U300 pinmux
  amba: request muxing for PrimeCell devices
  mach-u300: activate pinmux driver, delete old padmux driver

 Documentation/ABI/testing/sysfs-class-pinmux |   11 +
 Documentation/pinctrl.txt                    |  512 +++++++++++++++++++
 MAINTAINERS                                  |    5 +
 arch/arm/mach-u300/Kconfig                   |    2 +
 arch/arm/mach-u300/Makefile                  |    2 +-
 arch/arm/mach-u300/core.c                    |   31 ++-
 arch/arm/mach-u300/include/mach/syscon.h     |  136 -----
 arch/arm/mach-u300/mmc.c                     |   16 -
 arch/arm/mach-u300/padmux.c                  |  367 --------------
 arch/arm/mach-u300/padmux.h                  |   39 --
 arch/arm/mach-u300/spi.c                     |   20 -
 drivers/Kconfig                              |    4 +
 drivers/Makefile                             |    2 +
 drivers/amba/bus.c                           |   49 ++-
 drivers/pinctrl/Kconfig                      |   36 ++
 drivers/pinctrl/Makefile                     |    7 +
 drivers/pinctrl/core.c                       |  437 ++++++++++++++++
 drivers/pinctrl/core.h                       |   22 +
 drivers/pinctrl/pinmux-u300.c                |  421 ++++++++++++++++
 drivers/pinctrl/pinmux-u300.h                |  141 ++++++
 drivers/pinctrl/pinmux.c                     |  700 ++++++++++++++++++++++++++
 drivers/pinctrl/pinmux.h                     |    4 +
 include/linux/amba/bus.h                     |    2 +
 include/linux/pinctrl/machine.h              |   62 +++
 include/linux/pinctrl/pinctrl.h              |  120 +++++
 include/linux/pinctrl/pinmux.h               |  122 +++++
 26 files changed, 2687 insertions(+), 583 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-pinmux
 create mode 100644 Documentation/pinctrl.txt
 delete mode 100644 arch/arm/mach-u300/padmux.c
 delete mode 100644 arch/arm/mach-u300/padmux.h
 create mode 100644 drivers/pinctrl/Kconfig
 create mode 100644 drivers/pinctrl/Makefile
 create mode 100644 drivers/pinctrl/core.c
 create mode 100644 drivers/pinctrl/core.h
 create mode 100644 drivers/pinctrl/pinmux-u300.c
 create mode 100644 drivers/pinctrl/pinmux-u300.h
 create mode 100644 drivers/pinctrl/pinmux.c
 create mode 100644 drivers/pinctrl/pinmux.h
 create mode 100644 include/linux/pinctrl/machine.h
 create mode 100644 include/linux/pinctrl/pinctrl.h
 create mode 100644 include/linux/pinctrl/pinmux.h

-- 
1.7.3.2
