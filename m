From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 12 Feb 2015 15:53:26 +0100
Subject: [PATCH v2 00/10] ARM: berlin: add nand support
Message-ID: <1423752816-26219-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series introduces the support for the Marvell Berlin nand
controller. It is based on top of v3.19 and was tested on the
Marvell Berlin BG2Q DMP board.

The support is added into the existing pxa3xx nand controller. Some
additions were done in order to get this controller working:
- Support for a non mandatory ECC clock has been added.
- The Berlin nand controller needs to poll the status register.
- Sequences of commands are quite different in order to perform write
  operation.

Changes were done in order to avoid impacting other controllers using
this driver, but I'd like people actually using the pxa3xx nand driver
to test theses patches to ensure no harm was done. A specific Berlin
nand cmd function has been added to deal with most of the Berlin
specific code.

Because of a bug in the Berlin clock driver, this series requires the
fix provided by Jisheng Zhang, which is already in v3.19-rc6
(b71e8ecd57c8aae5b1815782c47b74ffe3efc09a).

Thanks!

Antoine

Changes since v1:
        - Added a fallback to NULL when looking for the 'nfc' clock
	- Added the clocks in the bindings documentation
        - Reworked the DT
        - Removed non needed RNDOUT command
        - Used the standard RESET command
        - Fixed the flash type matching order
        - Remove all non tested flash types (only one left)
        - Added a check to explicitly not support nand chips with small pages
        - Remove useless checks for clocks in the probing function
        - Various clean up

Antoine Tenart (10):
  mtd: pxa3xx_nand: initialiaze pxa3xx_flash_ids to 0
  mtd: pxa3xx_nand: add a non mandatory ECC clock
  Documentation: bindings: document the clocks for pxa3xx-nand
  mtd: pxa3xx_nand: set NDCR_PG_PER_BLK if page per block is 128
  mtd: pxa3xx_nand: add a default chunk size
  mtd: pxa3xx_nand: add support for the Marvell Berlin nand controller
  Documentation: bindings: add the Berlin nand controller compatible
  mtd: nand: let Marvell Berlin SoCs select the pxa3xx driver
  ARM: berlin: add BG2Q node for the nand
  ARM: berlin: enable flash on the BG2Q DMP

 .../devicetree/bindings/mtd/pxa3xx-nand.txt        |   5 +
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts         |  25 ++
 arch/arm/boot/dts/berlin2q.dtsi                    |  13 +
 drivers/mtd/nand/Kconfig                           |   2 +-
 drivers/mtd/nand/pxa3xx_nand.c                     | 268 ++++++++++++++++++---
 5 files changed, 276 insertions(+), 37 deletions(-)

-- 
2.3.0
