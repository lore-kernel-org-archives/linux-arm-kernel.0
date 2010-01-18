From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 18 Jan 2010 09:20:16 +0000
Subject: [PATCH] ARM: S5P6440: Add S5P6440 GPIO support
In-Reply-To: <1263782319-20775-3-git-send-email-ben-linux@fluff.org>
References: <1263782319-20775-1-git-send-email-ben-linux@fluff.org>
	<1263782319-20775-3-git-send-email-ben-linux@fluff.org>
Message-ID: <20100118092016.GQ10014@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2010 at 02:38:37AM +0000, Ben Dooks wrote:
> From: Kukjin Kim <kgene.kim@samsung.com>
> 
> This patch adds Samsung's S5P6440 GPIO support.
> 
> Signed-off-by: Adityapratap Sharma <aditya.ps@samsung.com>
> Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> [ben-linux at fluff.org: remove changelog comments from internal dev]
> [ben-linux at fluff.org: fix aditya's email address]
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> ---
>  arch/arm/mach-s5p6440/Makefile                 |    2 +-
>  arch/arm/mach-s5p6440/include/mach/gpio-core.h |   40 +++
>  arch/arm/mach-s5p6440/include/mach/regs-gpio.h |   54 ++++
>  arch/arm/mach-s5p6440/s5p6440-gpio.c           |  325 ++++++++++++++++++++++++
>  arch/arm/plat-s5p/Kconfig                      |    4 +
>  5 files changed, 424 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-s5p6440/include/mach/regs-gpio.h
>  create mode 100644 arch/arm/mach-s5p6440/s5p6440-gpio.c
> 
> diff --git a/arch/arm/mach-s5p6440/Makefile b/arch/arm/mach-s5p6440/Makefile
> index a3ffda9..a79b130 100644
> --- a/arch/arm/mach-s5p6440/Makefile
> +++ b/arch/arm/mach-s5p6440/Makefile
> @@ -12,7 +12,7 @@ obj-				:=
>  
>  # Core support for S5P6440 system
>  
> -obj-$(CONFIG_CPU_S5P6440)	+= cpu.o
> +obj-$(CONFIG_CPU_S5P6440)	+= cpu.o s5p6440-gpio.o
>  
>  # machine support
>  
> diff --git a/arch/arm/mach-s5p6440/include/mach/gpio-core.h b/arch/arm/mach-s5p6440/include/mach/gpio-core.h
> index ff7fb30..b6368df 100644
> --- a/arch/arm/mach-s5p6440/include/mach/gpio-core.h
> +++ b/arch/arm/mach-s5p6440/include/mach/gpio-core.h
> @@ -16,4 +16,44 @@
>  /* currently we just include the platform support */
>  #include <plat/gpio-core.h>
>  
> +#define con_4bit_shift(__off) ((__off) * 4)
> +
> +/* various helper functions added which are specific to PLAT_S5P platform */
> +
> +/**
> + * s5p6440_gpiolib_set_cfg - S5P style GPIO configuration
> + * @chip: The gpio chip that is being configured.
> + * @nr_chips: no of chips (gpio ports) for the GPIO being configured.
> +*/
> +extern void s5p6440_gpiolib_set_cfg(struct s3c_gpio_cfg *chipcfg, int nr_chips);

this doesn't seem to get outside of arch/arm/mach-s5p6440/s5p6440-gpio.c
so could do with not being added to this header.

> +/**
> + * samsung_gpiolib_add_4bit_chips - 4bit single register GPIO config.
> + * @chip: The gpio chip that is being configured.
> + * @nr_chips: The no of chips (gpio ports) for the GPIO being configured.
> + *
> + * This helper deal with the GPIO cases where the control register has 4 bits
> + * of control per GPIO, generally in the form of:
> + * 0000 = Input
> + * 0001 = Output
> + * others = Special functions (dependant on bank)
> + *
> + * Note, since the code to deal with the case where there are two control
> + * registers instead of one, we do not have a seperate set of function
> + * (samsung_gpiolib_add_4bit2_chips)for each case.
> + */
> +extern void samsung_gpiolib_add_4bit_chips(struct s3c_gpio_chip *chip,
> +					   int nr_chips);
> +extern void samsung_gpiolib_add_4bit2_chips(struct s3c_gpio_chip *chip,
> +					    int nr_chips);

Should have been added to the previous patch moving the code to the
common directory and also should have been in plat-s3c/include/plat/gpio-core.h
instead of here.

> +/**
> + * s5p6440_gpio_setcfg_4bit_rbank - S5P64XX 4bit single register GPIO config.
> + * @chip: The gpio chip that is being configured (always R).
> + * @off: The offset for the GPIO being configured.
> + * @cfg: The configuration value to set.
> + *
> + */
> +extern int s5p6440_gpio_setcfg_4bit_rbank(struct s3c_gpio_chip *chip,
> +					  unsigned int off, unsigned int cfg);
>  #endif /* __ASM_ARCH_GPIO_CORE_H */

If we can find a new place for this definition we can elimiante all
users of <mach/gpio-core.h> and just use <plat/gpio-core.h> instead.

Since it is just the one definition it could go into <plat/gpio-core.h>

> diff --git a/arch/arm/mach-s5p6440/include/mach/regs-gpio.h b/arch/arm/mach-s5p6440/include/mach/regs-gpio.h
> new file mode 100644
> index 0000000..82ff753
> --- /dev/null
> +++ b/arch/arm/mach-s5p6440/include/mach/regs-gpio.h
> @@ -0,0 +1,54 @@
> +/* linux/arch/arm/mach-s5p6440/include/mach/regs-gpio.h
> + *
> + * Copyright (c) 2009 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5P6440 - GPIO register definitions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ASM_ARCH_REGS_GPIO_H
> +#define __ASM_ARCH_REGS_GPIO_H __FILE__
> +
> +#include <mach/map.h>
> +
> +/* Base addresses for each of the banks */
> +#define S5P6440_GPA_BASE		(S5P_VA_GPIO + 0x0000)
> +#define S5P6440_GPB_BASE		(S5P_VA_GPIO + 0x0020)
> +#define S5P6440_GPC_BASE		(S5P_VA_GPIO + 0x0040)
> +#define S5P6440_GPF_BASE		(S5P_VA_GPIO + 0x00A0)
> +#define S5P6440_GPG_BASE		(S5P_VA_GPIO + 0x00C0)
> +#define S5P6440_GPH_BASE		(S5P_VA_GPIO + 0x00E0)
> +#define S5P6440_GPI_BASE		(S5P_VA_GPIO + 0x0100)
> +#define S5P6440_GPJ_BASE		(S5P_VA_GPIO + 0x0120)
> +#define S5P6440_GPN_BASE		(S5P_VA_GPIO + 0x0830)
> +#define S5P6440_GPP_BASE		(S5P_VA_GPIO + 0x0160)
> +#define S5P6440_GPR_BASE		(S5P_VA_GPIO + 0x0290)
> +#define S5P6440_EINT0CON0		(S5P_VA_GPIO + 0x900)
> +#define S5P6440_EINT0FLTCON0		(S5P_VA_GPIO + 0x910)
> +#define S5P6440_EINT0FLTCON1		(S5P_VA_GPIO + 0x914)
> +#define S5P6440_EINT0MASK		(S5P_VA_GPIO + 0x920)
> +#define S5P6440_EINT0PEND		(S5P_VA_GPIO + 0x924)
> +
> +/* for LCD */
> +#define S5P6440_SPCON_LCD_SEL_RGB	(1 << 0)
> +#define S5P6440_SPCON_LCD_SEL_MASK	(3 << 0)
> +
> +/* These set of macros are not really useful for the
> + * GPF/GPI/GPJ/GPN/GPP,
> + * useful for others set of GPIO's (4 bit)
> + */
> +#define S5P6440_GPIO_CONMASK(__gpio)	(0xf << ((__gpio) * 4))
> +#define S5P6440_GPIO_INPUT(__gpio)	(0x0 << ((__gpio) * 4))
> +#define S5P6440_GPIO_OUTPUT(__gpio)	(0x1 << ((__gpio) * 4))
> +
> +/* Use these macros for GPF/GPI/GPJ/GPN/GPP set of GPIO (2 bit)
> + * */
> +#define S5P6440_GPIO2_CONMASK(__gpio)	(0x3 << ((__gpio) * 2))
> +#define S5P6440_GPIO2_INPUT(__gpio)	(0x0 << ((__gpio) * 2))
> +#define S5P6440_GPIO2_OUTPUT(__gpio)	(0x1 << ((__gpio) * 2))
> +
> +#endif /* __ASM_ARCH_REGS_GPIO_H */
> diff --git a/arch/arm/mach-s5p6440/s5p6440-gpio.c b/arch/arm/mach-s5p6440/s5p6440-gpio.c
> new file mode 100644
> index 0000000..dff1703
> --- /dev/null
> +++ b/arch/arm/mach-s5p6440/s5p6440-gpio.c
> @@ -0,0 +1,325 @@
> +/* arch/arm/mach-s5p6440/s5p6440-gpio.c
> + *
> + * Copyright (c) 2009 Samsung Electronics Co., Ltd.
> + * 		http://www.samsung.com/
> + *
> + * S5P6440 - GPIOlib support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/irq.h>
> +#include <linux/io.h>
> +#include <mach/map.h>
> +#include <mach/gpio.h>
> +#include <mach/gpio-core.h>
> +#include <mach/regs-gpio.h>
> +#include <plat/gpio-cfg.h>
> +#include <plat/gpio-cfg-helpers.h>
> +
> +#define GPIODAT_OFF	(0x04)
> +#define con_4bit_shift(__off) ((__off) * 4)

That should have already come from the header file.

> +/* GPIO bank summary:
> +*
> +* Bank	GPIOs	Style	SlpCon	ExtInt Group
> +* A	6	4Bit	Yes	1
> +* B	7	4Bit	Yes	1
> +* C	8	4Bit	Yes	2
> +* F	2	2Bit	Yes	4 [1]
> +* G	7	4Bit	Yes	5
> +* H	10	4Bit[2]	Yes	6
> +* I	16	2Bit	Yes	None
> +* J	12	2Bit	Yes	None
> +* N	16	2Bit	No	IRQ_EINT
> +* P	8	2Bit	Yes	8
> +* R	15	4Bit[2]	Yes	8
> +*
> +* [1] BANKF pins 14,15 do not form part of the external interrupt sources
> +* [2] BANK has two control registers, GPxCON0 and GPxCON1
> +*/
> +
> +static int s5p6440_gpiolib_rbank_4bit2_input(struct gpio_chip *chip,
> +					     unsigned int offset)
> +{
> +	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
> +	void __iomem *base = ourchip->base;
> +	void __iomem *regcon = base;
> +	unsigned long con;
> +
> +	switch (offset) {
> +	case 6:
> +		offset += 1;
> +	case 0:
> +	case 1:
> +	case 2:
> +	case 3:
> +	case 4:
> +	case 5:
> +		regcon -= 4;
> +		break;
> +	default:
> +		offset -= 7;
> +		break;
> +	}
> +
> +	con = __raw_readl(regcon);
> +	con &= ~(0xf << con_4bit_shift(offset));
> +	__raw_writel(con, regcon);
> +
> +	return 0;
> +}
> +
> +static int s5p6440_gpiolib_rbank_4bit2_output(struct gpio_chip *chip,
> +					      unsigned int offset, int value)
> +{
> +	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
> +	void __iomem *base = ourchip->base;
> +	void __iomem *regcon = base;
> +	unsigned long con;
> +	unsigned long dat;
> +	unsigned con_offset  = offset;
> +
> +	switch (con_offset) {
> +	case 6:
> +		con_offset += 1;
> +	case 0:
> +	case 1:
> +	case 2:
> +	case 3:
> +	case 4:
> +	case 5:
> +		regcon -= 4;
> +		break;
> +	default:
> +		con_offset -= 7;
> +		break;
> +	}
> +
> +	con = __raw_readl(regcon);
> +	con &= ~(0xf << con_4bit_shift(con_offset));
> +	con |= 0x1 << con_4bit_shift(con_offset);
> +
> +	dat = __raw_readl(base + GPIODAT_OFF);
> +	if (value)
> +		dat |= 1 << offset;
> +	else
> +		dat &= ~(1 << offset);
> +
> +	__raw_writel(con, regcon);
> +	__raw_writel(dat, base + GPIODAT_OFF);
> +
> +	return 0;
> +}
> +
> +int s5p6440_gpio_setcfg_4bit_rbank(struct s3c_gpio_chip *chip,
> +				   unsigned int off, unsigned int cfg)
> +{
> +	void __iomem *reg = chip->base;
> +	unsigned int shift;
> +	u32 con;
> +
> +	switch (off) {
> +	case 0:
> +	case 1:
> +	case 2:
> +	case 3:
> +	case 4:
> +	case 5:
> +		shift = (off & 7) * 4;
> +		reg -= 4;
> +		break;
> +	case 6:
> +		shift = ((off + 1) & 7) * 4;
> +		reg -= 4;
> +	default:
> +		shift = ((off + 1) & 7) * 4;
> +		break;
> +	}
> +
> +	if (s3c_gpio_is_cfg_special(cfg)) {
> +		cfg &= 0xf;
> +		cfg <<= shift;
> +	}
> +
> +	con = __raw_readl(reg);
> +	con &= ~(0xf << shift);
> +	con |= cfg;
> +	__raw_writel(con, reg);
> +
> +	return 0;
> +}
> +
> +static struct s3c_gpio_cfg s5p6440_gpio_cfgs[] = {
> +	{
> +		.cfg_eint	= 0,
> +	}, {
> +		.cfg_eint	= 7,
> +	}, {
> +		.cfg_eint	= 3,
> +		.set_config	= s5p6440_gpio_setcfg_4bit_rbank,
> +	}, {
> +		.cfg_eint	= 0,
> +		.set_config	= s3c_gpio_setcfg_s3c24xx,
> +	}, {
> +		.cfg_eint	= 2,
> +		.set_config	= s3c_gpio_setcfg_s3c24xx,
> +	}, {
> +		.cfg_eint	= 3,
> +		.set_config	= s3c_gpio_setcfg_s3c24xx,
> +	},
> +};
> +
> +static struct s3c_gpio_chip s5p6440_gpio_4bit[] = {
> +	{
> +		.base	= S5P6440_GPA_BASE,
> +		.config	= &s5p6440_gpio_cfgs[1],
> +		.chip	= {
> +			.base	= S5P6440_GPA(0),
> +			.ngpio	= S5P6440_GPIO_A_NR,
> +			.label	= "GPA",
> +		},
> +	}, {
> +		.base	= S5P6440_GPB_BASE,
> +		.config	= &s5p6440_gpio_cfgs[1],
> +		.chip	= {
> +			.base	= S5P6440_GPB(0),
> +			.ngpio	= S5P6440_GPIO_B_NR,
> +			.label	= "GPB",
> +		},
> +	}, {
> +		.base	= S5P6440_GPC_BASE,
> +		.config	= &s5p6440_gpio_cfgs[1],
> +		.chip	= {
> +			.base	= S5P6440_GPC(0),
> +			.ngpio	= S5P6440_GPIO_C_NR,
> +			.label	= "GPC",
> +		},
> +	}, {
> +		.base	= S5P6440_GPG_BASE,
> +		.config	= &s5p6440_gpio_cfgs[1],
> +		.chip	= {
> +			.base	= S5P6440_GPG(0),
> +			.ngpio	= S5P6440_GPIO_G_NR,
> +			.label	= "GPG",
> +		},
> +	},
> +};
> +
> +static struct s3c_gpio_chip s5p6440_gpio_4bit2[] = {
> +	{
> +		.base	= S5P6440_GPH_BASE + 0x4,
> +		.config	= &s5p6440_gpio_cfgs[1],
> +		.chip	= {
> +			.base	= S5P6440_GPH(0),
> +			.ngpio	= S5P6440_GPIO_H_NR,
> +			.label	= "GPH",
> +		},
> +	},
> +};
> +
> +static struct s3c_gpio_chip gpio_rbank_4bit2[] = {
> +	{
> +		.base	= S5P6440_GPR_BASE + 0x4,
> +		.config	= &s5p6440_gpio_cfgs[2],
> +		.chip	= {
> +			.base	= S5P6440_GPR(0),
> +			.ngpio	= S5P6440_GPIO_R_NR,
> +			.label	= "GPR",
> +		},
> +	},
> +};
> +
> +static struct s3c_gpio_chip s5p6440_gpio_2bit[] = {
> +	{
> +		.base	= S5P6440_GPF_BASE,
> +		.config	= &s5p6440_gpio_cfgs[5],
> +		.chip	= {
> +			.base	= S5P6440_GPF(0),
> +			.ngpio	= S5P6440_GPIO_F_NR,
> +			.label	= "GPF",
> +		},
> +	}, {
> +		.base	= S5P6440_GPI_BASE,
> +		.config	= &s5p6440_gpio_cfgs[3],
> +		.chip	= {
> +			.base	= S5P6440_GPI(0),
> +			.ngpio	= S5P6440_GPIO_I_NR,
> +			.label	= "GPI",
> +		},
> +	}, {
> +		.base	= S5P6440_GPJ_BASE,
> +		.config	= &s5p6440_gpio_cfgs[3],
> +		.chip	= {
> +			.base	= S5P6440_GPJ(0),
> +			.ngpio	= S5P6440_GPIO_J_NR,
> +			.label	= "GPJ",
> +		},
> +	}, {
> +		.base	= S5P6440_GPN_BASE,
> +		.config	= &s5p6440_gpio_cfgs[4],
> +		.chip	= {
> +			.base	= S5P6440_GPN(0),
> +			.ngpio	= S5P6440_GPIO_N_NR,
> +			.label	= "GPN",
> +		},
> +	}, {
> +		.base	= S5P6440_GPP_BASE,
> +		.config	= &s5p6440_gpio_cfgs[5],
> +		.chip	= {
> +			.base	= S5P6440_GPP(0),
> +			.ngpio	= S5P6440_GPIO_P_NR,
> +			.label	= "GPP",
> +		},
> +	},
> +};
> +
> +void __init s5p6440_gpiolib_set_cfg(struct s3c_gpio_cfg *chipcfg, int nr_chips)
> +{
> +	for (; nr_chips > 0; nr_chips--, chipcfg++) {
> +		if (!chipcfg->set_config)
> +			chipcfg->set_config	= s3c_gpio_setcfg_s3c64xx_4bit;
> +		if (!chipcfg->set_pull)
> +			chipcfg->set_pull	= s3c_gpio_setpull_updown;
> +		if (!chipcfg->get_pull)
> +			chipcfg->get_pull	= s3c_gpio_getpull_updown;
> +	}
> +}
> +
> +static void __init s5p6440_gpio_add_rbank_4bit2(struct s3c_gpio_chip *chip,
> +						int nr_chips)
> +{
> +	for (; nr_chips > 0; nr_chips--, chip++) {
> +		chip->chip.direction_input = s5p6440_gpiolib_rbank_4bit2_input;
> +		chip->chip.direction_output =
> +					s5p6440_gpiolib_rbank_4bit2_output;
> +		s3c_gpiolib_add(chip);
> +	}
> +}
> +
> +static int __init s5p6440_gpiolib_init(void)
> +{
> +	struct s3c_gpio_chip *chips = s5p6440_gpio_2bit;
> +	int nr_chips = ARRAY_SIZE(s5p6440_gpio_2bit);
> +
> +	s5p6440_gpiolib_set_cfg(s5p6440_gpio_cfgs,
> +				ARRAY_SIZE(s5p6440_gpio_cfgs));
> +
> +	for (; nr_chips > 0; nr_chips--, chips++)
> +		s3c_gpiolib_add(chips);
> +
> +	samsung_gpiolib_add_4bit_chips(s5p6440_gpio_4bit,
> +				ARRAY_SIZE(s5p6440_gpio_4bit));
> +
> +	samsung_gpiolib_add_4bit2_chips(s5p6440_gpio_4bit2,
> +				ARRAY_SIZE(s5p6440_gpio_4bit2));
> +
> +	s5p6440_gpio_add_rbank_4bit2(gpio_rbank_4bit2,
> +				ARRAY_SIZE(gpio_rbank_4bit2));
> +
> +	return 0;
> +}
> +arch_initcall(s5p6440_gpiolib_init);
> diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
> index 7e08b40..9d8686c 100644
> --- a/arch/arm/plat-s5p/Kconfig
> +++ b/arch/arm/plat-s5p/Kconfig
> @@ -14,6 +14,10 @@ config PLAT_S5P
>  	select NO_IOPORT
>  	select ARCH_REQUIRE_GPIOLIB
>  	select S3C_GPIO_TRACK
> +	select SAMSUNG_GPIOLIB
> +	select S3C_GPIO_CFG_S3C64XX
> +	select S3C_GPIO_PULL_UPDOWN
> +	select S3C_GPIO_CFG_S3C24XX
>  	select PLAT_SAMSUNG
>  	select SAMSUNG_CLKSRC
>  	select SAMSUNG_IRQ_VIC_TIMER
> -- 
> 1.6.0.4
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
