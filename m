From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 9 Feb 2010 11:58:17 +0100
Subject: [PATCH 04/14] ARM: LPC32XX: GPIO, timer, and IRQ drivers
In-Reply-To: <1265674295-23996-5-git-send-email-wellsk40@gmail.com>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
	<1265674295-23996-5-git-send-email-wellsk40@gmail.com>
Message-ID: <20100209105817.GE2284@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2010 at 04:11:25PM -0800, wellsk40 at gmail.com wrote:
> From: Kevin Wells <wellsk40@gmail.com>
> 
> Common drivers for the LPC32XX used on all platforms
> 
> Signed-off-by: Kevin Wells <wellsk40@gmail.com>
> ---
>  arch/arm/mach-lpc32xx/gpiolib.c |  458 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-lpc32xx/irq.c     |  438 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-lpc32xx/timer.c   |  182 ++++++++++++++++
>  3 files changed, 1078 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-lpc32xx/gpiolib.c b/arch/arm/mach-lpc32xx/gpiolib.c
> new file mode 100644
> index 0000000..202cd82
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/gpiolib.c
> @@ -0,0 +1,458 @@
> +/*
> + * arch/arm/mach-lpc32xx/gpiolib.c
> + *
> + * Author: Kevin Wells <kevin.wells@nxp.com>
> + *
> + * Copyright (C) 2010 NXP Semiconductors
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/errno.h>
> +#include <linux/gpio.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/platform.h>
> +#include "common.h"
> +
> +#define LPC32XX_GPIO_P3_INP_STATE		_GPREG(0x000)
> +#define LPC32XX_GPIO_P3_OUTP_SET		_GPREG(0x004)
> +#define LPC32XX_GPIO_P3_OUTP_CLR		_GPREG(0x008)
> +#define LPC32XX_GPIO_P3_OUTP_STATE		_GPREG(0x00C)
> +#define LPC32XX_GPIO_P2_DIR_SET			_GPREG(0x010)
> +#define LPC32XX_GPIO_P2_DIR_CLR			_GPREG(0x014)
> +#define LPC32XX_GPIO_P2_DIR_STATE		_GPREG(0x018)
> +#define LPC32XX_GPIO_P2_INP_STATE		_GPREG(0x01C)
> +#define LPC32XX_GPIO_P2_OUTP_SET		_GPREG(0x020)
> +#define LPC32XX_GPIO_P2_OUTP_CLR		_GPREG(0x024)
> +#define LPC32XX_GPIO_P2_MUX_SET			_GPREG(0x028)
> +#define LPC32XX_GPIO_P2_MUX_CLR			_GPREG(0x02C)
> +#define LPC32XX_GPIO_P2_MUX_STATE		_GPREG(0x030)
> +#define LPC32XX_GPIO_P0_INP_STATE		_GPREG(0x040)
> +#define LPC32XX_GPIO_P0_OUTP_SET		_GPREG(0x044)
> +#define LPC32XX_GPIO_P0_OUTP_CLR		_GPREG(0x048)
> +#define LPC32XX_GPIO_P0_OUTP_STATE		_GPREG(0x04C)
> +#define LPC32XX_GPIO_P0_DIR_SET			_GPREG(0x050)
> +#define LPC32XX_GPIO_P0_DIR_CLR			_GPREG(0x054)
> +#define LPC32XX_GPIO_P0_DIR_STATE		_GPREG(0x058)
> +#define LPC32XX_GPIO_P1_INP_STATE		_GPREG(0x060)
> +#define LPC32XX_GPIO_P1_OUTP_SET		_GPREG(0x064)
> +#define LPC32XX_GPIO_P1_OUTP_CLR		_GPREG(0x068)
> +#define LPC32XX_GPIO_P1_OUTP_STATE		_GPREG(0x06C)
> +#define LPC32XX_GPIO_P1_DIR_SET			_GPREG(0x070)
> +#define LPC32XX_GPIO_P1_DIR_CLR			_GPREG(0x074)
> +#define LPC32XX_GPIO_P1_DIR_STATE		_GPREG(0x078)
> +
> +#define GPIO012_PIN_TO_BIT(x)			(1 << (x))
> +#define GPIO3_PIN_TO_BIT(x)			(1 << ((x) + 25))
> +#define GPO3_PIN_TO_BIT(x)			(1 << (x))
> +#define GPIO012_PIN_IN_SEL(x, y)		(((x) >> (y)) & 1)
> +#define GPIO3_PIN_IN_SEL(x, y)			(((x) >> (10 + (y))) & 1)
> +#define GPIO3_PIN5_IN_SEL(x)			(((x) >> 24) & 1)
> +#define GPI3_PIN_IN_SEL(x, y)			(((x) >> (y)) & 1)
> +
> +struct gpio_regs {
> +	void __iomem *inp_state;
> +	void __iomem *outp_set;
> +	void __iomem *outp_clr;
> +	void __iomem *dir_set;
> +	void __iomem *dir_clr;
> +};
> +
> +/*
> + * GPIO names
> + */
> +static const char *gpio_p0_names[LPC32XX_GPIO_P0_MAX] = {
> +	"p0.0", "p0.1", "p0.2", "p0.3",
> +	"p0.4", "p0.5", "p0.6", "p0.7"
> +};
> +
> +static const char *gpio_p1_names[LPC32XX_GPIO_P1_MAX] = {
> +	"p1.0", "p1.1", "p1.2", "p1.3",
> +	"p1.4", "p1.5", "p1.6", "p1.7",
> +	"p1.8", "p1.9", "p1.10", "p1.11",
> +	"p1.12", "p1.13", "p1.14", "p1.15",
> +	"p1.16", "p1.17", "p1.18", "p1.19",
> +	"p1.20", "p1.21", "p1.22", "p1.23",
> +};
> +
> +static const char *gpio_p2_names[LPC32XX_GPIO_P2_MAX] = {
> +	"p2.0", "p2.1", "p2.2", "p2.3",
> +	"p2.4", "p2.5", "p2.6", "p2.7",
> +	"p2.8", "p2.9", "p2.10", "p2.11",
> +	"p2.12"
> +};
> +
> +static const char *gpio_p3_names[LPC32XX_GPIO_P3_MAX] = {
> +	"gpi000", "gpio01", "gpio02", "gpio03",
> +	"gpio04", "gpio05"
> +};
> +
> +static const char *gpi_p3_names[LPC32XX_GPI_P3_MAX] = {
> +	"gpi00", "gpi01", "gpi02", "gpi03",
> +	"gpi04", "gpi05", "gpi06", "gpi07",
> +	"gpi08", "gpi09",  NULL,    NULL,
> +	 NULL,    NULL,    NULL,   "gpi15",
> +	"gpi16", "gpi17", "gpi18", "gpi19",
> +	"gpi20", "gpi21", "gpi22", "gpi23",
> +	"gpi24", "gpi25", "gpi26", "gpi27"
> +};
> +
> +static const char *gpo_p3_names[LPC32XX_GPO_P3_MAX] = {
> +	"gpo00", "gpo01", "gpo02", "gpo03",
> +	"gpo04", "gpo05", "gpo06", "gpo07",
> +	"gpo08", "gpo09", "gpo10", "gpo11",
> +	"gpo12", "gpo13", "gpo14", "gpo15",
> +	"gpo16", "gpo17", "gpo18", "gpo19",
> +	"gpo20", "gpo21", "gpo22", "gpo23"
> +};
> +
> +static struct gpio_regs gpio_grp_regs_p0 = {
> +	.inp_state	= LPC32XX_GPIO_P0_INP_STATE,
> +	.outp_set	= LPC32XX_GPIO_P0_OUTP_SET,
> +	.outp_clr	= LPC32XX_GPIO_P0_OUTP_CLR,
> +	.dir_set	= LPC32XX_GPIO_P0_DIR_SET,
> +	.dir_clr	= LPC32XX_GPIO_P0_DIR_CLR,
> +};
> +
> +static struct gpio_regs gpio_grp_regs_p1 = {
> +	.inp_state	= LPC32XX_GPIO_P1_INP_STATE,
> +	.outp_set	= LPC32XX_GPIO_P1_OUTP_SET,
> +	.outp_clr	= LPC32XX_GPIO_P1_OUTP_CLR,
> +	.dir_set	= LPC32XX_GPIO_P1_DIR_SET,
> +	.dir_clr	= LPC32XX_GPIO_P1_DIR_CLR,
> +};
> +
> +static struct gpio_regs gpio_grp_regs_p2 = {
> +	.inp_state	= LPC32XX_GPIO_P2_INP_STATE,
> +	.outp_set	= LPC32XX_GPIO_P2_OUTP_SET,
> +	.outp_clr	= LPC32XX_GPIO_P2_OUTP_CLR,
> +	.dir_set	= LPC32XX_GPIO_P2_DIR_SET,
> +	.dir_clr	= LPC32XX_GPIO_P2_DIR_CLR,
> +};
> +
> +static struct gpio_regs gpio_grp_regs_p3 = {
> +	.inp_state	= LPC32XX_GPIO_P3_INP_STATE,
> +	.outp_set	= LPC32XX_GPIO_P3_OUTP_SET,
> +	.outp_clr	= LPC32XX_GPIO_P3_OUTP_CLR,
> +	.dir_set	= LPC32XX_GPIO_P2_DIR_SET,
> +	.dir_clr	= LPC32XX_GPIO_P2_DIR_CLR,
> +};
> +
> +struct lpc32xx_gpio_chip {
> +	struct gpio_chip	chip;
> +	struct gpio_regs	*gpio_grp;
> +};
> +
> +static inline struct lpc32xx_gpio_chip *to_lpc32xx_gpio(
> +	struct gpio_chip *gpc)
> +{
> +	return container_of(gpc, struct lpc32xx_gpio_chip, chip);
> +}
> +
> +static void __set_gpio_dir_p012(struct lpc32xx_gpio_chip *group,
> +	unsigned pin, int input)
> +{
> +	if (input)
> +		__raw_writel(GPIO012_PIN_TO_BIT(pin),
> +			group->gpio_grp->dir_clr);
> +	else
> +		__raw_writel(GPIO012_PIN_TO_BIT(pin),
> +			group->gpio_grp->dir_set);
> +}
> +
> +static void __set_gpio_dir_p3(struct lpc32xx_gpio_chip *group,
> +	unsigned pin, int input)
> +{
> +	u32 u;
> +
> +	/* P3 GPIO pins are offset in the register to pin mapping */
> +	u =  GPIO3_PIN_TO_BIT(pin);
here ------^ is a superflous space.

> +
> +	if (input)
> +		__raw_writel(u, group->gpio_grp->dir_clr);
> +	else
> +		__raw_writel(u, group->gpio_grp->dir_set);
> +}
> +
> +static void __set_gpio_level_p012(struct lpc32xx_gpio_chip *group,
> +	unsigned pin, int high)
> +{
> +	if (high)
> +		__raw_writel(GPIO012_PIN_TO_BIT(pin),
> +			group->gpio_grp->outp_set);
> +	else
> +		__raw_writel(GPIO012_PIN_TO_BIT(pin),
> +			group->gpio_grp->outp_clr);
> +}
> +
> +static void __set_gpio_level_p3(struct lpc32xx_gpio_chip *group,
> +	unsigned pin, int high)
> +{
> +	u32 u;
> +
> +	/* P3 GPIO pins are offset in the register to pin mapping */
> +	u = GPIO3_PIN_TO_BIT(pin);

	u32 u = ...
?

> +
> +	if (high)
> +		__raw_writel(u, group->gpio_grp->outp_set);
> +	else
> +		__raw_writel(u, group->gpio_grp->outp_clr);
> +}
> +
> +static void __set_gpo_level_p3(struct lpc32xx_gpio_chip *group,
> +	unsigned pin, int high)
> +{
> +	if (high)
> +		__raw_writel(GPO3_PIN_TO_BIT(pin), group->gpio_grp->outp_set);
> +	else
> +		__raw_writel(GPO3_PIN_TO_BIT(pin), group->gpio_grp->outp_clr);
> +}
> +
> +static int __get_gpio_state_p012(struct lpc32xx_gpio_chip *group,
> +	unsigned pin)
> +{
> +	return GPIO012_PIN_IN_SEL(__raw_readl(group->gpio_grp->inp_state),
> +		pin);
> +}
> +
> +static int __get_gpio_state_p3(struct lpc32xx_gpio_chip *group,
> +	unsigned pin)
> +{
> +	int state;
> +
> +	state = __raw_readl(group->gpio_grp->inp_state);
> +
> +	/*
> +	 * P3 GPIO pin input mapping is not contiguous, GPIOP3-0..4 is mapped
> +	 * to bits 10..14, while GPIOP3-5 is mapped to bit 24.
> +	 */
> +	if (pin == 5)
> +		state = GPIO3_PIN5_IN_SEL(state);
> +	else
> +		state = GPIO3_PIN_IN_SEL(state, pin);
I would hide that in GPIO3_PIN_IN_SEL, e.g.


	#define GPIO3_PIN_IN_SHIFT(pin)		(pin == 5 ? 24 : 10 + (pin))
	#define GPIO3_PIN_IN_SEL(state, pin)	(((state) >> GPIO3_PIN_IN_SHIFT(pin)) & 1)

> +
> +	return state;
> +}
> +
> +static int __get_gpi_state_p3(struct lpc32xx_gpio_chip *group,
> +	unsigned pin)
> +{
> +	return GPI3_PIN_IN_SEL(__raw_readl(group->gpio_grp->inp_state), pin);
> +}
> +
> +/*
> + * GENERIC_GPIO primitives.
> + */
> +static int lpc32xx_gpio_dir_input_p012(struct gpio_chip *chip,
> +	unsigned pin)
> +{
> +	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> +	__set_gpio_dir_p012(group, pin, 1);
> +
> +	return 0;
> +}
> +
> +static int lpc32xx_gpio_dir_input_p3(struct gpio_chip *chip,
> +	unsigned pin)
> +{
> +	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> +	__set_gpio_dir_p3(group, pin, 1);
> +
> +	return 0;
> +}
> +
> +static int lpc32xx_gpio_dir_in_always(struct gpio_chip *chip,
> +	unsigned pin)
> +{
> +	return 0;
> +}
> +
> +static int lpc32xx_gpio_get_value_p012(struct gpio_chip *chip, unsigned pin)
> +{
> +	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> +	return __get_gpio_state_p012(group, pin);
> +}
> +
> +static int lpc32xx_gpio_get_value_p3(struct gpio_chip *chip, unsigned pin)
> +{
> +	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> +	return __get_gpio_state_p3(group, pin);
> +}
> +
> +static int lpc32xx_gpi_get_value(struct gpio_chip *chip, unsigned pin)
> +{
> +	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> +	return __get_gpi_state_p3(group, pin);
> +}
> +
> +static int lpc32xx_gpio_dir_output_p012(struct gpio_chip *chip, unsigned pin,
> +	int value)
> +{
> +	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> +	__set_gpio_dir_p012(group, pin, 0);
> +
> +	return 0;
> +}
> +
> +static int lpc32xx_gpio_dir_output_p3(struct gpio_chip *chip, unsigned pin,
> +	int value)
> +{
> +	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> +	__set_gpio_dir_p3(group, pin, 0);
> +
> +	return 0;
> +}
> +
> +static int lpc32xx_gpio_dir_out_always(struct gpio_chip *chip, unsigned pin,
> +	int value)
> +{
> +	return 0;
> +}
> +
> +static void lpc32xx_gpio_set_value_p012(struct gpio_chip *chip, unsigned pin,
> +	int value)
> +{
> +	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> +	__set_gpio_level_p012(group, pin, value);
> +}
> +
> +static void lpc32xx_gpio_set_value_p3(struct gpio_chip *chip, unsigned pin,
> +	int value)
> +{
> +	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> +	__set_gpio_level_p3(group, pin, value);
> +}
> +
> +static void lpc32xx_gpo_set_value(struct gpio_chip *chip, unsigned pin,
> +	int value)
> +{
> +	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> +	__set_gpo_level_p3(group, pin, value);
> +}
> +
> +static int lpc32xx_gpio_request(struct gpio_chip *chip, unsigned pin)
> +{
> +	if (pin < chip->ngpio)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static struct lpc32xx_gpio_chip lpc32xx_gpiochip[] = {
> +	{
> +		.chip = {
> +			.label			= "gpio_p0",
> +			.direction_input	= lpc32xx_gpio_dir_input_p012,
> +			.get			= lpc32xx_gpio_get_value_p012,
> +			.direction_output	= lpc32xx_gpio_dir_output_p012,
> +			.set			= lpc32xx_gpio_set_value_p012,
> +			.request		= lpc32xx_gpio_request,
> +			.base			= LPC32XX_GPIO_P0_GRP,
> +			.ngpio			= LPC32XX_GPIO_P0_MAX,
> +			.names			= gpio_p0_names,
> +			.can_sleep		= 0,
> +		},
> +		.gpio_grp = &gpio_grp_regs_p0,
> +	},
> +	{
> +		.chip = {
> +			.label			= "gpio_p1",
> +			.direction_input	= lpc32xx_gpio_dir_input_p012,
> +			.get			= lpc32xx_gpio_get_value_p012,
> +			.direction_output	= lpc32xx_gpio_dir_output_p012,
> +			.set			= lpc32xx_gpio_set_value_p012,
> +			.request		= lpc32xx_gpio_request,
> +			.base			= LPC32XX_GPIO_P1_GRP,
> +			.ngpio			= LPC32XX_GPIO_P1_MAX,
> +			.names			= gpio_p1_names,
> +			.can_sleep		= 0,
> +		},
> +		.gpio_grp = &gpio_grp_regs_p1,
> +	},
> +	{
> +		.chip = {
> +			.label			= "gpio_p2",
> +			.direction_input	= lpc32xx_gpio_dir_input_p012,
> +			.get			= lpc32xx_gpio_get_value_p012,
> +			.direction_output	= lpc32xx_gpio_dir_output_p012,
> +			.set			= lpc32xx_gpio_set_value_p012,
> +			.request		= lpc32xx_gpio_request,
> +			.base			= LPC32XX_GPIO_P2_GRP,
> +			.ngpio			= LPC32XX_GPIO_P2_MAX,
> +			.names			= gpio_p2_names,
> +			.can_sleep		= 0,
> +		},
> +		.gpio_grp = &gpio_grp_regs_p2,
> +	},
> +	{
> +		.chip = {
> +			.label			= "gpio_p3",
> +			.direction_input	= lpc32xx_gpio_dir_input_p3,
> +			.get			= lpc32xx_gpio_get_value_p3,
> +			.direction_output	= lpc32xx_gpio_dir_output_p3,
> +			.set			= lpc32xx_gpio_set_value_p3,
> +			.request		= lpc32xx_gpio_request,
> +			.base			= LPC32XX_GPIO_P3_GRP,
> +			.ngpio			= LPC32XX_GPIO_P3_MAX,
> +			.names			= gpio_p3_names,
> +			.can_sleep		= 0,
> +		},
> +		.gpio_grp = &gpio_grp_regs_p3,
> +	},
> +	{
> +		.chip = {
> +			.label			= "gpi_p3",
> +			.direction_input	= lpc32xx_gpio_dir_in_always,
> +			.get			= lpc32xx_gpi_get_value,
> +			.request		= lpc32xx_gpio_request,
> +			.base			= LPC32XX_GPI_P3_GRP,
> +			.ngpio			= LPC32XX_GPI_P3_MAX,
> +			.names			= gpi_p3_names,
> +			.can_sleep		= 0,
> +		},
> +		.gpio_grp = &gpio_grp_regs_p3,
> +	},
> +	{
> +		.chip = {
> +			.label			= "gpo_p3",
> +			.direction_output	= lpc32xx_gpio_dir_out_always,
> +			.set			= lpc32xx_gpo_set_value,
> +			.request		= lpc32xx_gpio_request,
> +			.base			= LPC32XX_GPO_P3_GRP,
> +			.ngpio			= LPC32XX_GPO_P3_MAX,
> +			.names			= gpo_p3_names,
> +			.can_sleep		= 0,
> +		},
> +		.gpio_grp = &gpio_grp_regs_p3,
> +	},
> +};
> +
> +void __init lpc32xx_gpio_init(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(lpc32xx_gpiochip); i++)
> +		gpiochip_add(&lpc32xx_gpiochip[i].chip);
> +}
> diff --git a/arch/arm/mach-lpc32xx/irq.c b/arch/arm/mach-lpc32xx/irq.c
> new file mode 100644
> index 0000000..18c3caf
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/irq.c
> @@ -0,0 +1,438 @@
> +/*
> + * arch/arm/mach-lpc32xx/irq.c
> + *
> + * Author: Kevin Wells <kevin.wells@nxp.com>
> + *
> + * Copyright (C) 2010 NXP Semiconductors
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +
> +#include <mach/irqs.h>
> +#include <mach/hardware.h>
> +#include <mach/platform.h>
> +#include "common.h"
> +
> +/*
> + * Default value representing the Activation polarity of all internal
> + * interrupt sources
> + */
> +#define MIC_APR_DEFAULT		0x3FF0EFE0
> +#define SIC1_APR_DEFAULT	0xFBD27186
> +#define SIC2_APR_DEFAULT	0x801810C0
> +
> +/*
> + * Default value representing the Activation Type of all internal
> + * interrupt sources. All are level sensitive.
> + */
> +#define MIC_ATR_DEFAULT		0x00000000
> +#define SIC1_ATR_DEFAULT	0x00026000
> +#define SIC2_ATR_DEFAULT	0x00000000
> +
> +struct lpc32xx_event_group_regs {
> +	void __iomem *enab_reg;
> +	void __iomem *edge_reg;
> +	void __iomem *maskstat_reg;
> +	void __iomem *rawstat_reg;
> +};
> +
> +static const struct lpc32xx_event_group_regs lpc32xx_event_int_regs = {
> +	.enab_reg = LPC32XX_CLKPWR_INT_ER,
> +	.edge_reg = LPC32XX_CLKPWR_INT_AP,
> +	.maskstat_reg = LPC32XX_CLKPWR_INT_SR,
> +	.rawstat_reg = LPC32XX_CLKPWR_INT_RS,
> +};
> +
> +static const struct lpc32xx_event_group_regs lpc32xx_event_pin_regs = {
> +	.enab_reg = LPC32XX_CLKPWR_PIN_ER,
> +	.edge_reg = LPC32XX_CLKPWR_PIN_AP,
> +	.maskstat_reg = LPC32XX_CLKPWR_PIN_SR,
> +	.rawstat_reg = LPC32XX_CLKPWR_PIN_RS,
> +};
> +
> +struct lpc32xx_event_info {
> +	const struct lpc32xx_event_group_regs *event_group;
> +	u32 mask;
> +};
> +
> +/*
> + * Maps an IRQ number to and event mask and register
> + */
> +static const struct lpc32xx_event_info lpc32xx_events[NR_IRQS] = {
> +	[IRQ_LPC32XX_GPI_08] = {
> +		.event_group = &lpc32xx_event_pin_regs,
> +		.mask = LPC32XX_CLKPWR_EXTSRC_GPI_08_BIT,
> +	},
> +	[IRQ_LPC32XX_GPI_09] = {
> +		.event_group = &lpc32xx_event_pin_regs,
> +		.mask = LPC32XX_CLKPWR_EXTSRC_GPI_09_BIT,
> +	},
> +	[IRQ_LPC32XX_GPI_19] = {
> +		.event_group = &lpc32xx_event_pin_regs,
> +		.mask = LPC32XX_CLKPWR_EXTSRC_GPI_19_BIT,
> +	},
> +	[IRQ_LPC32XX_GPI_07] = {
> +		.event_group = &lpc32xx_event_pin_regs,
> +		.mask = LPC32XX_CLKPWR_EXTSRC_GPI_07_BIT,
> +	},
> +	[IRQ_LPC32XX_GPI_00] = {
> +		.event_group = &lpc32xx_event_pin_regs,
> +		.mask = LPC32XX_CLKPWR_EXTSRC_GPI_00_BIT,
> +	},
> +	[IRQ_LPC32XX_GPI_01] = {
> +		.event_group = &lpc32xx_event_pin_regs,
> +		.mask = LPC32XX_CLKPWR_EXTSRC_GPI_01_BIT,
> +	},
> +	[IRQ_LPC32XX_GPI_02] = {
> +		.event_group = &lpc32xx_event_pin_regs,
> +		.mask = LPC32XX_CLKPWR_EXTSRC_GPI_02_BIT,
> +	},
> +	[IRQ_LPC32XX_GPI_03] = {
> +		.event_group = &lpc32xx_event_pin_regs,
> +		.mask = LPC32XX_CLKPWR_EXTSRC_GPI_03_BIT,
> +	},
> +	[IRQ_LPC32XX_GPI_04] = {
> +		.event_group = &lpc32xx_event_pin_regs,
> +		.mask = LPC32XX_CLKPWR_EXTSRC_GPI_04_BIT,
> +	},
> +	[IRQ_LPC32XX_GPI_05] = {
> +		.event_group = &lpc32xx_event_pin_regs,
> +		.mask = LPC32XX_CLKPWR_EXTSRC_GPI_05_BIT,
> +	},
> +	[IRQ_LPC32XX_GPI_06] = {
> +		.event_group = &lpc32xx_event_pin_regs,
> +		.mask = LPC32XX_CLKPWR_EXTSRC_GPI_06_BIT,
> +	},
> +	[IRQ_LPC32XX_GPIO_00] = {
> +		.event_group = &lpc32xx_event_int_regs,
> +		.mask = LPC32XX_CLKPWR_INTSRC_GPIO_00_BIT,
> +	},
> +	[IRQ_LPC32XX_GPIO_01] = {
> +		.event_group = &lpc32xx_event_int_regs,
> +		.mask = LPC32XX_CLKPWR_INTSRC_GPIO_01_BIT,
> +	},
> +	[IRQ_LPC32XX_GPIO_02] = {
> +		.event_group = &lpc32xx_event_int_regs,
> +		.mask = LPC32XX_CLKPWR_INTSRC_GPIO_02_BIT,
> +	},
> +	[IRQ_LPC32XX_GPIO_03] = {
> +		.event_group = &lpc32xx_event_int_regs,
> +		.mask = LPC32XX_CLKPWR_INTSRC_GPIO_03_BIT,
> +	},
> +	[IRQ_LPC32XX_GPIO_04] = {
> +		.event_group = &lpc32xx_event_int_regs,
> +		.mask = LPC32XX_CLKPWR_INTSRC_GPIO_04_BIT,
> +	},
> +	[IRQ_LPC32XX_GPIO_05] = {
> +		.event_group = &lpc32xx_event_int_regs,
> +		.mask = LPC32XX_CLKPWR_INTSRC_GPIO_05_BIT,
> +	},
> +	[IRQ_LPC32XX_KEY] = {
> +		.event_group = &lpc32xx_event_int_regs,
> +		.mask = LPC32XX_CLKPWR_INTSRC_KEY_BIT,
> +	},
> +	[IRQ_LPC32XX_USB_OTG_ATX] = {
> +		.event_group = &lpc32xx_event_int_regs,
> +		.mask = LPC32XX_CLKPWR_INTSRC_USBATXINT_BIT,
> +	},
> +	[IRQ_LPC32XX_USB_HOST] = {
> +		.event_group = &lpc32xx_event_int_regs,
> +		.mask = LPC32XX_CLKPWR_INTSRC_USB_BIT,
> +	},
> +	[IRQ_LPC32XX_RTC] = {
> +		.event_group = &lpc32xx_event_int_regs,
> +		.mask = LPC32XX_CLKPWR_INTSRC_RTC_BIT,
> +	},
> +	[IRQ_LPC32XX_MSTIMER] = {
> +		.event_group = &lpc32xx_event_int_regs,
> +		.mask = LPC32XX_CLKPWR_INTSRC_MSTIMER_BIT,
> +	},
> +	[IRQ_LPC32XX_TS_AUX] = {
> +		.event_group = &lpc32xx_event_int_regs,
> +		.mask = LPC32XX_CLKPWR_INTSRC_TS_AUX_BIT,
> +	},
> +	[IRQ_LPC32XX_TS_P] = {
> +		.event_group = &lpc32xx_event_int_regs,
> +		.mask = LPC32XX_CLKPWR_INTSRC_TS_P_BIT,
> +	},
> +	[IRQ_LPC32XX_TS_IRQ] = {
> +		.event_group = &lpc32xx_event_int_regs,
> +		.mask = LPC32XX_CLKPWR_INTSRC_ADC_BIT,
> +	},
> +};
> +
> +static void get_controller(unsigned int irq, unsigned int *base,
> +	unsigned int *irqbit)
> +{
> +	if (irq < 32) {
> +		*base = LPC32XX_MIC_BASE;
> +		*irqbit = 1 << irq;
> +	} else if (irq < 64) {
> +		*base = LPC32XX_SIC1_BASE;
> +		*irqbit = 1 << (irq - 32);
> +	} else {
> +		*base = LPC32XX_SIC2_BASE;
> +		*irqbit = 1 << (irq - 64);
> +	}
> +}
> +
> +static void lpc32xx_mask_irq(unsigned int irq)
> +{
> +	unsigned int reg, ctrl, mask;
> +
> +	get_controller(irq, &ctrl, &mask);
> +
> +	reg = __raw_readl(LPC32XX_INTC_MASK(ctrl)) & ~mask;
> +	__raw_writel(reg, LPC32XX_INTC_MASK(ctrl));
> +}
> +
> +static void lpc32xx_unmask_irq(unsigned int irq)
> +{
> +	unsigned int reg, ctrl, mask;
> +
> +	get_controller(irq, &ctrl, &mask);
> +
> +	reg = __raw_readl(LPC32XX_INTC_MASK(ctrl)) | mask;
> +	__raw_writel(reg, LPC32XX_INTC_MASK(ctrl));
> +}
> +
> +static void lpc32xx_ack_irq(unsigned int irq)
> +{
> +	unsigned int ctrl, mask;
> +
> +	get_controller(irq, &ctrl, &mask);
> +
> +	__raw_writel(mask, LPC32XX_INTC_RAW_STAT(ctrl));
> +
> +	/* Also need to clear pending wake event */
> +	if (lpc32xx_events[irq].mask != 0)
> +		__raw_writel(lpc32xx_events[irq].mask,
> +			lpc32xx_events[irq].event_group->rawstat_reg);
> +}
> +
> +static void __lpc32xx_set_irq_type(unsigned int irq, int use_high_level,
> +	int use_edge)
> +{
> +	unsigned int reg, ctrl, mask;
> +
> +	get_controller(irq, &ctrl, &mask);
> +
> +	/* Activation level, high or low */
> +	reg = __raw_readl(LPC32XX_INTC_POLAR(ctrl));
> +	if (use_high_level)
> +		reg |= mask;
> +	else
> +		reg &= ~mask;
> +	__raw_writel(reg, LPC32XX_INTC_POLAR(ctrl));
> +
> +	/* Activation type, edge or level */
> +	reg = __raw_readl(LPC32XX_INTC_ACT_TYPE(ctrl));
> +	if (use_edge) {
> +		reg |= mask;
> +		set_irq_handler(irq, handle_edge_irq);
> +	} else {
> +		reg &= ~mask;
> +		set_irq_handler(irq, handle_level_irq);
> +	}
> +
> +	/* Use same polarity for the wake events */
> +	if (lpc32xx_events[irq].mask != 0) {
> +		reg = __raw_readl(lpc32xx_events[irq].event_group->edge_reg);
> +
> +		if (use_high_level)
> +			reg |= lpc32xx_events[irq].mask;
> +		else
> +			reg &= ~lpc32xx_events[irq].mask;
> +
> +		__raw_writel(reg, lpc32xx_events[irq].event_group->edge_reg);
> +	}
> +}
> +
> +static int lpc32xx_set_irq_type(unsigned int irq, unsigned int type)
> +{
> +	switch (type) {
> +	case IRQ_TYPE_EDGE_RISING:
> +		/* Rising edge sensitive */
> +		__lpc32xx_set_irq_type(irq, 1, 1);
> +		break;
> +
> +	case IRQ_TYPE_EDGE_FALLING:
> +		/* Falling edge sensitive */
> +		__lpc32xx_set_irq_type(irq, 0, 1);
> +		break;
> +
> +	case IRQ_TYPE_LEVEL_LOW:
> +		/* Low level sensitive */
> +		__lpc32xx_set_irq_type(irq, 0, 0);
> +		break;
> +
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		/* High level sensitive */
> +		__lpc32xx_set_irq_type(irq, 1, 0);
> +		break;
> +
> +	/* Other modes are not supported */
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Ok to use the level handler for all types */
> +	set_irq_handler(irq, handle_level_irq);
> +
> +	return 0;
> +}
> +
> +static int lpc32xx_irq_wake(unsigned int irqno, unsigned int state)
> +{
> +	unsigned long eventreg;
> +
> +	if (lpc32xx_events[irqno].mask != 0) {
> +		eventreg = __raw_readl(lpc32xx_events[irqno].
> +			event_group->enab_reg);
> +
> +		if (state)
> +			eventreg |= lpc32xx_events[irqno].mask;
> +		else
> +			eventreg &= ~lpc32xx_events[irqno].mask;
> +
> +		__raw_writel(eventreg,
> +			lpc32xx_events[irqno].event_group->enab_reg);
> +
> +		return 0;
> +	}
> +
> +	/* Clear event */
> +	__raw_writel(lpc32xx_events[irqno].mask,
> +		lpc32xx_events[irqno].event_group->rawstat_reg);
> +
> +	return -ENODEV;
> +}
> +
> +static void __init lpc32xx_set_default_mappings(unsigned int apr,
> +	unsigned int atr, unsigned int offset)
> +{
> +	unsigned int i;
> +
> +	/* Set activation levels for each interrupt */
> +	i = 0;
> +	while (i < 32) {
> +		__lpc32xx_set_irq_type(offset + i, ((apr >> i) & 0x1),
> +			((atr >> i) & 0x1));
> +		i++;
> +	}
> +}
> +
> +static struct irq_chip lpc32xx_irq_chip = {
> +	.ack = lpc32xx_ack_irq,
> +	.mask = lpc32xx_mask_irq,
> +	.unmask = lpc32xx_unmask_irq,
> +	.set_type = lpc32xx_set_irq_type,
> +	.set_wake = lpc32xx_irq_wake
> +};
> +
> +#define SIC1_IRQ(x) ((x) + 32)
> +#define SIC2_IRQ(x) ((x) + 64)
> +
> +static void lpc32xx_sic1_handler(unsigned int irq, struct irq_desc *desc)
> +{
> +	unsigned long ints = __raw_readl(LPC32XX_INTC_STAT(LPC32XX_SIC1_BASE));
> +
> +	while (ints != 0) {
> +		int irqno = fls(ints) - 1;
> +
> +		ints &= ~(1 << irqno);
> +
> +		handle_level_irq(SIC1_IRQ(irqno), desc);
> +	}
> +}
> +
> +static void lpc32xx_sic2_handler(unsigned int irq, struct irq_desc *desc)
> +{
> +	unsigned long ints = __raw_readl(LPC32XX_INTC_STAT(LPC32XX_SIC2_BASE));
> +
> +	while (ints != 0) {
> +		int irqno = fls(ints) - 1;
> +
> +		ints &= ~(1 << irqno);
> +
> +		handle_level_irq(SIC2_IRQ(irqno), desc);
This is wrong!  You call handle_level_irq(SIC2_IRQ(irqno)) with the
descriptor of IRQ_LPC32XX_SUB2IRQ.

Better use

	generic_handle_irq(SIC2_IRQ(irqno));

and don't hardcode handle_level_irq here.

> +	}
> +}
> +
> +void __init lpc32xx_init_irq(void)
> +{
> +	unsigned int i;
> +
> +	/* Setup MIC */
> +	__raw_writel(0, LPC32XX_INTC_MASK(LPC32XX_MIC_BASE));
> +	__raw_writel(MIC_APR_DEFAULT, LPC32XX_INTC_POLAR(LPC32XX_MIC_BASE));
> +	__raw_writel(MIC_ATR_DEFAULT, LPC32XX_INTC_ACT_TYPE(LPC32XX_MIC_BASE));
> +
> +	/* Setup SIC1 */
> +	__raw_writel(0, LPC32XX_INTC_MASK(LPC32XX_SIC1_BASE));
> +	__raw_writel(MIC_APR_DEFAULT, LPC32XX_INTC_POLAR(LPC32XX_SIC1_BASE));
> +	__raw_writel(MIC_ATR_DEFAULT, LPC32XX_INTC_ACT_TYPE(LPC32XX_SIC1_BASE));
> +
> +	/* Setup SIC2 */
> +	__raw_writel(0, LPC32XX_INTC_MASK(LPC32XX_SIC2_BASE));
> +	__raw_writel(MIC_APR_DEFAULT, LPC32XX_INTC_POLAR(LPC32XX_SIC2_BASE));
> +	__raw_writel(MIC_ATR_DEFAULT, LPC32XX_INTC_ACT_TYPE(LPC32XX_SIC2_BASE));
> +
> +	/* Configure supported IRQ's */
> +	for (i = 0; i < NR_IRQS; i++) {
> +		set_irq_chip(i, &lpc32xx_irq_chip);
> +		set_irq_handler(i, handle_level_irq);
> +		set_irq_flags(i, IRQF_VALID);
> +	}
> +
> +	/* Set default mappings */
> +	lpc32xx_set_default_mappings(MIC_APR_DEFAULT, MIC_ATR_DEFAULT, 0);
> +	lpc32xx_set_default_mappings(SIC1_APR_DEFAULT, SIC1_ATR_DEFAULT, 32);
> +	lpc32xx_set_default_mappings(SIC2_APR_DEFAULT, SIC2_ATR_DEFAULT, 64);
> +
> +	/* MIC SUBIRQx interrupts will route handling to the chain handlers */
> +	set_irq_chained_handler(IRQ_LPC32XX_SUB1IRQ, lpc32xx_sic1_handler);
> +	set_irq_chained_handler(IRQ_LPC32XX_SUB2IRQ, lpc32xx_sic2_handler);
> +
> +	/* mask all interrupts except SUBIRQ */
> +	__raw_writel((1 << IRQ_LPC32XX_SUB1IRQ) | (1 << IRQ_LPC32XX_SUB2IRQ),
> +		LPC32XX_INTC_MASK(LPC32XX_MIC_BASE));
> +	__raw_writel(0, LPC32XX_INTC_MASK(LPC32XX_SIC1_BASE));
> +	__raw_writel(0, LPC32XX_INTC_MASK(LPC32XX_SIC2_BASE));
set_irq_chained_handler(IRQ_LPC32XX_SUB2IRQ, lpc32xx_sic2_handler) calls
lpc32xx_irq_chip->enable(IRQ_LPC32XX_SUB2IRQ), so first masking all irqs
and only then calling set_irq_chained_handler should do the right thing.

> +
> +	/* Initially disable all wake events */
> +	__raw_writel(0, LPC32XX_CLKPWR_P01_ER);
> +	__raw_writel(0, LPC32XX_CLKPWR_INT_ER);
> +	__raw_writel(0, LPC32XX_CLKPWR_PIN_ER);
> +
> +	/*
> +	 * Default wake activation polarities, all pin sources are low edge
> +	 * triggered
> +	 */
> +	__raw_writel(LPC32XX_CLKPWR_INTSRC_TS_P_BIT |
> +		LPC32XX_CLKPWR_INTSRC_MSTIMER_BIT |
> +		LPC32XX_CLKPWR_INTSRC_RTC_BIT,
> +		LPC32XX_CLKPWR_INT_AP);
> +	__raw_writel(0, LPC32XX_CLKPWR_PIN_AP);
> +
> +	/* Clear latched wake event states */
> +	__raw_writel(__raw_readl(LPC32XX_CLKPWR_PIN_RS),
> +		LPC32XX_CLKPWR_PIN_RS);
> +	__raw_writel(__raw_readl(LPC32XX_CLKPWR_INT_RS),
> +		LPC32XX_CLKPWR_INT_RS);
> +}
> diff --git a/arch/arm/mach-lpc32xx/timer.c b/arch/arm/mach-lpc32xx/timer.c
> new file mode 100644
> index 0000000..630dd4a
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/timer.c
> @@ -0,0 +1,182 @@
> +/*
> + * arch/arm/mach-lpc32xx/timer.c
> + *
> + * Author: Kevin Wells <kevin.wells@nxp.com>
> + *
> + * Copyright (C) 2009 - 2010 NXP Semiconductors
> + * Copyright (C) 2009 Fontys University of Applied Sciences, Eindhoven
> + *                    Ed Schouten <e.schouten@fontys.nl>
> + *                    Laurens Timmermans <l.timmermans@fontys.nl>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/time.h>
> +#include <linux/err.h>
> +#include <linux/clockchips.h>
> +
> +#include <asm/mach/time.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/platform.h>
> +#include "common.h"
> +
> +static cycle_t lpc32xx_clksrc_read(struct clocksource *cs)
> +{
> +	return (cycle_t)__raw_readl(LCP32XX_TIMER_TC(LPC32XX_TIMER1_BASE));
> +}
> +
> +static struct clocksource lpc32xx_clksrc = {
> +	.name	= "lpc32xx_clksrc",
> +	.shift	= 24,
> +	.rating	= 300,
> +	.read	= lpc32xx_clksrc_read,
> +	.mask	= CLOCKSOURCE_MASK(32),
> +	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
> +static int lpc32xx_clkevt_next_event(unsigned long delta,
> +    struct clock_event_device *dev)
> +{
> +	__raw_writel(LCP32XX_TIMER_CNTR_TCR_RESET,
> +		LCP32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
> +	__raw_writel(delta, LCP32XX_TIMER_PR(LPC32XX_TIMER0_BASE));
> +	__raw_writel(LCP32XX_TIMER_CNTR_TCR_EN,
> +		LCP32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
> +
> +	return 0;
> +}
> +
> +static void lpc32xx_clkevt_mode(enum clock_event_mode mode,
> +    struct clock_event_device *dev)
> +{
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		WARN_ON(1);
> +		break;
> +
> +	case CLOCK_EVT_MODE_ONESHOT:
> +	case CLOCK_EVT_MODE_SHUTDOWN:
> +		/*
> +		 * Disable the timer. When using oneshot, we must also
> +		 * disable the timer to wait for the first call to
> +		 * set_next_event().
> +		 */
> +		__raw_writel(0, LCP32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
> +		break;
> +
> +	case CLOCK_EVT_MODE_UNUSED:
> +	case CLOCK_EVT_MODE_RESUME:
> +		break;
> +	}
> +}
> +
> +static struct clock_event_device lpc32xx_clkevt = {
> +	.name		= "lpc32xx_clkevt",
> +	.features	= CLOCK_EVT_FEAT_ONESHOT,
> +	.shift		= 32,
> +	.rating		= 300,
> +	.set_next_event	= lpc32xx_clkevt_next_event,
> +	.set_mode	= lpc32xx_clkevt_mode,
> +};
> +
> +static irqreturn_t lpc32xx_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = &lpc32xx_clkevt;
> +
> +	/* Clear match */
> +	__raw_writel(LCP32XX_TIMER_CNTR_MTCH_BIT(0),
> +		LCP32XX_TIMER_IR(LPC32XX_TIMER0_BASE));
> +
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct irqaction lpc32xx_timer_irq = {
> +	.name		= "LPC32XX Timer Tick",
> +	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
> +	.handler	= lpc32xx_timer_interrupt,
> +};
> +
> +/*
> + * The clock management driver isn't initialized at this point, so the
> + * clocks need to be enabled here manually and then tagged as used in
> + * the clock driver initialization
> + */
> +static void __init lpc32xx_timer_init(void)
> +{
> +	u32 clkrate, pllreg;
> +
> +	/* Enable timer clock */
> +	__raw_writel(LPC32XX_CLKPWR_TMRPWMCLK_TIMER0_EN |
> +		LPC32XX_CLKPWR_TMRPWMCLK_TIMER1_EN,
> +		LPC32XX_CLKPWR_TIMERS_PWMS_CLK_CTRL_1);
> +
> +	/*
> +	 * The clock driver isn't initialized at this point. So determine if
> +	 * the SYSCLK is driven from the PLL397 or main oscillator and then use
> +	 * it to compute the PLL frequency and the PCLK divider to get the base
> +	 * timer rates. This rate is needed to compute the tick rate.
> +	 */
> +	if (clk_is_sysclk_mainosc() != 0)
> +		clkrate = LPC32XX_MAIN_OSC_FREQ;
> +	else
> +		clkrate = 397 * LPC32XX_CLOCK_OSC_FREQ;
> +
> +	/* Get ARM HCLKPLL register and convert it into a frequency */
> +	pllreg = __raw_readl(LPC32XX_CLKPWR_HCLKPLL_CTRL) & 0x1FFFF;
> +	clkrate = clk_get_pllrate_from_reg(clkrate, pllreg);
> +
> +	/* Get PCLK divider and divide ARM PLL clock by it to get timer rate */
> +	clkrate = clkrate / clk_get_pclk_div();
> +
> +	/* Initial timer setup */
> +	__raw_writel(0, LCP32XX_TIMER_TCR(LPC32XX_TIMER0_BASE));
> +	__raw_writel(LCP32XX_TIMER_CNTR_MTCH_BIT(0),
> +		LCP32XX_TIMER_IR(LPC32XX_TIMER0_BASE));
> +	__raw_writel(1, LCP32XX_TIMER_MR0(LPC32XX_TIMER0_BASE));
> +	__raw_writel(LCP32XX_TIMER_CNTR_MCR_MTCH(0) |
> +		LCP32XX_TIMER_CNTR_MCR_STOP(0) |
> +		LCP32XX_TIMER_CNTR_MCR_RESET(0),
> +		LCP32XX_TIMER_MCR(LPC32XX_TIMER0_BASE));
> +
> +	/* Setup tick interrupt */
> +	setup_irq(IRQ_LPC32XX_TIMER0, &lpc32xx_timer_irq);
> +
> +	/* Setup the clockevent structure. */
> +	lpc32xx_clkevt.mult = div_sc(clkrate, NSEC_PER_SEC,
> +		lpc32xx_clkevt.shift);
> +	lpc32xx_clkevt.max_delta_ns = clockevent_delta2ns(-1,
> +		&lpc32xx_clkevt);
> +	lpc32xx_clkevt.min_delta_ns = clockevent_delta2ns(1,
> +		&lpc32xx_clkevt) + 1;
> +	lpc32xx_clkevt.cpumask = cpumask_of(0);
> +	clockevents_register_device(&lpc32xx_clkevt);
> +
> +	/* Use timer1 as clock source. */
> +	__raw_writel(LCP32XX_TIMER_CNTR_TCR_RESET,
> +		LCP32XX_TIMER_TCR(LPC32XX_TIMER1_BASE));
> +	__raw_writel(0, LCP32XX_TIMER_PR(LPC32XX_TIMER1_BASE));
> +	__raw_writel(0, LCP32XX_TIMER_MCR(LPC32XX_TIMER1_BASE));
> +	__raw_writel(LCP32XX_TIMER_CNTR_TCR_EN,
> +		LCP32XX_TIMER_TCR(LPC32XX_TIMER1_BASE));
> +	lpc32xx_clksrc.mult = clocksource_hz2mult(clkrate,
> +		lpc32xx_clksrc.shift);
> +	clocksource_register(&lpc32xx_clksrc);
> +}
> +
> +struct sys_timer lpc32xx_timer = {
> +	.init		= &lpc32xx_timer_init,
> +};
> +
Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
