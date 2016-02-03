From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Wed, 3 Feb 2016 14:26:45 +0100
Subject: [PATCH v3 00/14] mtd: spi-nor: add driver for Atmel QSPI controller
Message-ID: <cover.1454505161.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series of patches adds support to the Atmel QSPI controller available
on sama5d2 SoCs. It was tested on a sama5d2 xplained ultra board with  
Micron n25q128a13, Spansion s25fl512 and Macronix mx25l51245g QSPI
memories and a at25df321a SPI memory.

The SPI protocol to be used by .read_reg(), .write_reg(), .read(), .write()
and .erase() hooks should be read by these hooks from new *_proto fields in
the struct spi_nor, the same way as the .read(), .write() and .erase()
hooks already get the op code value from dedicated *_opcode fields in the
very same struct spi_nor.
Doing so, there is no need to modify the current prototypes of all these
hooks.

Also, if some implementation is not interrested in supporting Dual or Quad
SPI protocols, it can simply ignore the value of the new  *_proto fields,
thus assuming the SPI 1-1-1 protocol is always used. Such an
implementation would work exactly as it did before introducing the *_proto
fields hence no regression should happen.
Indeed SPI protocols other than SPI 1-1-1 are used only if the caller of
spi_nor_scan() sets the value of the 'mode' argument to either
SPI_NOR_DUAL or SPI_NOR_QUAD.


This series was based and tested on linux-next

1 - Atmel QSPI controller + Micron n25q128a13 (atmel-quadspi.c driver)

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

2 - Atmel QSPI controller + Macronix mx25l51245g (atmel-quadspi.c driver)

SPI 1-1-4: the number of dummy cycles is set to 8 so drivers such as the
           m25p80 one can work properly.

3 - Atmel QSPI controller + Spansion s25fl512 (atmel-quadspi.c driver)

SPI 1-1-4: default settings. Early developpements on a FPGA board.

4 - Atmel SPI contoller + at25df321a (m25p80.c driver)

SPI 1-1-1: tested with the m25p80 driver for non regression purpose.


Winbond memories were NOT tested since I don't have any sample yet. The
patches were written only based on the manufacturers' datasheets.


Best regards,

Cyrille


ChangeLog:

v2 > v3:
- no longer check patterns such as FFFFFF or 000000 to detect a Read Jedec
  ID failure: always look the read ID up in the spi_nor_ids[] table (patch 2).
- fix patch 10 to configure the number of dummy cycles on Macronix memories:
  these memories use op code 0x15 to read their Configuration Register. Op
  code 0x35 is used to enter Macronix QPI mode, which was not intented.
- add "Acked-by Nicolas Ferre <nicolas.ferre@atmel.com>" to patch 14:
  driver for Atmel QSPI controller.

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
 drivers/mtd/spi-nor/atmel-quadspi.c                | 877 ++++++++++++++++++++
 drivers/mtd/spi-nor/spi-nor.c                      | 921 +++++++++++++++++++--
 include/linux/mtd/spi-nor.h                        |  74 +-
 7 files changed, 1971 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
 create mode 100644 drivers/mtd/spi-nor/atmel-quadspi.c

-- 
1.8.2.2
