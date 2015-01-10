From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat, 10 Jan 2015 18:35:52 +0100
Subject: [PATCH 1/4] mtd: nand: add NVIDIA Tegra NAND Flash controller
 driver
In-Reply-To: <1420403960-26626-1-git-send-email-dev@lynxeye.de>
References: <1420403960-26626-1-git-send-email-dev@lynxeye.de>
Message-ID: <20150110183552.61d3292a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

Have you tried running mtd tests on your driver, if you did, can you
give the results in a cover letter, and if you didn't, can you launch
them.

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
> diff --git a/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt b/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> new file mode 100644
> index 0000000..088223c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> @@ -0,0 +1,30 @@
> +NVIDIA Tegra NAND Flash controller
> +
> +Required properties:
> +- compatible: Must be one of:
> +  - "nvidia,tegra20-nand"
> +  - "nvidia,tegra30-nand"
> +- reg: MMIO address range
> +- interrupts: interrupt output of the NFC controller
> +- clocks: Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: Must include the following entries:
> +  - nand
> +- resets: Must contain an entry for each entry in reset-names.
> +  See ../reset/reset.txt for details.
> +- reset-names: Must include the following entries:
> +  - nand
> +
> +Optional properties:
> +- nvidia,wp-gpios: GPIO used to disable write protection of the flash
> +
> +  Example:
> +	nand at 70008000 {
> +		compatible = "nvidia,tegra20-nand";
> +		reg = <0x70008000 0x100>;
> +		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&tegra_car TEGRA20_CLK_NDFLASH>;
> +		clock-names = "nand";
> +		resets = <&tegra_car 13>;
> +		reset-names = "nand";
> +	};

According to the CMD_CE macro, your NAND controller seems to support
multiple chips. If this is the case, maybe you should represent it with
one nand-controller node and nand chips as children of this controller
(see the sunxi controller binding [1]).

BTW, not that I really care :-), but I thought DT bindings had to be
submitted in their own patch.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index ddb9ac8..972e31d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9459,6 +9459,12 @@ M:	Laxman Dewangan <ldewangan@nvidia.com>
>  S:	Supported
>  F:	drivers/input/keyboard/tegra-kbc.c
>  
> +TEGRA NAND DRIVER
> +M:	Lucas Stach <dev@lynxeye.de>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> +F:	drivers/mtd/nand/tegra_nand.c
> +
>  TEGRA PWM DRIVER
>  M:	Thierry Reding <thierry.reding@gmail.com>
>  S:	Supported
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 7d0150d..1eafd4e 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -524,4 +524,10 @@ config MTD_NAND_SUNXI
>  	help
>  	  Enables support for NAND Flash chips on Allwinner SoCs.
>  
> +config MTD_NAND_TEGRA
> +	tristate "Support for NAND on NVIDIA Tegra"
> +	depends on ARCH_TEGRA || COMPILE_TEST
> +	help
> +	  Enables support for NAND flash on NVIDIA Tegra SoC based boards.
> +
>  endif # MTD_NAND
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index bd38f21..58399ce 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -51,5 +51,6 @@ obj-$(CONFIG_MTD_NAND_GPMI_NAND)	+= gpmi-nand/
>  obj-$(CONFIG_MTD_NAND_XWAY)		+= xway_nand.o
>  obj-$(CONFIG_MTD_NAND_BCM47XXNFLASH)	+= bcm47xxnflash/
>  obj-$(CONFIG_MTD_NAND_SUNXI)		+= sunxi_nand.o
> +obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
>  
>  nand-objs := nand_base.o nand_bbt.o nand_timings.o
> diff --git a/drivers/mtd/nand/tegra_nand.c b/drivers/mtd/nand/tegra_nand.c
> new file mode 100644
> index 0000000..b919a6e
> --- /dev/null
> +++ b/drivers/mtd/nand/tegra_nand.c
> @@ -0,0 +1,794 @@
> +/*
> + * Copyright (C) 2014-2015 Lucas Stach <dev@lynxeye.de>
> + * Copyright (C) 2012 Avionic Design GmbH
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_mtd.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +#define CMD				0x00
> +#define   CMD_GO			(1 << 31)
> +#define   CMD_CLE			(1 << 30)
> +#define   CMD_ALE			(1 << 29)
> +#define   CMD_PIO			(1 << 28)
> +#define   CMD_TX			(1 << 27)
> +#define   CMD_RX			(1 << 26)
> +#define   CMD_SEC_CMD			(1 << 25)
> +#define   CMD_AFT_DAT			(1 << 24)
> +#define   CMD_TRANS_SIZE(x)		(((x) & 0xf) << 20)
> +#define   CMD_A_VALID			(1 << 19)
> +#define   CMD_B_VALID			(1 << 18)
> +#define   CMD_RD_STATUS_CHK		(1 << 17)
> +#define   CMD_RBSY_CHK			(1 << 16)
> +#define   CMD_CE(x)			(1 << (8 + ((x) & 0x7)))
> +#define   CMD_CLE_SIZE(x)		(((x) & 0x3) << 4)
> +#define   CMD_ALE_SIZE(x)		(((x) & 0xf) << 0)
> +
> +#define STATUS				0x04
> +
> +#define ISR				0x08
> +#define   ISR_UND			(1 << 7)
> +#define   ISR_OVR			(1 << 6)
> +#define   ISR_CMD_DONE			(1 << 5)
> +#define   ISR_ECC_ERR			(1 << 4)
> +
> +#define IER				0x0c
> +#define   IER_ERR_TRIG_VAL(x)		(((x) & 0xf) << 16)
> +#define   IER_UND			(1 << 7)
> +#define   IER_OVR			(1 << 6)
> +#define   IER_CMD_DONE			(1 << 5)
> +#define   IER_ECC_ERR			(1 << 4)
> +#define   IER_GIE			(1 << 0)
> +
> +#define CFG				0x10
> +#define   CFG_HW_ECC			(1 << 31)
> +#define   CFG_ECC_SEL			(1 << 30)
> +#define   CFG_ERR_COR			(1 << 29)
> +#define   CFG_PIPE_EN			(1 << 28)
> +#define   CFG_TVAL_4			(0 << 24)
> +#define   CFG_TVAL_6			(1 << 24)
> +#define   CFG_TVAL_8			(2 << 24)
> +#define   CFG_SKIP_SPARE		(1 << 23)
> +#define   CFG_BUS_WIDTH_8		(0 << 21)
> +#define   CFG_BUS_WIDTH_16		(1 << 21)
> +#define   CFG_COM_BSY			(1 << 20)
> +#define   CFG_PS_256			(0 << 16)
> +#define   CFG_PS_512			(1 << 16)
> +#define   CFG_PS_1024			(2 << 16)
> +#define   CFG_PS_2048			(3 << 16)
> +#define   CFG_PS_4096			(4 << 16)
> +#define   CFG_SKIP_SPARE_SIZE_4		(0 << 14)
> +#define   CFG_SKIP_SPARE_SIZE_8		(1 << 14)
> +#define   CFG_SKIP_SPARE_SIZE_12	(2 << 14)
> +#define   CFG_SKIP_SPARE_SIZE_16	(3 << 14)
> +#define   CFG_TAG_BYTE_SIZE(x)		((x) & 0xff)
> +
> +#define TIMING_1			0x14
> +#define   TIMING_TRP_RESP(x)		(((x) & 0xf) << 28)
> +#define   TIMING_TWB(x)			(((x) & 0xf) << 24)
> +#define   TIMING_TCR_TAR_TRR(x)		(((x) & 0xf) << 20)
> +#define   TIMING_TWHR(x)		(((x) & 0xf) << 16)
> +#define   TIMING_TCS(x)			(((x) & 0xc) << 14)
> +#define   TIMING_TWH(x)			(((x) & 0x3) << 12)
> +#define   TIMING_TWP(x)			(((x) & 0xf) <<  8)
> +#define   TIMING_TRH(x)			(((x) & 0xf) <<  4)
> +#define   TIMING_TRP(x)			(((x) & 0xf) <<  0)
> +
> +#define RESP				0x18
> +
> +#define TIMING_2			0x1c
> +#define   TIMING_TADL(x)		((x) & 0xf)
> +
> +#define CMD_1				0x20
> +#define CMD_2				0x24
> +#define ADDR_1				0x28
> +#define ADDR_2				0x2c
> +
> +#define DMA_CTRL			0x30
> +#define   DMA_CTRL_GO			(1 << 31)
> +#define   DMA_CTRL_IN			(0 << 30)
> +#define   DMA_CTRL_OUT			(1 << 30)
> +#define   DMA_CTRL_PERF_EN		(1 << 29)
> +#define   DMA_CTRL_IE_DONE		(1 << 28)
> +#define   DMA_CTRL_REUSE		(1 << 27)
> +#define   DMA_CTRL_BURST_1		(2 << 24)
> +#define   DMA_CTRL_BURST_4		(3 << 24)
> +#define   DMA_CTRL_BURST_8		(4 << 24)
> +#define   DMA_CTRL_BURST_16		(5 << 24)
> +#define   DMA_CTRL_IS_DONE		(1 << 20)
> +#define   DMA_CTRL_EN_A			(1 <<  2)
> +#define   DMA_CTRL_EN_B			(1 <<  1)
> +
> +#define DMA_CFG_A			0x34
> +#define DMA_CFG_B			0x38
> +
> +#define FIFO_CTRL			0x3c
> +#define   FIFO_CTRL_CLR_ALL		(1 << 3)
> +
> +#define DATA_PTR			0x40
> +#define TAG_PTR				0x44
> +#define ECC_PTR				0x48
> +
> +#define HWSTATUS_CMD			0x50
> +#define HWSTATUS_MASK			0x54
> +#define   HWSTATUS_RDSTATUS_MASK(x)	(((x) & 0xff) << 24)
> +#define   HWSTATUS_RDSTATUS_VALUE(x)	(((x) & 0xff) << 16)
> +#define   HWSTATUS_RBSY_MASK(x)		(((x) & 0xff) << 8)
> +#define   HWSTATUS_RBSY_VALUE(x)	(((x) & 0xff) << 0)
> +
> +#define DEC_RESULT			0xd0
> +#define   DEC_RESULT_CORRFAIL		(1 << 8)
> +
> +#define DEC_STATUS_BUF			0xd4
> +#define   DEC_STATUS_BUF_FAIL_SEC_FLAG(x)	((x) & (0xff << 24))
> +#define   DEC_STATUS_BUF_CORR_SEC_FLAG(x)	((x) & (0xff << 16))
> +#define   DEC_STATUS_BUF_MAX_CORR_CNT(x)	(((x) & 0xf00) >> 8)
> +
> +struct tegra_nand {
> +	void __iomem *regs;
> +	int irq;
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	int wp_gpio;
> +	int buswidth;
> +
> +	struct nand_chip chip;
> +	struct mtd_info mtd;
> +	struct device *dev;
> +
> +	struct completion command_complete;
> +	struct completion dma_complete;
> +
> +	dma_addr_t data_dma;
> +	void *data_buf;
> +	dma_addr_t oob_dma;
> +	void *oob_buf;
> +
> +	int cur_chip;
> +};
> +
> +static inline struct tegra_nand *to_tegra_nand(struct mtd_info *mtd)
> +{
> +	return container_of(mtd, struct tegra_nand, mtd);
> +}
> +
> +static struct nand_ecclayout tegra_nand_oob_16 = {
> +	.eccbytes = 4,
> +	.eccpos = { 3, 4, 5, 6 },
> +	.oobfree = {
> +		{ .offset = 8, . length = 8 }
> +	}
> +};
> +
> +static struct nand_ecclayout tegra_nand_oob_64 = {
> +	.eccbytes = 36,
> +	.eccpos = {
> +		 3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
> +		19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
> +		35, 36, 37, 38, 39
> +	},
> +	.oobfree = {
> +		{ .offset = 40, .length = 20 }
> +	}
> +};
> +
> +static struct nand_ecclayout tegra_nand_oob_128 = {
> +	.eccbytes = 72,
> +	.eccpos = {
> +		 3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
> +		19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
> +		35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
> +		51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66,
> +		67, 68, 69, 70, 71, 72, 73, 74, 75
> +	},
> +	.oobfree = {
> +		{ .offset = 76, .length = 52 }
> +	}
> +};
> +
> +static struct nand_ecclayout tegra_nand_oob_224 = {
> +	.eccbytes = 144,
> +	.eccpos = {
> +		  3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
> +		 15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  26,
> +		 27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,
> +		 39,  40,  41,  42,  43,  44,  45,  46,  47,  48,  49,  50,
> +		 51,  52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  62,
> +		 63,  64,  65,  66,  67,  68,  69,  70,  71,  72,  73,  74,
> +		 75,  76,  77,  78,  79,  80,  81,  82,  83,  84,  85,  86,
> +		 87,  88,  89,  90,  91,  92,  93,  94,  95,  96,  97,  98,
> +		 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110,
> +		111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122,
> +		123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134,
> +		135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146,
> +		147
> +	},
> +	.oobfree = {
> +		{ .offset = 148, .length = 76 }
> +	}
> +};

If you want to support as much NAND references as possible (I mean
those with oob size > 224), maybe these layouts should be dynamically
defined (based on the chosen ECC strength and step size).
See what's done in nand_bch.c.

> +
> +static irqreturn_t tegra_nand_irq(int irq, void *data)
> +{
> +	struct tegra_nand *nand = data;
> +	irqreturn_t ret = IRQ_HANDLED;
> +	u32 isr, dma;
> +
> +	isr = readl(nand->regs + ISR);
> +	dma = readl(nand->regs + DMA_CTRL);
> +
> +	if (!isr && !(dma & DMA_CTRL_IS_DONE)) {
> +		ret = IRQ_NONE;
> +		goto out;
> +	}
> +
> +	if (isr & ISR_CMD_DONE)
> +		complete(&nand->command_complete);
> +
> +	if (isr & ISR_UND)
> +		dev_dbg(nand->dev, "  FIFO underrun\n");
> +
> +	if (isr & ISR_OVR)
> +		dev_dbg(nand->dev, "  FIFO overrun\n");
> +
> +	/* handle DMA interrupts */
> +	if (dma & DMA_CTRL_IS_DONE) {
> +		writel(dma, nand->regs + DMA_CTRL);
> +		complete(&nand->dma_complete);
> +	}
> +
> +	/* clear interrupts */
> +	writel(isr, nand->regs + ISR);
> +
> +out:
> +	return ret;
> +}
> +
> +static void tegra_nand_command(struct mtd_info *mtd, unsigned int command,
> +			       int column, int page_addr)
> +{
> +	struct tegra_nand *nand = to_tegra_nand(mtd);
> +	u32 value;
> +
> +	switch (command) {
> +	case NAND_CMD_READOOB:
> +		column += mtd->writesize;
> +		/* fall-through */
> +
> +	case NAND_CMD_READ0:
> +		writel(NAND_CMD_READ0, nand->regs + CMD_1);
> +		writel(NAND_CMD_READSTART, nand->regs + CMD_2);
> +
> +		value = (page_addr << 16) | (column & 0xffff);
> +		writel(value, nand->regs + ADDR_1);
> +
> +		value = page_addr >> 16;
> +		writel(value, nand->regs + ADDR_2);
> +
> +		value = CMD_CLE | CMD_ALE | CMD_ALE_SIZE(4) | CMD_SEC_CMD |
> +			CMD_RBSY_CHK | CMD_CE(nand->cur_chip) | CMD_GO;
> +		writel(value, nand->regs + CMD);
> +		break;
> +
> +	case NAND_CMD_SEQIN:
> +		writel(NAND_CMD_SEQIN, nand->regs + CMD_1);
> +
> +		value = (page_addr << 16) | (column & 0xffff);
> +		writel(value, nand->regs + ADDR_1);
> +
> +		value = page_addr >> 16;
> +		writel(value, nand->regs + ADDR_2);
> +
> +		value = CMD_CLE | CMD_ALE | CMD_ALE_SIZE(4) |
> +			CMD_CE(nand->cur_chip) | CMD_GO;
> +		writel(value, nand->regs + CMD);
> +		break;
> +
> +	case NAND_CMD_PAGEPROG:
> +		writel(NAND_CMD_PAGEPROG, nand->regs + CMD_1);
> +
> +		value = CMD_CLE | CMD_CE(nand->cur_chip) | CMD_GO;
> +		writel(value, nand->regs + CMD);
> +		break;
> +
> +	case NAND_CMD_READID:
> +		writel(NAND_CMD_READID, nand->regs + CMD_1);
> +		writel(column & 0xff, nand->regs + ADDR_1);
> +
> +		value = CMD_GO | CMD_CLE | CMD_ALE | CMD_CE(nand->cur_chip);
> +		writel(value, nand->regs + CMD);
> +		break;
> +
> +	case NAND_CMD_ERASE1:
> +		writel(NAND_CMD_ERASE1, nand->regs + CMD_1);
> +		writel(NAND_CMD_ERASE2, nand->regs + CMD_2);
> +		writel(page_addr, nand->regs + ADDR_1);
> +
> +		value = CMD_GO | CMD_CLE | CMD_ALE | CMD_ALE_SIZE(2) |
> +			CMD_SEC_CMD | CMD_RBSY_CHK | CMD_CE(nand->cur_chip);
> +		writel(value, nand->regs + CMD);
> +		break;
> +
> +	case NAND_CMD_ERASE2:
> +		return;
> +
> +	case NAND_CMD_STATUS:
> +		writel(NAND_CMD_STATUS, nand->regs + CMD_1);
> +
> +		value = CMD_GO | CMD_CLE | CMD_CE(nand->cur_chip);
> +		writel(value, nand->regs + CMD);
> +		break;
> +
> +	case NAND_CMD_PARAM:
> +		writel(NAND_CMD_PARAM, nand->regs + CMD_1);
> +		writel(column & 0xff, nand->regs + ADDR_1);
> +		value = CMD_GO | CMD_CLE | CMD_ALE | CMD_CE(nand->cur_chip);
> +		writel(value, nand->regs + CMD);
> +		break;
> +
> +	case NAND_CMD_RESET:
> +		writel(NAND_CMD_RESET, nand->regs + CMD_1);
> +
> +		value = CMD_GO | CMD_CLE | CMD_CE(nand->cur_chip);
> +		writel(value, nand->regs + CMD);
> +		break;
> +
> +	default:
> +		dev_warn(nand->dev, "unsupported command: %x\n", command);
> +		return;
> +	}
> +
> +	wait_for_completion(&nand->command_complete);
> +}

Have you tried defining cmd_ctrl and dev_ready instead of
reimplementing the nand_command function (already provided by
nand_base.c) ?
Here is a quick rework [2] (not sure this can work though).

That's all I got for now.

By the way, if you plan to support addressing multiple NAND chips with
this controller you might want to take a look at the sunxi_nand driver
[3].

Best Regards,

Boris

[1]https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/mtd/sunxi-nand.txt?id=refs/tags/v3.19-rc3
[2]http://code.bulix.org/tljno2-87698
[3]https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/mtd/nand/sunxi_nand.c?id=refs/tags/v3.19-rc3

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
