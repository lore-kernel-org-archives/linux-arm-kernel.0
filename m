From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 30 Apr 2018 10:24:41 +0200
Subject: [PATCH 00/12] mtd: nand: davinci: stop using pdev->id as chipselect
Message-ID: <20180430082453.8091-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We have the 'ti,davinci-chipselect' property in the device tree, but
when using platform data the driver silently uses the id field of
struct platform_device as the chipselect. This is confusing and we
almost broke the nand support again recently after converting the
platform to common clock framework (which changed the device id in the
clock lookup - the problem is gone now that we no longer acquire the
clock in the nand driver.

This series adds a new field to davinci-nand platform data, then makes
all board use it and finally modifies the two drivers that make use of
it.

Bartosz Golaszewski (12):
  mtd: nand: davinci: store the core chipselect number in platform data
  ARM: davinci: da830-evm: specify the chipselect in davinci_nand_pdata
  ARM: davinci: da850-evm: specify the chipselect in davinci_nand_pdata
  ARM: davinci: dm355-evm: specify the chipselect in davinci_nand_pdata
  ARM: davinci: dm355-leopard: specify the chipselect in
    davinci_nand_pdata
  ARM: davinci: dm365-evm: specify the chipselect in davinci_nand_pdata
  ARM: davinci: dm644x-evm: specify the chipselect in davinci_nand_pdata
  ARM: davinci: mityomapl138: specify the chipselect in
    davinci_nand_pdata
  ARM: davinci: dm646x-evm: specify the chipselect in davinci_nand_pdata
  ARM: davinci: neuros-osd2: specify the chipselect in
    davinci_nand_pdata
  mtd: nand: davinci: stop using pdev->id as chipselect
  ARM: davinci: aemif: stop using pdev->id as nand chipselect

 arch/arm/mach-davinci/aemif.c               | 8 ++++----
 arch/arm/mach-davinci/board-da830-evm.c     | 1 +
 arch/arm/mach-davinci/board-da850-evm.c     | 1 +
 arch/arm/mach-davinci/board-dm355-evm.c     | 1 +
 arch/arm/mach-davinci/board-dm355-leopard.c | 1 +
 arch/arm/mach-davinci/board-dm365-evm.c     | 1 +
 arch/arm/mach-davinci/board-dm644x-evm.c    | 1 +
 arch/arm/mach-davinci/board-dm646x-evm.c    | 1 +
 arch/arm/mach-davinci/board-mityomapl138.c  | 1 +
 arch/arm/mach-davinci/board-neuros-osd2.c   | 1 +
 drivers/mtd/nand/raw/davinci_nand.c         | 6 +++---
 include/linux/platform_data/mtd-davinci.h   | 2 ++
 12 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.17.0
