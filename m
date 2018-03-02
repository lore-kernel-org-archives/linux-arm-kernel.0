From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:08 +0100
Subject: [PATCH 00/52] Allow dynamic allocations during NAND chip
 identification phase
Message-ID: <20180302170400.6712-1-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series make a quite deep change in the NAND framework. Until now,
the NAND chip identification phase could be done in two manners from the
controller driver perspective:

1/ Call nand_scan()

  or

1/ Call nand_scan_ident()
2/ Do some controller-dependent configuration
3/ Call nand_scan_tail().

The fact that the identifaction could be split in two operations
involved that in the NAND framework, it was not possible to do any
dynamic allocation without risking a memory leak. What if the core
allocates a structure, then the driver between nand_scan_ident() and
nand_scan_tail() decides it cannot handle the chip and errors out?
The structure allocated by the core is lost: it is a memory leak.

To avoid this situation, we migrate all drivers to use nand_scan(). But
because drivers need to do some configuration before nand_scan_tail(), a
first hook is offered, embedded in the nand_ecc_ctrl structure, called
->attach_chip(). Drivers that need to tweak their configuration after
nand_scan_ident() should implement it. Any dynamically allocated space
in ->attach_chip() must be freed in the second hook: ->detach_chip().

The ->detach_chip() does not have to be called upon error in the
controller driver probe function. The nand_realease() helper already
exists for that and will do the call if needed. Of course, this helper
must be called on error after a successful nand_scan(), just like
before.

Once all drivers not using nand_scan() (yet) are migrated,
nand_scan_ident() and nand_scan_tail() are unexported and only available
internally.

A previous work [1] removed the ONFI/JEDEC parameter pages and instead
allocated a nand_parameters structure in nand_chip, embedding both
generic entries and ONFI-related ones. The deal was, once dynamic
allocation possible, allocate in nand_scan_ident() the ONFI strcuture
only if actually needed. This is done in the last patches.

All these changes have been tested with the GPMI driver and tested by
the 0-day robot.

Thank you,
Miqu?l

[1] http://lists.infradead.org/pipermail/linux-mtd/2018-March/079456.html


Miquel Raynal (52):
  mtd: rawnand: add hooks that may be called during nand_scan()
  mtd: rawnand: bf5xx: fix probe function error path
  mtd: rawnand: bf5xx: convert driver to nand_scan()
  mtd: rawnand: brcmnand: fix probe function error path
  mtd: rawnand: brcmnand: convert driver to nand_scan()
  mtd: rawnand: cafe: fix probe function error path
  mtd: rawnand: cafe: convert driver to nand_scan()
  mtd: rawnand: davinci: fix probe function error path
  mtd: rawnand: davinci: convert driver to nand_scan()
  mtd: rawnand: denali: fix probe function error path
  mtd: rawnand: denali: convert to nand_scan()
  mtd: rawnand: fsl_elbc: fix probe function error path
  mtd: rawnand: fsl_elbc: convert driver to nand_scan()
  mtd: rawnand: fsl_ifc: fix probe function error path
  mtd: rawnand: fsl_ifc: convert driver to nand_scan()
  mtd: rawnand: fsmc: fix probe function error path
  mtd: rawnand: fsmc: convert driver to nand_scan()
  mtd: rawnand: gpmi: convert driver to nand_scan()
  mtd: rawnand: hisi504: enhance the probe function error path
  mtd: rawnand: hisi504: convert driver to nand_scan()
  mtd: rawnand: jz4780: convert driver to nand_scan()
  mtd: rawnand: lpc32xx_mlc: enhance the probe function error path
  mtd: rawnand: lpc32xx_mlc: convert driver to nand_scan()
  mtd: rawnand: lpc32xx_slc: enhance the probe function error
  mtd: rawnand: lpc32xx_slc: convert driver to nand_scan()
  mtd: rawnand: marvell: convert driver to nand_scan()
  mtd: rawnand: mtk: convert driver to nand_scan()
  mtd: rawnand: mxc: fix probe function error path
  mtd: rawnand: mxc: convert driver to nand_scan()
  mtd: rawnand: nandsim: convert driver to nand_scan()
  mtd: rawnand: omap2: fix the probe function error path
  mtd: rawnand: omap2: convert driver to nand_scan()
  mtd: rawnand: s3c2410: enhance the probe function error path
  mtd: rawnand: s3c2410: convert driver to nand_scan()
  mtd: rawnand: sh_flctl: move all NAND chip related setup in one
    function
  mtd: rawnand: sh_flctl: fix the probe function error path
  mtd: rawnand: sh_flctl: convert driver to nand_scan()
  mtd: rawnand: sunxi: convert driver to nand_scan()
  mtd: rawnand: tango: fix probe function error path
  mtd: rawnand: tango: convert driver to nand_scan()
  mtd: rawnand: txx9ndfmc: convert driver to nand_scan()
  mtd: rawnand: vf610: convert driver to nand_scan()
  mtd: rawnand: atmel: convert driver to nand_scan()
  mtd: rawnand: add a field in nand_chip to fill an array of IDs
  mtd: rawnand: sm_common: make use of the new flash_ids table entry
  mtd: rawnand: sm_common: convert driver to nand_scan()
  mtd: rawnand: docg4: fix the probe function error path
  mtd: rawnand: docg4: convert driver to nand_scan()
  mtd: rawnand: qcom: convert driver to nand_scan()
  mtd: rawnand: jz4740: convert driver to nand_scan()
  mtd: rawnand: do not export nand_scan_[ident|tail]() anymore
  mtd: rawnand: allocate dynamically ONFI parameters during detection

 drivers/mtd/nand/raw/atmel/nand-controller.c |  70 ++--
 drivers/mtd/nand/raw/bf5xx_nand.c            |  55 +--
 drivers/mtd/nand/raw/brcmnand/brcmnand.c     |  45 ++-
 drivers/mtd/nand/raw/cafe_nand.c             | 148 ++++----
 drivers/mtd/nand/raw/davinci_nand.c          | 192 +++++-----
 drivers/mtd/nand/raw/denali.c                | 138 +++----
 drivers/mtd/nand/raw/docg4.c                 |  65 ++--
 drivers/mtd/nand/raw/fsl_elbc_nand.c         |  22 +-
 drivers/mtd/nand/raw/fsl_ifc_nand.c          |  21 +-
 drivers/mtd/nand/raw/fsmc_nand.c             | 154 ++++----
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c   |  52 +--
 drivers/mtd/nand/raw/hisi504_nand.c          | 101 +++---
 drivers/mtd/nand/raw/jz4740_nand.c           |  42 ++-
 drivers/mtd/nand/raw/jz4780_nand.c           |  30 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c           | 131 +++----
 drivers/mtd/nand/raw/lpc32xx_slc.c           |  97 ++---
 drivers/mtd/nand/raw/marvell_nand.c          | 201 ++++++-----
 drivers/mtd/nand/raw/mtk_nand.c              |  71 ++--
 drivers/mtd/nand/raw/mxc_nand.c              | 143 ++++----
 drivers/mtd/nand/raw/nand_base.c             | 118 ++++--
 drivers/mtd/nand/raw/nand_micron.c           |   4 +-
 drivers/mtd/nand/raw/nand_timings.c          |  12 +-
 drivers/mtd/nand/raw/nandsim.c               |  78 ++--
 drivers/mtd/nand/raw/omap2.c                 | 521 +++++++++++++--------------
 drivers/mtd/nand/raw/qcom_nandc.c            |  67 +---
 drivers/mtd/nand/raw/s3c2410.c               |  32 +-
 drivers/mtd/nand/raw/sh_flctl.c              |  55 ++-
 drivers/mtd/nand/raw/sm_common.c             |  35 +-
 drivers/mtd/nand/raw/sunxi_nand.c            |  38 +-
 drivers/mtd/nand/raw/tango_nand.c            |  40 +-
 drivers/mtd/nand/raw/txx9ndfmc.c             |  25 +-
 drivers/mtd/nand/raw/vf610_nfc.c             | 119 +++---
 include/linux/mtd/rawnand.h                  |  27 +-
 include/linux/mtd/sh_flctl.h                 |   1 +
 34 files changed, 1537 insertions(+), 1413 deletions(-)

-- 
2.14.1
