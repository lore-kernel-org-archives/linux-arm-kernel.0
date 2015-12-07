From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 7 Dec 2015 15:09:09 +0100
Subject: [PATCH linux-next 0/5] mtd: spi-nor: add driver for Atmel QSPI
 controller
Message-ID: <cover.1449494420.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this series of patches adds support to the Atmel QSPI controller available
on sama5d2 SoCs. It was tested on a sama5d2 xplained ultra board with a 
Micron n25q128a13 QSPI memory and a at25df321a SPI memory.

In order to use the Micron memory in its Quad SPI mode, the spi-nor
framework needed to be patched to fix the support of Quad/Dual SPI
protocols with some memory manufacturers such as Spansion, Micron and
Macronix. There are many comments in the source code to explain the
implementation choices based on the datasheets from memory manufacturers.


This series was based and tested on linux-next-20151207

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

2 - Atmel SPI + at25df321a (m25p80.c driver)

SPI 1-1-1: tested with the m25p80 driver for non regression purpose.


mtd_speedtest was run with the Atmel QSPI controller + Micron memory to
compare the performances of normal and quad SPI protocols. The SPI
bus clock was configured to 83 MHz.

1 - Fast Read 1-1-1

mtd_speedtest: testing eraseblock write speed
mtd_speedtest: eraseblock read speed is 9319 KiB/s
[...]
mtd_speedtest: testing page read speed
mtd_speedtest: page read speed is 6649 KiB/s
[...]
mtd_speedtest: testing 2 page read speed
mtd_speedtest: 2 page read speed is 7757 KiB/s

2 - Fast Read 1-1-4

mtd_speedtest: testing eraseblock read speed
mtd_speedtest: eraseblock read speed is 30117 KiB/s
[...]
mtd_speedtest: testing page read speed
mtd_speedtest: page read speed is 13096 KiB/s
[...]
mtd_speedtest: testing 2 page read speed
mtd_speedtest: 2 page read speed is 18224 KiB/s


So the performance improvements are:
eraseblock read speed (65536 bytes) : +223%
page read speed (512 bytes)         :  +97%
2 page read speed (1024 bytes)      : +135%


Best Regards,

Cyrille

Cyrille Pitchen (5):
  mtd: spi-nor: properly detect the memory when it boots in Quad or Dual
    mode
  mtd: spi-nor: fix Quad SPI mode support for Spansion, Micron and
    Macronix
  mtd: m25p80: add support of dual and quad spi protocols to all
    commands
  Documentation: atmel-quadspi: add binding file for Atmel QSPI driver
  mtd: atmel-quadspi: add driver for Atmel QSPI controller

 .../devicetree/bindings/mtd/atmel-quadspi.txt      |  32 +
 drivers/mtd/devices/m25p80.c                       | 233 +++++-
 drivers/mtd/spi-nor/Kconfig                        |   8 +
 drivers/mtd/spi-nor/Makefile                       |   3 +-
 drivers/mtd/spi-nor/atmel-quadspi.c                | 877 +++++++++++++++++++++
 drivers/mtd/spi-nor/spi-nor.c                      | 835 +++++++++++++++++---
 include/linux/mtd/spi-nor.h                        |  38 +-
 7 files changed, 1880 insertions(+), 146 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
 create mode 100644 drivers/mtd/spi-nor/atmel-quadspi.c

-- 
1.8.2.2
