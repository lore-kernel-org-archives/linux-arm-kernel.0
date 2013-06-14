From: b32955@freescale.com (Huang Shijie)
Date: Fri, 14 Jun 2013 16:06:21 +0800
Subject: [PATCH 0/4] mtd: gpmi: support two nand chips at most
Message-ID: <1371197185-27491-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current gpmi-nand driver only supports one chips. But we may meet
some embarrassing situation, such as Micron MT29F32G08QAA.
This nand chip has two DIEs internally. Each die has its own chip select pin,
so this chip acts as two nand chips.

If we only scan one chip, we may find that we only get 2G for this chip,
but in actually, this chip's size is 4G.

So scan two chips by default.

In order to support two nand chips, we have to do the following:
   1.) We only have one dma channel now, so decouple the chip select
      from the DMA channel, We can use the dma 0 to access all the nand chips.

   2.) fix the wrong method of checking the ready/busy status.
      In the imx6, all the ready/busy pins are binding together, we
      should check ready/busy status of chip 0 for the all the chips. 

Tested this patch set with MT29F32G08QAA.


Huang Shijie (4):
  mtd: gpmi: decouple the chip select from the DMA channel
  mtd: gpmi: use DMA channel 0 for all the nand chips
  mtd: gpmi: scan two nand chips
  mtd: gpmi: imx6: fix the wrong method for checking ready/busy

 drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |   14 ++++++++++++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    7 +++----
 drivers/mtd/nand/gpmi-nand/gpmi-regs.h |    3 +++
 3 files changed, 20 insertions(+), 4 deletions(-)
