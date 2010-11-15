From: cyril@ti.com (Cyril Chemparathy)
Date: Mon, 15 Nov 2010 14:12:02 -0500
Subject: [PATCH v5 00/12] tnetv107x ssp drivers
Message-ID: <1289848334-8695-1-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TI's sequencer serial port (TI-SSP) is a jack-of-all-trades type of serial port
device.  It has a built-in programmable execution engine that can be programmed
to operate as almost any serial bus (I2C, SPI, EasyScale, and others).

This patch series implements a driver stack that looks like the following:

                             +--------+
                             | eeprom | . . .
                             +--------+
   +-----------+             +--------------+ +---------+
   | regulator | . . .       |   i2c-gpio   | | 1-wire  | . . .
   +-----------+             +--------------+ +---------+
   +----------------------+  +--------------------------------+
   |       ssp-spi        |  |           ssp-gpio             |
   +----------------------+  +--------------------------------+
   +----------------------------------------------------------+
   |                            ssp                           |
   +----------------------------------------------------------+

Changes between v5 and v4 of this series:
  - Moved drivers from misc/gpio/spi to mfd
  - Removed implicit init-time iosel setup
  - Minor cleanups in backlight driver

Changes between v3 and v4 of this series:
  - Replaced polled wait for sequence termination with interrupt
  - Improved locking within SSP driver
  - Other minor cleanups

Changes between v2 and v3 of this series:
  - Minor cleanups in Kconfig and Makefile ordering

Changes between v1 and v2 of this series:
  - Replaced open()/close() semantics with dynamic platform_device
    registration on SSP probe.
  - Removed user-land interface to regulator registers
  - More sensible regulator constraints
  - Other minor cleanups

Cyril Chemparathy (12):
  misc: add driver for sequencer serial port
  davinci: add tnetv107x ssp platform device
  davinci: add ssp config for tnetv107x evm board
  spi: add ti-ssp spi master driver
  davinci: add spi devices on tnetv107x evm
  regulator: add driver for tps6524x regulator
  davinci: add tnetv107x evm regulators
  gpio: add ti-ssp gpio driver
  davinci: add tnetv107x evm ti-ssp gpio device
  backlight: add support for tps6116x controller
  davinci: add tnetv107x evm backlight device
  davinci: add tnetv107x evm i2c eeprom device

 arch/arm/mach-davinci/board-tnetv107x-evm.c    |  192 +++++++
 arch/arm/mach-davinci/devices-tnetv107x.c      |   25 +
 arch/arm/mach-davinci/include/mach/tnetv107x.h |    2 +
 arch/arm/mach-davinci/tnetv107x.c              |    2 +-
 drivers/mfd/Kconfig                            |   31 +
 drivers/mfd/Makefile                           |    3 +
 drivers/mfd/ti-ssp-gpio.c                      |  205 +++++++
 drivers/mfd/ti-ssp-spi.c                       |  402 ++++++++++++++
 drivers/mfd/ti-ssp.c                           |  475 ++++++++++++++++
 drivers/regulator/Kconfig                      |   10 +
 drivers/regulator/Makefile                     |    1 +
 drivers/regulator/tps6524x-regulator.c         |  692 ++++++++++++++++++++++++
 drivers/video/backlight/Kconfig                |    7 +
 drivers/video/backlight/Makefile               |    2 +-
 drivers/video/backlight/tps6116x.c             |  339 ++++++++++++
 include/linux/mfd/ti_ssp.h                     |   97 ++++
 16 files changed, 2483 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mfd/ti-ssp-gpio.c
 create mode 100644 drivers/mfd/ti-ssp-spi.c
 create mode 100644 drivers/mfd/ti-ssp.c
 create mode 100644 drivers/regulator/tps6524x-regulator.c
 create mode 100644 drivers/video/backlight/tps6116x.c
 create mode 100644 include/linux/mfd/ti_ssp.h
