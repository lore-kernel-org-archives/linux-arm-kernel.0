From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Tue, 19 Dec 2017 14:29:37 +0100
Subject: [PATCH v2 0/5] Marvell NAND controller rework with ->exec_op()
Message-ID: <20171219132942.27433-1-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

After the addition of the NAND framework ->exec_op() interface (see [1]
for the series preparing it and [2] for the last version of the
core-side implementation of ->exec_op() itself), this series replaces
the current Marvell NAND controller driver pxa3xx_nand.c with a rework
called marvell_nand.c.

Aside the fact that it drops the big state machine, improves the overall
speed and implements raw accesses, it is the first driver-side
implementation of the ->exec_op() interface and may be used as reference
for latter reworks of the same type.

One may find more detail about why a completely new driver is needed in
the commit log of:

    "mtd: nand: add reworked Marvell NAND controller driver"

Device tree NAND node definition for all platforms referring to the
Marvell driver using the new bindings have already been accepted by the
MVEBU DT maintainers and will be merged after the driver. They are more
hierarchical and fit the real organization of the hardware, by having
NAND partitions that are part of NAND chip nodes, themselves part of the
NAND controller node.

These changes have been tested on:
   - PXA3xx platform with a CM-X300 board (2kiB page NAND, 1b/512B
     strength, Hamming ECC engine) [32 bits]
   - Armada 385 DB AP (4kiB page NAND, 4b/512B, BCH ECC engine) [32 bits]
   - Armada 398 DB (4kiB page NAND, 8b/512B, BCH ECC engine using a layout
     with a last chunk different than the others) [32 bits]
   - Armada 7040 DB and Armada 8040 DB (4kiB page NAND, 4b/512B, BCH ECC
     engine) [64 bits]
   - Triax dvb-tc board (2kiB page NAND, 4b/512B, BCH ECC engine) [32 bits]

This version is probably one step before the last version as Robert's
Zylonite still does not boot with it.

For people who would like to test it easily, a branch ready to be tested
is available at [3]. It is based on nand/next and has all the changes
brought by the previously mentionned series as well as this one.

Thank you,
Miqu?l


[1] https://www.spinics.net/lists/arm-kernel/msg619633.html
[2] http://lists.infradead.org/pipermail/linux-mtd/2017-December/077965.html
[3] https://github.com/miquelraynal/linux/tree/marvell/nand-next/nfc-rework


Changes since v1:
  - Rewording
  - Fixed BCH ->read/write_page() hooks for 2kiB pages NAND chips
  - Removed license text, used SPDX tag instead
  - Removed read_page_data()
  - Enhanced the DT bindings document with the label property and the
    deprecated bindings.
  - Simplified the read_chunk() helper (OOB always read).
  - Simplified the ->bch_read_page() hook by removing the addition raw
    read to get ECC bytes.
  - Fixed the ->correct() function that did not check for bitflips in
    ECC bytes in erased pages.


Miquel Raynal (5):
  dt-bindings: mtd: add Marvell NAND controller documentation
  mtd: nand: add reworked Marvell NAND controller driver
  mtd: nand: replace pxa3xx_nand driver by its rework called
    marvell_nand
  dt-bindings: mtd: remove pxa3xx NAND controller documentation
  mtd: nand: remove useless fields from pxa3xx NAND platform data

 .../devicetree/bindings/mtd/marvell-nand.txt       |  123 +
 .../devicetree/bindings/mtd/pxa3xx-nand.txt        |   50 -
 arch/arm/configs/cm_x300_defconfig                 |    2 +-
 arch/arm/configs/mvebu_v7_defconfig                |    2 +-
 arch/arm/configs/pxa3xx_defconfig                  |    3 +-
 arch/arm/configs/pxa_defconfig                     |    2 +-
 arch/arm/configs/raumfeld_defconfig                |    2 +-
 arch/arm/mach-mmp/ttc_dkb.c                        |    4 +-
 arch/arm/mach-pxa/cm-x300.c                        |    8 +-
 arch/arm/mach-pxa/colibri-pxa3xx.c                 |    8 +-
 arch/arm/mach-pxa/colibri.h                        |    2 +-
 arch/arm/mach-pxa/littleton.c                      |   10 +-
 arch/arm/mach-pxa/mxm8x10.c                        |   10 +-
 arch/arm/mach-pxa/raumfeld.c                       |    6 +-
 arch/arm/mach-pxa/zylonite.c                       |   10 +-
 drivers/mtd/nand/Kconfig                           |   18 +-
 drivers/mtd/nand/Makefile                          |    2 +-
 drivers/mtd/nand/marvell_nand.c                    | 2941 ++++++++++++++++++++
 drivers/mtd/nand/pxa3xx_nand.c                     | 2104 --------------
 include/linux/platform_data/mtd-nand-pxa3xx.h      |   43 +-
 20 files changed, 3115 insertions(+), 2235 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt
 delete mode 100644 Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
 create mode 100644 drivers/mtd/nand/marvell_nand.c
 delete mode 100644 drivers/mtd/nand/pxa3xx_nand.c

-- 
2.11.0
