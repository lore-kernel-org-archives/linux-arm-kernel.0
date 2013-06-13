From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 13 Jun 2013 09:59:21 +0800
Subject: [PATCH 3/6] mtd: atmel_nand: add Nand Flash Controller (NFC)
 support
In-Reply-To: <20130610132211.GO23653@game.jcrosoft.org>
References: <1370860014-1770-1-git-send-email-josh.wu@atmel.com>
 <1370860014-1770-4-git-send-email-josh.wu@atmel.com>
 <20130610132211.GO23653@game.jcrosoft.org>
Message-ID: <51B92779.8030309@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Jean-Christophe PLAGNIOL-VILLARD

On 6/10/2013 9:22 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> +
>>   /*
>>    * Minimal-overhead PIO for data access.
>>    */
>> @@ -1341,6 +1409,9 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
>>   
>>   	host->has_pmecc = of_property_read_bool(np, "atmel,has-pmecc");
>>   
>> +	/* load the nfc driver if there is */
>> +	of_platform_populate(np, NULL, NULL, host->dev);
> what is this?????

Here I call of_platform_populate() to make sure the NFC driver's probe 
function is called.

In this version, in the dts file, the NFC device node is as sub-node of 
Atmel NAND device like:

nand0: nand at 40000000 {
     compatible = "atmel,at91rm9200-nand";
     #address-cells = <1>;
     #size-cells = <1>;
     ranges;
         ...
         nfc at 70000000 {
         compatible = "atmel,sama5d3-nfc";
            reg =  <
                       ...
                       >;
         };


So when NAND driver is probed, It will populate its sub-node (i.e NFC 
device node). And this make
sure after the function (atmel_of_init_port) is called and the NFC 
driver's probe function is already
called and NFC resources should be initialized.

>
>
>> +
>>   	if (!(board->ecc_mode == NAND_ECC_HW) || !host->has_pmecc)
>>   		return 0;	/* Not using PMECC */
>>   
>> @@ -1452,6 +1523,238 @@ static int __init atmel_hw_nand_init_params(struct platform_device *pdev,
>>   	return 0;
>>   }
>>   
>> +/* SMC interrupt service routine */
>> +static irqreturn_t hsmc_interrupt(int irq, void *dev_id)
>> +{
>> +	struct atmel_nand_host *host = dev_id;
>> +	u32 status, mask, pending;
>> +	irqreturn_t ret = IRQ_HANDLED;
>> +
>> +	status = nfc_readl(host->nfc->hsmc_regs, SR);
>> +	mask = nfc_readl(host->nfc->hsmc_regs, IMR);
>> +	pending = status & mask;
>> +
>> +	if (pending & NFC_SR_XFR_DONE) {
>> +		complete(&host->nfc->comp_nfc);
>> +		nfc_writel(host->nfc->hsmc_regs, IDR, NFC_SR_XFR_DONE);
>> +	} else if (pending & NFC_SR_RB_EDGE) {
>> +		complete(&host->nfc->comp_nfc);
>> +		nfc_writel(host->nfc->hsmc_regs, IDR, NFC_SR_RB_EDGE);
>> +	} else if (pending & NFC_SR_CMD_DONE) {
>> +		complete(&host->nfc->comp_nfc);
>> +		nfc_writel(host->nfc->hsmc_regs, IDR, NFC_SR_CMD_DONE);
>> +	} else {
>> +		ret = IRQ_NONE;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +/* NFC(Nand Flash Controller) related functions */
>> +static int nfc_wait_interrupt(struct atmel_nand_host *host, u32 flag)
>> +{
>> +	unsigned long timeout;
>> +	init_completion(&host->nfc->comp_nfc);
>> +
>> +	/* Enable interrupt that need to wait for */
>> +	nfc_writel(host->nfc->hsmc_regs, IER, flag);
>> +
>> +	timeout = wait_for_completion_timeout(&host->nfc->comp_nfc,
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
>> +	while (nfc_cmd_readl(NFCADDR_CMD_NFCBUSY, host->nfc->base_cmd_regs)
>> +			& NFCADDR_CMD_NFCBUSY) {
>> +		if (time_after(jiffies, timeout)) {
>> +			dev_err(host->dev,
>> +				"Time out to wait CMD_NFCBUSY ready!\n");
>> +			return -ETIMEDOUT;
>> +		}
>> +	}
>> +	nfc_writel(host->nfc->hsmc_regs, CYCLE0, cycle0);
>> +	nfc_cmd_addr1234_writel(cmd, addr, host->nfc->base_cmd_regs);
>> +	return nfc_wait_interrupt(host, NFC_SR_CMD_DONE);
>> +}
>> +
>> +static int nfc_device_ready(struct mtd_info *mtd)
>> +{
>> +	struct nand_chip *nand_chip = mtd->priv;
>> +	struct atmel_nand_host *host = nand_chip->priv;
>> +	if (!nfc_wait_interrupt(host, NFC_SR_RB_EDGE))
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
>> +		nfc_writel(host->nfc->hsmc_regs, CTRL, NFC_CTRL_DISABLE);
>> +	else
>> +		nfc_writel(host->nfc->hsmc_regs, CTRL, NFC_CTRL_ENABLE);
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
>> +		nfc_wait_interrupt(host, NFC_SR_RB_EDGE);
>> +	}
>> +}
>> +
>> +static struct platform_driver atmel_nand_nfc_driver;
>>   /*
>>    * Probe for the NAND device.
>>    */
>> @@ -1462,7 +1765,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
>>   	struct nand_chip *nand_chip;
>>   	struct resource *mem;
>>   	struct mtd_part_parser_data ppdata = {};
>> -	int res;
>> +	int res, irq;
>>   	struct pinctrl *pinctrl;
>>   
>>   	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> @@ -1478,6 +1781,10 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
>>   		return -ENOMEM;
>>   	}
>>   
>> +	res = platform_driver_register(&atmel_nand_nfc_driver);
>> +	if (res)
>> +		printk(KERN_ERR "atmel_nand: can't register NFC driver\n");
>> +
> and this????

Did you mean the printk()?

Sorry, I forgot to replace the printk() function, I willuse dev_err() in 
next version.

Best Regards,
Josh Wu

>>   	host->io_base = devm_request_and_ioremap(&pdev->dev, mem);
>>   	if (host->io_base == NULL) {
>>   		printk(KERN_ERR "atmel_nand: ioremap failed\n");
>> @@ -1505,7 +1812,6 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
>>   	/* Set address of NAND IO lines */
>>   	nand_chip->IO_ADDR_R = host->io_base;
>>   	nand_chip->IO_ADDR_W = host->io_base;
>> -	nand_chip->cmd_ctrl = atmel_nand_cmd_ctrl;
>>   
>>   	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
>>   	if (IS_ERR(pinctrl)) {
>> @@ -1514,44 +1820,34 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
>>   		goto err_nand_ioremap;
>>   	}
>>   
> Best Regards,
> J.
