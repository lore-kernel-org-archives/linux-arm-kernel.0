From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 7 Sep 2010 00:40:50 +0200
Subject: [PATCH 43/74] ST SPEAr : EMI (Extrenal Memory Interface)
	controller driver
In-Reply-To: <468bb871e1ce062fbde39f78600b23a896b57a72.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<468bb871e1ce062fbde39f78600b23a896b57a72.1283161023.git.viresh.kumar@st.com>
Message-ID: <20100906224050.GA8153@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:09 Mon 30 Aug     , Viresh KUMAR wrote:
> From: Vipin Kumar <vipin.kumar@st.com>
> 
> 2 SPEAr platform SoCs(spear310 and spear320) support an External Memory
> Interface controller. This controller is used to interface with Parallel
> NOR Flash devices.
> 
> This patch adds just the platform code needed for EMI (mainly EMI
> initialization). The driver being used is driver/mtd/maps/physmap.c
> 
> Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  arch/arm/mach-spear3xx/Makefile                |    4 +
>  arch/arm/mach-spear3xx/clock.c                 |   12 +++
>  arch/arm/mach-spear3xx/emi.c                   |   86 ++++++++++++++++++++++++
>  arch/arm/mach-spear3xx/include/mach/emi.h      |   79 ++++++++++++++++++++++
>  arch/arm/mach-spear3xx/include/mach/generic.h  |    2 +
>  arch/arm/mach-spear3xx/include/mach/spear310.h |    9 +++
>  arch/arm/mach-spear3xx/include/mach/spear320.h |    6 ++
>  arch/arm/mach-spear3xx/spear310.c              |   20 ++++++
>  arch/arm/mach-spear3xx/spear310_evb.c          |   18 +++++
>  arch/arm/mach-spear3xx/spear320.c              |   20 ++++++
>  arch/arm/mach-spear3xx/spear320_evb.c          |   17 +++++
>  11 files changed, 273 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-spear3xx/emi.c
>  create mode 100644 arch/arm/mach-spear3xx/include/mach/emi.h
> 
> diff --git a/arch/arm/mach-spear3xx/Makefile b/arch/arm/mach-spear3xx/Makefile
> index b248624..d38ae47 100644
> --- a/arch/arm/mach-spear3xx/Makefile
> +++ b/arch/arm/mach-spear3xx/Makefile
> @@ -24,3 +24,7 @@ obj-$(CONFIG_MACH_SPEAR320) += spear320.o
>  
>  # spear320 boards files
>  obj-$(CONFIG_BOARD_SPEAR320_EVB) += spear320_evb.o
> +
> +# specific files
> +obj-$(CONFIG_MACH_SPEAR310) += emi.o
> +obj-$(CONFIG_MACH_SPEAR320) += emi.o
> diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
> index 41a2b5e..4f049fe 100644
> --- a/arch/arm/mach-spear3xx/clock.c
> +++ b/arch/arm/mach-spear3xx/clock.c
> @@ -552,6 +552,15 @@ static struct clk adc_clk = {
>  	.recalc = &follow_parent,
>  };
>  
> +#if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
can you create a macro for this?
or even better detect it

> +/* emi clock */
> +static struct clk emi_clk = {
> +	.flags = ALWAYS_ENABLED,
> +	.pclk = &ahb_clk,
> +	.recalc = &follow_parent,
> +};
> +#endif
> +
>  /* ssp clock */
>  static struct clk ssp0_clk = {
>  	.pclk = &apb_clk,
> @@ -744,6 +753,9 @@ static struct clk_lookup spear_clk_lookups[] = {
>  	{ .dev_id = "adc",		.clk = &adc_clk},
>  	{ .dev_id = "ssp-pl022.0",	.clk = &ssp0_clk},
>  	{ .dev_id = "gpio",		.clk = &gpio_clk},
> +#if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
> +	{ .dev_id = "physmap-flash",	.clk = &emi_clk},
> +#endif
>  #if defined(CONFIG_MACH_SPEAR300) || defined(CONFIG_MACH_SPEAR310) || \
>  	defined(CONFIG_MACH_SPEAR320)
>  	{ .con_id = "fsmc",		.clk = &fsmc_clk},
> diff --git a/arch/arm/mach-spear3xx/emi.c b/arch/arm/mach-spear3xx/emi.c
> new file mode 100644
> index 0000000..dd5cb8e
> --- /dev/null
> +++ b/arch/arm/mach-spear3xx/emi.c
> @@ -0,0 +1,86 @@
> +/*
> + * arch/arm/mach-spear3xx/emi.c
> + *
> + * EMI (External Memory Interface) file
> + *
> + * Copyright (C) 2010 ST Microelectronics
> + * Vipin Kumar<vipin.kumar@st.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <mach/emi.h>
> +
> +int __init emi_init(struct platform_device *pdev, unsigned long base,
> +		u32 bank, u32 width)
> +{
how about request the memory region

and use platform device to register the bank ressource instead of define

it will make it more flexible
> +	void __iomem *emi_reg_base;
> +	struct clk *clk;
> +	int ret;
> +
> +	if (bank > (EMI_MAX_BANKS - 1))
> +		return -EINVAL;
> +
> +	emi_reg_base = ioremap(base, EMI_REG_SIZE);
> +	if (!emi_reg_base)
> +		return -ENOMEM;
> +
> +	clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk)) {
> +		iounmap(emi_reg_base);
> +		return PTR_ERR(clk);
> +	}
> +
> +	ret = clk_enable(clk);
> +	if (ret) {
> +		iounmap(emi_reg_base);
> +		return ret;
> +	}
> +
> +	/* set the timing */
> +	writel(0x10, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TAP_REG);
> +	writel(0x05, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TSDP_REG);
> +	writel(0x0a, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TDPW_REG);
> +	writel(0x0a, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TDPR_REG);
> +	writel(0x05, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TDCS_REG);
you always set the same timmings?

it's wired as the timings as supposed to be nor or nand specific

and you can you more than one nor or nand

so NACK

> +
> +	switch (width) {
> +	case EMI_FLASH_WIDTH8:
> +		width = EMI_CNTL_WIDTH8;
> +		break;
> +
> +	case EMI_FLASH_WIDTH16:
> +		width = EMI_CNTL_WIDTH16;
> +		break;
> +
> +	case EMI_FLASH_WIDTH32:
> +		width = EMI_CNTL_WIDTH32;
> +		break;
> +	default:
> +		width = EMI_CNTL_WIDTH8;
> +		break;
> +	}
> +	/* set the data width */
> +	writel(width | EMI_CNTL_ENBBYTERW,
> +		emi_reg_base + (EMI_BANK_REG_SIZE * bank) + CTRL_REG);
> +
> +	/* disable all the acks */
> +	writel(0x3f << bank, emi_reg_base + ACK_REG);
> +
> +	iounmap(emi_reg_base);
> +
> +	return 0;
> +}
> +
> +void __init emi_init_board_info(struct platform_device *pdev,
> +		struct mtd_partition *partitions, unsigned int nr_partitions,
> +		unsigned int width)
> +{
> +	emi_init_plat_data(pdev, partitions, nr_partitions, width);
> +}
???
> diff --git a/arch/arm/mach-spear3xx/include/mach/emi.h b/arch/arm/mach-spear3xx/include/mach/emi.h
> new file mode 100644
> index 0000000..f3cbfbc
> --- /dev/null
> +++ b/arch/arm/mach-spear3xx/include/mach/emi.h
> @@ -0,0 +1,79 @@
> +/*
> + * arch/arm/mach-spear3xx/include/mach/emi.h
> + *
> + * EMI macros for SPEAr platform
> + *
> + * Copyright (C) 2010 ST Microelectronics
> + * Vipin Kumar <vipin.kumar@st.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __MACH_EMI_H
> +#define __MACH_EMI_H
> +
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/physmap.h>
> +
> +#define EMI_FLASH_WIDTH8	1
> +#define EMI_FLASH_WIDTH16	2
> +#define EMI_FLASH_WIDTH32	4
> +
> +#define EMI_REG_SIZE		0x100
> +#define EMI_BANK_REG_SIZE	0x18
> +
> +#define TAP_REG			(0x0)
> +#define TSDP_REG		(0x4)
> +#define TDPW_REG		(0x8)
> +#define TDPR_REG		(0xC)
> +#define TDCS_REG		(0x10)
> +#define CTRL_REG		(0x14)
> +
> +#if defined(CONFIG_MACH_SPEAR310)
> +#define TIMEOUT_REG		(0x90)
> +#define ACK_REG			(0x94)
> +#define IRQ_REG			(0x98)
> +
> +#define EMI_MAX_BANKS		6
> +
> +#elif defined(CONFIG_MACH_SPEAR320)
> +#define TIMEOUT_REG		(0x60)
> +#define ACK_REG			(0x64)
> +#define IRQ_REG			(0x68)
> +
> +#define EMI_MAX_BANKS		4
> +
> +#endif
> +
> +/* Control register definitions */
> +#define EMI_CNTL_WIDTH8		(0 << 0)
> +#define EMI_CNTL_WIDTH16	(1 << 0)
> +#define EMI_CNTL_WIDTH32	(2 << 0)
> +#define EMI_CNTL_ENBBYTEW	(1 << 2)
> +#define EMI_CNTL_ENBBYTER	(1 << 3)
> +#define EMI_CNTL_ENBBYTERW	(EMI_CNTL_ENBBYTER | EMI_CNTL_ENBBYTEW)
> +
> +static inline void emi_init_plat_data(struct platform_device *pdev,
> +		struct mtd_partition *partitions, unsigned int nr_partitions,
> +		unsigned int width)
> +{
> +	struct physmap_flash_data *emi_plat_data;
> +	emi_plat_data = dev_get_platdata(&pdev->dev);
> +
> +	if (partitions) {
> +		emi_plat_data->parts = partitions;
> +		emi_plat_data->nr_parts = nr_partitions;
> +	}
> +
> +	emi_plat_data->width = width;
> +}
> +
> +extern int __init emi_init(struct platform_device *pdev, unsigned long base,
> +		u32 bank, u32 width);
> +extern void __init emi_init_board_info(struct platform_device *pdev,
> +		struct mtd_partition *partitions, unsigned int nr_partitions,
> +		unsigned int width);
> +#endif
> diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
> index 4d04dbe..6c6eced 100644
> --- a/arch/arm/mach-spear3xx/include/mach/generic.h
> +++ b/arch/arm/mach-spear3xx/include/mach/generic.h
> @@ -167,6 +167,7 @@ extern struct amba_device uart2_device;
>  extern struct amba_device uart3_device;
>  extern struct amba_device uart4_device;
>  extern struct amba_device uart5_device;
> +extern struct platform_device emi_nor_device;
>  extern struct platform_device plgpio_device;
>  extern struct platform_device nand_device;
>  
> @@ -192,6 +193,7 @@ extern struct amba_device uart1_device;
>  extern struct amba_device uart2_device;
>  extern struct platform_device can0_device;
>  extern struct platform_device can1_device;
> +extern struct platform_device emi_nor_device;
>  extern struct platform_device i2c1_device;
>  extern struct platform_device nand_device;
>  extern struct platform_device plgpio_device;
> diff --git a/arch/arm/mach-spear3xx/include/mach/spear310.h b/arch/arm/mach-spear3xx/include/mach/spear310.h
> index 1e85347..37556b6 100644
> --- a/arch/arm/mach-spear3xx/include/mach/spear310.h
> +++ b/arch/arm/mach-spear3xx/include/mach/spear310.h
> @@ -18,6 +18,15 @@
>  
>  #define SPEAR310_NAND_BASE		UL(0x40000000)
>  #define SPEAR310_FSMC_BASE		UL(0x44000000)
> +#define SPEAR310_EMI_REG_BASE		UL(0x4F000000)
> +#define SPEAR310_EMI_MEM_0_BASE		UL(0x50000000)
> +#define SPEAR310_EMI_MEM_1_BASE		UL(0x60000000)
> +#define SPEAR310_EMI_MEM_2_BASE		UL(0x70000000)
> +#define SPEAR310_EMI_MEM_3_BASE		UL(0x80000000)
> +#define SPEAR310_EMI_MEM_4_BASE		UL(0x90000000)
> +#define SPEAR310_EMI_MEM_5_BASE		UL(0xA0000000)
> +#define SPEAR310_EMI_MEM_SIZE		UL(0x10000000)
> +
>  #define SPEAR310_UART1_BASE		UL(0xB2000000)
>  #define SPEAR310_UART2_BASE		UL(0xB2080000)
>  #define SPEAR310_UART3_BASE		UL(0xB2100000)
> diff --git a/arch/arm/mach-spear3xx/include/mach/spear320.h b/arch/arm/mach-spear3xx/include/mach/spear320.h
> index 940f0d8..4f60073 100644
> --- a/arch/arm/mach-spear3xx/include/mach/spear320.h
> +++ b/arch/arm/mach-spear3xx/include/mach/spear320.h
> @@ -17,6 +17,12 @@
>  #define __MACH_SPEAR320_H
>  
>  #define SPEAR320_EMI_CTRL_BASE		UL(0x40000000)
> +#define SPEAR320_EMI_MEM_0_BASE		UL(0x44000000)
> +#define SPEAR320_EMI_MEM_1_BASE		UL(0x45000000)
> +#define SPEAR320_EMI_MEM_2_BASE		UL(0x46000000)
> +#define SPEAR320_EMI_MEM_3_BASE		UL(0x47000000)
> +#define SPEAR320_EMI_MEM_SIZE		UL(0x01000000)
> +
>  #define SPEAR320_FSMC_BASE		UL(0x4C000000)
>  #define SPEAR320_NAND_BASE		UL(0x50000000)
>  #define SPEAR320_I2S_BASE		UL(0x60000000)
> diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
> index 29e3c2c..32c492d 100644
> --- a/arch/arm/mach-spear3xx/spear310.c
> +++ b/arch/arm/mach-spear3xx/spear310.c
> @@ -11,6 +11,7 @@
>   * warranty of any kind, whether express or implied.
>   */
>  
> +#include <linux/mtd/physmap.h>
>  #include <linux/ptrace.h>
>  #include <asm/irq.h>
>  #include <mach/generic.h>
> @@ -268,6 +269,25 @@ int spear300_o2p(int offset)
>  		return offset + 2;
>  }
>  
> +/* emi nor flash device registeration */
> +static struct physmap_flash_data emi_norflash_data;
> +
> +static struct resource emi_nor_resources[] = {
> +	{
> +		.start	= SPEAR310_EMI_MEM_0_BASE,
> +		.end	= SPEAR310_EMI_MEM_0_BASE + SPEAR310_EMI_MEM_SIZE - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
it's board specfic not mach

NACK

Best Regards,
J.
