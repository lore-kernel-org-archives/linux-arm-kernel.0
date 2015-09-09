From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Wed, 9 Sep 2015 15:24:10 +0200
Subject: [PATCH linux-next v6 0/8] add driver for Atmel QSPI controller
Message-ID: <cover.1441803609.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ChangeLog

v6:
- add new patch which tries to read the JEDEC ID with different SPI protocols
  and different commands: 0x9f (SPI-1-1-1), 0xaf (SPI-4-4-4) and finally
  0xaf (SPI-2-2-2).
- remove the set_protocol() hook from struct spi_nor and add 4 new members
  instead of type enum spi_protocol:
  read_proto, write_proto, erase_proto, reg_proto.
  The relevant protocol value should be checked by the driver specific read(),
  write(), erase(), read_reg() and write_reg() hook implementations.
- remove unused hooks: write_xfer() and read_xfer().
- tune the op code for read, write and erase commands depending on the memory
  manufacturer.
- remove some previously added "Acked-by" since the protocol switch strategy
  has been changed but not discussed yet.

v5:
- remove unused inline functions qspi_read[bw]() and qspi_write[bw](),
  keep only qspi_readl() and qspi_writel().
- use reinit_completion() instead of init_completion() during run time,
  call init_completion() once for all in the probe().
- add a dev_warn() when trying to tune the number of dummy cycles for
  spi-nor of a not supported manufacturer then fall back to the default
  framework value.
- reword some comments.
- add "Acked-by: Marek Vasut <marex@denx.de>" for patches 1 and 4.
- add "Acked-by: Bean Huo <beanhuo@micron.com>" for patch 1.

v4:
- add "OF && HAS_DMA" dependency in Kconfig for Atmel Quad SPI driver.
- return -ENOMEM instead of the return code of dma_mapping_error() as this
  function returns a boolean on ARM achitecture.
- add "Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>" for Atmel Quad
  SPI driver and its DT binding documentation.

v3:
- reword the comment which explains that spi_nor_set_protocol() is used by
  the spi-nor framework to notify lower layers, especially the (Q)SPI
  controller about a protocol change.
- change the definitions of register/bitfield macros in the Atmel QSPI
  controller driver: get rid of concatenation operator and use BIT and
  GENMASK macros when possible.
- use #define[SPACE] instead of #define[TAB]

v2:
- remove the patches to set the "latency code" of Spansion QSPI memories
  (support of Spansion memories may be submitted in later series).
- rename "qspi" node into "spi" in the DT example to fit ePAPR standard.
- remove the useless "qspi0" label from the DT node example.
- remove the leading 0 from the size of the second memory region to make
  it consistent with the size of the first memory region.
- indent the DT bindings documentation to make it more readable.
- remove the useless ".bus	= &platform_bus_type," line from the
  platform driver definition.

v1:

This series of patches add support for the new Atmel QSPI controller
embedded inside sama5d2x SoCs.

These patches were first developped for linux-3.18-at91 and tested on a
sama5d27 Xplained ultra board, which embeds a Micron n25q128a13 QSPI NOR
flash memory. Then the series was adapted for mainline.

Cyrille Pitchen (8):
  mtd: spi-nor: read JEDEC ID with multiple I/O protocols
  mtd: spi-nor: remove unused read_xfer/write_xfer hooks
  mtd: spi-nor: update the SPI protocol when enabling manufacturer Quad
    mode
  mtd: spi-nor: use optimized commands for read/write/erase operations
  Documentation: mtd: add a DT property to set the number of dummy
    cycles
  mtd: spi-nor: allow to tune the number of dummy cycles
  Documentation: atmel-quadspi: add binding file for Atmel QSPI driver
  mtd: atmel-quadspi: add driver for Atmel QSPI controller

 .../devicetree/bindings/mtd/atmel-quadspi.txt      |  29 +
 .../devicetree/bindings/mtd/jedec,spi-nor.txt      |   6 +
 drivers/mtd/spi-nor/Kconfig                        |   7 +
 drivers/mtd/spi-nor/Makefile                       |   1 +
 drivers/mtd/spi-nor/atmel-quadspi.c                | 889 +++++++++++++++++++++
 drivers/mtd/spi-nor/spi-nor.c                      | 356 +++++++--
 include/linux/mtd/spi-nor.h                        |  63 +-
 7 files changed, 1269 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
 create mode 100644 drivers/mtd/spi-nor/atmel-quadspi.c

-- 
1.8.2.2
