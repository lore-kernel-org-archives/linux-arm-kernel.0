From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 31 May 2011 16:31:19 -0700
Subject: [PATCH 0/8] clean-up NAND / BBT code, flags
Message-ID: <1306884687-1824-1-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series handles several issues with NAND chip flags and BBT
flags, especially those related to the nand_chip.options and
nand_bbt_descr.options fields. This topic was discussed and reviewed a
bit on the linux-mtd thread found here:
    http://lists.infradead.org/pipermail/linux-mtd/2011-April/035146.html

These changes have affected many drivers in relatively small ways, so
I copied all the maintainers/contributors given by the
scripts/getmaintainer.pl scripts. FYI, this patch set is based on the
mtd-2.6.git repository from linux-mtd.

Also, the first patch:
    mtd: nand: remove NAND_BBT_SCANBYTE1AND6 option
solves the regression issues discussed here:
    http://lists.infradead.org/pipermail/linux-mtd/2011-May/035696.html

Thanks for the review.

Brian

Brian Norris (8):
  mtd: nand: remove NAND_BBT_SCANBYTE1AND6 option
  mtd: nand: separate chip options / bbt_options
  mtd: nand: consolidate redundant flash-based BBT flags
  mtd: nand: rename NAND_USE_FLASH_BBT
  mtd: nand: move NAND_CREATE_EMPTY_BBT flag
  mtd: nand: rename CREATE_EMPTY bbt flag with proper prefix
  mtd: nand: renumber the reorganized flags in nand.h / bbm.h
  mtd: nand: improve comment on NAND_BBT_DYNAMIC_STRUCT

 Documentation/DocBook/mtdnand.tmpl             |    5 +--
 arch/arm/mach-davinci/board-da830-evm.c        |    2 +-
 arch/arm/mach-davinci/board-da850-evm.c        |    2 +-
 arch/arm/mach-davinci/board-dm355-evm.c        |    2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c    |    2 +-
 arch/arm/mach-davinci/board-dm365-evm.c        |    2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c       |    2 +-
 arch/arm/mach-davinci/board-mityomapl138.c     |    3 +-
 arch/arm/mach-davinci/board-neuros-osd2.c      |    2 +-
 arch/arm/mach-davinci/board-tnetv107x-evm.c    |    2 +-
 arch/arm/mach-davinci/include/mach/nand.h      |    4 +-
 arch/arm/mach-orion5x/ts78xx-setup.c           |    2 +-
 arch/cris/arch-v32/drivers/mach-a3/nandflash.c |    2 +-
 arch/cris/arch-v32/drivers/mach-fs/nandflash.c |    2 +-
 drivers/mtd/nand/atmel_nand.c                  |    2 +-
 drivers/mtd/nand/autcpu12.c                    |    4 +-
 drivers/mtd/nand/bcm_umi_nand.c                |    2 +-
 drivers/mtd/nand/cafe_nand.c                   |    3 +-
 drivers/mtd/nand/cs553x_nand.c                 |    3 +-
 drivers/mtd/nand/davinci_nand.c                |    4 +-
 drivers/mtd/nand/denali.c                      |    3 +-
 drivers/mtd/nand/diskonchip.c                  |    2 +-
 drivers/mtd/nand/fsl_elbc_nand.c               |    4 +-
 drivers/mtd/nand/mpc5121_nfc.c                 |    3 +-
 drivers/mtd/nand/mxc_nand.c                    |    2 +-
 drivers/mtd/nand/nand_base.c                   |   41 ++++------------
 drivers/mtd/nand/nand_bbt.c                    |   59 ++++++------------------
 drivers/mtd/nand/nandsim.c                     |    4 +-
 drivers/mtd/nand/pasemi_nand.c                 |    3 +-
 drivers/mtd/nand/s3c2410.c                     |    6 ++-
 include/linux/mtd/bbm.h                        |   39 +++++++++++-----
 include/linux/mtd/nand.h                       |   22 +++------
 32 files changed, 103 insertions(+), 137 deletions(-)
