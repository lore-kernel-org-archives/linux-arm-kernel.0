From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat, 10 Jan 2015 19:20:25 +0100
Subject: [PATCH 1/4] mtd: nand: add NVIDIA Tegra NAND Flash controller
 driver
In-Reply-To: <1420403960-26626-1-git-send-email-dev@lynxeye.de>
References: <1420403960-26626-1-git-send-email-dev@lynxeye.de>
Message-ID: <20150110192025.78c763e9@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  4 Jan 2015 21:39:17 +0100
Lucas Stach <dev@lynxeye.de> wrote:

> Add support for the NAND flash controller found on NVIDIA
> Tegra 2/3 SoCs. This is a largely reworked version of the driver
> started by Thierry.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> ---
> I've tested this driver with the in-kernel mtd-tests and some
> realworld workloads on a Colibri T20 module.
> ---
>  .../bindings/mtd/nvidia,tegra20-nand.txt           |  30 +
>  MAINTAINERS                                        |   6 +
>  drivers/mtd/nand/Kconfig                           |   6 +
>  drivers/mtd/nand/Makefile                          |   1 +
>  drivers/mtd/nand/tegra_nand.c                      | 794 +++++++++++++++++++++
>  5 files changed, 837 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
>  create mode 100644 drivers/mtd/nand/tegra_nand.c
> 

[...]

> +
> +static const char * const part_probes[] = {
> +	"cmdlinepart", "ofpart", NULL };

Where is part_probe referenced in this driver ?

> +
> +static int tegra_nand_probe(struct platform_device *pdev)
> +{
> +	struct tegra_nand *nand;
> +	struct nand_chip *chip;
> +	struct mtd_info *mtd;
> +	struct resource *res;
> +	unsigned long value;
> +	int err = 0;
> +
> +	nand = devm_kzalloc(&pdev->dev, sizeof(*nand), GFP_KERNEL);
> +	if (!nand)
> +		return -ENOMEM;
> +
> +	nand->dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	nand->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(nand->regs))
> +		return PTR_ERR(nand->regs);
> +
> +	nand->irq  = platform_get_irq(pdev, 0);
> +	err = devm_request_irq(&pdev->dev, nand->irq, tegra_nand_irq, 0,
> +			       dev_name(&pdev->dev), nand);
> +	if (err)
> +		return err;
> +
> +	nand->rst = devm_reset_control_get(&pdev->dev, "nand");
> +	if (IS_ERR(nand->rst))
> +		return PTR_ERR(nand->rst);
> +
> +	nand->clk = devm_clk_get(&pdev->dev, "nand");
> +	if (IS_ERR(nand->clk))
> +		return PTR_ERR(nand->clk);
> +
> +	err = tegra_nand_parse_dt(pdev->dev.of_node, nand);
> +	if (err)
> +		return err;
> +
> +	err = clk_prepare_enable(nand->clk);
> +	if (err)
> +		return err;
> +
> +	reset_control_assert(nand->rst);
> +	udelay(2);
> +	reset_control_deassert(nand->rst);
> +
> +	if (gpio_is_valid(nand->wp_gpio)) {
> +		err = devm_gpio_request_one(&pdev->dev, nand->wp_gpio,
> +				GPIOF_OUT_INIT_HIGH, "tegra-nand-wp");
> +		if (err)
> +			return err;
> +	}
> +
> +	value = HWSTATUS_RDSTATUS_MASK(1) | HWSTATUS_RDSTATUS_VALUE(0) |
> +		HWSTATUS_RBSY_MASK(NAND_STATUS_READY) |
> +		HWSTATUS_RBSY_VALUE(NAND_STATUS_READY);
> +	writel(NAND_CMD_STATUS, nand->regs + HWSTATUS_CMD);
> +	writel(value, nand->regs + HWSTATUS_MASK);
> +
> +	init_completion(&nand->command_complete);
> +	init_completion(&nand->dma_complete);
> +
> +	mtd = &nand->mtd;
> +	mtd->name = dev_name(&pdev->dev);
> +	mtd->owner = THIS_MODULE;
> +	mtd->priv = &nand->chip;
> +
> +	mtd->type = MTD_NANDFLASH;
> +	mtd->flags = MTD_CAP_NANDFLASH;
> +
> +	/* clear interrupts */
> +	value = readl(nand->regs + ISR);
> +	writel(value, nand->regs + ISR);
> +
> +	writel(DMA_CTRL_IS_DONE, nand->regs + DMA_CTRL);
> +
> +	/* enable interrupts */
> +	value = IER_UND | IER_OVR | IER_CMD_DONE | IER_ECC_ERR | IER_GIE;
> +	writel(value, nand->regs + IER);
> +
> +	chip = &nand->chip;
> +	chip->cmdfunc = tegra_nand_command;
> +	chip->select_chip = tegra_nand_select_chip;
> +	chip->read_byte = tegra_nand_read_byte;
> +	chip->read_buf = tegra_nand_read_buf;
> +	chip->write_buf = tegra_nand_write_buf;
> +
> +	tegra_nand_setup_timing(nand, 0);
> +
> +	err = nand_scan_ident(mtd, 1, NULL);
> +	if (err)
> +		return err;
> +
> +	nand->data_buf = dmam_alloc_coherent(&pdev->dev, mtd->writesize,
> +					    &nand->data_dma, GFP_KERNEL);
> +	if (!nand->data_buf)
> +		return -ENOMEM;
> +
> +	nand->oob_buf = dmam_alloc_coherent(&pdev->dev, mtd->oobsize,
> +					    &nand->oob_dma, GFP_KERNEL);
> +	if (!nand->oob_buf)
> +		return -ENOMEM;
> +
> +	chip->ecc.mode = NAND_ECC_HW;
> +	chip->ecc.size = 512;
> +	chip->ecc.bytes = mtd->oobsize;
> +	chip->ecc.read_page = tegra_nand_read_page;
> +	chip->ecc.write_page = tegra_nand_write_page;

Just a nit, but I would rename those read/write_page functions into
tegra_nand_hwecc_xxx_page to clearly state that HW ECC is involved
here.

> +
> +	value = CFG_HW_ECC | CFG_ECC_SEL | CFG_ERR_COR | CFG_PIPE_EN |
> +		CFG_TVAL_8 | CFG_SKIP_SPARE | CFG_SKIP_SPARE_SIZE_4;

Can you move the CFG_HW_ECC flags setting into tegra_nand_read_page
(setting them at entry and clearing them at exit).
This is really important to be able to access the NAND in raw mode
(i.e. without involving ECC), and you seem to force HW ECC for
all accesses, which means ecc.read/write_page_raw are probably not
working correctly.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
