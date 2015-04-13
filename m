From: dev@lynxeye.de (Lucas Stach)
Date: Mon, 13 Apr 2015 21:22:54 +0200
Subject: [PATCH v2 2/5] mtd: nand: add NVIDIA Tegra NAND Flash
 controller driver
In-Reply-To: <99af1297029d7f1624db2f5fd9d228d1@agner.ch>
References: <1428522370-18035-1-git-send-email-dev@lynxeye.de>
 <1428522370-18035-3-git-send-email-dev@lynxeye.de>
 <99af1297029d7f1624db2f5fd9d228d1@agner.ch>
Message-ID: <1428952974.2616.2.camel@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

thanks for the review.

Am Freitag, den 10.04.2015, 10:46 +0200 schrieb Stefan Agner:
> Hi Lucas,
> 
> Thanks for working on that. Some minor comments below...
> 
> On 2015-04-08 21:46, Lucas Stach wrote:
> > Add support for the NAND flash controller found on NVIDIA
> > Tegra 2/3 SoCs.
> > 
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > Signed-off-by: Lucas Stach <dev@lynxeye.de>
> > ---
> > v2:
> > - remove Tegra 3 compatible
> > - remove useless part_probes
> > - don't store irq number
> > - use gpiod API instead of deprecated of_gpios
> > - don't store reset
> > - correct TIMING_TCS mask
> > - simplify irq handler
> > - correct timing calculations
> > - don't store buswidth
> > - drop compile test
> > - correct ECC handling
> > ---
> >  MAINTAINERS                   |   6 +
> >  drivers/mtd/nand/Kconfig      |   6 +
> >  drivers/mtd/nand/Makefile     |   1 +
> >  drivers/mtd/nand/tegra_nand.c | 786 ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 799 insertions(+)
> >  create mode 100644 drivers/mtd/nand/tegra_nand.c
> > 
> [...]
> > +static struct nand_ecclayout tegra_nand_oob_16 = {
> > +	.eccbytes = 4,
> > +	.eccpos = { 3, 4, 5, 6 },
> > +	.oobfree = {
> > +		{ .offset = 7, . length = 8 }
> > +	}
> > +};
> > +
> > +static struct nand_ecclayout tegra_nand_oob_64 = {
> > +	.eccbytes = 36,
> > +	.eccpos = {
> > +		 3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
> > +		19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
> > +		35, 36, 37, 38, 39
> > +	},
> 
> The amount of eccbytes vs. length of eccpos do not match...
> 
> > +	.oobfree = {
> > +		{ .offset = 40, .length = 24 }
> > +	}
> > +};
> > +
> > +static struct nand_ecclayout tegra_nand_oob_128 = {
> > +	.eccbytes = 72,
> > +	.eccpos = {
> > +		 3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
> > +		19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
> > +		35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
> > +		51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66,
> > +		67, 68, 69, 70, 71, 72, 73, 74, 75
> > +	},
> 
> Here...
> 
> > +	.oobfree = {
> > +		{ .offset = 76, .length = 52 }
> > +	}
> > +};
> > +
> > +static struct nand_ecclayout tegra_nand_oob_224 = {
> > +	.eccbytes = 144,
> > +	.eccpos = {
> > +		  3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
> > +		 15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  26,
> > +		 27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,
> > +		 39,  40,  41,  42,  43,  44,  45,  46,  47,  48,  49,  50,
> > +		 51,  52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  62,
> > +		 63,  64,  65,  66,  67,  68,  69,  70,  71,  72,  73,  74,
> > +		 75,  76,  77,  78,  79,  80,  81,  82,  83,  84,  85,  86,
> > +		 87,  88,  89,  90,  91,  92,  93,  94,  95,  96,  97,  98,
> > +		 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110,
> > +		111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122,
> > +		123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134,
> > +		135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146,
> > +		147
> > +	},
> 
> ... and here too.
> 

Urgh, actually they are all wrong, as the ECC starts at byte 4, not
3. :/ Thanks for the hint.

> [...]
> > +static int tegra_nand_probe(struct platform_device *pdev)
> > +{
> > +	struct reset_control *rst;
> > +	struct tegra_nand *nand;
> > +	struct nand_chip *chip;
> > +	struct mtd_info *mtd;
> > +	struct resource *res;
> > +	unsigned long value;
> > +	int irq, buswidth, err = 0;
> > +
> > +	nand = devm_kzalloc(&pdev->dev, sizeof(*nand), GFP_KERNEL);
> > +	if (!nand)
> > +		return -ENOMEM;
> > +
> > +	nand->dev = &pdev->dev;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	nand->regs = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(nand->regs))
> > +		return PTR_ERR(nand->regs);
> > +
> > +	irq = platform_get_irq(pdev, 0);
> > +	err = devm_request_irq(&pdev->dev, irq, tegra_nand_irq, 0,
> > +			       dev_name(&pdev->dev), nand);
> > +	if (err)
> > +		return err;
> > +
> > +	rst = devm_reset_control_get(&pdev->dev, "nand");
> > +	if (IS_ERR(rst))
> > +		return PTR_ERR(rst);
> > +
> > +	nand->clk = devm_clk_get(&pdev->dev, "nand");
> > +	if (IS_ERR(nand->clk))
> > +		return PTR_ERR(nand->clk);
> > +
> > +	nand->wp_gpio = gpiod_get_optional(&pdev->dev, "nvidia,wp-gpios",
> > +					   GPIOD_OUT_HIGH);
> > +	if (IS_ERR(nand->wp_gpio))
> > +		return PTR_ERR(nand->wp_gpio);
> > +
> > +	buswidth = of_get_nand_bus_width(pdev->dev.of_node);
> > +	if (buswidth < 0)
> > +		return buswidth;
> > +
> > +	err = clk_prepare_enable(nand->clk);
> > +	if (err)
> > +		return err;
> > +
> > +	reset_control_assert(rst);
> > +	udelay(2);
> > +	reset_control_deassert(rst);
> > +
> > +	value = HWSTATUS_RDSTATUS_MASK(1) | HWSTATUS_RDSTATUS_VALUE(0) |
> > +		HWSTATUS_RBSY_MASK(NAND_STATUS_READY) |
> > +		HWSTATUS_RBSY_VALUE(NAND_STATUS_READY);
> > +	writel(NAND_CMD_STATUS, nand->regs + HWSTATUS_CMD);
> > +	writel(value, nand->regs + HWSTATUS_MASK);
> > +
> > +	init_completion(&nand->command_complete);
> > +	init_completion(&nand->dma_complete);
> > +
> > +	mtd = &nand->mtd;
> > +	mtd->name = dev_name(&pdev->dev);
> > +	mtd->owner = THIS_MODULE;
> > +	mtd->priv = &nand->chip;
> > +
> > +	mtd->type = MTD_NANDFLASH;
> > +	mtd->flags = MTD_CAP_NANDFLASH;
> 
> This get filled by nand_scan_tail anyway, any reason to have it here
> too?
> 
No, not really. Probably just cargo-culting. I'll remove this.

> Other than that, looks solid to me.
> 
> Reviewed-by: Stefan Agner <stefan@agner.ch>
> 
I'll wait a bit more before posting a v3, to give other people a chance
to look at this.

Thanks,
Lucas
