From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Thu, 16 Jul 2015 17:27:47 +0200
Subject: [PATCH 0/7] add driver for Atmel QSPI controller
Message-ID: <cover.1437059658.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

in order to be able to use Micron Quad SPI memories with the new Atmel QSPI
controller I added a new set_protocol() callback into struct spi_nor.
Indeed, once the quad I/O mode has been enabled on a Micron QSPI flash by
clearing bit 7 in its Enhanced Volatile Configuration Register, this memory
expects all the following commands to use the QSPI 4-4-4 protocol. So the
QSPI controller needs to be notified about this protocol change before
reading the Status register, 0x05 command sent by the
spi_nor_wail_till_ready() function, in micron_quad_enable().

Reading spi-nor.h, I saw an interesting struct spi_nor_xfer_cfg and its
associated callbacks write_xfer() and read_xfer(). However these callbacks
don't seem to be used at all for now. They look to have been designed to
add QSPI support to the generic spi-nor framework. So before extending the
framework with my own callback, I'd like to know whether I should have
tried to used the read_xfer()/write_xfer() callbacks to join an already
existing effort to add QSPI support.
If so, I think either the read/write_reg() prototypes should be updated or
new callbacks should be added for register reads/writes. As explained
above, even for reading the Status register the QSPI 4-4-4 protocol must be
used with Micron memories in quad I/O mode. So the framework has to find a
way to tell the QSPI controller which protocol it should use.

So I'm interested in your comments! :)

Best Regards,

Cyrille

ChangeLog

v1:

This series of patches add support for the new Atmel QSPI controller
embedded inside sama5d2x SoCs.

These patches were first developped for linux-3.18-at91 and tested on a
sama5d27 Xplained ultra board, which embeds a Micron n25q128a13 QSPI NOR
flash memory. Then the series was adapted for mainline.

Cyrille Pitchen (7):
  Documentation: mtd: add a DT property to set the number of dummy
    cycles
  mtd: spi-nor: notify (Q)SPI controller about protocol change
  mtd: spi-nor: allow to tune the number of dummy cycles
  Documentation: mtd: add a DT property to set the latency code of
    Spansion memory
  mtd: spi-nor: allow the set the latency code on Spansion memories
  Documentation: atmel-quadspi: add binding file for Atmel QSPI driver
  mtd: atmel-quadspi: add driver for Atmel QSPI controller

 .../devicetree/bindings/mtd/atmel-quadspi.txt      |  29 +
 .../devicetree/bindings/mtd/jedec,spi-nor.txt      |   6 +
 .../devicetree/bindings/mtd/spansion-nor.txt       |  22 +
 drivers/mtd/spi-nor/Kconfig                        |   7 +
 drivers/mtd/spi-nor/Makefile                       |   1 +
 drivers/mtd/spi-nor/atmel-quadspi.c                | 901 +++++++++++++++++++++
 drivers/mtd/spi-nor/spi-nor.c                      | 160 +++-
 include/linux/mtd/spi-nor.h                        |  15 +
 8 files changed, 1122 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/spansion-nor.txt
 create mode 100644 drivers/mtd/spi-nor/atmel-quadspi.c

-- 
1.8.2.2
