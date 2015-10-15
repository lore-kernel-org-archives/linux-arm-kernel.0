From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 15 Oct 2015 19:17:20 +0200
Subject: [PATCH 0/3] mtd: nand: add preliminary support for data scramblers
Message-ID: <1444929443-25537-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series aims at supporting the hardware scrambler available in
the Allwinner NAND controller, which is required to interface with some
unreliable MLC NANDs.

The main purpose of the scrambler is to avoid repeating patterns over
a specific NAND block, which can be a problem for some NANDs.

The approach taken in this patch is to flag all NAND requiring an external
data scrambler so that the controller will know about this constraint and
hopefully activate its scrambler engine (if it has one).

The scrambling itself is currently tightly coupled to the ECC engine, which
makes things easier: everything is hidden in the HW ECC engine
implementation, but that also mean you cannot activate the scrambler
without using the HW ECC engine (which is an unlikely case anyway).
Another thing that is worth mentioning is that the randomizer is disabled
when accessing the NAND in raw mode, which make NAND dumps in raw mode
pretty much unreadable unless you have a tool to descramble the data.

Also note that I previously posted an RFC [1] exposing the scrambler as a
separate layer to decouple the ECC and scrambling management, but I don't
think it's worth the pain until someone else comes with another scrambler
controller and we really see the need to factorize some code.

Best Regards,

Boris

[1]https://lkml.org/lkml/2014/4/30/721

Boris Brezillon (3):
  mtd: nand: add NAND_NEED_SCRAMBLING option flag
  mtd: nand: add NAND_NEED_SCRAMBLING flag to the H27UCG8T2ATR-BC
    definition
  mtd: nand: sunxi: add randomizer support

 drivers/mtd/nand/nand_ids.c   |   4 +-
 drivers/mtd/nand/sunxi_nand.c | 274 ++++++++++++++++++++++++++++++++++++++----
 include/linux/mtd/nand.h      |   6 +
 3 files changed, 258 insertions(+), 26 deletions(-)

-- 
2.1.4
