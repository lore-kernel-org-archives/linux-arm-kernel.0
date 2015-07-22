From: dev@lynxeye.de (Lucas Stach)
Date: Wed, 22 Jul 2015 22:42:40 +0200
Subject: [Patch v3 2/5] mtd: nand: add NVIDIA Tegra NAND Flash
 controller driver
In-Reply-To: <20150721212710.GN24125@google.com>
References: <1431282602-7137-1-git-send-email-dev@lynxeye.de>
 <1431282602-7137-3-git-send-email-dev@lynxeye.de>
 <20150721212710.GN24125@google.com>
Message-ID: <1437597760.2289.13.camel@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 21.07.2015, 14:27 -0700 schrieb Brian Norris:
> Hi Lucas,
> 
> On Sun, May 10, 2015 at 08:29:59PM +0200, Lucas Stach wrote:
> > Add support for the NAND flash controller found on NVIDIA
> > Tegra 2/3 SoCs.
> > 
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > Signed-off-by: Lucas Stach <dev@lynxeye.de>
> > Reviewed-by: Stefan Agner <stefan@agner.ch>
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
> > 
> > v3:
> > - remove superfluous NAND cap setting
> > - correct ECC layout
> > - don't flag ECC error for erased pages
> 
> ^^ So you approached a tricky subject here :) more below
> 
> > - make MTD device name a bit human friendlier
> > - mark subpage writes as unsupported
> > - parse BBT on flash property
> > ---
> >  MAINTAINERS                   |   6 +
> >  drivers/mtd/nand/Kconfig      |   6 +
> >  drivers/mtd/nand/Makefile     |   1 +
> >  drivers/mtd/nand/tegra_nand.c | 801 ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 814 insertions(+)
> >  create mode 100644 drivers/mtd/nand/tegra_nand.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 781e099..7e5551f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9747,6 +9747,12 @@ M:	Laxman Dewangan <ldewangan@nvidia.com>
> >  S:	Supported
> >  F:	drivers/input/keyboard/tegra-kbc.c
> >  
> > +TEGRA NAND DRIVER
> > +M:	Lucas Stach <dev@lynxeye.de>
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> > +F:	drivers/mtd/nand/tegra_nand.c
> 
> Thanks for doing this.
> 
> > +
> >  TEGRA PWM DRIVER
> >  M:	Thierry Reding <thierry.reding@gmail.com>
> >  S:	Supported
> > diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> > index 5897d8d..2696418 100644
> > --- a/drivers/mtd/nand/Kconfig
> > +++ b/drivers/mtd/nand/Kconfig
> > @@ -530,4 +530,10 @@ config MTD_NAND_HISI504
> >  	help
> >  	  Enables support for NAND controller on Hisilicon SoC Hip04.
> >  
> > +config MTD_NAND_TEGRA
> > +	tristate "Support for NAND on NVIDIA Tegra"
> > +	depends on ARCH_TEGRA
> 
> Is this a strict depends? Maybe relax to the following at least:
> 
> 	depends on ARCH_TEGRA || COMPILE_TEST
> 
> > +	help
> > +	  Enables support for NAND flash on NVIDIA Tegra SoC based boards.
> > +
> >  endif # MTD_NAND
> > diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> > index 582bbd05..3228e6e 100644
> > --- a/drivers/mtd/nand/Makefile
> > +++ b/drivers/mtd/nand/Makefile
> > @@ -52,5 +52,6 @@ obj-$(CONFIG_MTD_NAND_XWAY)		+= xway_nand.o
> >  obj-$(CONFIG_MTD_NAND_BCM47XXNFLASH)	+= bcm47xxnflash/
> >  obj-$(CONFIG_MTD_NAND_SUNXI)		+= sunxi_nand.o
> >  obj-$(CONFIG_MTD_NAND_HISI504)	        += hisi504_nand.o
> > +obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
> >  
> >  nand-objs := nand_base.o nand_bbt.o nand_timings.o
> > diff --git a/drivers/mtd/nand/tegra_nand.c b/drivers/mtd/nand/tegra_nand.c
> > new file mode 100644
> > index 0000000..20ea1f1
> > --- /dev/null
> > +++ b/drivers/mtd/nand/tegra_nand.c
> > @@ -0,0 +1,801 @@
> > +/*
> > + * Copyright (C) 2014-2015 Lucas Stach <dev@lynxeye.de>
> > + * Copyright (C) 2012 Avionic Design GmbH
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/err.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/mtd/nand.h>
> > +#include <linux/mtd/partitions.h>
> > +#include <linux/of_mtd.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/reset.h>
> > +
> > +#define CMD				0x00
> > +#define   CMD_GO			(1 << 31)
> > +#define   CMD_CLE			(1 << 30)
> > +#define   CMD_ALE			(1 << 29)
> > +#define   CMD_PIO			(1 << 28)
> > +#define   CMD_TX			(1 << 27)
> > +#define   CMD_RX			(1 << 26)
> > +#define   CMD_SEC_CMD			(1 << 25)
> > +#define   CMD_AFT_DAT			(1 << 24)
> > +#define   CMD_TRANS_SIZE(x)		(((x) & 0xf) << 20)
> > +#define   CMD_A_VALID			(1 << 19)
> > +#define   CMD_B_VALID			(1 << 18)
> > +#define   CMD_RD_STATUS_CHK		(1 << 17)
> > +#define   CMD_RBSY_CHK			(1 << 16)
> > +#define   CMD_CE(x)			(1 << (8 + ((x) & 0x7)))
> > +#define   CMD_CLE_SIZE(x)		(((x) & 0x3) << 4)
> > +#define   CMD_ALE_SIZE(x)		(((x) & 0xf) << 0)
> > +
> > +#define STATUS				0x04
> > +
> > +#define ISR				0x08
> > +#define   ISR_UND			(1 << 7)
> > +#define   ISR_OVR			(1 << 6)
> > +#define   ISR_CMD_DONE			(1 << 5)
> > +#define   ISR_ECC_ERR			(1 << 4)
> > +
> > +#define IER				0x0c
> > +#define   IER_ERR_TRIG_VAL(x)		(((x) & 0xf) << 16)
> > +#define   IER_UND			(1 << 7)
> > +#define   IER_OVR			(1 << 6)
> > +#define   IER_CMD_DONE			(1 << 5)
> > +#define   IER_ECC_ERR			(1 << 4)
> > +#define   IER_GIE			(1 << 0)
> > +
> > +#define CFG				0x10
> > +#define   CFG_HW_ECC			(1 << 31)
> > +#define   CFG_ECC_SEL			(1 << 30)
> > +#define   CFG_ERR_COR			(1 << 29)
> > +#define   CFG_PIPE_EN			(1 << 28)
> > +#define   CFG_TVAL_4			(0 << 24)
> > +#define   CFG_TVAL_6			(1 << 24)
> > +#define   CFG_TVAL_8			(2 << 24)
> > +#define   CFG_SKIP_SPARE		(1 << 23)
> > +#define   CFG_BUS_WIDTH_8		(0 << 21)
> > +#define   CFG_BUS_WIDTH_16		(1 << 21)
> > +#define   CFG_COM_BSY			(1 << 20)
> > +#define   CFG_PS_256			(0 << 16)
> > +#define   CFG_PS_512			(1 << 16)
> > +#define   CFG_PS_1024			(2 << 16)
> > +#define   CFG_PS_2048			(3 << 16)
> > +#define   CFG_PS_4096			(4 << 16)
> > +#define   CFG_SKIP_SPARE_SIZE_4		(0 << 14)
> > +#define   CFG_SKIP_SPARE_SIZE_8		(1 << 14)
> > +#define   CFG_SKIP_SPARE_SIZE_12	(2 << 14)
> > +#define   CFG_SKIP_SPARE_SIZE_16	(3 << 14)
> > +#define   CFG_TAG_BYTE_SIZE(x)		((x) & 0xff)
> > +
> > +#define TIMING_1			0x14
> > +#define   TIMING_TRP_RESP(x)		(((x) & 0xf) << 28)
> > +#define   TIMING_TWB(x)			(((x) & 0xf) << 24)
> > +#define   TIMING_TCR_TAR_TRR(x)		(((x) & 0xf) << 20)
> > +#define   TIMING_TWHR(x)		(((x) & 0xf) << 16)
> > +#define   TIMING_TCS(x)			(((x) & 0x3) << 14)
> > +#define   TIMING_TWH(x)			(((x) & 0x3) << 12)
> > +#define   TIMING_TWP(x)			(((x) & 0xf) <<  8)
> > +#define   TIMING_TRH(x)			(((x) & 0xf) <<  4)
> > +#define   TIMING_TRP(x)			(((x) & 0xf) <<  0)
> > +
> > +#define RESP				0x18
> > +
> > +#define TIMING_2			0x1c
> > +#define   TIMING_TADL(x)		((x) & 0xf)
> > +
> > +#define CMD_1				0x20
> > +#define CMD_2				0x24
> > +#define ADDR_1				0x28
> > +#define ADDR_2				0x2c
> > +
> > +#define DMA_CTRL			0x30
> > +#define   DMA_CTRL_GO			(1 << 31)
> > +#define   DMA_CTRL_IN			(0 << 30)
> > +#define   DMA_CTRL_OUT			(1 << 30)
> > +#define   DMA_CTRL_PERF_EN		(1 << 29)
> > +#define   DMA_CTRL_IE_DONE		(1 << 28)
> > +#define   DMA_CTRL_REUSE		(1 << 27)
> > +#define   DMA_CTRL_BURST_1		(2 << 24)
> > +#define   DMA_CTRL_BURST_4		(3 << 24)
> > +#define   DMA_CTRL_BURST_8		(4 << 24)
> > +#define   DMA_CTRL_BURST_16		(5 << 24)
> > +#define   DMA_CTRL_IS_DONE		(1 << 20)
> > +#define   DMA_CTRL_EN_A			(1 <<  2)
> > +#define   DMA_CTRL_EN_B			(1 <<  1)
> > +
> > +#define DMA_CFG_A			0x34
> > +#define DMA_CFG_B			0x38
> > +
> > +#define FIFO_CTRL			0x3c
> > +#define   FIFO_CTRL_CLR_ALL		(1 << 3)
> > +
> > +#define DATA_PTR			0x40
> > +#define TAG_PTR				0x44
> > +#define ECC_PTR				0x48
> > +
> > +#define DEC_STATUS			0x4c
> > +#define   DEC_STATUS_A_ECC_FAIL		(1 << 1)
> > +#define   DEC_STATUS_ERR_COUNT_MASK	0x00ff0000
> > +#define   DEC_STATUS_ERR_COUNT_SHIFT	16
> > +
> > +#define HWSTATUS_CMD			0x50
> > +#define HWSTATUS_MASK			0x54
> > +#define   HWSTATUS_RDSTATUS_MASK(x)	(((x) & 0xff) << 24)
> > +#define   HWSTATUS_RDSTATUS_VALUE(x)	(((x) & 0xff) << 16)
> > +#define   HWSTATUS_RBSY_MASK(x)		(((x) & 0xff) << 8)
> > +#define   HWSTATUS_RBSY_VALUE(x)	(((x) & 0xff) << 0)
> > +
> > +struct tegra_nand {
> > +	void __iomem *regs;
> > +	struct clk *clk;
> > +	struct gpio_desc *wp_gpio;
> > +
> > +	struct nand_chip chip;
> > +	struct mtd_info mtd;
> > +	struct device *dev;
> > +
> > +	struct completion command_complete;
> > +	struct completion dma_complete;
> > +
> > +	dma_addr_t data_dma;
> > +	void *data_buf;
> > +	dma_addr_t oob_dma;
> > +	void *oob_buf;
> > +
> > +	int cur_chip;
> > +};
> > +
> > +static inline struct tegra_nand *to_tegra_nand(struct mtd_info *mtd)
> > +{
> > +	return container_of(mtd, struct tegra_nand, mtd);
> > +}
> > +
> > +static struct nand_ecclayout tegra_nand_oob_16 = {
> > +	.eccbytes = 4,
> > +	.eccpos = { 4, 5, 6, 7 },
> > +	.oobfree = {
> > +		{ .offset = 8, . length = 8 }
> > +	}
> > +};
> > +
> > +static struct nand_ecclayout tegra_nand_oob_64 = {
> > +	.eccbytes = 36,
> > +	.eccpos = {
> > +		 4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
> > +		20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35,
> > +		36, 37, 38, 39
> > +	},
> > +	.oobfree = {
> > +		{ .offset = 40, .length = 24 }
> > +	}
> > +};
> > +
> > +static struct nand_ecclayout tegra_nand_oob_128 = {
> > +	.eccbytes = 72,
> > +	.eccpos = {
> > +		 4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
> > +		20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35,
> > +		36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51,
> > +		52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67,
> > +		68, 69, 70, 71, 72, 73, 74, 75
> > +	},
> > +	.oobfree = {
> > +		{ .offset = 76, .length = 52 }
> > +	}
> > +};
> > +
> > +static struct nand_ecclayout tegra_nand_oob_224 = {
> > +	.eccbytes = 144,
> > +	.eccpos = {
> > +		  4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,  15,  16,
> > +		 17,  18,  19,  20,  21,  22,  23,  24,  25,  26,  27,  28,  29,
> > +		 30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,  41,  42,
> > +		 43,  44,  45,  46,  47,  48,  49,  50,  51,  52,  53,  54,  55,
> > +		 56,  57,  58,  59,  60,  61,  62,  63,  64,  65,  66,  67,  68,
> > +		 69,  70,  71,  72,  73,  74,  75,  76,  77,  78,  79,  80,  81,
> > +		 82,  83,  84,  85,  86,  87,  88,  89,  90,  91,  92,  93,  94,
> > +		 95,  96,  97,  98,  99, 100, 101, 102, 103, 104, 105, 106, 107,
> > +		108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120,
> > +		121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133,
> > +		134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146,
> > +		147
> > +	},
> > +	.oobfree = {
> > +		{ .offset = 148, .length = 76 }
> > +	}
> > +};
> > +
> > +static irqreturn_t tegra_nand_irq(int irq, void *data)
> > +{
> > +	struct tegra_nand *nand = data;
> > +	u32 isr, dma;
> > +
> > +	isr = readl(nand->regs + ISR);
> > +	dma = readl(nand->regs + DMA_CTRL);
> > +
> > +	if (!isr && !(dma & DMA_CTRL_IS_DONE))
> > +		return IRQ_NONE;
> > +
> > +	if (isr & ISR_CMD_DONE)
> > +		complete(&nand->command_complete);
> > +
> > +	if (isr & ISR_UND)
> > +		dev_dbg(nand->dev, "FIFO underrun\n");
> > +
> > +	if (isr & ISR_OVR)
> > +		dev_dbg(nand->dev, "FIFO overrun\n");
> > +
> > +	/* handle DMA interrupts */
> > +	if (dma & DMA_CTRL_IS_DONE) {
> > +		writel(dma, nand->regs + DMA_CTRL);
> > +		complete(&nand->dma_complete);
> > +	}
> > +
> > +	/* clear interrupts */
> > +	writel(isr, nand->regs + ISR);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void tegra_nand_command(struct mtd_info *mtd, unsigned int command,
> > +			       int column, int page_addr)
> > +{
> > +	struct tegra_nand *nand = to_tegra_nand(mtd);
> > +	u32 value;
> > +
> > +	switch (command) {
> > +	case NAND_CMD_READOOB:
> > +		column += mtd->writesize;
> > +		/* fall-through */
> > +
> > +	case NAND_CMD_READ0:
> > +		writel(NAND_CMD_READ0, nand->regs + CMD_1);
> > +		writel(NAND_CMD_READSTART, nand->regs + CMD_2);
> > +
> > +		value = (page_addr << 16) | (column & 0xffff);
> > +		writel(value, nand->regs + ADDR_1);
> > +
> > +		value = page_addr >> 16;
> > +		writel(value, nand->regs + ADDR_2);
> > +
> > +		value = CMD_CLE | CMD_ALE | CMD_ALE_SIZE(4) | CMD_SEC_CMD |
> > +			CMD_RBSY_CHK | CMD_CE(nand->cur_chip) | CMD_GO;
> > +		writel(value, nand->regs + CMD);
> > +		break;
> > +
> > +	case NAND_CMD_SEQIN:
> > +		writel(NAND_CMD_SEQIN, nand->regs + CMD_1);
> > +
> > +		value = (page_addr << 16) | (column & 0xffff);
> > +		writel(value, nand->regs + ADDR_1);
> > +
> > +		value = page_addr >> 16;
> > +		writel(value, nand->regs + ADDR_2);
> > +
> > +		value = CMD_CLE | CMD_ALE | CMD_ALE_SIZE(4) |
> > +			CMD_CE(nand->cur_chip) | CMD_GO;
> > +		writel(value, nand->regs + CMD);
> > +		break;
> > +
> > +	case NAND_CMD_PAGEPROG:
> > +		writel(NAND_CMD_PAGEPROG, nand->regs + CMD_1);
> > +
> > +		value = CMD_CLE | CMD_CE(nand->cur_chip) | CMD_GO;
> > +		writel(value, nand->regs + CMD);
> > +		break;
> > +
> > +	case NAND_CMD_READID:
> > +		writel(NAND_CMD_READID, nand->regs + CMD_1);
> > +		writel(column & 0xff, nand->regs + ADDR_1);
> > +
> > +		value = CMD_GO | CMD_CLE | CMD_ALE | CMD_CE(nand->cur_chip);
> > +		writel(value, nand->regs + CMD);
> > +		break;
> > +
> > +	case NAND_CMD_ERASE1:
> > +		writel(NAND_CMD_ERASE1, nand->regs + CMD_1);
> > +		writel(NAND_CMD_ERASE2, nand->regs + CMD_2);
> > +		writel(page_addr, nand->regs + ADDR_1);
> > +
> > +		value = CMD_GO | CMD_CLE | CMD_ALE | CMD_ALE_SIZE(2) |
> > +			CMD_SEC_CMD | CMD_RBSY_CHK | CMD_CE(nand->cur_chip);
> > +		writel(value, nand->regs + CMD);
> > +		break;
> > +
> > +	case NAND_CMD_ERASE2:
> > +		return;
> > +
> > +	case NAND_CMD_STATUS:
> > +		writel(NAND_CMD_STATUS, nand->regs + CMD_1);
> > +
> > +		value = CMD_GO | CMD_CLE | CMD_CE(nand->cur_chip);
> > +		writel(value, nand->regs + CMD);
> > +		break;
> > +
> > +	case NAND_CMD_PARAM:
> > +		writel(NAND_CMD_PARAM, nand->regs + CMD_1);
> > +		writel(column & 0xff, nand->regs + ADDR_1);
> > +		value = CMD_GO | CMD_CLE | CMD_ALE | CMD_CE(nand->cur_chip);
> > +		writel(value, nand->regs + CMD);
> > +		break;
> > +
> > +	case NAND_CMD_RESET:
> > +		writel(NAND_CMD_RESET, nand->regs + CMD_1);
> > +
> > +		value = CMD_GO | CMD_CLE | CMD_CE(nand->cur_chip);
> > +		writel(value, nand->regs + CMD);
> > +		break;
> > +
> > +	default:
> > +		dev_warn(nand->dev, "unsupported command: %x\n", command);
> > +		return;
> > +	}
> > +
> > +	wait_for_completion(&nand->command_complete);
> > +}
> > +
> > +static void tegra_nand_select_chip(struct mtd_info *mtd, int chip)
> > +{
> > +	struct tegra_nand *nand = to_tegra_nand(mtd);
> > +
> > +	nand->cur_chip = chip;
> > +}
> > +
> > +static uint8_t tegra_nand_read_byte(struct mtd_info *mtd)
> > +{
> > +	struct tegra_nand *nand = to_tegra_nand(mtd);
> > +	u32 value;
> > +
> > +	value = CMD_TRANS_SIZE(0) | CMD_CE(nand->cur_chip) |
> > +		CMD_PIO | CMD_RX | CMD_A_VALID | CMD_GO;
> > +
> > +	writel(value, nand->regs + CMD);
> > +	wait_for_completion(&nand->command_complete);
> > +
> > +	return readl(nand->regs + RESP) & 0xff;
> > +}
> > +
> > +static void tegra_nand_read_buf(struct mtd_info *mtd, uint8_t *buffer,
> > +				int length)
> > +{
> > +	struct tegra_nand *nand = to_tegra_nand(mtd);
> > +	size_t i;
> > +
> > +	for (i = 0; i < length; i += 4) {
> > +		u32 value;
> > +		size_t n = min_t(size_t, length - i, 4);
> > +
> > +		value = CMD_GO | CMD_PIO | CMD_RX | CMD_A_VALID |
> > +			CMD_CE(nand->cur_chip) | CMD_TRANS_SIZE(n - 1);
> > +
> > +		writel(value, nand->regs + CMD);
> > +		wait_for_completion(&nand->command_complete);
> > +
> > +		value = readl(nand->regs + RESP);
> > +		memcpy(buffer + i, &value, n);
> > +	}
> > +}
> > +
> > +static void tegra_nand_write_buf(struct mtd_info *mtd, const uint8_t *buffer,
> > +				 int length)
> > +{
> > +	struct tegra_nand *nand = to_tegra_nand(mtd);
> > +	size_t i;
> > +
> > +	for (i = 0; i < length; i += 4) {
> > +		u32 value;
> > +		size_t n = min_t(size_t, length - i, 4);
> > +
> > +		memcpy(&value, buffer + i, n);
> > +		writel(value, nand->regs + RESP);
> > +
> > +		value = CMD_GO | CMD_PIO | CMD_TX | CMD_A_VALID |
> > +			CMD_CE(nand->cur_chip) | CMD_TRANS_SIZE(n - 1);
> > +
> > +		writel(value, nand->regs + CMD);
> > +		wait_for_completion(&nand->command_complete);
> > +	}
> > +}
> > +
> > +static int tegra_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
> > +				uint8_t *buf, int oob_required, int page)
> > +{
> > +	struct tegra_nand *nand = to_tegra_nand(mtd);
> > +	u32 value;
> > +
> > +	value = readl(nand->regs + CFG);
> > +	value |= CFG_HW_ECC | CFG_ERR_COR;
> > +	writel(value, nand->regs + CFG);
> > +
> > +	writel(mtd->writesize - 1, nand->regs + DMA_CFG_A);
> > +	writel(nand->data_dma, nand->regs + DATA_PTR);
> > +
> > +	if (oob_required) {
> > +		writel(mtd->oobsize - 1, nand->regs + DMA_CFG_B);
> > +		writel(nand->oob_dma, nand->regs + TAG_PTR);
> > +	} else {
> > +		writel(0, nand->regs + DMA_CFG_B);
> > +		writel(0, nand->regs + TAG_PTR);
> > +	}
> > +
> > +	value = DMA_CTRL_GO | DMA_CTRL_IN | DMA_CTRL_PERF_EN |
> > +		DMA_CTRL_REUSE | DMA_CTRL_IE_DONE | DMA_CTRL_IS_DONE |
> > +		DMA_CTRL_BURST_8 | DMA_CTRL_EN_A;
> > +
> > +	if (oob_required)
> > +		value |= DMA_CTRL_EN_B;
> > +
> > +	writel(value, nand->regs + DMA_CTRL);
> > +
> > +	value = CMD_GO | CMD_RX | CMD_TRANS_SIZE(8) |
> > +		CMD_A_VALID | CMD_CE(nand->cur_chip);
> > +	if (oob_required)
> > +		value |= CMD_B_VALID;
> > +	writel(value, nand->regs + CMD);
> > +
> > +	wait_for_completion(&nand->command_complete);
> > +	wait_for_completion(&nand->dma_complete);
> > +
> > +	if (oob_required)
> > +		memcpy(chip->oob_poi, nand->oob_buf, mtd->oobsize);
> > +	memcpy(buf, nand->data_buf, mtd->writesize);
> > +
> > +	value = readl(nand->regs + CFG);
> > +	value &= ~(CFG_HW_ECC | CFG_ERR_COR);
> > +	writel(value, nand->regs + CFG);
> > +
> > +	value = readl(nand->regs + DEC_STATUS);
> > +
> > +	if (value & DEC_STATUS_A_ECC_FAIL) {
> > +		/*
> > +		 * The ECC isn't smart enough to figure out if a page is
> > +		 * completely erased and flags an error in this case. So we
> > +		 * check the read data here to figure out if it's a legitimate
> > +		 * error or a false positive.
> > +		 */
> > +		int i;
> > +		u32 *data = (u32 *)buf;
> > +		for (i = 0; i < mtd->writesize / 4; i++) {
> > +			if (data[i] != 0xffffffff) {
> > +				mtd->ecc_stats.failed++;
> > +				return -EBADMSG;
> > +			}
> > +		}
> 
> Hmm, what about OOB? It's possible to actually write 0xff to the entire
> page. This hunk means that such a data pattern would then be
> unprotected. You should probably check that *both* the main and OOB data
> are all 0xff; if there are non-0xff bytes, then that (probably, see the
> following) means someone intentionally wrote all 0xff to the page. [1]
> 

This check is only executed if the ECC engine flagged a non-correctable
error. If someone wrote all 0xff to the page there will be a proper ECC
checksum calculated and we won't get into this path. So to get this
check to wrongly paper over a legitimate error someone would need to
write almost all 0xff with a few bits 0, which then flip to a 1
afterwards, which is highly unlikely as far as I understand flash
technology.

> Also, your check doesn't handle the case of finding bitflips in erased
> pages. So not only do you need to check for all 0xff, but you also need
> to tolerate a few flips. e.g., using hweight*() functions. There is
> plenty of discussion on this subject, as many people have tried to
> resolve this for their various drivers. But none have really done this
> in a thorough and correct way, so few have been merged. Thus, I'd really
> like to get something like this merged to nand_base.c, with a NAND_*
> flag or two to enable it. That would help drivers like yours to easily
> grab a good (albeit, likely slow) implementation.
> 
Did those discussion lead somewhere? It seems they got stuck some time
ago. I'm all for using common infrastructure that does the right thing,
but I wouldn't like to base this driver on top of future work with no
clear roadmap.

> So, I'd like to see the first request (about OOB checks) solved, and if
> the larger bitflips-in-erased-pages issue isn't addressed, please
> include a FIXME comment, or something similar.
> 
> > +		return 0;
> > +	}
> > +
> > +	if (value & DEC_STATUS_ERR_COUNT_MASK) {
> > +		value = (value & DEC_STATUS_ERR_COUNT_MASK) >>
> > +			DEC_STATUS_ERR_COUNT_SHIFT;
> 
> What does this ERR_COUNT represent? The total bitflips seen in this
> page? The max seen per ECC region? Or something else?
> 
> > +		mtd->ecc_stats.corrected += value;
> 
> I ask because this ^^^ should be accounting the total bitflips for the
> page, if possible...
> 
> > +		return value;
> 
> ...and this ^^^ should be returning the max bitflips seen in a single
> correction region (see the mtd_read() API). There is a subtle
> difference.
> 
Urgh, yeah. The value is bitflips per page. I think there is another
register that should give max errors per ECC region, but I'm not sure it
works correctly. Will test that. Thanks for the hint.

> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int tegra_nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
> > +				 const uint8_t *buf, int oob_required)
> > +{
> > +	struct tegra_nand *nand = to_tegra_nand(mtd);
> > +	unsigned long value;
> > +
> > +	value = readl(nand->regs + CFG);
> > +	value |= CFG_HW_ECC | CFG_ERR_COR;
> > +	writel(value, nand->regs + CFG);
> > +
> > +	memcpy(nand->data_buf, buf, mtd->writesize);
> > +
> > +	writel(mtd->writesize - 1, nand->regs + DMA_CFG_A);
> > +	writel(nand->data_dma, nand->regs + DATA_PTR);
> > +
> > +	writel(0, nand->regs + DMA_CFG_B);
> > +	writel(0, nand->regs + TAG_PTR);
> > +
> > +	value = DMA_CTRL_GO | DMA_CTRL_OUT | DMA_CTRL_PERF_EN |
> > +		DMA_CTRL_IE_DONE | DMA_CTRL_IS_DONE |
> > +		DMA_CTRL_BURST_8 | DMA_CTRL_EN_A;
> > +	writel(value, nand->regs + DMA_CTRL);
> > +
> > +	value = CMD_GO | CMD_TX | CMD_A_VALID | CMD_TRANS_SIZE(8) |
> > +		CMD_CE(nand->cur_chip);
> > +	writel(value, nand->regs + CMD);
> > +
> > +	wait_for_completion(&nand->command_complete);
> > +	wait_for_completion(&nand->dma_complete);
> > +
> > +	value = readl(nand->regs + CFG);
> > +	value &= ~(CFG_HW_ECC | CFG_ERR_COR);
> > +	writel(value, nand->regs + CFG);
> > +
> > +	return 0;
> > +}
> > +
> > +static void tegra_nand_setup_timing(struct tegra_nand *nand, int mode)
> > +{
> 
> This function could use some comments. The math can be easy to get
> wrong, especially without the annotation of units (e.g., picoseconds).
> Also, look out for rounding inaccuracies. DIV_ROUND_UP() is nice for
> getting conservative conversions at times.
> 
The timing formulas are listed in the TRM and I don't think it makes
sense to repeat them here. Are you okay with a pointer to the relevant
section in the TRM?

> > +	unsigned long rate = clk_get_rate(nand->clk) / 1000000;
> > +	unsigned long period = 1000000 / rate;
> > +	const struct nand_sdr_timings *timings;
> > +	u32 val, reg = 0;
> > +
> > +	timings = onfi_async_timing_mode_to_sdr_timings(mode);
> > +
> > +	val = max3(timings->tAR_min, timings->tRR_min,
> > +		   timings->tRC_min) / period;
> > +	if (val > 2)
> > +		val -= 3;
> > +	reg |= TIMING_TCR_TAR_TRR(val);
> > +
> > +	val = max(max(timings->tCS_min, timings->tCH_min),
> > +		  max(timings->tALS_min, timings->tALH_min)) / period;
> > +	if (val > 1)
> > +		val -= 2;
> > +	reg |= TIMING_TCS(val);
> > +
> > +	val = (max(timings->tRP_min, timings->tREA_max) + 6000) / period;
> > +	reg |= (TIMING_TRP(val) | TIMING_TRP_RESP(val));
> > +
> > +	reg |= TIMING_TWB(timings->tWB_max / period);
> > +	reg |= TIMING_TWHR(timings->tWHR_min / period);
> > +	reg |= TIMING_TWH(timings->tWH_min / period);
> > +	reg |= TIMING_TWP(timings->tWP_min / period);
> > +	reg |= TIMING_TRH(timings->tRHW_min / period);
> > +
> > +	writel(reg, nand->regs + TIMING_1);
> > +
> > +	val = timings->tADL_min / period;
> > +	if (val > 2)
> > +		val -= 3;
> > +	reg = TIMING_TADL(val);
> > +
> > +	writel(reg, nand->regs + TIMING_2);
> > +}
> > +
> > +static void tegra_nand_setup_chiptiming(struct tegra_nand *nand)
> > +{
> > +	struct nand_chip *chip = &nand->chip;
> > +	int mode;
> > +
> > +	mode = onfi_get_async_timing_mode(chip);
> > +	if (mode == ONFI_TIMING_MODE_UNKNOWN)
> > +		mode = chip->onfi_timing_mode_default;
> > +	else
> > +		mode = fls(mode);
> > +
> > +	tegra_nand_setup_timing(nand, mode);
> > +}
> > +
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
> 
> You could set chip->dn, then nand_dt_init() might capture this for you.
> 
Thanks, will do.

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
> > +	mtd->name = "tegra_nand";
> > +	mtd->owner = THIS_MODULE;
> > +	mtd->priv = &nand->chip;
> > +
> > +	/* clear interrupts */
> > +	value = readl(nand->regs + ISR);
> > +	writel(value, nand->regs + ISR);
> > +
> > +	writel(DMA_CTRL_IS_DONE, nand->regs + DMA_CTRL);
> > +
> > +	/* enable interrupts */
> > +	value = IER_UND | IER_OVR | IER_CMD_DONE | IER_ECC_ERR | IER_GIE;
> > +	writel(value, nand->regs + IER);
> > +
> > +	value = 0;
> > +	if (buswidth == 16)
> > +		value |= CFG_BUS_WIDTH_16;
> > +	writel(value, nand->regs + CFG);
> > +
> > +	chip = &nand->chip;
> > +	chip->options = NAND_NO_SUBPAGE_WRITE;
> > +	chip->cmdfunc = tegra_nand_command;
> > +	chip->select_chip = tegra_nand_select_chip;
> > +	chip->read_byte = tegra_nand_read_byte;
> > +	chip->read_buf = tegra_nand_read_buf;
> > +	chip->write_buf = tegra_nand_write_buf;
> > +
> > +	if (of_get_nand_on_flash_bbt(pdev->dev.of_node))
> > +		chip->bbt_options = NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
> 
> Again, nand_dt_init() might help you. You might then augment it with:
> 
> 	if (chip->bbt_options & NAND_BBT_USE_FLASH)
> 		chip->bbt_options |= NAND_BBT_NO_OOB;
> 
> > +
> > +	tegra_nand_setup_timing(nand, 0);
> > +
> > +	err = nand_scan_ident(mtd, 1, NULL);
> > +	if (err)
> > +		return err;
> > +
> > +	nand->data_buf = dmam_alloc_coherent(&pdev->dev, mtd->writesize,
> > +					    &nand->data_dma, GFP_KERNEL);
> > +	if (!nand->data_buf)
> > +		return -ENOMEM;
> > +
> > +	nand->oob_buf = dmam_alloc_coherent(&pdev->dev, mtd->oobsize,
> > +					    &nand->oob_dma, GFP_KERNEL);
> > +	if (!nand->oob_buf)
> > +		return -ENOMEM;
> > +
> > +	chip->ecc.mode = NAND_ECC_HW;
> > +	chip->ecc.size = 512;
> > +	chip->ecc.bytes = mtd->oobsize;
> > +	chip->ecc.read_page = tegra_nand_read_page;
> > +	chip->ecc.write_page = tegra_nand_write_page;
> > +
> > +	value = readl(nand->regs + CFG);
> > +	value |=  CFG_PIPE_EN | CFG_SKIP_SPARE | CFG_SKIP_SPARE_SIZE_4;
> > +
> > +	switch (mtd->oobsize) {
> > +	case 16:
> > +		chip->ecc.layout = &tegra_nand_oob_16;
> > +		chip->ecc.strength = 1;
> > +		value |= CFG_TAG_BYTE_SIZE(tegra_nand_oob_16.oobfree[0].length
> > +			 - 1);
> > +		break;
> > +	case 64:
> > +		chip->ecc.layout = &tegra_nand_oob_64;
> > +		chip->ecc.strength = 8;
> > +		value |= CFG_ECC_SEL | CFG_TVAL_8 |
> > +			 CFG_TAG_BYTE_SIZE(tegra_nand_oob_64.oobfree[0].length
> > +			 - 1);
> > +		break;
> > +	case 128:
> > +		chip->ecc.layout = &tegra_nand_oob_128;
> > +		chip->ecc.strength = 8;
> > +		value |= CFG_ECC_SEL | CFG_TVAL_8 |
> > +			 CFG_TAG_BYTE_SIZE(tegra_nand_oob_128.oobfree[0].length
> > +			 - 1);
> > +		break;
> > +	case 224:
> > +		chip->ecc.layout = &tegra_nand_oob_224;
> > +		chip->ecc.strength = 8;
> > +		value |= CFG_ECC_SEL | CFG_TVAL_8 |
> > +			 CFG_TAG_BYTE_SIZE(tegra_nand_oob_224.oobfree[0].length
> > +			 - 1);
> > +		break;
> > +	default:
> > +		dev_err(&pdev->dev, "unhandled OOB size %d\n", mtd->oobsize);
> > +		return -ENODEV;
> > +	}
> > +
> > +	switch (mtd->writesize) {
> > +	case 256:
> > +		value |= CFG_PS_256;
> > +		break;
> > +	case 512:
> > +		value |= CFG_PS_512;
> > +		break;
> > +	case 1024:
> > +		value |= CFG_PS_1024;
> > +		break;
> > +	case 2048:
> > +		value |= CFG_PS_2048;
> > +		break;
> > +	case 4096:
> > +		value |= CFG_PS_4096;
> > +		break;
> > +	default:
> > +		dev_err(&pdev->dev, "unhandled writesize %d\n", mtd->writesize);
> > +		return -ENODEV;
> > +	}
> > +
> > +	writel(value, nand->regs + CFG);
> > +
> > +	tegra_nand_setup_chiptiming(nand);
> > +
> > +	err = nand_scan_tail(mtd);
> > +	if (err)
> > +		return err;
> > +
> > +	mtd_device_parse_register(mtd, NULL,
> > +				  &(struct mtd_part_parser_data) {
> > +					.of_node = pdev->dev.of_node,
> > +				  },
> > +				  NULL, 0);
> 
> Check the return value for errors.
> 
Will do,

Thanks,
Lucas
