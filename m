From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 5 Aug 2013 19:14:32 +0800
Subject: [PATCH v6 0/6] mtd: atmel_nand: enable Nand Flash Controller (NFC)
 support
Message-ID: <1375701279-11495-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enable NFC support for SAMA5 soc. It can send command,
address cycles automaticly. Also when enable NFC sram, NFC will transfer
data to sram. Which can save lots of cpu time.

The mtd speed test results (non-NFC vs NFC), run in sama5d3x-ek with DMA
enable, is in the end of this patch.

v5 --> v6:
 rebase on the top of l2-mtd.git

v4 --> v5:
 1) rebase to latest l2-mtd.git
 2) remove blank line in EOF for atmel_nand.txt
 3) add blank line for patch 2/6 for coding style.

v3 --> v4:
 1) refine the commit message for ofpart.c patch and also change the
    description in partition.txt
 2) remove len parameter for ofpart.c's change.
 3) use devm_ioremap_resource instead of devm_requrest_and_ioremap.
 4) add BIT_POS macro definition for magic number.

v2 --> v3:
 1) Change the dts usage for NFC. Now use a NFC child node of atmel nand
    to enable NFC driver. In this way the atmel nand driver will include
    a NFC driver, which will be probed if dts has NFC node.
 2) can enable/disable NFC write by sram in dts.
 3) merged J.C's patch(use devm_xxx to simple the code) in this series.
 4) remove unused NFC register definitions. Change the definition names.
 5) trival fix accroding to J.C's suggestion.
 6) modify the ofpart.c for child node check. If the child node has compatible
    property then this node is a device not a partition.

v1 --> v2:
 1) rebase it with latest l2-mtd git tree: 
    - remove useless nand commands (NAND_CMD_DEPLETE1, NAND_CMD_STATUS_ERRORx).
    - adopt to the new nand write function's parameters. Add error message when
      handle subpage write via nfc sram.
 2) rewrite pmecc_enable function. Now I use exist NAND_ECC_READ/WRITE const
    instead of using a new enum definition.

Jean-Christophe PLAGNIOL-VILLARD (1):
  MTD: atmel_nand: use devm_xxx gpio kzalloc, gpio and ioremap

Josh Wu (5):
  mtd: atmel_nand: replace pmecc enable code with one function.
  mtd: atmel_nand: add Nand Flash Controller (NFC) support
  mtd: atmel_nand: enable Nand Flash Controller (NFC) read data via
    sram
  mtd: atmel_nand: enable Nand Flash Controller (NFC) write via sram
  mtd: ofpart: add compatible check for child nodes

 .../devicetree/bindings/mtd/atmel-nand.txt         |   27 +
 .../devicetree/bindings/mtd/partition.txt          |    1 +
 drivers/mtd/nand/atmel_nand.c                      |  875 ++++++++++++++++----
 drivers/mtd/nand/atmel_nand_nfc.h                  |   98 +++
 drivers/mtd/ofpart.c                               |   13 +-
 5 files changed, 852 insertions(+), 162 deletions(-)
 create mode 100644 drivers/mtd/nand/atmel_nand_nfc.h


mtd_speedtest is run in 60M partition with DMA enabled for two cases:
 1. Using NFC and sram read/write with DMA enabled.
 2. Using Non-NFC with DMA enabled.

Summary of the two test results:
 1. With NFC and sram read/write enabled, the write speed will become %10 slower
    and the cpu load also is reduce a lot (50% -> 20%):
                          Non-NFC                  NFC
      Page write Speed:   5536KiB : 46% ~ 64% --> 4989KiB : 13% ~ 22%
      2 Page write speed: 5567KiB : 52% ~ 69% --> 5043KiB : 10% ~ 20%

 2. With NFC and sram read/write enabled, the read speed is almost same and the
    cpu load is reduced (30% -> 15%):
                          Non-NFC                  NFC
      Page read Speed:    9361KiB : %24 ~ 46% --> 9340KiB : 13% ~ 19%
      2 Page read Speed:  9361KiB : %21 ~ 57% --> 9426KiB :  8% ~ 15%

Following is the detail test log:

case 1: Non-NFC with DMA:
=================================================
mtd_speedtest: MTD device: 2
mtd_speedtest: MTD device size 62914560, eraseblock size 131072, page size 2048, count of eraseblocks 480, pages per eraseblock 64, OOB size 64
mtd_speedtest: scanning for bad eraseblocks
mtd_speedtest: scanned 480 eraseblocks, 0 are bad
mtd_speedtest: testing eraseblock write speed
top -n 130 -d 1 | grep speedtest
  513   504 root     R     1164   0%  62% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     D     1164   0%  53% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  57% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  58% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  53% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  60% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  55% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  55% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  59% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  57% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  62% insmod /root/mtd_test/mtd_speedtest.ko
mtd_speedtest: eraseblock write speed is 5594 KiB/s
mtd_speedtest: testing eraseblock read speed
  513   504 root     R     1164   0%  27% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  14% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%   5% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%   1% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%   2% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%   1% insmod /root/mtd_test/mtd_speedtest.ko
mtd_speedtest: eraseblock read speed is 9442 KiB/s
mtd_speedtest: testing page write speed
  513   504 root     R     1164   0%  46% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  64% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  57% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  64% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  56% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  59% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  59% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  56% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  59% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  62% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  60% insmod /root/mtd_test/mtd_speedtest.ko
mtd_speedtest: page write speed is 5536 KiB/s
mtd_speedtest: testing page read speed
  513   504 root     R     1164   0%  46% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  24% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  30% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  30% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  26% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  25% insmod /root/mtd_test/mtd_speedtest.ko
mtd_speedtest: page read speed is 9361 KiB/s
  513   504 root     R     1164   0%  24% insmod /root/mtd_test/mtd_speedtest.ko
mtd_speedtest: testing 2 page write speed
  513   504 root     R     1164   0%  69% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  56% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  57% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  61% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  55% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  61% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  55% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  52% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  55% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  58% insmod /root/mtd_test/mtd_speedtest.ko
mtd_speedtest: 2 page write speed is 5567 KiB/s
mtd_speedtest: testing 2 page read speed
  513   504 root     D     1164   0%  57% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  26% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  21% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  23% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  24% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  25% insmod /root/mtd_test/mtd_speedtest.ko
  513   504 root     R     1164   0%  23% insmod /root/mtd_test/mtd_speedtest.ko
mtd_speedtest: 2 page read speed is 9361 KiB/s
mtd_speedtest: Testing erase speed
mtd_speedtest: erase speed is 167411 KiB/s
mtd_speedtest: Testing 2x multi-block erase speed
mtd_speedtest: 2x multi-block erase speed is 326808 KiB/s
mtd_speedtest: Testing 4x multi-block erase speed
  513   504 root     R     1164   0%  74% insmod /root/mtd_test/mtd_speedtest.ko
mtd_speedtest: 4x multi-block erase speed is 301176 KiB/s
mtd_speedtest: Testing 8x multi-block erase speed
mtd_speedtest: 8x multi-block erase speed is 326808 KiB/s
mtd_speedtest: Testing 16x multi-block erase speed
mtd_speedtest: 16x multi-block erase speed is 328556 KiB/s
mtd_speedtest: Testing 32x multi-block erase speed
mtd_speedtest: 32x multi-block erase speed is 328556 KiB/s
mtd_speedtest: Testing 64x multi-block erase speed
mtd_speedtest: 64x multi-block erase speed is 325079 KiB/s
mtd_speedtest: finished
=================================================


case 2: NFC with DMA:
=================================================
mtd_speedtest: MTD device: 2
mtd_speedtest: MTD device size 62914560, eraseblock size 131072, page size 2048, count of eraseblocks 480, pages per eraseblock 64, OOB size 64
mtd_speedtest: scanning for bad eraseblocks
mtd_speedtest: scanned 480 eraseblocks, 0 are bad
top -n 130 -d 1 | grep speedtest
mtd_speedtest: testing eraseblock write speed
  514   504 root     R     1164   0%   8% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  12% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  10% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  13% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     D     1164   0%  15% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     D     1164   0%  14% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  11% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%   9% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  15% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  11% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  15% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  12% insmod /root/mtd_test/mtd_speedtest.ko
mtd_speedtest: eraseblock write speed is 5105 KiB/s
mtd_speedtest: testing eraseblock read speed
  514   504 root     R     1164   0%  14% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  20% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  17% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%   8% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%   6% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  15% insmod /root/mtd_test/mtd_speedtest.ko
mtd_speedtest: eraseblock read speed is 9512 KiB/s
  514   504 root     R     1164   0%   6% insmod /root/mtd_test/mtd_speedtest.ko
mtd_speedtest: testing page write speed
  514   504 root     R     1164   0%  17% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  20% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  13% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  12% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  14% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  17% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  11% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  22% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  17% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  14% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  17% insmod /root/mtd_test/mtd_speedtest.ko
mtd_speedtest: page write speed is 4989 KiB/s
mtd_speedtest: testing page read speed
  514   504 root     R     1164   0%  16% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  13% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  17% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  16% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  18% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  19% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  16% insmod /root/mtd_test/mtd_speedtest.ko
mtd_speedtest: page read speed is 9340 KiB/s
mtd_speedtest: testing 2 page write speed
  514   504 root     R     1164   0%  20% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  10% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  14% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  16% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  15% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  12% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  16% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  18% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  15% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  16% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  17% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  13% insmod /root/mtd_test/mtd_speedtest.ko
mtd_speedtest: 2 page write speed is 5043 KiB/s
mtd_speedtest: testing 2 page read speed
  514   504 root     R     1164   0%   8% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%   9% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  14% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  12% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  12% insmod /root/mtd_test/mtd_speedtest.ko
  514   504 root     R     1164   0%  15% insmod /root/mtd_test/mtd_speedtest.ko
mtd_speedtest: 2 page read speed is 9426 KiB/s
mtd_speedtest: Testing erase speed
  514   504 root     R     1164   0%  12% insmod /root/mtd_test/mtd_speedtest.ko
mtd_speedtest: erase speed is 157943 KiB/s
mtd_speedtest: Testing 2x multi-block erase speed
mtd_speedtest: 2x multi-block erase speed is 308743 KiB/s
mtd_speedtest: Testing 4x multi-block erase speed
mtd_speedtest: 4x multi-block erase speed is 313469 KiB/s
mtd_speedtest: Testing 8x multi-block erase speed
mtd_speedtest: 8x multi-block erase speed is 313469 KiB/s
mtd_speedtest: Testing 16x multi-block erase speed
mtd_speedtest: 16x multi-block erase speed is 315076 KiB/s
mtd_speedtest: Testing 32x multi-block erase speed
  514   504 root     R     1164   0%  12% insmod /root/mtd_test/mtd_speedtest.ko
mtd_speedtest: 32x multi-block erase speed is 298252 KiB/s
mtd_speedtest: Testing 64x multi-block erase speed
mtd_speedtest: 64x multi-block erase speed is 311878 KiB/s
mtd_speedtest: finished
=================================================

-- 
1.7.9.5
