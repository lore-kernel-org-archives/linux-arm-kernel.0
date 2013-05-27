From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 27 May 2013 12:26:03 +0200
Subject: [PATCH v2 2/4] mtd: atmel_nand: add Nand Flash Controller
 (NFC) support
In-Reply-To: <51A32DD2.9040707@atmel.com>
References: <1368784308-7600-1-git-send-email-josh.wu@atmel.com>
 <1368784308-7600-3-git-send-email-josh.wu@atmel.com>
 <20130524200947.GM24476@game.jcrosoft.org>
 <51A32DD2.9040707@atmel.com>
Message-ID: <20130527102603.GR24476@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:56 Mon 27 May     , Josh Wu wrote:
> Hi, Jean-Christophe PLAGNIOL-VILLARD
> 
> Thank you for your review comments. See my comment in below.
> 
> On 5/25/2013 4:09 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >On 17:51 Fri 17 May     , Josh Wu wrote:
> >>Nand Flash Controller (NFC) can handle automatic transfers, sending the
> >>commands and address cycles to the NAND Flash.
> >>
> >>To use NFC in this driver, the user needs to set the address and size of
> >>NFC command registers, NFC registers (embedded in HSMC) and NFC SRAM in dts.
> >>Also user need to set up the HSMC irq, which use to check whether nfc
> >>command is finish or not.
> >>
> >>This driver has been tested on SAMA5D3X-EK board with JFFS2, YAFFS,
> >>UBIFS and mtd-utils.
> >>
> >>I put the part of the mtd_speedtest result here for your information.
> >> From the mtd_speedtest, we can see the NFC will reduce the %50 of cpu load
> >>when writing nand flash. No change when reading.
> >>In the meantime, the speed will be slow about %8.
> >>
> >>- commands use to test:
> >>     #insmod /mnt/mtd_speedtest.ko dev=2 &
> >>     #top -n 30 -d 1 | grep speedtest
> >>
> >>- test result:
> >>
> >>Before the patch:
> >>=================================================
> >>mtd_speedtest: MTD device: 2
> >>mtd_speedtest: MTD device size 41943040, eraseblock size 131072, page size 2048, count of eraseblocks 320, pages per eraseblock 64, OOB size 64
> >>   515   495 root     R     1164   0%  93% insmod /mnt/mtd_speedtest.ko dev=2
> >>   515   495 root     R     1164   0%  98% insmod /mnt/mtd_speedtest.ko dev=2
> >>   515   495 root     R     1164   0%  99% insmod /mnt/mtd_speedtest.ko dev=2
> >>mtd_speedtest: eraseblock write speed is 5768 KiB/s
> >>mtd_speedtest: testing eraseblock read speed
> >>   515   495 root     R     1164   0%  92% insmod /mnt/mtd_speedtest.ko dev=2
> >>   515   495 root     R     1164   0%  91% insmod /mnt/mtd_speedtest.ko dev=2
> >>   515   495 root     R     1164   0%  94% insmod /mnt/mtd_speedtest.ko dev=2
> >>mtd_speedtest: eraseblock read speed is 5932 KiB/s
> >>mtd_speedtest: testing page write speed
> >>   515   495 root     R     1164   0%  94% insmod /mnt/mtd_speedtest.ko dev=2
> >>   515   495 root     R     1164   0%  98% insmod /mnt/mtd_speedtest.ko dev=2
> >>   515   495 root     R     1164   0%  98% insmod /mnt/mtd_speedtest.ko dev=2
> >>mtd_speedtest: page write speed is 5770 KiB/s
> >>mtd_speedtest: testing page read speed
> >>   515   495 root     R     1164   0%  91% insmod /mnt/mtd_speedtest.ko dev=2
> >>   515   495 root     R     1164   0%  89% insmod /mnt/mtd_speedtest.ko dev=2
> >>   515   495 root     R     1164   0%  91% insmod /mnt/mtd_speedtest.ko dev=2
> >>mtd_speedtest: page read speed is 5910 KiB/s
> >>
> >>After the patch:
> >>=================================================
> >>mtd_speedtest: MTD device: 2
> >>mtd_speedtest: MTD device size 41943040, eraseblock size 131072, page size 2048, count of eraseblocks 320, pages per eraseblock 64, OOB size 64
> >>mtd_speedtest: testing eraseblock write speed
> >>   509   495 root     D     1164   0%  49% insmod /mnt/mtd_speedtest.ko dev=2
> >>   509   495 root     D     1164   0%  50% insmod /mnt/mtd_speedtest.ko dev=2
> >>   509   495 root     D     1164   0%  47% insmod /mnt/mtd_speedtest.ko dev=2
> >>mtd_speedtest: eraseblock write speed is 5370 KiB/s
> >>mtd_speedtest: testing eraseblock read speed
> >>   509   495 root     R     1164   0%  92% insmod /mnt/mtd_speedtest.ko dev=2
> >>   509   495 root     R     1164   0%  91% insmod /mnt/mtd_speedtest.ko dev=2
> >>   509   495 root     R     1164   0%  95% insmod /mnt/mtd_speedtest.ko dev=2
> >>mtd_speedtest: eraseblock read speed is 5715 KiB/s
> >>mtd_speedtest: testing page write speed
> >>   509   495 root     D     1164   0%  48% insmod /mnt/mtd_speedtest.ko dev=2
> >>   509   495 root     D     1164   0%  47% insmod /mnt/mtd_speedtest.ko dev=2
> >>   509   495 root     D     1164   0%  50% insmod /mnt/mtd_speedtest.ko dev=2
> >>mtd_speedtest: page write speed is 5224 KiB/s
> >>mtd_speedtest: testing page read speed
> >>   509   495 root     R     1164   0%  89% insmod /mnt/mtd_speedtest.ko dev=2
> >>   509   495 root     R     1164   0%  94% insmod /mnt/mtd_speedtest.ko dev=2
> >>   509   495 root     R     1164   0%  93% insmod /mnt/mtd_speedtest.ko dev=2
> >>mtd_speedtest: page read speed is 5641 KiB/s
> >>
> >>Signed-off-by: Josh Wu <josh.wu@atmel.com>
> >>---
> >>v1 --> v2:
> >>   remove the useless nand commands: NAND_CMD_STATUS_ERRORx, NAND_CMD_DEPLETE1.
> >>
> >>  .../devicetree/bindings/mtd/atmel-nand.txt         |    3 +
> >>  drivers/mtd/nand/atmel_nand.c                      |  373 ++++++++++++++++++--
> >>  drivers/mtd/nand/atmel_nand_nfc.h                  |  106 ++++++
> >>  3 files changed, 454 insertions(+), 28 deletions(-)
> >>  create mode 100644 drivers/mtd/nand/atmel_nand_nfc.h
> >>
> >>diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> >>index d555421..88e3313 100644
> >>--- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> >>+++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> >>@@ -6,6 +6,8 @@ Required properties:
> >>  	and hardware ECC controller if available.
> >>  	If the hardware ECC is PMECC, it should contain address and size for
> >>  	PMECC, PMECC Error Location controller and ROM which has lookup tables.
> >>+	If hardware supports Nand Flash Controller, it should contain address and
> >>+	size for NFC command registers, NFC registers and NFC Sram.
> >>  - atmel,nand-addr-offset : offset for the address latch.
> >>  - atmel,nand-cmd-offset : offset for the command latch.
> >>  - #address-cells, #size-cells : Must be present if the device has sub-nodes
> >>@@ -29,6 +31,7 @@ Optional properties:
> >>    sector size 1024.
> >>  - nand-bus-width : 8 or 16 bus width if not present 8
> >>  - nand-on-flash-bbt: boolean to enable on flash bbt option if not present false
> >>+- atmel,has-nfc: boolean to enable Nand Flash Controller(NFC).
> >yes but you need to update the compatible or check the IP support it too
> >as has-nfc will mean I have the nfs on the hardware but not enable it
> >
> >the SoC dtsi will describe you have it but the board will decide to enable it or
> >not
> 
> I can add some code to check whether is NFC supported by read SMC IP
> version. But I'm afraid
> such code may not work for AVR arch.
> 
> Another way is just add a 'enable-nfc' compatible string. Which is
> for board to enable the NFC feature.
> 
> I'm prefer to the later one. What do you think?

I do not like no 2

I like this

		nand0: nand at 60000000 {
			compatible = "atmel,at91rm9200-nand";
			#address-cells = <1>;
			#size-cells = <1>;
			reg = < 0x60000000 0x01000000   /* EBI CS3 */
				0xffffc070 0x00000490   /* SMC PMECC regs */
				0xffffc500 0x00000100   /* SMC PMECC Error Location regs */
				0x00100000 0x00100000   /* ROM code */
				>;
			interrupts = <5 IRQ_TYPE_LEVEL_HIGH 6>;
			atmel,nand-addr-offset = <21>;
			atmel,nand-cmd-offset = <22>;
			pinctrl-names = "default";
			pinctrl-0 = <&pinctrl_nand0_ale_cle>;
			atmel,pmecc-lookup-table-offset = <0x10000 0x18000>;
			status = "disabled";

			nfc at 70000000 {
				compatible = "atmel,sama5d3-nfc";
				reg = < 0x70000000 0x10000000   /* NFC Command Registers */
					0xffffc000 0x00000070   /* NFC HSMC regs */
					0x00200000 0x00100000   /* NFC SRAM banks */
				>;
			}
		};

so you can enable/disable it easly


> 
> >>  Examples:
> >>  nand0: nand at 40000000,0 {
> >>diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> >>index f747791..48d7ee6 100644
> >>--- a/drivers/mtd/nand/atmel_nand.c
> >>+++ b/drivers/mtd/nand/atmel_nand.c
> >>@@ -18,6 +18,9 @@
> >>   *  Add Programmable Multibit ECC support for various AT91 SoC
> >>   *     ? Copyright 2012 ATMEL, Hong Xu
> >>   *
> >>+ *  Add Nand Flash Controller support for SAMA5 SoC
> >>+ *     ? Copyright 2013 ATMEL, Josh Wu (josh.wu at atmel.com)
> >>+ *
> >>   * This program is free software; you can redistribute it and/or modify
> >>   * it under the terms of the GNU General Public License version 2 as
> >>   * published by the Free Software Foundation.
> >>@@ -37,9 +40,11 @@
> >>  #include <linux/mtd/nand.h>
> >>  #include <linux/mtd/partitions.h>
> >>+#include <linux/delay.h>
> >>  #include <linux/dmaengine.h>
> >>  #include <linux/gpio.h>
> >>  #include <linux/io.h>
> >>+#include <linux/interrupt.h>
> >>  #include <linux/platform_data/atmel.h>
> >>  #include <linux/pinctrl/consumer.h>
> >>@@ -58,6 +63,7 @@ module_param(on_flash_bbt, int, 0);
> >>  	__raw_writel((value), add + ATMEL_ECC_##reg)
> >>  #include "atmel_nand_ecc.h"	/* Hardware ECC registers */
> >>+#include "atmel_nand_nfc.h"	/* Nand Flash Controller definition */
> >>  /* oob layout for large page size
> >>   * bad block info is on bytes 0 and 1
> >>@@ -85,6 +91,13 @@ static struct nand_ecclayout atmel_oobinfo_small = {
> >>  	},
> >>  };
....
> >>+				dev_err(&pdev->dev,
> >>+					"can't request input direction rdy gpio %d\n",
> >>+					host->board.rdy_pin);
> >>+				goto err_ecc_ioremap;
> >>+			}
> >>+
> >>+			nand_chip->dev_ready = atmel_nand_device_ready;
> >>  		}
> >>-		res = gpio_direction_output(host->board.enable_pin, 1);
> >>-		if (res < 0) {
> >>-			dev_err(&pdev->dev,
> >>-				"can't request output direction enable gpio %d\n",
> >>-				host->board.enable_pin);
> >>-			goto err_ecc_ioremap;
> >>+		if (gpio_is_valid(host->board.enable_pin)) {
> >>+			res = gpio_request(host->board.enable_pin,
> >we need to use devm_ here too
> >and everywhere we can in this driver
> 
> yes, but seems you already sent one patch to use devm_ for this driver.
> https://patchwork.kernel.org/patch/1589071/
> It is not merged in at91 tree yet.
> 
> So what do you think if I put that patch rebased and put it as one
> of this NFC series patches?

yes do so

Best Regards,
J.
