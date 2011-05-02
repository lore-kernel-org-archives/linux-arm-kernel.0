From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 2 May 2011 21:16:08 +0200
Subject: [PATCH 0/4] Pinmux subsystem
Message-ID: <1304363768-30338-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This patchset creates a pinmux subsystem and switches U300 to use that new
subsystem as an example. The problem is not that fantastically hard to
solve in a general way, nobody got around to it because it requires some
upfront code I believe, and this is my stab at it.

For details about what pinmuxing is see the Documentation/pinmux.txt file
in the patchset.

The problem is not ARM specific at all, I haven't looked around deeply but I
expect the same type of hacks to exist in most embedded hardware.

This patchset goes on top of my previous gpio consolidation patches that
bring the U300 GPIO driver into drivers/gpio.

If there is nothing fundamentally insane about the design I will likely
attempt to optimistically push it for 2.6.40 as part of the ARM depopulation
work.

Linus Walleij (4):
  drivers: create a pinmux subsystem
  pinmux: add a driver for the U300 pinmux
  amba: request muxing for PrimeCell devices
  pinmux: activate pinmux driver, delete old padmux driver

 Documentation/ABI/testing/sysfs-class-pinmux |   11 +
 Documentation/pinmux.txt                     |  306 +++++++++++
 MAINTAINERS                                  |    5 +
 arch/arm/mach-u300/Kconfig                   |    2 +
 arch/arm/mach-u300/Makefile                  |    2 +-
 arch/arm/mach-u300/core.c                    |   30 +-
 arch/arm/mach-u300/include/mach/pinmux.h     |    2 +
 arch/arm/mach-u300/include/mach/syscon.h     |  136 -----
 arch/arm/mach-u300/mmc.c                     |   16 -
 arch/arm/mach-u300/padmux.c                  |  367 -------------
 arch/arm/mach-u300/padmux.h                  |   39 --
 arch/arm/mach-u300/spi.c                     |   20 -
 drivers/Kconfig                              |    4 +
 drivers/Makefile                             |    2 +
 drivers/amba/bus.c                           |   49 ++-
 drivers/pinmux/Kconfig                       |   32 ++
 drivers/pinmux/Makefile                      |    6 +
 drivers/pinmux/core.c                        |  732 ++++++++++++++++++++++++++
 drivers/pinmux/pinmux-u300.c                 |  361 +++++++++++++
 drivers/pinmux/pinmux-u300.h                 |  141 +++++
 include/linux/amba/bus.h                     |    2 +
 include/linux/pinmux.h                       |  217 ++++++++
 22 files changed, 1899 insertions(+), 583 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-pinmux
 create mode 100644 Documentation/pinmux.txt
 create mode 100644 arch/arm/mach-u300/include/mach/pinmux.h
 delete mode 100644 arch/arm/mach-u300/padmux.c
 delete mode 100644 arch/arm/mach-u300/padmux.h
 create mode 100644 drivers/pinmux/Kconfig
 create mode 100644 drivers/pinmux/Makefile
 create mode 100644 drivers/pinmux/core.c
 create mode 100644 drivers/pinmux/pinmux-u300.c
 create mode 100644 drivers/pinmux/pinmux-u300.h
 create mode 100644 include/linux/pinmux.h

-- 
1.7.3.2
