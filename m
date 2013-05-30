From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 30 May 2013 18:54:53 +0200
Subject: [PATCH v2 2/4] mtd: atmel_nand: add Nand Flash Controller
 (NFC) support
In-Reply-To: <51A6EE46.6050701@atmel.com>
References: <1368784308-7600-1-git-send-email-josh.wu@atmel.com>
 <1368784308-7600-3-git-send-email-josh.wu@atmel.com>
 <20130524200947.GM24476@game.jcrosoft.org>
 <51A32DD2.9040707@atmel.com>
 <20130527102603.GR24476@game.jcrosoft.org>
 <51A6EE46.6050701@atmel.com>
Message-ID: <20130530165453.GD23653@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:14 Thu 30 May     , Josh Wu wrote:
> Hi, JC
> 
> On 5/27/2013 6:26 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> [snip]
> 
> >>>yes but you need to update the compatible or check the IP support it too
> >>>as has-nfc will mean I have the nfs on the hardware but not enable it
> >>>
> >>>the SoC dtsi will describe you have it but the board will decide to enable it or
> >>>not
> >>I can add some code to check whether is NFC supported by read SMC IP
> >>version. But I'm afraid
> >>such code may not work for AVR arch.
> >>
> >>Another way is just add a 'enable-nfc' compatible string. Which is
> >>for board to enable the NFC feature.
> >>
> >>I'm prefer to the later one. What do you think?
> >I do not like no 2
> >
> >I like this
> >
> >		nand0: nand at 60000000 {
> >			compatible = "atmel,at91rm9200-nand";
> >			#address-cells = <1>;
> >			#size-cells = <1>;
> >			reg = < 0x60000000 0x01000000   /* EBI CS3 */
> >				0xffffc070 0x00000490   /* SMC PMECC regs */
> >				0xffffc500 0x00000100   /* SMC PMECC Error Location regs */
> >				0x00100000 0x00100000   /* ROM code */
> >				>;
> >			interrupts = <5 IRQ_TYPE_LEVEL_HIGH 6>;
> >			atmel,nand-addr-offset = <21>;
> >			atmel,nand-cmd-offset = <22>;
> >			pinctrl-names = "default";
> >			pinctrl-0 = <&pinctrl_nand0_ale_cle>;
> >			atmel,pmecc-lookup-table-offset = <0x10000 0x18000>;
> >			status = "disabled";
> >
> >			nfc at 70000000 {
> >				compatible = "atmel,sama5d3-nfc";
> >				reg = < 0x70000000 0x10000000   /* NFC Command Registers */
> >					0xffffc000 0x00000070   /* NFC HSMC regs */
> >					0x00200000 0x00100000   /* NFC SRAM banks */
> >				>;
> >			}
> >		};
> >
> >so you can enable/disable it easly
> 
> Since I am not use such dts definition before, following is my guest
> implementation for above dts:
> So I need define an additional platform driver for
> "atmel,sama5d3-nfc" with probe/remove function. right?

give one day for thisI need to check something on the hardware features
> if yes, then there are two question are rise out:
> 1. which driver will be probed first? or it is depends? Since I
> think the "atmel,sama5d3-nfc" can be probe first is good for me.
> 2. how do these two drivers share data with others? I check at91
> pinctrl as a example, and it use a static pointer array store gpio
> data, and pinctrl can access it. Seems that is enough for me.

no the pinctrl is a special case as both drivers use the same registers
to handle the pinctrl and gpio

Best Regards,
J.
> 
> >
> >
> >>>>  Examples:
> >>>>  nand0: nand at 40000000,0 {
> >>>>diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> >>>>index f747791..48d7ee6 100644
> >>>>--- a/drivers/mtd/nand/atmel_nand.c
> >>>>+++ b/drivers/mtd/nand/atmel_nand.c
> >>>>@@ -18,6 +18,9 @@
> >>>>   *  Add Programmable Multibit ECC support for various AT91 SoC
> >>>>   *     ? Copyright 2012 ATMEL, Hong Xu
> >>>>   *
> >>>>+ *  Add Nand Flash Controller support for SAMA5 SoC
> >>>>+ *     ? Copyright 2013 ATMEL, Josh Wu (josh.wu at atmel.com)
> >>>>+ *
> >>>>   * This program is free software; you can redistribute it and/or modify
> >>>>   * it under the terms of the GNU General Public License version 2 as
> >>>>   * published by the Free Software Foundation.
> >>>>@@ -37,9 +40,11 @@
> >>>>  #include <linux/mtd/nand.h>
> >>>>  #include <linux/mtd/partitions.h>
> >>>>+#include <linux/delay.h>
> >>>>  #include <linux/dmaengine.h>
> >>>>  #include <linux/gpio.h>
> >>>>  #include <linux/io.h>
> >>>>+#include <linux/interrupt.h>
> >>>>  #include <linux/platform_data/atmel.h>
> >>>>  #include <linux/pinctrl/consumer.h>
> >>>>@@ -58,6 +63,7 @@ module_param(on_flash_bbt, int, 0);
> >>>>  	__raw_writel((value), add + ATMEL_ECC_##reg)
> >>>>  #include "atmel_nand_ecc.h"	/* Hardware ECC registers */
> >>>>+#include "atmel_nand_nfc.h"	/* Nand Flash Controller definition */
> >>>>  /* oob layout for large page size
> >>>>   * bad block info is on bytes 0 and 1
> >>>>@@ -85,6 +91,13 @@ static struct nand_ecclayout atmel_oobinfo_small = {
> >>>>  	},
> >>>>  };
> >....
> >>>>+				dev_err(&pdev->dev,
> >>>>+					"can't request input direction rdy gpio %d\n",
> >>>>+					host->board.rdy_pin);
> >>>>+				goto err_ecc_ioremap;
> >>>>+			}
> >>>>+
> >>>>+			nand_chip->dev_ready = atmel_nand_device_ready;
> >>>>  		}
> >>>>-		res = gpio_direction_output(host->board.enable_pin, 1);
> >>>>-		if (res < 0) {
> >>>>-			dev_err(&pdev->dev,
> >>>>-				"can't request output direction enable gpio %d\n",
> >>>>-				host->board.enable_pin);
> >>>>-			goto err_ecc_ioremap;
> >>>>+		if (gpio_is_valid(host->board.enable_pin)) {
> >>>>+			res = gpio_request(host->board.enable_pin,
> >>>we need to use devm_ here too
> >>>and everywhere we can in this driver
> >>yes, but seems you already sent one patch to use devm_ for this driver.
> >>https://patchwork.kernel.org/patch/1589071/
> >>It is not merged in at91 tree yet.
> >>
> >>So what do you think if I put that patch rebased and put it as one
> >>of this NFC series patches?
> >yes do so
> 
> ok. I will rebase the patch and including it with nfc patches.
> 
> Best Regards,
> Josh Wu
> 
> >
> >Best Regards,
> >J.
> 
