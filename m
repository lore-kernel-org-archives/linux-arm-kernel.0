From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 27 May 2013 17:56:34 +0800
Subject: [PATCH v2 2/4] mtd: atmel_nand: add Nand Flash Controller (NFC)
 support
In-Reply-To: <20130524200947.GM24476@game.jcrosoft.org>
References: <1368784308-7600-1-git-send-email-josh.wu@atmel.com>
 <1368784308-7600-3-git-send-email-josh.wu@atmel.com>
 <20130524200947.GM24476@game.jcrosoft.org>
Message-ID: <51A32DD2.9040707@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Jean-Christophe PLAGNIOL-VILLARD

Thank you for your review comments. See my comment in below.

On 5/25/2013 4:09 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 17:51 Fri 17 May     , Josh Wu wrote:
>> Nand Flash Controller (NFC) can handle automatic transfers, sending the
>> commands and address cycles to the NAND Flash.
>>
>> To use NFC in this driver, the user needs to set the address and size of
>> NFC command registers, NFC registers (embedded in HSMC) and NFC SRAM in dts.
>> Also user need to set up the HSMC irq, which use to check whether nfc
>> command is finish or not.
>>
>> This driver has been tested on SAMA5D3X-EK board with JFFS2, YAFFS,
>> UBIFS and mtd-utils.
>>
>> I put the part of the mtd_speedtest result here for your information.
>>  From the mtd_speedtest, we can see the NFC will reduce the %50 of cpu load
>> when writing nand flash. No change when reading.
>> In the meantime, the speed will be slow about %8.
>>
>> - commands use to test:
>>      #insmod /mnt/mtd_speedtest.ko dev=2 &
>>      #top -n 30 -d 1 | grep speedtest
>>
>> - test result:
>>
>> Before the patch:
>> =================================================
>> mtd_speedtest: MTD device: 2
>> mtd_speedtest: MTD device size 41943040, eraseblock size 131072, page size 2048, count of eraseblocks 320, pages per eraseblock 64, OOB size 64
>>    515   495 root     R     1164   0%  93% insmod /mnt/mtd_speedtest.ko dev=2
>>    515   495 root     R     1164   0%  98% insmod /mnt/mtd_speedtest.ko dev=2
>>    515   495 root     R     1164   0%  99% insmod /mnt/mtd_speedtest.ko dev=2
>> mtd_speedtest: eraseblock write speed is 5768 KiB/s
>> mtd_speedtest: testing eraseblock read speed
>>    515   495 root     R     1164   0%  92% insmod /mnt/mtd_speedtest.ko dev=2
>>    515   495 root     R     1164   0%  91% insmod /mnt/mtd_speedtest.ko dev=2
>>    515   495 root     R     1164   0%  94% insmod /mnt/mtd_speedtest.ko dev=2
>> mtd_speedtest: eraseblock read speed is 5932 KiB/s
>> mtd_speedtest: testing page write speed
>>    515   495 root     R     1164   0%  94% insmod /mnt/mtd_speedtest.ko dev=2
>>    515   495 root     R     1164   0%  98% insmod /mnt/mtd_speedtest.ko dev=2
>>    515   495 root     R     1164   0%  98% insmod /mnt/mtd_speedtest.ko dev=2
>> mtd_speedtest: page write speed is 5770 KiB/s
>> mtd_speedtest: testing page read speed
>>    515   495 root     R     1164   0%  91% insmod /mnt/mtd_speedtest.ko dev=2
>>    515   495 root     R     1164   0%  89% insmod /mnt/mtd_speedtest.ko dev=2
>>    515   495 root     R     1164   0%  91% insmod /mnt/mtd_speedtest.ko dev=2
>> mtd_speedtest: page read speed is 5910 KiB/s
>>
>> After the patch:
>> =================================================
>> mtd_speedtest: MTD device: 2
>> mtd_speedtest: MTD device size 41943040, eraseblock size 131072, page size 2048, count of eraseblocks 320, pages per eraseblock 64, OOB size 64
>> mtd_speedtest: testing eraseblock write speed
>>    509   495 root     D     1164   0%  49% insmod /mnt/mtd_speedtest.ko dev=2
>>    509   495 root     D     1164   0%  50% insmod /mnt/mtd_speedtest.ko dev=2
>>    509   495 root     D     1164   0%  47% insmod /mnt/mtd_speedtest.ko dev=2
>> mtd_speedtest: eraseblock write speed is 5370 KiB/s
>> mtd_speedtest: testing eraseblock read speed
>>    509   495 root     R     1164   0%  92% insmod /mnt/mtd_speedtest.ko dev=2
>>    509   495 root     R     1164   0%  91% insmod /mnt/mtd_speedtest.ko dev=2
>>    509   495 root     R     1164   0%  95% insmod /mnt/mtd_speedtest.ko dev=2
>> mtd_speedtest: eraseblock read speed is 5715 KiB/s
>> mtd_speedtest: testing page write speed
>>    509   495 root     D     1164   0%  48% insmod /mnt/mtd_speedtest.ko dev=2
>>    509   495 root     D     1164   0%  47% insmod /mnt/mtd_speedtest.ko dev=2
>>    509   495 root     D     1164   0%  50% insmod /mnt/mtd_speedtest.ko dev=2
>> mtd_speedtest: page write speed is 5224 KiB/s
>> mtd_speedtest: testing page read speed
>>    509   495 root     R     1164   0%  89% insmod /mnt/mtd_speedtest.ko dev=2
>>    509   495 root     R     1164   0%  94% insmod /mnt/mtd_speedtest.ko dev=2
>>    509   495 root     R     1164   0%  93% insmod /mnt/mtd_speedtest.ko dev=2
>> mtd_speedtest: page read speed is 5641 KiB/s
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>> ---
>> v1 --> v2:
>>    remove the useless nand commands: NAND_CMD_STATUS_ERRORx, NAND_CMD_DEPLETE1.
>>
>>   .../devicetree/bindings/mtd/atmel-nand.txt         |    3 +
>>   drivers/mtd/nand/atmel_nand.c                      |  373 ++++++++++++++++++--
>>   drivers/mtd/nand/atmel_nand_nfc.h                  |  106 ++++++
>>   3 files changed, 454 insertions(+), 28 deletions(-)
>>   create mode 100644 drivers/mtd/nand/atmel_nand_nfc.h
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
>> index d555421..88e3313 100644
>> --- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
>> +++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
>> @@ -6,6 +6,8 @@ Required properties:
>>   	and hardware ECC controller if available.
>>   	If the hardware ECC is PMECC, it should contain address and size for
>>   	PMECC, PMECC Error Location controller and ROM which has lookup tables.
>> +	If hardware supports Nand Flash Controller, it should contain address and
>> +	size for NFC command registers, NFC registers and NFC Sram.
>>   - atmel,nand-addr-offset : offset for the address latch.
>>   - atmel,nand-cmd-offset : offset for the command latch.
>>   - #address-cells, #size-cells : Must be present if the device has sub-nodes
>> @@ -29,6 +31,7 @@ Optional properties:
>>     sector size 1024.
>>   - nand-bus-width : 8 or 16 bus width if not present 8
>>   - nand-on-flash-bbt: boolean to enable on flash bbt option if not present false
>> +- atmel,has-nfc: boolean to enable Nand Flash Controller(NFC).
> yes but you need to update the compatible or check the IP support it too
> as has-nfc will mean I have the nfs on the hardware but not enable it
>
> the SoC dtsi will describe you have it but the board will decide to enable it or
> not

I can add some code to check whether is NFC supported by read SMC IP 
version. But I'm afraid
such code may not work for AVR arch.

Another way is just add a 'enable-nfc' compatible string. Which is for 
board to enable the NFC feature.

I'm prefer to the later one. What do you think?

>>   
>>   Examples:
>>   nand0: nand at 40000000,0 {
>> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
>> index f747791..48d7ee6 100644
>> --- a/drivers/mtd/nand/atmel_nand.c
>> +++ b/drivers/mtd/nand/atmel_nand.c
>> @@ -18,6 +18,9 @@
>>    *  Add Programmable Multibit ECC support for various AT91 SoC
>>    *     ? Copyright 2012 ATMEL, Hong Xu
>>    *
>> + *  Add Nand Flash Controller support for SAMA5 SoC
>> + *     ? Copyright 2013 ATMEL, Josh Wu (josh.wu at atmel.com)
>> + *
>>    * This program is free software; you can redistribute it and/or modify
>>    * it under the terms of the GNU General Public License version 2 as
>>    * published by the Free Software Foundation.
>> @@ -37,9 +40,11 @@
>>   #include <linux/mtd/nand.h>
>>   #include <linux/mtd/partitions.h>
>>   
>> +#include <linux/delay.h>
>>   #include <linux/dmaengine.h>
>>   #include <linux/gpio.h>
>>   #include <linux/io.h>
>> +#include <linux/interrupt.h>
>>   #include <linux/platform_data/atmel.h>
>>   #include <linux/pinctrl/consumer.h>
>>   
>> @@ -58,6 +63,7 @@ module_param(on_flash_bbt, int, 0);
>>   	__raw_writel((value), add + ATMEL_ECC_##reg)
>>   
>>   #include "atmel_nand_ecc.h"	/* Hardware ECC registers */
>> +#include "atmel_nand_nfc.h"	/* Nand Flash Controller definition */
>>   
>>   /* oob layout for large page size
>>    * bad block info is on bytes 0 and 1
>> @@ -85,6 +91,13 @@ static struct nand_ecclayout atmel_oobinfo_small = {
>>   	},
>>   };
>>   
>> +struct atmel_nfc {
>> +	void __iomem		*base_cmd_regs;
>> +	void __iomem		*hsmc_regs;
>> +	void __iomem		*sram_bank0;
>> +	dma_addr_t		sram_bank0_phys;
>> +};
>> +
>>   struct atmel_nand_host {
>>   	struct nand_chip	nand_chip;
>>   	struct mtd_info		mtd;
>> @@ -93,10 +106,15 @@ struct atmel_nand_host {
>>   	struct atmel_nand_data	board;
>>   	struct device		*dev;
>>   	void __iomem		*ecc;
>> +	int			irq;
>>   
>>   	struct completion	comp;
>>   	struct dma_chan		*dma_chan;
>>   
>> +	bool			has_nfc;
>> +	struct atmel_nfc	nfc;
>> +	struct completion	comp_nfc;
>> +
>>   	bool			has_pmecc;
>>   	u8			pmecc_corr_cap;
>>   	u16			pmecc_sector_size;
>> @@ -1357,6 +1375,7 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
>>   	board->det_pin = of_get_gpio(np, 2);
>>   
>>   	host->has_pmecc = of_property_read_bool(np, "atmel,has-pmecc");
>> +	host->has_nfc = of_property_read_bool(np, "atmel,has-nfc");
>>   
>>   	if (!(board->ecc_mode == NAND_ECC_HW) || !host->has_pmecc)
>>   		return 0;	/* Not using PMECC */
>> @@ -1469,6 +1488,275 @@ static int __init atmel_hw_nand_init_params(struct platform_device *pdev,
>>   	return 0;
>>   }
>>   
>> +/* SMC interrupt service routine */
>> +static irqreturn_t hsmc_interrupt(int irq, void *dev_id)
>> +{
>> +	struct atmel_nand_host *host = dev_id;
>> +	u32 status, mask, pending;
>> +	irqreturn_t ret = IRQ_NONE;
>> +
>> +	status = nfc_readl(host->nfc.hsmc_regs, SR);
>> +	mask = nfc_readl(host->nfc.hsmc_regs, IMR);
>> +	pending = status & mask;
>> +
>> +	if (pending & ATMEL_HSMC_NFC_XFR_DONE) {
>> +		complete(&host->comp_nfc);
>> +		nfc_writel(host->nfc.hsmc_regs, IDR, ATMEL_HSMC_NFC_XFR_DONE);
>> +		ret = IRQ_HANDLED;
>> +	} else if (pending & ATMEL_HSMC_NFC_RB_EDGE) {
>> +		complete(&host->comp_nfc);
>> +		nfc_writel(host->nfc.hsmc_regs, IDR, ATMEL_HSMC_NFC_RB_EDGE);
>> +		ret = IRQ_HANDLED;
>> +	} else if (pending & ATMEL_HSMC_NFC_CMD_DONE) {
>> +		complete(&host->comp_nfc);
>> +		nfc_writel(host->nfc.hsmc_regs, IDR, ATMEL_HSMC_NFC_CMD_DONE);
>> +		ret = IRQ_HANDLED;
>> +	}
> 	put esle ret = IRQ_NONE less code

right, I will do it in next version.

>> +
>> +	return ret;
>> +}
>> +
>> +/* NFC(Nand Flash Controller) related functions */
>> +static int nfc_wait_interrupt(struct atmel_nand_host *host, u32 flag)
>> +{
>> +	unsigned long timeout;
>> +	init_completion(&host->comp_nfc);
>> +
>> +	/* Enable interrupt that need to wait for */
>> +	nfc_writel(host->nfc.hsmc_regs, IER, flag);
>> +
>> +	timeout = wait_for_completion_timeout(&host->comp_nfc,
>> +			msecs_to_jiffies(NFC_TIME_OUT_MS));
>> +	if (timeout)
>> +		return 0;
>> +
>> +	/* Time out to wait for the interrupt */
>> +	dev_err(host->dev, "Time out to wait for interrupt: 0x%08x\n", flag);
>> +	return -ETIMEDOUT;
>> +}
>> +
>> +static int nfc_send_command(struct atmel_nand_host *host,
>> +	unsigned int cmd, unsigned int addr, unsigned char cycle0)
>> +{
>> +	unsigned long timeout;
>> +	dev_dbg(host->dev,
>> +		"nfc_cmd: 0x%08x, addr1234: 0x%08x, cycle0: 0x%02x\n",
>> +		cmd, addr, cycle0);
>> +
>> +	timeout = jiffies + msecs_to_jiffies(NFC_TIME_OUT_MS);
>> +	while (nfc_cmd_readl(NFCADDR_CMD_NFCBUSY, host->nfc.base_cmd_regs)
>> +			& NFCADDR_CMD_NFCBUSY) {
>> +		if (time_after(jiffies, timeout)) {
>> +			dev_err(host->dev,
>> +				"Time out to wait CMD_NFCBUSY ready!\n");
>> +			break;
> 			already timeout you still neeed to wait DONE?

ok. I will return timeout error in this case.

>> +		}
>> +	}
>> +	nfc_writel(host->nfc.hsmc_regs, CYCLE0, cycle0);
>> +	nfc_cmd_addr1234_writel(cmd, addr, host->nfc.base_cmd_regs);
>> +	return nfc_wait_interrupt(host, ATMEL_HSMC_NFC_CMD_DONE);
>> +}
>> +
>> +static int nfc_device_ready(struct mtd_info *mtd)
>> +{
>> +	struct nand_chip *nand_chip = mtd->priv;
>> +	struct atmel_nand_host *host = nand_chip->priv;
>> +	if (!nfc_wait_interrupt(host, ATMEL_HSMC_NFC_RB_EDGE))
>> +		return 1;
>> +	return 0;
>> +}
>> +
>> +static void nfc_select_chip(struct mtd_info *mtd, int chip)
>> +{
>> +	struct nand_chip *nand_chip = mtd->priv;
>> +	struct atmel_nand_host *host = nand_chip->priv;
>> +
>> +	if (chip == -1)
>> +		nfc_writel(host->nfc.hsmc_regs, CTRL, ATMEL_HSMC_NFC_DISABLE);
>> +	else
>> +		nfc_writel(host->nfc.hsmc_regs, CTRL, ATMEL_HSMC_NFC_ENABLE);
>> +}
>> +
>> +static int nfc_init(struct platform_device *pdev, struct mtd_info *mtd)
>> +{
>> +	struct nand_chip *nand_chip = mtd->priv;
>> +	struct atmel_nand_host *host = nand_chip->priv;
>> +	struct atmel_nfc *nfc = &host->nfc;
>> +	struct resource *nfc_cmd_regs, *nfc_hsmc_regs, *nfc_sram;
>> +
>> +	nfc_cmd_regs = platform_get_resource(pdev, IORESOURCE_MEM, 4);
>> +	if (!nfc_cmd_regs)
>> +		return -EINVAL;
>> +
>> +	nfc_hsmc_regs = platform_get_resource(pdev, IORESOURCE_MEM, 5);
>> +	if (!nfc_hsmc_regs)
>> +		return -EINVAL;
>> +
>> +	nfc_sram = platform_get_resource(pdev, IORESOURCE_MEM, 6);
>> +	if (!nfc_sram)
>> +		return -EINVAL;
>> +
>> +	nfc->base_cmd_regs = devm_ioremap_resource(&pdev->dev, nfc_cmd_regs);
>> +	if (IS_ERR(nfc->base_cmd_regs))
>> +		return PTR_ERR(nfc->base_cmd_regs);
>> +
>> +	nfc->hsmc_regs = devm_ioremap_resource(&pdev->dev, nfc_hsmc_regs);
>> +	if (IS_ERR(nfc->hsmc_regs))
>> +		return PTR_ERR(nfc->hsmc_regs);
>> +
>> +	nfc->sram_bank0 = devm_ioremap_resource(&pdev->dev, nfc_sram);
>> +	if (IS_ERR(nfc->sram_bank0))
>> +		return PTR_ERR(nfc->sram_bank0);
>> +
>> +	nfc->sram_bank0_phys = (dma_addr_t)nfc_sram->start;
>> +
>> +	dev_info(host->dev, "Using NFC\n");
>> +	return 0;
>> +}
>> +
>> +static int nfc_make_addr(struct mtd_info *mtd, int column, int page_addr,
>> +		unsigned int *addr1234, unsigned int *cycle0)
>> +{
>> +	struct nand_chip *chip = mtd->priv;
>> +
>> +	int acycle = 0;
>> +	unsigned char addr_bytes[8];
>> +	int index = 0, bit_shift;
>> +
>> +	BUG_ON(addr1234 == NULL || cycle0 == NULL);
>> +
>> +	*cycle0 = 0;
>> +	*addr1234 = 0;
>> +
>> +	if (column != -1) {
>> +		if (chip->options & NAND_BUSWIDTH_16)
>> +			column >>= 1;
>> +		addr_bytes[acycle++] = column & 0xff;
>> +		if (mtd->writesize > 512)
>> +			addr_bytes[acycle++] = (column >> 8) & 0xff;
>> +	}
>> +
>> +	if (page_addr != -1) {
>> +		addr_bytes[acycle++] = page_addr & 0xff;
>> +		addr_bytes[acycle++] = (page_addr >> 8) & 0xff;
>> +		if (chip->chipsize > (128 << 20))
>> +			addr_bytes[acycle++] = (page_addr >> 16) & 0xff;
>> +	}
>> +
>> +	if (acycle > 4)
>> +		*cycle0 = addr_bytes[index++];
>> +
>> +	for (bit_shift = 0; index < acycle; bit_shift += 8)
>> +		*addr1234 += addr_bytes[index++] << bit_shift;
>> +
>> +	return acycle << 19;	/* return acycle in cmd register */
>> +}
>> +
>> +static void nfc_nand_command(struct mtd_info *mtd, unsigned int command,
>> +				int column, int page_addr)
>> +{
>> +	struct nand_chip *chip = mtd->priv;
>> +	struct atmel_nand_host *host = chip->priv;
>> +	unsigned long timeout;
>> +	unsigned int nfc_addr_cmd = 0;
>> +
>> +	unsigned int cmd1 = command << 2;
>> +
>> +	/* Set default settings: no cmd2, no addr cycle. read from nand */
>> +	unsigned int cmd2 = 0;
>> +	unsigned int vcmd2 = 0;
>> +	int acycle = NFCADDR_CMD_ACYCLE_NONE;
>> +	int csid = NFCADDR_CMD_CSID_3;
>> +	int dataen = NFCADDR_CMD_DATADIS;
>> +	int nfcwr = NFCADDR_CMD_NFCRD;
>> +	unsigned int addr1234 = 0;
>> +	unsigned int cycle0 = 0;
>> +	bool do_addr = true;
>> +
>> +	dev_dbg(host->dev, "%s: cmd = 0x%02x, col = 0x%08x, page = 0x%08x\n",
>> +	     __func__, command, column, page_addr);
>> +
>> +	switch (command) {
>> +	case NAND_CMD_RESET:
>> +		nfc_addr_cmd = cmd1 | acycle | csid | dataen | nfcwr;
>> +		nfc_send_command(host, nfc_addr_cmd, addr1234, cycle0);
>> +		udelay(chip->chip_delay);
>> +
>> +		nfc_nand_command(mtd, NAND_CMD_STATUS, -1, -1);
>> +		timeout = jiffies + msecs_to_jiffies(NFC_TIME_OUT_MS);
>> +		while (!(chip->read_byte(mtd) & NAND_STATUS_READY)) {
>> +			if (time_after(jiffies, timeout)) {
>> +				dev_err(host->dev,
>> +					"Time out to wait status ready!\n");
>> +				break;
>> +			}
>> +		}
>> +		return;
>> +	case NAND_CMD_STATUS:
>> +		do_addr = false;
>> +		break;
>> +	case NAND_CMD_PARAM:
>> +	case NAND_CMD_READID:
>> +		do_addr = false;
>> +		acycle = NFCADDR_CMD_ACYCLE_1;
>> +		if (column != -1)
>> +			addr1234 = column;
>> +		break;
>> +	case NAND_CMD_RNDOUT:
>> +		cmd2 = NAND_CMD_RNDOUTSTART << 10;
>> +		vcmd2 = NFCADDR_CMD_VCMD2;
>> +		break;
>> +	case NAND_CMD_READ0:
>> +	case NAND_CMD_READOOB:
>> +		if (command == NAND_CMD_READOOB) {
>> +			column += mtd->writesize;
>> +			command = NAND_CMD_READ0; /* only READ0 is valid */
>> +			cmd1 = command << 2;
>> +		}
>> +
>> +		cmd2 = NAND_CMD_READSTART << 10;
>> +		vcmd2 = NFCADDR_CMD_VCMD2;
>> +		break;
>> +	/* For prgramming command, the cmd need set to write enable */
>> +	case NAND_CMD_PAGEPROG:
>> +	case NAND_CMD_SEQIN:
>> +	case NAND_CMD_RNDIN:
>> +		nfcwr = NFCADDR_CMD_NFCWR;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	if (do_addr)
>> +		acycle = nfc_make_addr(mtd, column, page_addr, &addr1234,
>> +				&cycle0);
>> +
>> +	nfc_addr_cmd = cmd1 | cmd2 | vcmd2 | acycle | csid | dataen | nfcwr;
>> +	nfc_send_command(host, nfc_addr_cmd, addr1234, cycle0);
>> +
>> +	/*
>> +	 * Program and erase have their own busy handlers status, sequential
>> +	 * in, and deplete1 need no delay.
>> +	 */
>> +	switch (command) {
>> +	case NAND_CMD_CACHEDPROG:
>> +	case NAND_CMD_PAGEPROG:
>> +	case NAND_CMD_ERASE1:
>> +	case NAND_CMD_ERASE2:
>> +	case NAND_CMD_RNDIN:
>> +	case NAND_CMD_STATUS:
>> +	case NAND_CMD_RNDOUT:
>> +	case NAND_CMD_SEQIN:
>> +	case NAND_CMD_READID:
>> +		return;
>> +
>> +	case NAND_CMD_READ0:
>> +		/* fall through */
>> +	default:
>> +		nfc_wait_interrupt(host, ATMEL_HSMC_NFC_RB_EDGE);
>> +	}
>> +}
>> +
>>   /*
>>    * Probe for the NAND device.
>>    */
>> @@ -1479,7 +1767,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
>>   	struct nand_chip *nand_chip;
>>   	struct resource *mem;
>>   	struct mtd_part_parser_data ppdata = {};
>> -	int res;
>> +	int res, irq;
>>   	struct pinctrl *pinctrl;
>>   
>>   	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> @@ -1523,7 +1811,6 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
>>   	/* Set address of NAND IO lines */
>>   	nand_chip->IO_ADDR_R = host->io_base;
>>   	nand_chip->IO_ADDR_W = host->io_base;
>> -	nand_chip->cmd_ctrl = atmel_nand_cmd_ctrl;
>>   
>>   	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
>>   	if (IS_ERR(pinctrl)) {
>> @@ -1532,41 +1819,69 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
>>   		goto err_ecc_ioremap;
>>   	}
>>   
>> -	if (gpio_is_valid(host->board.rdy_pin)) {
>> -		res = gpio_request(host->board.rdy_pin, "nand_rdy");
>> -		if (res < 0) {
>> -			dev_err(&pdev->dev,
>> -				"can't request rdy gpio %d\n",
>> -				host->board.rdy_pin);
>> +	if (host->has_nfc) {
> 		split in 2 function
>
> 		nfs_init

ok. I will add a function to do this.

>> +		res = nfc_init(pdev, mtd);
>> +		if (res)
>> +			goto err_ecc_ioremap;
>> +		nand_chip->select_chip = nfc_select_chip;
>> +		nand_chip->dev_ready = nfc_device_ready;
>> +		nand_chip->cmdfunc = nfc_nand_command;
>> +
>> +		/* Initialize the interrupt for NFC */
>> +		irq = platform_get_irq(pdev, 0);
>> +		if (irq < 0) {
>> +			dev_err(host->dev, "Cannot get HSMC irq!\n");
>>   			goto err_ecc_ioremap;
>>   		}
>>   
>> -		res = gpio_direction_input(host->board.rdy_pin);
>> -		if (res < 0) {
>> -			dev_err(&pdev->dev,
>> -				"can't request input direction rdy gpio %d\n",
>> -				host->board.rdy_pin);
>> +		res = request_irq(irq, hsmc_interrupt, 0, "hsmc", host);
> 		devm_request_irq

thank you to catch that. I'll fix it.

>> +		if (res) {
>> +			dev_err(&pdev->dev, "Unable to request HSMC irq %d\n",
>> +				irq);
>>   			goto err_ecc_ioremap;
>>   		}
>>   
>> -		nand_chip->dev_ready = atmel_nand_device_ready;
>> -	}
>> +		host->irq = irq;
>> +	} else {
> 		rest

I can't get this point.

>> +		nand_chip->cmd_ctrl = atmel_nand_cmd_ctrl;
>> +
>> +		if (gpio_is_valid(host->board.rdy_pin)) {
>> +			res = gpio_request(host->board.rdy_pin, "nand_rdy");
>> +			if (res < 0) {
>> +				dev_err(&pdev->dev,
>> +					"can't request rdy gpio %d\n",
>> +					host->board.rdy_pin);
>> +				goto err_ecc_ioremap;
>> +			}
>>   
>> -	if (gpio_is_valid(host->board.enable_pin)) {
>> -		res = gpio_request(host->board.enable_pin, "nand_enable");
>> -		if (res < 0) {
>> -			dev_err(&pdev->dev,
>> -				"can't request enable gpio %d\n",
>> -				host->board.enable_pin);
>> -			goto err_ecc_ioremap;
>> +			res = gpio_direction_input(host->board.rdy_pin);
>> +			if (res < 0) {
>> +				dev_err(&pdev->dev,
>> +					"can't request input direction rdy gpio %d\n",
>> +					host->board.rdy_pin);
>> +				goto err_ecc_ioremap;
>> +			}
>> +
>> +			nand_chip->dev_ready = atmel_nand_device_ready;
>>   		}
>>   
>> -		res = gpio_direction_output(host->board.enable_pin, 1);
>> -		if (res < 0) {
>> -			dev_err(&pdev->dev,
>> -				"can't request output direction enable gpio %d\n",
>> -				host->board.enable_pin);
>> -			goto err_ecc_ioremap;
>> +		if (gpio_is_valid(host->board.enable_pin)) {
>> +			res = gpio_request(host->board.enable_pin,
> we need to use devm_ here too
> and everywhere we can in this driver

yes, but seems you already sent one patch to use devm_ for this driver.
https://patchwork.kernel.org/patch/1589071/
It is not merged in at91 tree yet.

So what do you think if I put that patch rebased and put it as one of 
this NFC series patches?

>> +				"nand_enable");
>> +			if (res < 0) {
>> +				dev_err(&pdev->dev,
>> +					"can't request enable gpio %d\n",
>> +					host->board.enable_pin);
>> +				goto err_ecc_ioremap;
>> +			}
>> +
>> +			res = gpio_direction_output(host->board.enable_pin, 1);
>> +			if (res < 0) {
>> +				dev_err(&pdev->dev,
>> +					"can't request output direction enable gpio %d\n",
>> +					host->board.enable_pin);
>> +				goto err_ecc_ioremap;
>> +			}
>>   		}
>>   	}
>>   
>> @@ -1682,6 +1997,8 @@ err_ecc_ioremap:
>>   	iounmap(host->io_base);
>>   err_nand_ioremap:
>>   	kfree(host);
>> +	if (host->irq)
>> +		free_irq(host->irq, host);
>>   	return res;
>>   }
>>   
>> diff --git a/drivers/mtd/nand/atmel_nand_nfc.h b/drivers/mtd/nand/atmel_nand_nfc.h
>> new file mode 100644
>> index 0000000..ca124de
>> --- /dev/null
>> +++ b/drivers/mtd/nand/atmel_nand_nfc.h
>> @@ -0,0 +1,106 @@
>> +/*
>> + * Atmel Nand Flash Controller (NFC) - System peripherals regsters.
>> + * Based on SAMA5D3 datasheet.
>> + *
>> + * ? Copyright 2013 Atmel Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License as published by the
>> + * Free Software Foundation; either version 2 of the License, or (at your
>> + * option) any later version.
>> + */
>> +
>> +#ifndef ATMEL_NAND_NFC_H
>> +#define ATMEL_NAND_NFC_H
>> +
>> +/*
>> + * HSMC NFC registers
>> + */
>> +#define ATMEL_HSMC_NFC_CFG		0x00	/* NFC Configuration Register */
>> +#define		ATMEL_HSMC_PAGESIZE_512		(0)
>> +#define		ATMEL_HSMC_PAGESIZE_1024	(1)
>> +#define		ATMEL_HSMC_PAGESIZE_2048	(2)
>> +#define		ATMEL_HSMC_PAGESIZE_4096	(3)
>> +#define		ATMEL_HSMC_PAGESIZE_8192	(4)
> 	keep the << 0

ok. i'll fix it.

>> +#define		ATMEL_HSMC_WSPARE		(1 << 8)
>> +#define		ATMEL_HSMC_RSPARE		(1 << 9)
>> +#define		ATMEL_HSMC_EDGE_CTRL_RISING	(0 << 12)
>> +#define		ATMEL_HSMC_EDGE_CTRL_FALLING	(1 << 12)
>> +#define		ATMEL_HSMC_RBEDGE		(1 << 13)
>> +#define		ATMEL_HSMC_NFC_DTOCYC		(0xf << 16)
>> +#define		ATMEL_HSMC_NFC_DTOMUL		(0x7 << 20)
>> +#define		ATMEL_HSMC_NFC_SPARESIZE	(0x7f << 24)
>> +
>> +#define ATMEL_HSMC_NFC_CTRL		0x04	/* NFC Control Register */
>> +#define		ATMEL_HSMC_NFC_ENABLE		(1 << 0)
>> +#define		ATMEL_HSMC_NFC_DISABLE		(1 << 1)
>> +
>> +#define ATMEL_HSMC_NFC_SR		0x08	/* NFC Status Register */
>> +#define		ATMEL_HSMC_NFC_STATUS		(1 << 0)
>> +#define		ATMEL_HSMC_NFC_RB_RISE		(1 << 4)
>> +#define		ATMEL_HSMC_NFC_RB_FALL		(1 << 5)
>> +#define		ATMEL_HSMC_NFC_BUSY		(1 << 8)
>> +#define		ATMEL_HSMC_NFC_WR		(1 << 11)
>> +#define		ATMEL_HSMC_NFC_CSID		(7 << 12)
>> +#define		ATMEL_HSMC_NFC_XFR_DONE		(1 << 16)
>> +#define		ATMEL_HSMC_NFC_CMD_DONE		(1 << 17)
>> +#define		ATMEL_HSMC_NFC_DTOE		(1 << 20)
>> +#define		ATMEL_HSMC_NFC_UNDEF		(1 << 21)
>> +#define		ATMEL_HSMC_NFC_AWB		(1 << 22)
>> +#define		ATMEL_HSMC_NFC_ASE		(1 << 23)
>> +#define		ATMEL_HSMC_NFC_RB_EDGE		(1 << 24)
>> +
>> +#define ATMEL_HSMC_NFC_IER		0x0c
>> +#define ATMEL_HSMC_NFC_IDR		0x10
>> +#define ATMEL_HSMC_NFC_IMR		0x14
>> +#define ATMEL_HSMC_NFC_CYCLE0		0x18	/* NFC Address Cycle Zero */
>> +#define		ATMEL_HSMC_NFC_ADDR_CYCLE0	(0xff)
>> +
>> +#define ATMEL_HSMC_NFC_BANK		0x1c	/* NFC Bank Register */
>> +#define		ATMEL_HSMC_NFC_BANK0	(0 << 0)
>> +#define		ATMEL_HSMC_NFC_BANK1	(1 << 0)
>> +#define		NFC_SRAM_BANK_OFFSET	(0x1200)
>> +
>> +#define nfc_writel(addr, reg, value) \
>> +	writel((value), (addr) + ATMEL_HSMC_NFC_##reg)
>> +
>> +#define nfc_readl(addr, reg) \
>> +	readl_relaxed((addr) + ATMEL_HSMC_NFC_##reg)
>> +
>> +/*
>> + * NFC Address Command definitions
>> + */
>> +#define NFCADDR_CMD_CMD1	(0xff << 2)	/* Command for Cycle 1 */
>> +#define NFCADDR_CMD_CMD2	(0xff << 10)	/* Command for Cycle 2 */
>> +#define NFCADDR_CMD_VCMD2	(0x1 << 18)	/* Valid Cycle 2 Command */
>> +#define NFCADDR_CMD_ACYCLE	(0x7 << 19)	/* Number of Address required */
>> +#define   NFCADDR_CMD_ACYCLE_NONE	(0x0 << 19)
>> +#define   NFCADDR_CMD_ACYCLE_1		(0x1 << 19)
>> +#define   NFCADDR_CMD_ACYCLE_2		(0x2 << 19)
>> +#define   NFCADDR_CMD_ACYCLE_3		(0x3 << 19)
>> +#define   NFCADDR_CMD_ACYCLE_4		(0x4 << 19)
>> +#define   NFCADDR_CMD_ACYCLE_5		(0x5 << 19)
>> +#define NFCADDR_CMD_CSID	(0x7 << 22)	/* Chip Select Identifier */
>> +#define   NFCADDR_CMD_CSID_0		(0x0 << 22)
>> +#define   NFCADDR_CMD_CSID_1		(0x1 << 22)
>> +#define   NFCADDR_CMD_CSID_2		(0x2 << 22)
>> +#define   NFCADDR_CMD_CSID_3		(0x3 << 22)
>> +#define   NFCADDR_CMD_CSID_4		(0x4 << 22)
>> +#define   NFCADDR_CMD_CSID_5		(0x5 << 22)
>> +#define   NFCADDR_CMD_CSID_6		(0x6 << 22)
>> +#define   NFCADDR_CMD_CSID_7		(0x7 << 22)
>> +#define NFCADDR_CMD_DATAEN	(0x1 << 25)	/* Data Transfer Enable */
>> +#define NFCADDR_CMD_DATADIS	(0x0 << 25)	/* Data Transfer Disable */
>> +#define NFCADDR_CMD_NFCRD	(0x0 << 26)	/* NFC Read Enable */
>> +#define NFCADDR_CMD_NFCWR	(0x1 << 26)	/* NFC Write Enable */
>> +#define NFCADDR_CMD_NFCBUSY	(0x1 << 27)	/* NFC Busy */
>> +
>> +#define nfc_cmd_addr1234_writel(cmd, addr1234, nfc_base) \
>> +	writel((addr1234), (cmd) + nfc_base)
>> +
>> +#define nfc_cmd_readl(bitstatus, nfc_base) \
>> +	readl_relaxed((bitstatus) + nfc_base)
>> +
>> +#define NFC_TIME_OUT_MS		100
>> +
>> +#endif
>> -- 
>> 1.7.9.5
>>

Best Regards,
Josh Wu
