From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Mar 2016 17:18:17 +0100
Subject: [PATCH 00/16] mtd: nand: sunxi: various improvements/fixes
Message-ID: <1457367513-26069-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset aims at fixing a few minor bugs, and improving performances
of NAND accesses going through the sunxi NAND controller.

Note that patch 5 exports functions provided by the core which are needed
in patch 6 to still support raw OOB accesses. Other patches are just
fixes or improvements only touching the sunxi driver itself.

Here are the main improvements:
- queue CLE/ALE requests instead of forcing the controller to issue each
  cmd and address cycle separately
- benefit from ECC correction on protected OOB bytes
- use polling instead of interrupt-based waiting (avoid scheduling
  overhead for short wait period)

I'm preparing another series based on this one to add page operations
and DMA support, which, according to my first tests will bring a huge
speed improvement (at least x2 on read accesses, and even more when
ONFI timing mode > 0 is used).

Stay tuned.

Best Regards,

Boris

Boris Brezillon (16):
  mtd: nand: sunxi: fix call order in sunxi_nand_chip_init()
  mtd: nand: sunxi: fix clk rate calculation
  mtd: nand: sunxi: fix EDO mode selection
  mtd: nand: sunxi: adapt clk_rate to tWB, tADL, tWHR and tRHW timings
  mtd: nand: export default read/write oob functions
  mtd: nand: sunxi: implement ->read_oob()/->write_oob()
  mtd: nand: sunxi: implement ->read_subpage()
  mtd: nand: sunxi: improve ->cmd_ctrl() function
  mtd: nand: sunxi: let the NAND controller control the CE line
  mtd: nand: sunxi: fix the NFC_ECC_ERR_CNT() macro
  mtd: nand: sunxi: fix NFC_CTL setting
  mtd: nand: sunxi: disable clks on device removal
  mtd: nand: enable ECC pipelining
  mtd: nand: sunxi: fix ->dev_ready() implementation
  mtd: nand: sunxi: make use of readl_poll_timeout()
  mtd: nand: sunxi: poll for events instead of using interrupts

 drivers/mtd/nand/nand_base.c  |  18 +--
 drivers/mtd/nand/sunxi_nand.c | 293 ++++++++++++++++++++++++++++++------------
 include/linux/mtd/nand.h      |  14 ++
 3 files changed, 233 insertions(+), 92 deletions(-)

-- 
2.1.4
