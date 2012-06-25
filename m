From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 25 Jun 2012 18:07:42 +0800
Subject: [PATCH v11 0/4] MTD: at91: Add PMECC support for at91 nand flash
 driver
Message-ID: <1340618866-28776-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Those patches is based on v3.5-rc4

Changes since v10,
	add one more patch in this patch set, which add 'int' return value for write_page()/write_page_raw() functions in structure of nand_ecc_ctrl.
	Instead of calling BUG(), atmel_nand_pmecc_write_page() will return -EIO when time out to read the pmecc status register.
	increase the time-out duration to 100ms, which has more toleration.
	add oob_required argument for pmecc read/write functions to align with v3.5-rc4.

Changes since v9,
	use jiffies for timeout test to read PMECC status register.
	modified according to J.C and Artem's comments.
	add rom lookup table offset as DT variables.
	refine coding style and error handling.

Changes since v8,
	use _relaxed read/write in most place. use writel in operations of Control Register since it needs memory barrier.
	allocate the data for PMECC computation.
	add pmecc prefix for related variable/functions.
	modify code according to J.C's suggestion.

Josh Wu (4):
  MTD: at91: extract hw ecc initialization to one function
  MTD: at91: add dt parameters for Atmel PMECC
  MTD: nand: add return value for write_page()/write_page_raw() functions in structure of nand_ecc_ctrl.
  MTD: at91: atmel_nand: Update driver to support Programmable Multibit ECC controller

 .../devicetree/bindings/mtd/atmel-nand.txt         |    9 +
 drivers/mtd/nand/atmel_nand.c                      |  914 ++++++++++++++++++--
 drivers/mtd/nand/atmel_nand_ecc.h                  |  114 ++-
 drivers/mtd/nand/bcm_umi_bch.c                     |    6 +-
 drivers/mtd/nand/bf5xx_nand.c                      |    6 +-
 drivers/mtd/nand/cafe_nand.c                       |   11 +-
 drivers/mtd/nand/denali.c                          |   12 +-
 drivers/mtd/nand/docg4.c                           |    8 +-
 drivers/mtd/nand/fsl_elbc_nand.c                   |    4 +-
 drivers/mtd/nand/fsl_ifc_nand.c                    |    4 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c             |    6 +-
 drivers/mtd/nand/nand_base.c                       |   27 +-
 drivers/mtd/nand/pxa3xx_nand.c                     |    4 +-
 drivers/mtd/nand/sh_flctl.c                        |    4 +-
 include/linux/mtd/nand.h                           |    4 +-
 15 files changed, 1039 insertions(+), 94 deletions(-)

-- 
1.7.9.5
