From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Thu, 30 Nov 2017 18:01:27 +0100
Subject: [PATCH 0/5] Introduce the new NAND core interface: ->exec_op()
Message-ID: <20171130170132.27522-1-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds the implementation of the NAND framework ->exec_op()
interface with all the related hooks and helpers. The reasons for adding
it are explained in details in the commit log:

        "mtd: nand: add ->exec_op() implementation"

Long story short: it will ease later expansion of the framework, as well
as the implementation of new vendor specific commands, and should also
ease driver development.

A lot of comments are written to explain how to use the new API. Several
NAND controller drivers are already/almost converted to ->exec_op(), in
particular a rework of the Marvell NAND controller driver, and will
follow. One can have a look at them as examples to understand how to
implement or rework NAND controller drivers. A proper external
documentation is being written and will later be submitted.

Thank you,
Miqu?l


Boris Brezillon (2):
  mtd: nand: provide several helpers to do common NAND operations
  mtd: nand: force drivers to explicitly send READ/PROG commands

Miquel Raynal (3):
  mtd: nand: use usual return values for the ->erase() hook
  mtd: nand: use a static data_interface in the nand_chip structure
  mtd: nand: add ->exec_op() implementation

 drivers/mtd/nand/atmel/nand-controller.c      |    9 +-
 drivers/mtd/nand/bf5xx_nand.c                 |    6 +-
 drivers/mtd/nand/brcmnand/brcmnand.c          |   20 +-
 drivers/mtd/nand/cafe_nand.c                  |   20 +-
 drivers/mtd/nand/denali.c                     |   40 +-
 drivers/mtd/nand/diskonchip.c                 |    4 +-
 drivers/mtd/nand/docg4.c                      |   21 +-
 drivers/mtd/nand/fsl_elbc_nand.c              |   10 +-
 drivers/mtd/nand/fsl_ifc_nand.c               |    6 +-
 drivers/mtd/nand/fsmc_nand.c                  |    5 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c        |   77 +-
 drivers/mtd/nand/hisi504_nand.c               |    9 +-
 drivers/mtd/nand/jz4740_nand.c                |   16 +-
 drivers/mtd/nand/lpc32xx_mlc.c                |    7 +-
 drivers/mtd/nand/lpc32xx_slc.c                |   33 +-
 drivers/mtd/nand/mtk_nand.c                   |   25 +-
 drivers/mtd/nand/nand_base.c                  | 2161 ++++++++++++++++++++++---
 drivers/mtd/nand/nand_hynix.c                 |  124 +-
 drivers/mtd/nand/nand_micron.c                |   83 +-
 drivers/mtd/nand/nand_timings.c               |   21 +-
 drivers/mtd/nand/omap2.c                      |   18 +-
 drivers/mtd/nand/pxa3xx_nand.c                |   14 +-
 drivers/mtd/nand/qcom_nandc.c                 |   27 +-
 drivers/mtd/nand/r852.c                       |   11 +-
 drivers/mtd/nand/sh_flctl.c                   |    6 +-
 drivers/mtd/nand/sunxi_nand.c                 |   97 +-
 drivers/mtd/nand/tango_nand.c                 |   27 +-
 drivers/mtd/nand/tmio_nand.c                  |    5 +-
 drivers/mtd/nand/vf610_nfc.c                  |    6 +-
 drivers/staging/mt29f_spinand/mt29f_spinand.c |    5 +-
 include/linux/mtd/rawnand.h                   |  414 ++++-
 31 files changed, 2673 insertions(+), 654 deletions(-)

-- 
2.11.0
