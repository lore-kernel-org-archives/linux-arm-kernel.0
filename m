From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 Sep 2016 10:32:44 +0200
Subject: [PATCH v4] mtd: nand: automate NAND timings selection
Message-ID: <1473928373-8680-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series aims at automating the NAND timings selection which is
currently supposed to be done in each NAND controller driver, thus
simplifying drivers implementation.

As suggested by Boris this version of the series introduces a nand_reset()
function which replaces the several open coded NAND_CMD_RESET commands
in the code. This makes sure we can apply the timing each time after
after reset.

Also I have brought back the conversion patch for teh sunxi driver whic
was part of Boris initial posting. It's untested due to the lack of hardware,
so please test before applying.

Sascha

Changes since v4:
- Change onfi_init_data_interface() prototype to be more future proof as
  requested by Boris

Changes since v3:
- Bring back patch dropped in v3
- Use statically allocated default timing for all chips and store one
  optimized timing in struct nand_chip

Changes since v2:
- Add accessor function to get the SDR timing from struct nand_data_interface
- Change nand_reset() argument to struct nand_chip
- Drop conversion of nand_timing array to struct nand_data_interface
- Recalculate timing whenever needed instead of storing a pointer in struct
  nand_chip
- some more refactoring

Changes since v1:
- create a nand_reset() function to create a single place to reset NAND
  chips and to apply timings
- Add patch to convert sunxi driver for automated timing setup
- split into more patches

Changes since the initial posting from Boris:

- Integrate Feedback from Ezequiel Garcia
- When iterating over the chips calling onfi_set_features() for each
  bail out when any of the calls fail, not only the last one.
- When one of the onfi_set_features() calls fail then reset the chipi
  afterwards.
- Drop Sunxi example, add patch for the mxc_nand controller instead.

----------------------------------------------------------------

Boris Brezillon (1):
      mtd: nand: automate NAND timings selection

Sascha Hauer (8):
      mtd: nand: Create a NAND reset function
      mtd: nand: Introduce nand_data_interface
      mtd: nand: convert ONFI mode into data interface
      mtd: nand: Add function to convert ONFI mode to data_interface
      mtd: nand: Expose data interface for ONFI mode 0
      mtd: nand: sunxi: switch from manual to automated timing config
      mtd: nand: mxc: implement onfi get/set features
      mtd: nand: mxc: Add timing setup for v2 controllers

 drivers/mtd/nand/mxc_nand.c     | 133 ++++++++++++
 drivers/mtd/nand/nand_base.c    | 179 ++++++++++++++-
 drivers/mtd/nand/nand_timings.c | 469 ++++++++++++++++++++++------------------
 drivers/mtd/nand/sunxi_nand.c   |  76 ++-----
 include/linux/mtd/nand.h        | 190 +++++++++++-----
 5 files changed, 721 insertions(+), 326 deletions(-)
