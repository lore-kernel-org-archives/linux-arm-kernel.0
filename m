From: computersforpeace@gmail.com (Brian Norris)
Date: Sun, 8 Feb 2015 00:42:25 -0800
Subject: [PATCH v8 1/2] mtd: hisilicon: add a new NAND controller driver
 for hisilicon hip04 Soc
In-Reply-To: <1422183194-10148-2-git-send-email-wangzhou1@hisilicon.com>
References: <1422183194-10148-1-git-send-email-wangzhou1@hisilicon.com>
 <1422183194-10148-2-git-send-email-wangzhou1@hisilicon.com>
Message-ID: <20150208084225.GE3670@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhou,

On Sun, Jan 25, 2015 at 06:53:13PM +0800, Zhou Wang wrote:
> diff --git a/drivers/mtd/nand/hisi504_nand.c b/drivers/mtd/nand/hisi504_nand.c
> new file mode 100644
> index 0000000..484e1db
> --- /dev/null
> +++ b/drivers/mtd/nand/hisi504_nand.c
...
> +static uint8_t hisi_nfc_read_byte(struct mtd_info *mtd)
> +{
> +	struct nand_chip *chip = mtd->priv;
> +	struct hinfc_host *host = chip->priv;
> +
> +	if (host->command == NAND_CMD_STATUS)
> +		return *(uint8_t *)(host->mmio);
> +
> +	host->offset++;
> +
> +	if (host->command == NAND_CMD_READID)
> +		return *(uint8_t *)(host->mmio + host->offset - 1);
> +
> +	return *(uint8_t *)(host->buffer + host->offset - 1);
> +}
> +
> +static u16 hisi_nfc_read_word(struct mtd_info *mtd)
> +{
> +	struct nand_chip *chip = mtd->priv;
> +	struct hinfc_host *host = chip->priv;
> +
> +	host->offset += 2;
> +	return *(u16 *)(host->buffer + host->offset - 2);
> +}
> +
> +static void
> +hisi_nfc_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
> +{
> +	struct nand_chip *chip = mtd->priv;
> +	struct hinfc_host *host = chip->priv;
> +
> +	memcpy(host->buffer + host->offset, buf, len);
> +	host->offset += len;
> +}
> +
> +static void hisi_nfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
> +{
> +	struct nand_chip *chip = mtd->priv;
> +	struct hinfc_host *host = chip->priv;
> +
> +	memcpy(buf, host->buffer + host->offset, len);
> +	host->offset += len;
> +}

...

> +static int hisi_nfc_probe(struct platform_device *pdev)
> +{
> +	int ret = 0, irq, buswidth, flag, max_chips = HINFC504_MAX_CHIP;
> +	struct device *dev = &pdev->dev;
> +	struct hinfc_host *host;
> +	struct nand_chip  *chip;
> +	struct mtd_info   *mtd;
> +	struct resource	  *res;
> +	struct device_node *np = dev->of_node;
> +	struct mtd_part_parser_data ppdata;
> +
> +	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
> +	if (!host)
> +		return -ENOMEM;
> +	host->dev = dev;
> +
> +	platform_set_drvdata(pdev, host);
> +	chip = &host->chip;
> +	mtd  = &host->mtd;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "no IRQ resource defined\n");
> +		ret = -ENXIO;
> +		goto err_res;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	host->iobase = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(host->iobase)) {
> +		ret = PTR_ERR(host->iobase);
> +		goto err_res;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	host->mmio = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(host->mmio)) {
> +		ret = PTR_ERR(host->mmio);
> +		dev_err(dev, "devm_ioremap_resource[1] fail\n");
> +		goto err_res;
> +	}
> +
> +	mtd->priv		= chip;
> +	mtd->owner		= THIS_MODULE;
> +	mtd->name		= "hisi_nand";
> +	mtd->dev.parent         = &pdev->dev;
> +
> +	chip->priv		= host;
> +	chip->cmdfunc		= hisi_nfc_cmdfunc;
> +	chip->select_chip	= hisi_nfc_select_chip;
> +	chip->read_byte		= hisi_nfc_read_byte;
> +	chip->read_word		= hisi_nfc_read_word;
> +	chip->write_buf		= hisi_nfc_write_buf;
> +	chip->read_buf		= hisi_nfc_read_buf;
> +	chip->chip_delay	= HINFC504_CHIP_DELAY;
> +
> +	chip->ecc.mode = of_get_nand_ecc_mode(np);
> +
> +	buswidth = of_get_nand_bus_width(np);
> +	if (buswidth == 16)
> +		chip->options |= NAND_BUSWIDTH_16;
> +
> +	hisi_nfc_host_init(host);
> +
> +	ret = devm_request_irq(dev, irq, hinfc_irq_handle, IRQF_DISABLED,
> +				"nandc", host);
> +	if (ret) {
> +		dev_err(dev, "failed to request IRQ\n");
> +		goto err_res;
> +	}
> +
> +	ret = nand_scan_ident(mtd, max_chips, NULL);
> +	if (ret) {
> +		ret = -ENODEV;
> +		goto err_res;
> +	}
> +
> +	host->buffer = dmam_alloc_coherent(dev, mtd->writesize + mtd->oobsize,
> +		&host->dma_buffer, GFP_KERNEL);

You allocate this buffer after nand_scan_ident() (which is necessary, if
you want to use the page and OOB size), but note that this buffer is
used for everything but the READ_ID and STATUS commands, right? So there
is some potential for a NULL dereference in read_byte/read_buf, above.
Fortunately, there aren't many other commands used in nand_scan_ident(),
but I think you might run across one problem; what if an ONFI or JEDEC
compatible NAND is used? Then nand_scan_ident() might run a
PARAMETER_READ command.

Anyway, I see that PARAMETER_READ is not implemented in this driver, so
I guess that's not a big deal. Just FYI.

> +	if (!host->buffer) {
> +		ret = -ENOMEM;
> +		goto err_res;
> +	}
> +
> +	host->dma_oob = host->dma_buffer + mtd->writesize;
> +	memset(host->buffer, 0xff, mtd->writesize + mtd->oobsize);
> +
> +	flag = hinfc_read(host, HINFC504_CON);
> +	flag &= ~(HINFC504_CON_PAGESIZE_MASK << HINFC504_CON_PAGEISZE_SHIFT);
> +	switch (mtd->writesize) {
> +	case 2048:
> +		flag |= (0x001 << HINFC504_CON_PAGEISZE_SHIFT); break;
> +	/*
> +	 * TODO: add more pagesize support,
> +	 * default pagesize has been set in hisi_nfc_host_init
> +	 */
> +	default:
> +		dev_err(dev, "NON-2KB page size nand flash\n");
> +		ret = -EINVAL;
> +		goto err_res;
> +	}
> +	hinfc_write(host, flag, HINFC504_CON);
> +
> +	if (chip->ecc.mode == NAND_ECC_HW)
> +		hisi_nfc_ecc_probe(host);
> +
> +	ret = nand_scan_tail(mtd);
> +	if (ret) {
> +		dev_err(dev, "nand_scan_tail failed: %d\n", ret);
> +		goto err_res;
> +	}
> +
> +	ppdata.of_node = np;
> +	ret = mtd_device_parse_register(mtd, NULL, &ppdata, NULL, 0);
> +	if (ret) {
> +		dev_err(dev, "Err MTD partition=%d\n", ret);
> +		goto err_mtd;
> +	}
> +
> +	return 0;
> +
> +err_mtd:
> +	nand_release(mtd);
> +err_res:
> +	return ret;
> +}

Brian
