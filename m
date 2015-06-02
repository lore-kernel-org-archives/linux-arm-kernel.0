From: stefan@agner.ch (Stefan Agner)
Date: Tue, 02 Jun 2015 11:01:50 +0200
Subject: [PATCH v4 1/6] mtd: nand: =?UTF-8?Q?vf=36=31=30=5Fnfc=3A=20Fr?=
 =?UTF-8?Q?eescale=20NFC=20for=20VF=36=31=30=2C=20MPC=35=31=32=35=20and=20?=
 =?UTF-8?Q?others?=
In-Reply-To: <20150602013205.GA4917@ld-irv-0074>
References: <1427300909-20825-1-git-send-email-stefan@agner.ch>
 <1427300909-20825-2-git-send-email-stefan@agner.ch>
 <20150602013205.GA4917@ld-irv-0074>
Message-ID: <59f0d64e160e7b8dabaf086d368d00c4@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

Thanks for the review!

FYI, in between I have some patches pending which enable ONFI and some
other minor improvements. Those changes already went upstream in U-Boot,
I will port them to the Linux version.

Hence the next version will also include those changes...

FWIW, the U-boot thread:
http://thread.gmane.org/gmane.comp.boot-loaders.u-boot/220416


On 2015-06-02 03:32, Brian Norris wrote:
> Hi Stefan,
> 
> Late review...
> 
> On Wed, Mar 25, 2015 at 05:28:24PM +0100, Stefan Agner wrote:
>> This driver supports Freescale NFC (NAND flash controller) found on
>> Vybrid (VF610), MPC5125, MCF54418 and Kinetis K70.
>>
>> Limitations:
>> - DMA and pipelining not used
>> - Pages larger than 2k are not supported
>> - No hardware ECC
>>
>> The driver has only been tested on Vybrid (VF610).
>>
>> Signed-off-by: Bill Pringlemeir <bpringlemeir@nbsps.com>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  MAINTAINERS                  |   6 +
>>  drivers/mtd/nand/Kconfig     |  12 +
>>  drivers/mtd/nand/Makefile    |   1 +
>>  drivers/mtd/nand/vf610_nfc.c | 686 +++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 705 insertions(+)
>>  create mode 100644 drivers/mtd/nand/vf610_nfc.c
>>
> ...
>> diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
>> new file mode 100644
>> index 0000000..23c1510
>> --- /dev/null
>> +++ b/drivers/mtd/nand/vf610_nfc.c
>> @@ -0,0 +1,686 @@
>> +/*
>> + * Copyright 2009-2015 Freescale Semiconductor, Inc. and others
>> + *
>> + * Description: MPC5125, VF610, MCF54418 and Kinetis K70 Nand driver.
>> + * Jason ported to M54418TWR and MVFA5 (VF610).
>> + * Authors: Stefan Agner <stefan.agner@toradex.com>
>> + *          Bill Pringlemeir <bpringlemeir@nbsps.com>
>> + *          Shaohui Xie <b21989@freescale.com>
>> + *          Jason Jin <Jason.jin@freescale.com>
>> + *
>> + * Based on original driver mpc5121_nfc.c.
> 
> It's not supremely obvious to me: what's the relationship between these
> drivers? How similar is the IP, if at all?

I think this is the driver the initial authors templated from (Jason,
Shaohui).

It appears to me that the NFC in MPC5121 is a remote relative of this
IP: There are some register which are named similar, but usually the
layout is quite different. Also the command sequencing seems to be
handled differently...

Note that Bill Pringlemeir shares this opinion, as he stated in a thread
related to his initial RFC patch submission:
http://thread.gmane.org/gmane.linux.drivers.mtd/49878/focus=49885


<snip>
>> +static inline void vf610_nfc_memcpy(void *dst, const void *src, size_t n)
>> +{
>> +	/*
>> +	 * Use this accessor for the interal SRAM buffers. On ARM we can
>> +	 * treat the SRAM buffer as if its memory, hence use memcpy
> 
> s/its/it's/
> or
> s/its/it is/
> 
>> +	 */
>> +	memcpy(dst, src, n);
> 
> I'm not clear on all the reasoning in your comment. Is this really
> specific to ARM, that you can treat SRAM like memory? If so, should this
> driver have some dependency on ARM?

I do not have a PowerPC here, so I can't test it actually. My guess
would be that the PowerPC will behave similar and hence allow to use
memcpy too.

This memcpy encapsulation was suggested by Bill, and I think it makes
sense since the SRAM is part of the IP register map, it _could_ probably
behave different than normal SRAM and hence need special treatment...
However, at least on ARM memcpy works fine (and we can make use of the
assembler optimized variants of it).

I will alter the comment to read somewhat like:
/*
 * Use this accessor for the internal SRAM buffers. On ARM platforms,
it's
 * known that the driver can treat the SRAM buffer as if it's memory.
Other
 * platform might need to treat that buffer differently.
 *
 * For the time being, use memcpy
 */


> 
> Also, if you're really trying to handle iomem, it makes sense to
> annotate the 2nd argument with __iomem. Then sparse will only complain
> on the memcpy(), which has a proper comment explanation, rather than on
> every call site for vf610_nfc_memcpy(). i.e.:
> 
> static inline void vf610_nfc_memcpy(void *dst, const void __iomem *src,
> 				    size_t n)
> 

Agreed.


>> +}
>> +
>> +/* Clear flags for upcoming command */
>> +static inline void vf610_nfc_clear_status(struct vf610_nfc *nfc)
>> +{
>> +	void __iomem *reg = nfc->regs + NFC_IRQ_STATUS;
>> +	u32 tmp = __raw_readl(reg);
> 
> Why are you using __raw_xxx variants here, whereas you use readl() in
> others? The __raw_xxx variants do not have the normal endian awareness,
> nor do they have implicit I/O barriers. I'd bet you should be using the
> {read,write}l_relaxed() or {read,write}l(), depending on whether this is
> performance critical and you handle the consistency issues elsewhere.
> 
> (Same comment applies to all the __raw_xxx usages in this driver, I
> think.)
> 
>> +
>> +	tmp |= CMD_DONE_CLEAR_BIT | IDLE_CLEAR_BIT;
>> +	__raw_writel(tmp, reg);
>> +}
>> +
>> +static inline void vf610_nfc_done(struct vf610_nfc *nfc)
>> +{
>> +	int rv;
>> +
>> +	/*
>> +	 * Barrier is needed after this write. This write need
>> +	 * to be done before reading the next register the first
>> +	 * time.
>> +	 * vf610_nfc_set implicates such a barrier by using writel
>> +	 * to write to the register.
>> +	 */
>> +	vf610_nfc_set(nfc, NFC_IRQ_STATUS, IDLE_EN_BIT);
>> +	vf610_nfc_set(nfc, NFC_FLASH_CMD2, START_BIT);
>> +
>> +	if (!(vf610_nfc_read(nfc, NFC_IRQ_STATUS) & IDLE_IRQ_BIT)) {
>> +		rv = wait_event_timeout(nfc->irq_waitq,
>> +			(vf610_nfc_read(nfc, NFC_IRQ_STATUS) & IDLE_IRQ_BIT),
>> +					NFC_TIMEOUT);
> 
> This looks like you're doing a standard IRQ-based wait-for-completion,
> except that you're also including some extra register polling. Would
> this work just as well using a struct completion
> (wait_for_completion_timeout() and complete())? Or is the register poll
> necessary?
> 
>> +		if (!rv)
>> +			dev_warn(nfc->dev, "Timeout while waiting for BUSY.\n");
>> +	}
>> +	vf610_nfc_clear_status(nfc);
>> +}
>> +
>> +static u8 vf610_nfc_get_id(struct vf610_nfc *nfc, int col)
>> +{
>> +	u32 flash_id;
>> +
>> +	if (col < 4) {
>> +		flash_id = vf610_nfc_read(nfc, NFC_FLASH_STATUS1);
>> +		return (flash_id >> (3-col)*8) & 0xff;
> 
> Add spaces around the arithmetic, please.
> 
>> +	} else {
>> +		flash_id = vf610_nfc_read(nfc, NFC_FLASH_STATUS2);
>> +		return flash_id >> 24;
>> +	}
>> +}
>> +
>> +static u8 vf610_nfc_get_status(struct vf610_nfc *nfc)
>> +{
>> +	return vf610_nfc_read(nfc, NFC_FLASH_STATUS2) & STATUS_BYTE1_MASK;
>> +}
>> +
>> +static void vf610_nfc_send_command(struct vf610_nfc *nfc, u32 cmd_byte1,
>> +				   u32 cmd_code)
>> +{
>> +	void __iomem *reg = nfc->regs + NFC_FLASH_CMD2;
>> +	u32 tmp;
>> +
>> +	vf610_nfc_clear_status(nfc);
>> +
>> +	tmp = __raw_readl(reg);
>> +	tmp &= ~(CMD_BYTE1_MASK | CMD_CODE_MASK | BUFNO_MASK);
>> +	tmp |= cmd_byte1 << CMD_BYTE1_SHIFT;
>> +	tmp |= cmd_code << CMD_CODE_SHIFT;
>> +	__raw_writel(tmp, reg);
>> +}
>> +
>> +static void vf610_nfc_send_commands(struct vf610_nfc *nfc, u32 cmd_byte1,
>> +				    u32 cmd_byte2, u32 cmd_code)
>> +{
>> +	void __iomem *reg = nfc->regs + NFC_FLASH_CMD1;
>> +	u32 tmp;
>> +
>> +	vf610_nfc_send_command(nfc, cmd_byte1, cmd_code);
>> +
>> +	tmp = __raw_readl(reg);
>> +	tmp &= ~CMD_BYTE2_MASK;
>> +	tmp |= cmd_byte2 << CMD_BYTE2_SHIFT;
>> +	__raw_writel(tmp, reg);
>> +}
>> +
>> +static irqreturn_t vf610_nfc_irq(int irq, void *data)
>> +{
>> +	struct mtd_info *mtd = data;
>> +	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
>> +
>> +	vf610_nfc_clear(nfc, NFC_IRQ_STATUS, IDLE_EN_BIT);
>> +	wake_up(&nfc->irq_waitq);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static void vf610_nfc_addr_cycle(struct vf610_nfc *nfc, int column, int page)
>> +{
>> +	if (column != -1) {
>> +		if (nfc->chip.options | NAND_BUSWIDTH_16)
> 
> smatch caught a hard-to-spot one here:
> 
> drivers/mtd/nand/vf610_nfc.c:335 vf610_nfc_addr_cycle() warn:
> suspicious bitop condition [smatch]
> 
> You probably meant:
> 
> 		if (nfc->chip.options & NAND_BUSWIDTH_16)
> 
>> +			column = column/2;
>> +		vf610_nfc_set_field(nfc, NFC_COL_ADDR, COL_ADDR_MASK,
>> +				    COL_ADDR_SHIFT, column);
>> +	}
>> +	if (page != -1)
>> +		vf610_nfc_set_field(nfc, NFC_ROW_ADDR, ROW_ADDR_MASK,
>> +				    ROW_ADDR_SHIFT, page);
>> +}
>> +
>> +static inline void vf610_nfc_transfer_size(void __iomem *regbase, int size)
>> +{
>> +	__raw_writel(size, regbase + NFC_SECTOR_SIZE);
>> +}
>> +
>> +static void vf610_nfc_command(struct mtd_info *mtd, unsigned command,
>> +			      int column, int page)
>> +{
>> +	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
>> +
>> +	nfc->column     = max(column, 0);
>> +	nfc->spareonly	= 0;
>> +	nfc->alt_buf	= 0;
>> +
>> +	switch (command) {
>> +	case NAND_CMD_PAGEPROG:
>> +		nfc->page = -1;
>> +		vf610_nfc_transfer_size(nfc->regs, nfc->page_sz);
>> +		vf610_nfc_send_commands(nfc, NAND_CMD_SEQIN,
>> +					command, PROGRAM_PAGE_CMD_CODE);
>> +		vf610_nfc_addr_cycle(nfc, column, page);
>> +		break;
>> +
>> +	case NAND_CMD_RESET:
>> +		vf610_nfc_transfer_size(nfc->regs, 0);
>> +		vf610_nfc_send_command(nfc, command, RESET_CMD_CODE);
>> +		break;
>> +	/*
>> +	 * NFC does not support sub-page reads and writes,
>> +	 * so emulate them using full page transfers.
>> +	 */
>> +	case NAND_CMD_READOOB:
>> +		nfc->spareonly = 1;
>> +	case NAND_CMD_SEQIN: /* Pre-read for partial writes. */
>> +	case NAND_CMD_READ0:
>> +		column = 0;
>> +		/* Already read? */
>> +		if (nfc->page == page)
>> +			return;
>> +		nfc->page = page;
>> +		vf610_nfc_transfer_size(nfc->regs, nfc->page_sz);
>> +		vf610_nfc_send_commands(nfc, NAND_CMD_READ0,
>> +					NAND_CMD_READSTART, READ_PAGE_CMD_CODE);
>> +		vf610_nfc_addr_cycle(nfc, column, page);
>> +		break;
>> +
>> +	case NAND_CMD_ERASE1:
>> +		nfc->page = -1;
>> +		vf610_nfc_transfer_size(nfc->regs, 0);
>> +		vf610_nfc_send_commands(nfc, command,
>> +				  NAND_CMD_ERASE2, ERASE_CMD_CODE);
>> +		vf610_nfc_addr_cycle(nfc, column, page);
>> +		break;
>> +
>> +	case NAND_CMD_READID:
>> +		nfc->alt_buf = ALT_BUF_ID;
>> +		vf610_nfc_transfer_size(nfc->regs, 0);
>> +		vf610_nfc_send_command(nfc, command, READ_ID_CMD_CODE);
>> +		break;
>> +
>> +	case NAND_CMD_STATUS:
>> +		nfc->alt_buf = ALT_BUF_STAT;
>> +		vf610_nfc_transfer_size(nfc->regs, 0);
>> +		vf610_nfc_send_command(nfc, command, STATUS_READ_CMD_CODE);
>> +		break;
>> +	default:
>> +		return;
>> +	}
>> +
>> +	vf610_nfc_done(nfc);
>> +}
>> +
>> +static inline void vf610_nfc_read_spare(struct mtd_info *mtd, void *buf,
>> +					int len)
>> +{
>> +	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
>> +
>> +	len = min_t(uint, mtd->oobsize, len);
>> +	if (len > 0)
>> +		vf610_nfc_memcpy(buf, nfc->regs + mtd->writesize, len);
>> +}
>> +
>> +static void vf610_nfc_read_buf(struct mtd_info *mtd, u_char *buf, int len)
>> +{
>> +	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
>> +	uint c = nfc->column;
>> +	uint l;
>> +
>> +	/* Handle main area */
>> +	if (!nfc->spareonly) {
>> +		l = min_t(uint, len, mtd->writesize - c);
>> +		nfc->column += l;
>> +
>> +		if (!nfc->alt_buf)
>> +			vf610_nfc_memcpy(buf, nfc->regs + NFC_MAIN_AREA(0) + c, l);
>> +		else
>> +			if (nfc->alt_buf & ALT_BUF_ID)
>> +				*buf = vf610_nfc_get_id(nfc, c);
>> +			else
>> +				*buf = vf610_nfc_get_status(nfc);
>> +
>> +		buf += l;
>> +		len -= l;
>> +	}
>> +
>> +	/* Handle spare area access */
>> +	if (len) {
>> +		nfc->column += len;
>> +		vf610_nfc_read_spare(mtd, buf, len);
>> +	}
>> +}
>> +
>> +static void vf610_nfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
>> +{
>> +	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
>> +	uint c = nfc->column;
>> +	uint l;
>> +
>> +	l = min_t(uint, len, mtd->writesize + mtd->oobsize - c);
>> +	nfc->column += l;
>> +	vf610_nfc_memcpy(nfc->regs + NFC_MAIN_AREA(0) + c, buf, l);
>> +}
>> +
>> +static uint8_t vf610_nfc_read_byte(struct mtd_info *mtd)
>> +{
>> +	u8 tmp;
>> +
>> +	vf610_nfc_read_buf(mtd, &tmp, sizeof(tmp));
>> +	return tmp;
>> +}
>> +
>> +static u16 vf610_nfc_read_word(struct mtd_info *mtd)
>> +{
>> +	u16 tmp;
>> +
>> +	vf610_nfc_read_buf(mtd, (u_char *)&tmp, sizeof(tmp));
>> +	return tmp;
>> +}
>> +
>> +/* If not provided, upper layers apply a fixed delay. */
>> +static int vf610_nfc_dev_ready(struct mtd_info *mtd)
>> +{
>> +	/* NFC handles R/B internally; always ready.  */
>> +	return 1;
>> +}
>> +
>> +/*
>> + * This function supports Vybrid only (MPC5125 would have full RB and four CS)
>> + */
>> +static void vf610_nfc_select_chip(struct mtd_info *mtd, int chip)
>> +{
>> +#ifdef CONFIG_SOC_VF610
>> +	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
>> +	u32 tmp = vf610_nfc_read(nfc, NFC_ROW_ADDR);
>> +
>> +	tmp &= ~(ROW_ADDR_CHIP_SEL_RB_MASK | ROW_ADDR_CHIP_SEL_MASK);
>> +	tmp |= 1 << ROW_ADDR_CHIP_SEL_RB_SHIFT;
>> +
>> +	if (chip == 0)
>> +		tmp |= 1 << ROW_ADDR_CHIP_SEL_SHIFT;
>> +	else if (chip == 1)
>> +		tmp |= 2 << ROW_ADDR_CHIP_SEL_SHIFT;
>> +
>> +	vf610_nfc_write(nfc, NFC_ROW_ADDR, tmp);
>> +#endif
>> +}
>> +
>> +#ifdef CONFIG_OF_MTD
> 
> Don't use CONFIG_OF_MTD. Maybe CONFIG_OF, but even that doesn't seem
> necessary. The table is tiny, and the code should fail gracefully (and
> reduce to pretty simple / negligible code) if you don't have OF enabled.
> 
>> +static const struct of_device_id vf610_nfc_dt_ids[] = {
>> +	{ .compatible = "fsl,vf610-nfc" },
>> +	{ .compatible = "fsl,mpc5125-nfc" },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, vf610_nfc_dt_ids);
>> +
>> +static int vf610_nfc_probe_dt(struct device *dev, struct vf610_nfc_config *cfg)
>> +{
>> +	struct device_node *np = dev->of_node;
>> +	int buswidth;
>> +
>> +	if (!np)
>> +		return 1;
> 
> Try:
> 
> 		return -EINVAL;
> 
>> +
>> +	cfg->flash_bbt = of_get_nand_on_flash_bbt(np);
>> +
>> +	buswidth = of_get_nand_bus_width(np);
>> +	if (buswidth < 0)
>> +		return buswidth;
> 
> This function should mostly come for free as part of this:
> 
> commit 5844feeaa4154d1c46d3462c7a4653d22356d8b4
> Author: Brian Norris <computersforpeace@gmail.com>
> Date:   Fri Jan 23 00:22:27 2015 -0800
> 
>     mtd: nand: add common DT init code
> 
> in l2-mtd.git and linux-next.git. Can you try just assigning chip->dn
> instead?
> 
>> +
>> +	cfg->width = buswidth;
>> +
>> +	return 0;
>> +}
>> +#else
>> +static int vf610_nfc_probe_dt(struct device *dev, struct vf610_nfc_config *cfg)
>> +{
>> +	return 0;
> 
> Really? I doubt you want to silently do nothing if you don't have OF
> enabled. It seems to make more sense to just kill the #ifdef, and have
> the registration fail on either the '!np' case or the
> 'of_get_nand_bus_width(np) returns -ENOSYS' case.

The driver might be used on a platform which does not support DT
(ColdFire). However, I don't think anyone tried and I guess it doesn't
work as is, hence the driver would need an update anyway. So I'm fine
with just returning with an error in the non-DT case...

> 
>> +}
>> +#endif
>> +
>> +static int vf610_nfc_init_controller(struct vf610_nfc *nfc)
>> +{
>> +	struct vf610_nfc_config *cfg = &nfc->cfg;
>> +
>> +	if (cfg->width == 16)
>> +		vf610_nfc_set(nfc, NFC_FLASH_CONFIG, CONFIG_16BIT);
>> +	else
>> +		vf610_nfc_clear(nfc, NFC_FLASH_CONFIG, CONFIG_16BIT);
>> +
>> +	/* Set configuration register. */
>> +	vf610_nfc_clear(nfc, NFC_FLASH_CONFIG, CONFIG_ADDR_AUTO_INCR_BIT);
>> +	vf610_nfc_clear(nfc, NFC_FLASH_CONFIG, CONFIG_BUFNO_AUTO_INCR_BIT);
>> +	vf610_nfc_clear(nfc, NFC_FLASH_CONFIG, CONFIG_BOOT_MODE_BIT);
>> +	vf610_nfc_clear(nfc, NFC_FLASH_CONFIG, CONFIG_DMA_REQ_BIT);
>> +	vf610_nfc_set(nfc, NFC_FLASH_CONFIG, CONFIG_FAST_FLASH_BIT);
>> +
>> +	/* PAGE_CNT = 1 */
>> +	vf610_nfc_set_field(nfc, NFC_FLASH_CONFIG, CONFIG_PAGE_CNT_MASK,
>> +			    CONFIG_PAGE_CNT_SHIFT, 1);
>> +
>> +	return 0;
>> +}
>> +
>> +static int vf610_nfc_probe(struct platform_device *pdev)
>> +{
>> +	struct vf610_nfc *nfc;
>> +	struct resource *res;
>> +	struct mtd_info *mtd;
>> +	struct nand_chip *chip;
>> +	struct vf610_nfc_config *cfg;
>> +	int err = 0;
>> +	int irq;
>> +
>> +	nfc = devm_kzalloc(&pdev->dev, sizeof(*nfc), GFP_KERNEL);
>> +	if (!nfc)
>> +		return -ENOMEM;
>> +
>> +	cfg = &nfc->cfg;
>> +
>> +	nfc->dev = &pdev->dev;
>> +	nfc->page = -1;
>> +	mtd = &nfc->mtd;
>> +	chip = &nfc->chip;
>> +
>> +	mtd->priv = chip;
>> +	mtd->owner = THIS_MODULE;
>> +	mtd->dev.parent = nfc->dev;
>> +	mtd->name = DRV_NAME;
>> +
>> +	err = vf610_nfc_probe_dt(nfc->dev, cfg);
>> +	if (err)
>> +		return -ENODEV;
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq <= 0)
>> +		return -EINVAL;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	nfc->regs = devm_ioremap_resource(nfc->dev, res);
>> +	if (IS_ERR(nfc->regs))
>> +		return PTR_ERR(nfc->regs);
>> +
>> +	nfc->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(nfc->clk))
>> +		return PTR_ERR(nfc->clk);
>> +
>> +	err = clk_prepare_enable(nfc->clk);
>> +	if (err) {
>> +		dev_err(nfc->dev, "Unable to enable clock!\n");
>> +		return err;
>> +	}
>> +
>> +	if (cfg->width == 16)
>> +		chip->options |= NAND_BUSWIDTH_16;
>> +	else
>> +		chip->options &= ~NAND_BUSWIDTH_16;
> 
> Is the else clause needed? Also, you'll get the above for free with the
> aforementioned commit ("mtd: nand: add common DT init code").
> 
>> +
>> +	chip->dev_ready = vf610_nfc_dev_ready;
>> +	chip->cmdfunc = vf610_nfc_command;
>> +	chip->read_byte = vf610_nfc_read_byte;
>> +	chip->read_word = vf610_nfc_read_word;
>> +	chip->read_buf = vf610_nfc_read_buf;
>> +	chip->write_buf = vf610_nfc_write_buf;
>> +	chip->select_chip = vf610_nfc_select_chip;
>> +
>> +	/* Bad block options. */
>> +	if (cfg->flash_bbt)
>> +		chip->bbt_options = NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB |
>> +				    NAND_BBT_CREATE;
> 
> You probably don't need NAND_BBT_CREATE here. It's added automatically
> to the BBT descriptors in nand_bbt.c.
> 
> You can also get the NAND_BBT_USE_FLASH part for free from the
> aforementioned patch ("mtd: nand: add common DT init code").
> 
>> +
>> +	init_waitqueue_head(&nfc->irq_waitq);
>> +
>> +	err = devm_request_irq(nfc->dev, irq, vf610_nfc_irq, 0, DRV_NAME, mtd);
>> +	if (err) {
>> +		dev_err(nfc->dev, "Error requesting IRQ!\n");
>> +		goto error;
>> +	}
>> +
>> +	nfc->page_sz = PAGE_2K + OOB_64;
>> +	nfc->page_sz += cfg->width == 16 ? 1 : 0;
>> +
>> +	vf610_nfc_init_controller(nfc);
>> +
>> +	/* first scan to find the device and get the page size */
>> +	if (nand_scan_ident(mtd, 1, NULL)) {
>> +		err = -ENXIO;
>> +		goto error;
>> +	}
>> +
>> +	chip->ecc.mode = NAND_ECC_SOFT; /* default */
>> +
>> +	nfc->page_sz = mtd->writesize + mtd->oobsize;
>> +
>> +	/* Single buffer only, max 256 OOB minus ECC status */
>> +	if (nfc->page_sz > PAGE_2K + 256 - 8) {
>> +		dev_err(nfc->dev, "Unsupported flash page size\n");
>> +		err = -ENXIO;
>> +		goto error;
>> +	}
>> +	nfc->page_sz += cfg->width == 16 ? 1 : 0;
>> +
>> +	/* second phase scan */
>> +	if (nand_scan_tail(mtd)) {
>> +		err = -ENXIO;
>> +		goto error;
>> +	}
>> +
>> +	/* Register device in MTD */
>> +	mtd_device_parse_register(mtd, NULL,
>> +		&(struct mtd_part_parser_data){
>> +			.of_node = pdev->dev.of_node,
>> +		},
>> +		NULL, 0);
> 
> Please check the return code of mtd_device_parse_register().
> 
>> +
>> +	platform_set_drvdata(pdev, mtd);
> 
> If you move this up, then you can do:
> 
> 	return mtd_device_parse_register(...);
> 
>> +
>> +	return 0;
>> +
>> +error:
>> +	clk_disable_unprepare(nfc->clk);
>> +	return err;
>> +}
>> +
>> +static int vf610_nfc_remove(struct platform_device *pdev)
>> +{
>> +	struct mtd_info *mtd = platform_get_drvdata(pdev);
>> +	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
>> +
>> +	nand_release(mtd);
>> +	clk_disable_unprepare(nfc->clk);
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int vf610_nfc_suspend(struct device *dev)
>> +{
>> +	struct mtd_info *mtd = dev_get_drvdata(dev);
>> +	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
>> +
>> +	clk_disable_unprepare(nfc->clk);
>> +	return 0;
>> +}
>> +
>> +static int vf610_nfc_resume(struct device *dev)
>> +{
>> +	struct mtd_info *mtd = dev_get_drvdata(dev);
>> +	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
>> +
>> +	pinctrl_pm_select_default_state(dev);
>> +
>> +	clk_prepare_enable(nfc->clk);
>> +
>> +	vf610_nfc_init_controller(nfc);
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(vf610_nfc_pm_ops, vf610_nfc_suspend, vf610_nfc_resume);
>> +
>> +static struct platform_driver vf610_nfc_driver = {
>> +	.driver		= {
>> +		.name	= DRV_NAME,
>> +		.of_match_table = vf610_nfc_dt_ids,
>> +		.pm	= &vf610_nfc_pm_ops,
>> +	},
>> +	.probe		= vf610_nfc_probe,
>> +	.remove		= vf610_nfc_remove,
>> +};
>> +
>> +module_platform_driver(vf610_nfc_driver);
>> +
>> +MODULE_AUTHOR("Freescale Semiconductor, Inc.");
>> +MODULE_DESCRIPTION("Freescale VF610/MPC5125 NFC MTD NAND driver");
>> +MODULE_LICENSE("GPL");


Otherwise agreed, will look into implementing your changes and rebase
the driver on-top of l2-mtd.git/linux-next.git.

--
Stefan
