From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 30 Jul 2015 15:50:19 +0200
Subject: [RFC PATCH 0/6] mtd: nand: per-partition ECC config
Message-ID: <1438264225-23796-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

It's been a year and a half since I posted my first series proposing
an approach to support per-partition ECC config [1].

First of all, before describing what's done in this patch series, I'd
like to sum-up why this is needed, and why a generic approach is
preferred over a NAND controller specific one.
On one side we have a lot of NAND chips out there and they all have
their own requirements in term of ECC strength and step size. On the
other side, most SoCs support booting from NAND (they embed a simple
logic in the ROM code to access a NAND chip through their NAND
controller).
In a ideal world all NAND chips would use the ONFI or JEDEC standard
exposing their requirements in a standard way, and the SoC vendors
would put the ONFI and JEDEC detection code in their ROM code and use
it to properly configure their NAND controller.
But we're not leaving in an ideal world, and some SoC vendors have
decided to hardcode (or use a simplified logic) to select the ECC
controller config. And in the case where the NAND requirement does
not match the ROM code config, you only have two solutions:

1/ leave with the unsuitable ECC config for the whole chip
2/ isolate the portion of NAND read by the ROM code into a sperate
   partition and use a suitable ECC config for the rest of the
   NAND

IMHO the second solution is far better than the first one, but it
requires some adjustments in the mtdpart and NAND code layer to be
applicable.

Now, why should we prefer a generic approach over a NAND controller/SoC
specific one ?
Because, this seems to be a problem faced by other people on other
platform than the sunxi one. Moreover, the ECC config is not the only
thing we'd have to tweak per partition: I'm currently working on the
NAND randomizer/scrambler aspect (required to support some MLC chips),
and this is also something the ROM code configure differently to
boot the first stage bootloader.
For all these reasons, I think providing a generic infrastructure allowing
specific implementation to tweak their behavior is better than hardcoding
it somewhere in the NAND controller driver.

This series proposes a solution to allow such per-partition config by
first letting MTD implementations (or subframework) overload the MTD
partition functions (patches 1 and 2), and then providing the appropriate
modifications in the NAND layer to support per-partition ECC config
(patches 3 to 5).
The last patch is showing how a NAND controller can add support for
per-partition ECC config.

Note that I tried to keep the changes as less invasive as impossible, but
I might have missed some aspects.
Any suggestions are welcome.

Best Regards,

Boris

[1]https://lkml.org/lkml/2014/2/8/73

Boris Brezillon (6):
  mtd: allow device-specific partition handling
  mtd: part: pass OF node to the MTD partition layer
  mtd: nand: move nand_ecc_ctrl initialization out of nand_scan_tail
  mtd: nand: add an helper to access the ecc controller struct
  mtd: nand: add infrastructure for per-partition ECC config
  mtd: nand: sunxi: support per-partition ECC config

 drivers/mtd/mtdpart.c          |  26 +-
 drivers/mtd/nand/nand_base.c   | 526 ++++++++++++++++++++++++++++-------------
 drivers/mtd/nand/sunxi_nand.c  |  61 ++++-
 drivers/mtd/ofpart.c           |   1 +
 include/linux/mtd/mtd.h        |  45 ++++
 include/linux/mtd/nand.h       |  38 +++
 include/linux/mtd/partitions.h |   3 +-
 7 files changed, 519 insertions(+), 181 deletions(-)

-- 
1.9.1
