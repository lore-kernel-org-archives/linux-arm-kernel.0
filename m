From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 8 Jan 2016 17:02:12 +0100
Subject: [PATCH linux-next v2 00/14] mtd: spi-nor: add driver for Atmel QSPI
 controller
Message-ID: <cover.1452268345.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series of patches adds support to the Atmel QSPI controller available
on sama5d2 SoCs. It was tested on a sama5d2 xplained ultra board with a 
Micron n25q128a13 QSPI memory and a at25df321a SPI memory.

In order to use the Micron memory in its Quad SPI mode, the spi-nor
framework needed to be patched to fix the support of Quad/Dual SPI
protocols with some memory manufacturers such as Spansion, Micron and
Macronix. There are many comments in the source code to explain the
implementation choices based on the datasheets from memory manufacturers.


This series was based and tested on linux-next

1 - Atmel QSPI + Micron n25q128a13 (atmel-quadspi.c driver)

SPI 1-1-1: This mode was tested replacing SPI_NOR_QUAD by SPI_NOR_FAST as
           argument to spi_nor_scan() called from atmel_qspi_probe().

SPI 1-1-4: Bootloaders (at91bootstrap/uboot) don't enable the Quad SPI
           mode of the Micron memory. When probed from Linux, the memory
           uses its Extended SPI mode and replies to the regular Read ID
           (0x9f) command.

SPI 4-4-4: The romcode enabled the Quad SPI mode the of Micron memory
           before loading the at91bootstrap. When probed from Linux, the
           memory uses its Quad SPI mode and no longer replies to the
           regular Read ID (0x9f) command but instead to the Read ID
           Multiple I/O (0xaf) command. The memory expects ALL commands
           to use the SPI 4-4-4 protocol.

2 - Atmel QSPI + Spansion s25fl512 (atmel-quadspi.c driver)

SPI 1-1-4: default settings. Early developpements on a FPGA board.

3 - Atmel SPI + at25df321a (m25p80.c driver)

SPI 1-1-1: tested with the m25p80 driver for non regression purpose.


Winbond and Macronix memories were NOT tested. The patches were written
only based on the manufacturers' datasheets.


Best regards,

Cyrille


ChangeLog:

v1 -> v2:
- I've totally reworked the whole series. Especially I have split the
  former patch 2 to ease the code review. The Single/Dual/Quad SPI mode
  support fixes are now done by manufacturer.
- fix support and probing of Winbond memories.
- m25p80: compute the number of dummy bytes from both the number of dummy
  clock cycles and the number of I/O lines used to send them.
- fix Kconfig dependencies for the Atmel QSPI controller driver (it should
  fix the kbuild test robot warnings).
- add more comments.


Cyrille Pitchen (14):
  mtd: spi-nor: remove micron_quad_enable()
  mtd: spi-nor: properly detect the memory when it boots in Quad or Dual
    mode
  mtd: spi-nor: select op codes and SPI NOR protocols by manufacturer
  mtd: spi-nor: fix support of Macronix memories
  mtd: spi-nor: fix support of Winbond memories
  mtd: spi-nor: fix support of Micron memories
  mtd: spi-nor: fix support of Spansion memories
  mtd: spi-nor: configure the number of dummy clock cycles by
    manufacturer
  mtd: spi-nor: configure the number of dummy clock cycles on Micron
    memories
  mtd: spi-nor: configure the number of dummy clock cycles on Macronix
    memories
  mtd: spi-nor: configure the number of dummy clock cycles on Spansion
    memories
  mtd: m25p80: add support of dual and quad spi protocols to all
    commands
  Documentation: atmel-quadspi: add binding file for Atmel QSPI driver
  mtd: atmel-quadspi: add driver for Atmel QSPI controller

 .../devicetree/bindings/mtd/atmel-quadspi.txt      |  32 +
 drivers/mtd/devices/m25p80.c                       | 192 ++++-
 drivers/mtd/spi-nor/Kconfig                        |   9 +
 drivers/mtd/spi-nor/Makefile                       |   1 +
 drivers/mtd/spi-nor/atmel-quadspi.c                | 877 +++++++++++++++++++
 drivers/mtd/spi-nor/spi-nor.c                      | 928 +++++++++++++++++++--
 include/linux/mtd/spi-nor.h                        |  71 +-
 7 files changed, 1985 insertions(+), 125 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
 create mode 100644 drivers/mtd/spi-nor/atmel-quadspi.c

-- 
1.8.2.2
