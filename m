From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 24 Nov 2010 22:20:10 +0100
Subject: I2C support for Sodaville
Message-ID: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C core inside Sodaville is very much the same as in PXA25x.
I Cc the ARM folks because patch 2 reorganizes some files so that they
can be accessed from x86.
The I2C device is behind a PCI bus. The PCI probe code simply creates
three platform devices so we don't have much changes to the platform
driver. There is no clock framework on x86 and the peripherals don't
support changing their clocks or to enable/disable them. So I provided
dummy function which keep the driver happy.
This series indirectly depends on the SPI series I've sent earlier
because both modify include files and the spi & i2c includes are sometimes
too close to each other.

The patch series has been created with the -M option so file moves can
be easily noticed. The whole series (including spi) is also available at
  git://git.linutronix.de/users/bigeasy/soda.git spi-i2c

Sebastian Andrzej Siewior (7):
      i2c/pxa2xx: Don't touch ISAR if not in slave mode
      arm/pxa2xx: reorganize I2C files
      i2c/pxa2xx: Add PCI support for PXA I2C controller
      i2c/pxa2xx: add support for shared IRQ handler
      i2c/pxa2xx: check timeout correctly
      i2c/pxa2xx: reset the chip if the bus is not free
      i2c/pxa2xx: pass of_node from platform driver to adapter

 arch/arm/include/asm/pxa_i2c.h                     |   19 +++
 arch/arm/mach-mmp/include/mach/mmp2.h              |    2 +-
 arch/arm/mach-mmp/include/mach/pxa168.h            |    2 +-
 arch/arm/mach-mmp/include/mach/pxa910.h            |    2 +-
 arch/arm/mach-pxa/balloon3.c                       |    3 +-
 arch/arm/mach-pxa/cm-x300.c                        |    2 +-
 arch/arm/mach-pxa/colibri-pxa270-income.c          |    3 +-
 arch/arm/mach-pxa/corgi.c                          |    2 +-
 arch/arm/mach-pxa/csb726.c                         |    2 +-
 arch/arm/mach-pxa/devices.c                        |    2 +-
 arch/arm/mach-pxa/em-x270.c                        |    2 +-
 arch/arm/mach-pxa/ezx.c                            |    2 +-
 arch/arm/mach-pxa/hx4700.c                         |    2 +-
 arch/arm/mach-pxa/littleton.c                      |    2 +-
 arch/arm/mach-pxa/magician.c                       |    2 +-
 arch/arm/mach-pxa/mainstone.c                      |    2 +-
 arch/arm/mach-pxa/mioa701.c                        |    2 +-
 arch/arm/mach-pxa/mxm8x10.c                        |    2 +-
 arch/arm/mach-pxa/palm27x.c                        |    3 +-
 arch/arm/mach-pxa/pcm990-baseboard.c               |    2 +-
 arch/arm/mach-pxa/poodle.c                         |    2 +-
 arch/arm/mach-pxa/pxa27x.c                         |    2 +-
 arch/arm/mach-pxa/pxa3xx.c                         |    2 +-
 arch/arm/mach-pxa/raumfeld.c                       |    2 +-
 arch/arm/mach-pxa/saar.c                           |    2 +-
 arch/arm/mach-pxa/spitz.c                          |    3 +-
 arch/arm/mach-pxa/stargate2.c                      |    2 +-
 arch/arm/mach-pxa/tavorevb3.c                      |    3 +-
 arch/arm/mach-pxa/tosa.c                           |    2 +-
 arch/arm/mach-pxa/trizeps4.c                       |    2 +-
 arch/arm/mach-pxa/viper.c                          |    2 +-
 arch/arm/mach-pxa/vpac270.c                        |    3 +-
 arch/arm/mach-pxa/xcep.c                           |    3 +-
 arch/arm/mach-pxa/z2.c                             |    3 +-
 arch/arm/mach-pxa/zeus.c                           |    3 +-
 arch/arm/mach-pxa/zylonite_pxa300.c                |    2 +-
 arch/x86/include/asm/pxa_i2c.h                     |   24 +++
 drivers/i2c/busses/Kconfig                         |    7 +-
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-pxa-pci.c                   |  160 ++++++++++++++++++++
 drivers/i2c/busses/i2c-pxa.c                       |   70 +++++----
 .../plat/i2c.h => include/linux/i2c/pxa-i2c.h      |    1 +
 42 files changed, 282 insertions(+), 79 deletions(-)
 create mode 100644 arch/arm/include/asm/pxa_i2c.h
 create mode 100644 arch/x86/include/asm/pxa_i2c.h
 create mode 100644 drivers/i2c/busses/i2c-pxa-pci.c
 rename arch/arm/plat-pxa/include/plat/i2c.h => include/linux/i2c/pxa-i2c.h (99%)

Sebastian
