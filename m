From: dev@lynxeye.de (Lucas Stach)
Date: Wed, 07 Jan 2015 01:24:38 +0100
Subject: [PATCH 1/4] mtd: nand: add NVIDIA Tegra NAND Flash controller
 driver
In-Reply-To: <54AC290B.5000606@vanguardiasur.com.ar>
References: <1420403960-26626-1-git-send-email-dev@lynxeye.de>
 <54AC290B.5000606@vanguardiasur.com.ar>
Message-ID: <1420590278.25483.14.camel@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 06.01.2015, 15:27 -0300 schrieb Ezequiel Garcia:
> On 01/04/2015 05:39 PM, Lucas Stach wrote:
> 
> Hi Lucas,
> 
> The driver looks mostly good. Just a few comments on my side.
> 
> > Add support for the NAND flash controller found on NVIDIA
> > Tegra 2/3 SoCs. This is a largely reworked version of the driver
> > started by Thierry.
> > 
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > Signed-off-by: Lucas Stach <dev@lynxeye.de>
> > ---
> > I've tested this driver with the in-kernel mtd-tests and some
> > realworld workloads on a Colibri T20 module.
> > ---
> >  .../bindings/mtd/nvidia,tegra20-nand.txt           |  30 +
> >  MAINTAINERS                                        |   6 +
> >  drivers/mtd/nand/Kconfig                           |   6 +
> >  drivers/mtd/nand/Makefile                          |   1 +
> >  drivers/mtd/nand/tegra_nand.c                      | 794 +++++++++++++++++++++
> >  5 files changed, 837 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> >  create mode 100644 drivers/mtd/nand/tegra_nand.c
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt b/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> > new file mode 100644
> > index 0000000..088223c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> > @@ -0,0 +1,30 @@
> > +NVIDIA Tegra NAND Flash controller
> > +
> > +Required properties:
> > +- compatible: Must be one of:
> > +  - "nvidia,tegra20-nand"
> > +  - "nvidia,tegra30-nand"
> > +- reg: MMIO address range
> > +- interrupts: interrupt output of the NFC controller
> > +- clocks: Must contain an entry for each entry in clock-names.
> > +  See ../clocks/clock-bindings.txt for details.
> > +- clock-names: Must include the following entries:
> > +  - nand
> > +- resets: Must contain an entry for each entry in reset-names.
> > +  See ../reset/reset.txt for details.
> > +- reset-names: Must include the following entries:
> > +  - nand
> > +
> > +Optional properties:
> > +- nvidia,wp-gpios: GPIO used to disable write protection of the flash
> > +
> > +  Example:
> > +	nand at 70008000 {
> > +		compatible = "nvidia,tegra20-nand";
> > +		reg = <0x70008000 0x100>;
> > +		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks = <&tegra_car TEGRA20_CLK_NDFLASH>;
> > +		clock-names = "nand";
> > +		resets = <&tegra_car 13>;
> > +		reset-names = "nand";
> > +	};
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ddb9ac8..972e31d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9459,6 +9459,12 @@ M:	Laxman Dewangan <ldewangan@nvidia.com>
> >  S:	Supported
> >  F:	drivers/input/keyboard/tegra-kbc.c
> >  
> > +TEGRA NAND DRIVER
> > +M:	Lucas Stach <dev@lynxeye.de>
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> > +F:	drivers/mtd/nand/tegra_nand.c
> > +
> >  TEGRA PWM DRIVER
> >  M:	Thierry Reding <thierry.reding@gmail.com>
> >  S:	Supported
> > diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> > index 7d0150d..1eafd4e 100644
> > --- a/drivers/mtd/nand/Kconfig
> > +++ b/drivers/mtd/nand/Kconfig
> > @@ -524,4 +524,10 @@ config MTD_NAND_SUNXI
> >  	help
> >  	  Enables support for NAND Flash chips on Allwinner SoCs.
> >  
> > +config MTD_NAND_TEGRA
> > +	tristate "Support for NAND on NVIDIA Tegra"
> > +	depends on ARCH_TEGRA || COMPILE_TEST
> > +	help
> > +	  Enables support for NAND flash on NVIDIA Tegra SoC based boards.
> > +
> >  endif # MTD_NAND
> > diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> > index bd38f21..58399ce 100644
> > --- a/drivers/mtd/nand/Makefile
> > +++ b/drivers/mtd/nand/Makefile
> > @@ -51,5 +51,6 @@ obj-$(CONFIG_MTD_NAND_GPMI_NAND)	+= gpmi-nand/
> >  obj-$(CONFIG_MTD_NAND_XWAY)		+= xway_nand.o
> >  obj-$(CONFIG_MTD_NAND_BCM47XXNFLASH)	+= bcm47xxnflash/
> >  obj-$(CONFIG_MTD_NAND_SUNXI)		+= sunxi_nand.o
> > +obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
> >  
> >  nand-objs := nand_base.o nand_bbt.o nand_timings.o
> > diff --git a/drivers/mtd/nand/tegra_nand.c b/drivers/mtd/nand/tegra_nand.c
> > new file mode 100644
> > index 0000000..b919a6e
> > --- /dev/null
> > +++ b/drivers/mtd/nand/tegra_nand.c
> > @@ -0,0 +1,794 @@
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
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/mtd/nand.h>
> > +#include <linux/mtd/partitions.h>
> > +#include <linux/of_gpio.h>
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
> 
> How about using BIT() ?
> 
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
> > +#define   TIMING_TCS(x)			(((x) & 0xc) << 14)
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
> > +#define HWSTATUS_CMD			0x50
> > +#define HWSTATUS_MASK			0x54
> > +#define   HWSTATUS_RDSTATUS_MASK(x)	(((x) & 0xff) << 24)
> > +#define   HWSTATUS_RDSTATUS_VALUE(x)	(((x) & 0xff) << 16)
> > +#define   HWSTATUS_RBSY_MASK(x)		(((x) & 0xff) << 8)
> > +#define   HWSTATUS_RBSY_VALUE(x)	(((x) & 0xff) << 0)
> > +
> > +#define DEC_RESULT			0xd0
> > +#define   DEC_RESULT_CORRFAIL		(1 << 8)
> > +
> > +#define DEC_STATUS_BUF			0xd4
> > +#define   DEC_STATUS_BUF_FAIL_SEC_FLAG(x)	((x) & (0xff << 24))
> > +#define   DEC_STATUS_BUF_CORR_SEC_FLAG(x)	((x) & (0xff << 16))
> > +#define   DEC_STATUS_BUF_MAX_CORR_CNT(x)	(((x) & 0xf00) >> 8)
> > +
> > +struct tegra_nand {
> > +	void __iomem *regs;
> > +	int irq;
> 
> Seems like you don't need to store irq.
> 
> > +	struct clk *clk;
> > +	struct reset_control *rst;
> > +	int wp_gpio;
> > +	int buswidth;
> 
> And also you don't seem to need either wp_gpio or buswidth stored
> in the struct. You only use them at probe time.
> 

I'll keep the wp_gpio, as I still hope to use this to WP the NAND when
no write is pending. I'll fix the others.

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

[...]

> > +static int tegra_nand_parse_dt(struct device_node *node,
> > +			       struct tegra_nand *nand)
> > +{
> > +	enum of_gpio_flags flags;
> > +
> > +	nand->wp_gpio = of_get_named_gpio_flags(node, "nvidia,wp-gpios", 0,
> > +						 &flags);
> > +	if (nand->wp_gpio < 0)
> > +		nand->wp_gpio = 0;
> > +
> > +	nand->buswidth = of_get_nand_bus_width(node);
> > +	if (nand->buswidth < 0)
> > +		return nand->buswidth;
> > +
> 
> I believe you should set NAND_BUSWIDTH_16 flag in nand_chip.options,
> before calling nand_scan_ident?
> 
> Also, if you just access the of_get_nand_bus_width before nand_scan_ident
> you can drop the nand->buswidth field.
> 
> Same goes for wp_gpio.
> 

Right, will do.

> > +	return 0;
> > +}
> > +
[...]

> > +
> > +static const struct of_device_id tegra_nand_of_match[] = {
> > +	{ .compatible = "nvidia,tegra20-nand" },
> > +	{ .compatible = "nvidia,tegra30-nand" },
> 
> AFAIK, having two compatible strings, but making no distinction between
> them is typically frowned upon by devicetree maintainers.
> 
> Is the controller any different in tegra20 and tegra30?
> 
> If you are not sure about the controllers being different, you can
> try the following approach. The devicetree is written like this:
> 
> nand at foo {
>    compatible = "nvidia,tegra20-nand", "nvidia,tegra-nand";
> };
> 
> So you only deal with "nvidia,tegra-nand" in the driver, yet the
> devicetree files are prepared to deal with a difference.
> 

I believe that tegra30-nand is actually a bit different from tegra20 (at
least on more clock I know about), but obviously this driver doesn't
handle those differences and I don't know if I ever get to see Tegra30
hardware with NAND. Given that I think it's best to just remove the
tegra30-nand compatible for now and add it back if someone has hardware
to test with.

Regards,
Lucas
