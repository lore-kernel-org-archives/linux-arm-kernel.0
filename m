From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 14 Nov 2013 18:25:25 -0300
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
Message-ID: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Changes from v4

  * Rebased on top of l2-mtd.git origin/next branch

  * Fixed is_ready flag reset, renamed by a more descriptive
    and readble "need_wait".

* Changes from v3 (feedback from Brian Norris)

  * Add binding documentation for the nand-flash-bbt DT property.

  * Expand in the documentation and in a comment the reason for
    setting the NAND_BBT_NO_OOB_BBM option.

  * Reworked the 'is_ready' completion handler. We still have
    two completions, but we've dropped the atomic_t type as
    now the variable is no longer accesed from interruption context.

  * Fixed the ecc.read_page() which lacked the max_bitflip return.

  * Reworked the ECC strength and size setting. This is important
    to allow the MTD layer to properly report on bitflip threshold
    situation.

  * Dropped an unused fifo_size state variable

  * Use '0' instead of the wrong '-1' when the extended command type
    doesn't matter or extended semantics are not supposed to be used.

* Changes from v2 (some minor fixes as per Huang's good feedback)

  * Add some more details to the commit log in patch
    "mtd: nand: pxa3xx: Early variant detection"

  * Add an empty line between variable declaration and function body
    in patch "mtd: nand: pxa3xx: Use chip->cmdfunc instead of the internal".

  * Fix a build break caused by incomplete variable replacement:
    "mtd: nand: pxa3xx: Replace host->page_size by mtd->writesize"

* Changes from v1

Aside from several changes based in Brian's feedback, the main changes
from v1 are:

  * The controller's clock source is now fully modeled, see patche 1 to 4.
    Of course, none of those patches should be taken through the mtd
    subsystem, but I'm adding them here for completeness.

  * The chip's cmdfunc() is now independently implemented in each SoC variant.
    The rationale behind this decision is that 'chunked' I/O is the only tested
    mode on the Armada370 variant, while the old 'vanilla' I/O is the only
    tested mode on the PXA variant.

    So it's safer to have an implementation for each variant.

  * Added support for BCH-8, in other words: 8-bits of correction in a 512-byte
    region. This is obtained by using a data chunk size of 1024B, thus doubling
    the ECC BCH strength, as per this ECC engine mechanism.

  * The ECC layout in use, which must be set according to the page size and
    desired ECC strength is now strictly chosen to match only the tested
    combinations.


Ezequiel Garcia (14):
  mtd: nand: pxa3xx: Use a completion to signal device ready
  mtd: nand: pxa3xx: Use waitfunc() to wait for the device to be ready
  mtd: nand: pxa3xx: Add bad block handling
  mtd: nand: pxa3xx: Add driver-specific ECC BCH support
  mtd: nand: pxa3xx: Clear cmd buffer #3 (NDCB3) on command start
  mtd: nand: pxa3xx: Add helper function to set page address
  mtd: nand: pxa3xx: Remove READ0 switch/case falltrough
  mtd: nand: pxa3xx: Split prepare_command_pool() in two stages
  mtd: nand: pxa3xx: Move the data buffer clean to
    prepare_start_command()
  mtd: nand: pxa3xx: Fix SEQIN column address set
  mtd: nand: pxa3xx: Add a read/write buffers markers
  mtd: nand: pxa3xx: Introduce multiple page I/O support
  mtd: nand: pxa3xx: Add multiple chunk write support
  mtd: nand: pxa3xx: Add ECC BCH correctable errors detection

 .../devicetree/bindings/mtd/pxa3xx-nand.txt        |   2 +
 drivers/mtd/nand/pxa3xx_nand.c                     | 613 +++++++++++++++++----
 include/linux/platform_data/mtd-nand-pxa3xx.h      |   3 +
 3 files changed, 505 insertions(+), 113 deletions(-)

-- 
1.8.1.5
