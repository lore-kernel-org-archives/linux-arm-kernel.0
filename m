From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 27 Jan 2010 01:03:35 +0000
Subject: [PATCH 03/10] ARM: LPC32XX: core architecture files
In-Reply-To: <1264551591.6528.6@usb10132>
References: <1264551591.6528.6@usb10132>
Message-ID: <20100127010335.GH9153@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 04:19:51PM -0800, Kevin Wells wrote:
> LPC32XX core architecture files
>
>
> Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
> ---
>  arch/arm/mach-lpc32xx/gpiolib.c |  455  
> +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-lpc32xx/irq.c     |  237 ++++++++++++++++++++
>  arch/arm/mach-lpc32xx/serial.c  |  200 +++++++++++++++++
>  arch/arm/mach-lpc32xx/timer.c   |  187 ++++++++++++++++
>  4 files changed, 1079 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-lpc32xx/gpiolib.c  
> b/arch/arm/mach-lpc32xx/gpiolib.c
> new file mode 100644
> index 0000000..615b72f
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/gpiolib.c
> @@ -0,0 +1,455 @@
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
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  
> USA
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
> +
> +#define GPIO_IOBASE io_p2v(GPIO_BASE)
> +
> +struct gpio_regs {
> +	u32 inp_state;
> +	u32 outp_set;
> +	u32 outp_clr;
> +	u32 dir_set;
> +	u32 dir_clr;
> +	int pgroup;
> +};

Thinks passed to readl/writel or __readl,__writel should be 
__void iomem *.

> +/*
> + * GPIO names
> + */
> +static char *gpio_p0_names[GPIO_P0_MAX] = {
> +	"p0.0", "p0.1", "p0.2", "p0.3",
> +	"p0.4", "p0.5", "p0.6", "p0.7"
> +};
> +
> +static char *gpio_p1_names[GPIO_P1_MAX] = {
> +	"p1.0", "p1.1", "p1.2", "p1.3",
> +	"p1.4", "p1.5", "p1.6", "p1.7",
> +	"p1.8", "p1.9", "p1.10", "p1.11",
> +	"p1.12", "p1.13", "p1.14", "p1.15",
> +	"p1.16", "p1.17", "p1.18", "p1.19",
> +	"p1.20", "p1.21", "p1.22", "p1.23",
> +};
> +
> +static char *gpio_p2_names[GPIO_P2_MAX] = {
> +	"p2.0", "p2.1", "p2.2", "p2.3",
> +	"p2.4", "p2.5", "p2.6", "p2.7",
> +	"p2.8", "p2.9", "p2.10", "p2.11",
> +	"p2.12"
> +};
> +
> +static char *gpio_p3_names[GPIO_P3_MAX] = {
> +	"gpi000", "gpio01", "gpio02", "gpio03",
> +	"gpio04", "gpio05"
> +};
> +
> +static char *gpi_p3_names[GPI_P3_MAX] = {
> +	"gpi00", "gpi01", "gpi02", "gpi03",
> +	"gpi04", "gpi05", "gpi06", "gpi07",
> +	"gpi08", "gpi09", "na",    "na",
> +	"na",    "na",    "na",    "gpi15",
> +	"gpi16", "gpi17", "gpi18", "gpi19",
> +	"gpi20", "gpi21", "gpi22", "gpi23",
> +	"gpi24", "gpi25", "gpi26", "gpi27"
> +};
> +
> +static char *gpo_p3_names[GPO_P3_MAX] = {
> +	"gpo00", "gpo01", "gpo02", "gpo03",
> +	"gpo04", "gpo05", "gpo06", "gpo07",
> +	"gpo08", "gpo09", "gpo10", "gpo11",
> +	"gpo12", "gpo13", "gpo14", "gpo15",
> +	"gpo16", "gpo17", "gpo18", "gpo19",
> +	"gpo20", "gpo21", "gpo22", "gpo23"
> +};
> +
> +static struct gpio_regs gpio_grp_regs[] = {
> +	{
> +		.inp_state	= GPIO_P0_INP_STATE(GPIO_IOBASE),
> +		.outp_set	= GPIO_P0_OUTP_SET(GPIO_IOBASE),
> +		.outp_clr	= GPIO_P0_OUTP_CLR(GPIO_IOBASE),
> +		.dir_set	= GPIO_P0_DIR_SET(GPIO_IOBASE),
> +		.dir_clr	= GPIO_P0_DIR_CLR(GPIO_IOBASE),
> +		.pgroup		= 0,
> +	},
> +	{
> +		.inp_state	= GPIO_P1_INP_STATE(GPIO_IOBASE),
> +		.outp_set	= GPIO_P1_OUTP_SET(GPIO_IOBASE),
> +		.outp_clr	= GPIO_P1_OUTP_CLR(GPIO_IOBASE),
> +		.dir_set	= GPIO_P1_DIR_SET(GPIO_IOBASE),
> +		.dir_clr	= GPIO_P1_DIR_CLR(GPIO_IOBASE),
> +		.pgroup		= 1,
> +	},
> +	{
> +		.inp_state	= GPIO_P2_INP_STATE(GPIO_IOBASE),
> +		.outp_set	= GPIO_P2_OUTP_SET(GPIO_IOBASE),
> +		.outp_clr	= GPIO_P2_OUTP_CLR(GPIO_IOBASE),
> +		.dir_set	= GPIO_P2_DIR_SET(GPIO_IOBASE),
> +		.dir_clr	= GPIO_P2_DIR_CLR(GPIO_IOBASE),
> +		.pgroup		= 2,
> +	},
> +	{
> +		.inp_state	= GPIO_P3_INP_STATE(GPIO_IOBASE),
> +		.outp_set	= GPIO_P3_OUTP_SET(GPIO_IOBASE),
> +		.outp_clr	= GPIO_P3_OUTP_CLR(GPIO_IOBASE),
> +		.dir_set	= GPIO_P2_DIR_SET(GPIO_IOBASE),
> +		.dir_clr	= GPIO_P2_DIR_CLR(GPIO_IOBASE),
> +		.pgroup		= 3,
> +	},
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
> +		writel(1 << pin, group->gpio_grp->dir_clr);
> +	else
> +		writel(1 << pin, group->gpio_grp->dir_set);
> +}
> +
> +static void __set_gpio_dir_p3(struct lpc32xx_gpio_chip *group,
> +	unsigned pin, int input)
> +{
> +	u32 u;
> +
> +	/* P3 GPIO pins are offset in the register to pin mapping */
> +	u = (1 << (pin + 25));
> +
> +	if (input)
> +		writel(u, group->gpio_grp->dir_clr);
> +	else
> +		writel(u, group->gpio_grp->dir_set);
> +}
> +
> +static void __set_gpio_level_p012(struct lpc32xx_gpio_chip *group,
> +	unsigned pin, int high)
> +{
> +	if (high)
> +		writel(1 << pin, group->gpio_grp->outp_set);
> +	else
> +		writel(1 << pin, group->gpio_grp->outp_clr);
> +}
> +
> +static void __set_gpio_level_p3(struct lpc32xx_gpio_chip *group,
> +	unsigned pin, int high)
> +{
> +	u32 u;
> +
> +	/* P3 GPIO pins are offset in the register to pin mapping */
> +	u = (1 << (pin + 25));
> +
> +	if (high)
> +		writel(u, group->gpio_grp->outp_set);
> +	else
> +		writel(u, group->gpio_grp->outp_clr);
> +}
> +
> +static void __set_gpo_level_p3(struct lpc32xx_gpio_chip *group,
> +	unsigned pin, int high)
> +{
> +	if (high)
> +		writel(1 << pin, group->gpio_grp->outp_set);
> +	else
> +		writel(1 << pin, group->gpio_grp->outp_clr);
> +}
> +
> +static int __get_gpio_state_p012(struct lpc32xx_gpio_chip *group,
> +	unsigned pin)
> +{
> +	int state;
> +
> +	state =  (int) readl(group->gpio_grp->inp_state);

you shouldn't need the (int) cast here.

> +	state = (state >> pin) & 1;
> +
> +	return state;
> +}
> +
> +static int __get_gpio_state_p3(struct lpc32xx_gpio_chip *group,
> +	unsigned pin)
> +{
> +	int state;
> +
> +	state =  (int) readl(group->gpio_grp->inp_state);
> +
> +	/* P3 GPIO pin input mapping is not contiguous */
> +	if (pin == 5)
> +		state = (state >> 24) & 1;
> +	else
> +		state = (state >> (10 + pin)) & 1;
> +
> +	return state;
> +}
> +
> +static int __get_gpi_state_p3(struct lpc32xx_gpio_chip *group,
> +	unsigned pin)
> +{
> +	int state;
> +
> +	state =  (int) readl(group->gpio_grp->inp_state);
> +	state = (state >> pin) & 1;
> +
> +	return state;
> +}
> +
> +/*
> + * GENERIC_GPIO primitives.
> + */
> +static int lpc32xx_gpio_dir_input(struct gpio_chip *chip,
> +	unsigned pin)
> +{
> +	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> +	if (pin >= chip->ngpio)
> +		return -EINVAL;
> +
> +	if (group->gpio_grp->pgroup <= 2)
> +		__set_gpio_dir_p012(group, pin, 1);
> +	else
> +		__set_gpio_dir_p3(group, pin, 1);
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
> +static int lpc32xx_gpio_dir_in_none(struct gpio_chip *chip,
> +	unsigned pin)
> +{
> +	return -EINVAL;
> +}
does gpiolib do this for you already?


> +static int lpc32xx_gpio_get_value(struct gpio_chip *chip, unsigned pin)
> +{
> +	int val = 0;
> +	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> +	if (pin < chip->ngpio) {
> +		if (group->gpio_grp->pgroup <= 2)
> +			val = __get_gpio_state_p012(group, pin);
> +		else
> +			val = __get_gpio_state_p3(group, pin);
> +	}
> +
> +	return val;
> +}
> +
> +static int lpc32xx_gpio_get_none(struct gpio_chip *chip, unsigned pin)
> +{
> +	return 0;
> +}
> +
> +static int lpc32xx_gpi_get_value(struct gpio_chip *chip, unsigned pin)
> +{
> +	int val = 0;
> +	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> +	if (pin < chip->ngpio)
> +		val = __get_gpi_state_p3(group, pin);
> +
> +	return val;
> +}
> +
> +static int lpc32xx_gpio_dir_output(struct gpio_chip *chip, unsigned  
> pin,
> +	int value)
> +{
> +	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> +	if (pin >= chip->ngpio)
> +		return -EINVAL;
> +
> +	if (group->gpio_grp->pgroup <= 2)
> +		__set_gpio_dir_p012(group, pin, 0);
> +	else
> +		__set_gpio_dir_p3(group, pin, 0);
> +
> +	return 0;
> +}
> +
> +static int lpc32xx_gpio_dir_out_none(struct gpio_chip *chip, unsigned  
> pin,
> +	int value)
> +{
> +	return -EINVAL;
> +}
> +
> +static int lpc32xx_gpio_dir_out_always(struct gpio_chip *chip, unsigned 
> pin,
> +	int value)
> +{
> +	return 0;
> +}
> +
> +static void lpc32xx_gpio_set_value(struct gpio_chip *chip, unsigned  
> pin,
> +	int value)
> +{
> +	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> +	if (pin < chip->ngpio) {
> +		if (group->gpio_grp->pgroup <= 2)
> +			__set_gpio_level_p012(group, pin, value);
> +		else
> +			__set_gpio_level_p3(group, pin, value);
> +	}
> +}

Why not have the right call for the group set in the gpio chip instead
of having to check prgoup each time? Another way might be to just pass in
a valud depending on prgoup for offset of gpio.

> +static void lpc32xx_gpo_set_value(struct gpio_chip *chip, unsigned pin,
> +	int value)
> +{
> +	struct lpc32xx_gpio_chip *group = to_lpc32xx_gpio(chip);
> +
> +	if (pin < chip->ngpio)
> +		__set_gpo_level_p3(group, pin, value);
> +}

I thought gpiolib would enforce 'if (pin < chip->ngpio)'

> +static void lpc32xx_gpo_set_none(struct gpio_chip *chip, unsigned pin,
> +	int value)
> +{
> +	/* NULL function for GPI only pins */
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
> +			.direction_input	= lpc32xx_gpio_dir_input,
> +			.get			= lpc32xx_gpio_get_value,
> +			.direction_output	= lpc32xx_gpio_dir_output,
> +			.set			= lpc32xx_gpio_set_value,
> +			.request		= lpc32xx_gpio_request,
> +			.base			= GPIO_P0_GRP,
> +			.ngpio			= GPIO_P0_MAX,
> +			.names			= gpio_p0_names,
> +			.can_sleep		= 0,
> +		},
> +		.gpio_grp = &gpio_grp_regs[0],
> +	},
> +	{
> +		.chip = {
> +			.label			= "gpio_p1",
> +			.direction_input	= lpc32xx_gpio_dir_input,
> +			.get			= lpc32xx_gpio_get_value,
> +			.direction_output	= lpc32xx_gpio_dir_output,
> +			.set			= lpc32xx_gpio_set_value,
> +			.request		= lpc32xx_gpio_request,
> +			.base			= GPIO_P1_GRP,
> +			.ngpio			= GPIO_P1_MAX,
> +			.names			= gpio_p1_names,
> +			.can_sleep		= 0,
> +		},
> +		.gpio_grp = &gpio_grp_regs[1],
> +	},
> +	{
> +		.chip = {
> +			.label			= "gpio_p2",
> +			.direction_input	= lpc32xx_gpio_dir_input,
> +			.get			= lpc32xx_gpio_get_value,
> +			.direction_output	= lpc32xx_gpio_dir_output,
> +			.set			= lpc32xx_gpio_set_value,
> +			.request		= lpc32xx_gpio_request,
> +			.base			= GPIO_P2_GRP,
> +			.ngpio			= GPIO_P2_MAX,
> +			.names			= gpio_p2_names,
> +			.can_sleep		= 0,
> +		},
> +		.gpio_grp = &gpio_grp_regs[2],
> +	},
> +	{
> +		.chip = {
> +			.label			= "gpio_p3",
> +			.direction_input	= lpc32xx_gpio_dir_input,
> +			.get			= lpc32xx_gpio_get_value,
> +			.direction_output	= lpc32xx_gpio_dir_output,
> +			.set			= lpc32xx_gpio_set_value,
> +			.request		= lpc32xx_gpio_request,
> +			.base			= GPIO_P3_GRP,
> +			.ngpio			= GPIO_P3_MAX,
> +			.names			= gpio_p3_names,
> +			.can_sleep		= 0,
> +		},
> +		.gpio_grp = &gpio_grp_regs[3],
> +	},
> +	{
> +		.chip = {
> +			.label			= "gpi_p3",
> +			.direction_input	= lpc32xx_gpio_dir_in_always,
> +			.get			= lpc32xx_gpi_get_value,
> +			.direction_output	= lpc32xx_gpio_dir_out_none,
> +			.set			= lpc32xx_gpo_set_none,
> +			.request		= lpc32xx_gpio_request,
> +			.base			= GPI_P3_GRP,
> +			.ngpio			= GPI_P3_MAX,
> +			.names			= gpi_p3_names,
> +			.can_sleep		= 0,
> +		},
> +		.gpio_grp = &gpio_grp_regs[3],

if you've got 1:1 mapping of gpio_grp to chip, then why not have the
initialisation here and avoid an extra array?

> +	},
> +	{
> +		.chip = {
> +			.label			= "gpo_p3",
> +			.direction_input	= lpc32xx_gpio_dir_in_none,
> +			.get			= lpc32xx_gpio_get_none,
> +			.direction_output	= lpc32xx_gpio_dir_out_always,
> +			.set			= lpc32xx_gpo_set_value,
> +			.request		= lpc32xx_gpio_request,
> +			.base			= GPO_P3_GRP,
> +			.ngpio			= GPO_P3_MAX,
> +			.names			= gpo_p3_names,
> +			.can_sleep		= 0,
> +		},
> +		.gpio_grp = &gpio_grp_regs[3],
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
> index 0000000..8a1b57d
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/irq.c
> @@ -0,0 +1,237 @@
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
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  
> USA
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
> +
> +/*
> + * Default value represeting the Activation polarity of all internal
> + * interrupt sources
> + */
> +#define MIC_APR_DEFAULT		0x3FF0EFE0
> +#define SIC1_APR_DEFAULT	0xFBD27186
> +#define SIC2_APR_DEFAULT	0x801810C0
> +
> +/*
> + * Default value represeting the Activation Type of all internal
> + * interrupt sources. All are level senesitive.
> + */
> +#define MIC_ATR_DEFAULT		0x00000000
> +#define SIC1_ATR_DEFAULT	0x00026000
> +#define SIC2_ATR_DEFAULT	0x00000000
> +
> +static void get_controller(unsigned int irq, unsigned int *base,
> +	unsigned int *irqbit)
> +{
> +	if (irq < 32) {
> +		*base = io_p2v(MIC_BASE);
> +		*irqbit = 1 << irq;
> +	} else if (irq < 64) {
> +		*base = io_p2v(SIC1_BASE);
> +		*irqbit = 1 << (irq - 32);
> +	} else {
> +		*base = io_p2v(SIC2_BASE);
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
> +	reg = readl(ctrl + INTC_MASK);
> +	reg &= ~mask;
> +	writel(reg, (ctrl + INTC_MASK));
> +}
> +
> +static void lpc32xx_unmask_irq(unsigned int irq)
> +{
> +	unsigned int reg, ctrl, mask;
> +
> +	get_controller(irq, &ctrl, &mask);
> +
> +	reg = readl(ctrl + INTC_MASK);
> +	reg |= mask;
> +	writel(reg, (ctrl + INTC_MASK));
> +}
> +
> +static void lpc32xx_mask_ack_irq(unsigned int irq)
> +{
> +	unsigned int ctrl, mask;
> +
> +	get_controller(irq, &ctrl, &mask);
> +
> +	writel(mask, (ctrl + INTC_RAW_STAT));
> +}
> +
> +static int lpc32xx_set_irq_type(unsigned int irq, unsigned int type)
> +{
> +	unsigned int reg, ctrl, mask;
> +
> +	get_controller(irq, &ctrl, &mask);
> +
> +	switch (type) {
> +	case IRQ_TYPE_EDGE_RISING:
> +		/* Rising edge sensitive */
> +		reg = readl(ctrl + INTC_POLAR);
> +		reg |= mask;
> +		writel(reg, (ctrl + INTC_POLAR));
> +		reg = readl(ctrl + INTC_ACT_TYPE);
> +		reg |= mask;
> +		writel(reg, (ctrl + INTC_ACT_TYPE));
> +		set_irq_handler(irq, handle_edge_irq);
> +		break;
> +
> +	case IRQ_TYPE_EDGE_FALLING:
> +		/* Falling edge sensitive */
> +		reg = readl(ctrl + INTC_POLAR);
> +		reg &= ~mask;
> +		writel(reg, (ctrl + INTC_POLAR));
> +		reg = readl(ctrl + INTC_ACT_TYPE);
> +		reg |= mask;
> +		writel(reg, (ctrl + INTC_ACT_TYPE));
> +		set_irq_handler(irq, handle_edge_irq);
> +		break;
> +
> +	case IRQ_TYPE_LEVEL_LOW:
> +		/* Low level sensitive */
> +		reg = readl(ctrl + INTC_POLAR);
> +		reg &= ~mask;
> +		writel(reg, (ctrl + INTC_POLAR));
> +		reg = readl(ctrl + INTC_ACT_TYPE);
> +		reg &= ~mask;
> +		writel(reg, (ctrl + INTC_ACT_TYPE));
> +		set_irq_handler(irq, handle_level_irq);
> +		break;
> +
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		/* High level sensitive */
> +		reg = readl(ctrl + INTC_POLAR);
> +		reg |= mask;
> +		writel(reg, (ctrl + INTC_POLAR));
> +		reg = readl(ctrl + INTC_ACT_TYPE);
> +		reg &= ~mask;
> +		writel(reg, (ctrl + INTC_ACT_TYPE));
> +		set_irq_handler(irq, handle_level_irq);
> +		break;
> +
> +	/* Other modes are not supported */
> +	default:
> +		return -ENOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static void __init lpc32xx_set_default_mappings(unsigned int base,
> +	unsigned int apr, unsigned int atr, unsigned int offset)
> +{
> +	unsigned int i, lvl, type;
> +
> +	/* Set activation levels for each interrupt */
> +	i = 0;
> +	while (i < 32) 	{
> +		lvl = ((apr >> i) & 0x1) | (((atr >> i) & 0x1) << 1);
> +		switch (lvl) {
> +		case 0x0: /* Low polarity and level operation */
> +			type = IRQ_TYPE_LEVEL_LOW;
> +			break;
> +
> +		case 0x1: /* High polarity and level operation */
> +			type = IRQ_TYPE_LEVEL_HIGH;
> +			break;
> +
> +		case 0x2: /* Low polarity and edge operation */
> +			type = IRQ_TYPE_EDGE_FALLING;
> +			break;
> +
> +		case 0x3: /* High polarity and edge operation */
> +		default:
> +			type = IRQ_TYPE_EDGE_RISING;
> +			break;
> +		}
> +
> +		lpc32xx_set_irq_type((offset + i), type);
> +		i++;
> +	}
> +}
> +
> +static struct irq_chip lpc32xx_irq_chip = {
> +	.ack = lpc32xx_mask_ack_irq,
> +	.mask = lpc32xx_mask_irq,
> +	.unmask = lpc32xx_unmask_irq,
> +	.set_type = lpc32xx_set_irq_type,
> +};
> +
> +void __init lpc32xx_init_irq(void)
> +{
> +	unsigned int i, vloc;
> +
> +	/* Setup MIC */
> +	vloc = io_p2v(MIC_BASE);
> +	writel(0, (vloc + INTC_MASK));
> +	writel(MIC_APR_DEFAULT, (vloc + INTC_POLAR));
> +	writel(MIC_ATR_DEFAULT, (vloc + INTC_ACT_TYPE));
> +
> +	/* Setup SIC1 */
> +	vloc = io_p2v(SIC1_BASE);
> +	writel(0, (vloc + INTC_MASK));
> +	writel(SIC1_APR_DEFAULT, (vloc + INTC_POLAR));
> +	writel(SIC1_ATR_DEFAULT, (vloc + INTC_ACT_TYPE));
> +
> +	/* Setup SIC2 */
> +	vloc = io_p2v(SIC2_BASE);
> +	writel(0, (vloc + INTC_MASK));
> +	writel(SIC2_APR_DEFAULT, (vloc + INTC_POLAR));
> +	writel(SIC2_ATR_DEFAULT, (vloc + INTC_ACT_TYPE));
> +
> +	/* Configure supported IRQ's */
> +	for (i = 0; i < NR_IRQS; i++) {
> +		set_irq_flags(i, IRQF_VALID);
> +		set_irq_chip(i, &lpc32xx_irq_chip);
> +	}
> +
> +	/* Set default mappings */
> +	lpc32xx_set_default_mappings(io_p2v(MIC_BASE), MIC_APR_DEFAULT,
> +		MIC_ATR_DEFAULT, 0);
> +	lpc32xx_set_default_mappings(io_p2v(SIC1_BASE), SIC1_APR_DEFAULT,
> +		SIC1_ATR_DEFAULT, 32);
> +	lpc32xx_set_default_mappings(io_p2v(SIC2_BASE), SIC2_APR_DEFAULT,
> +		SIC2_ATR_DEFAULT, 64);
> +
> +	/* mask all interrupts except SUBIRQA and SUBFIQ */
> +	writel((1 << IRQ_SUB1IRQ) | (1 << IRQ_SUB2IRQ) |
> +			(1 << IRQ_SUB1FIQ) | (1 << IRQ_SUB2FIQ),
> +		(io_p2v(MIC_BASE) + INTC_MASK));
> +	writel(0, (io_p2v(SIC1_BASE) + INTC_MASK));
> +	writel(0, (io_p2v(SIC2_BASE) + INTC_MASK));
> +}
> diff --git a/arch/arm/mach-lpc32xx/serial.c  
> b/arch/arm/mach-lpc32xx/serial.c
> new file mode 100644
> index 0000000..1c15121
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/serial.c
> @@ -0,0 +1,200 @@
> +/*
> + * arch/arm/mach-lpc32xx/serial.c
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
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  
> USA
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/serial.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial_reg.h>
> +#include <linux/serial_8250.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/platform.h>
> +#include <mach/io.h>
> +#include "common.h"
> +
> +/* Standard 8250/16550 compatible serial ports */
> +static struct plat_serial8250_port serial_std_platform_data[] = {
> +#ifdef CONFIG_ARCH_LPC32XX_UART5_ENABLE
> +	{
> +		.membase        = (void *) io_p2v(UART5_BASE),
> +		.mapbase        = UART5_BASE,
> +		.irq		= IRQ_UART_IIR5,
> +		.uartclk	= MAIN_OSC_FREQ,
> +		.regshift	= 2,
> +		.iotype		= UPIO_MEM32,
> +		.flags		= UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
> +					UPF_SKIP_TEST,
> +	},
> +#endif
> +#ifdef CONFIG_ARCH_LPC32XX_UART3_ENABLE
> +	{
> +		.membase	= (void *) io_p2v(UART3_BASE),
> +		.mapbase        = UART3_BASE,
> +		.irq		= IRQ_UART_IIR3,
> +		.uartclk	= MAIN_OSC_FREQ,
> +		.regshift	= 2,
> +		.iotype		= UPIO_MEM32,
> +		.flags		= UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
> +					UPF_SKIP_TEST,
> +	},
> +#endif
> +#ifdef CONFIG_ARCH_LPC32XX_UART4_ENABLE
> +	{
> +		.membase	= (void *) io_p2v(UART4_BASE),
> +		.mapbase        = UART4_BASE,
> +		.irq		= IRQ_UART_IIR4,
> +		.uartclk	= MAIN_OSC_FREQ,
> +		.regshift	= 2,
> +		.iotype		= UPIO_MEM32,
> +		.flags		= UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
> +					UPF_SKIP_TEST,
> +	},
> +#endif
> +#ifdef CONFIG_ARCH_LPC32XX_UART6_ENABLE
> +	{
> +		.membase	= (void *) io_p2v(UART6_BASE),
> +		.mapbase        = UART6_BASE,
> +		.irq		= IRQ_UART_IIR6,
> +		.uartclk	= MAIN_OSC_FREQ,
> +		.regshift	= 2,
> +		.iotype		= UPIO_MEM32,
> +		.flags		= UPF_BOOT_AUTOCONF | UPF_BUGGY_UART |
> +					UPF_SKIP_TEST,
> +	},
> +#endif
> +	{ },
> +};
> +
> +struct uartinit {
> +	char *uart_ck_name;
> +	u32 ck_mode_mask;
> +	u32 pdiv_clk_reg;
> +};
> +
> +static struct uartinit uartinit_data[] __initdata = {
> +#ifdef CONFIG_ARCH_LPC32XX_UART5_ENABLE
> +	{
> +		.uart_ck_name = "uart5_ck",
> +		.ck_mode_mask = UART_CLKMODE_LOAD(UART_CLKMODE_ON, 5),
> +		.pdiv_clk_reg = CLKPWR_UART5_CLK_CTRL(CLKPWR_IOBASE),
> +	},
> +#endif
> +#ifdef CONFIG_ARCH_LPC32XX_UART3_ENABLE
> +	{
> +		.uart_ck_name = "uart3_ck",
> +		.ck_mode_mask = UART_CLKMODE_LOAD(UART_CLKMODE_ON, 3),
> +		.pdiv_clk_reg = CLKPWR_UART3_CLK_CTRL(CLKPWR_IOBASE),
> +	},
> +#endif
> +#ifdef CONFIG_ARCH_LPC32XX_UART4_ENABLE
> +	{
> +		.uart_ck_name = "uart4_ck",
> +		.ck_mode_mask = UART_CLKMODE_LOAD(UART_CLKMODE_ON, 4),
> +		.pdiv_clk_reg = CLKPWR_UART4_CLK_CTRL(CLKPWR_IOBASE),
> +	},
> +#endif
> +#ifdef CONFIG_ARCH_LPC32XX_UART6_ENABLE
> +	{
> +		.uart_ck_name = "uart6_ck",
> +		.ck_mode_mask = UART_CLKMODE_LOAD(UART_CLKMODE_ON, 6),
> +		.pdiv_clk_reg = CLKPWR_UART6_CLK_CTRL(CLKPWR_IOBASE),
> +	},
> +#endif
> +};
> +
> +static struct platform_device serial_std_platform_device = {
> +	.name			= "serial8250",
> +	.id			= 0,
> +	.dev			= {
> +		.platform_data	= serial_std_platform_data,
> +	},
> +};
> +
> +static struct platform_device *lpc32xx_serial_devs[] __initdata = {
> +	&serial_std_platform_device,
> +};
> +
> +void __init lpc32xx_serial_init(void)
> +{
> +	u32 tmp, clkmodes = 0;
> +	struct clk *clk;
> +	void *puart;
> +	int i;
> +
> +	/* UART clocks are off, let clock driver manage them */
> +	__raw_writel(0, CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE));
> +
> +	for (i = 0; i < ARRAY_SIZE(uartinit_data); i++) {
> +		clk = clk_get(NULL, uartinit_data[i].uart_ck_name);
> +		if (IS_ERR(clk)) {
> +#ifdef CONFIG_DEBUG_LL
> +			/* A clock get failure can mean the console might
> +			   not work. It's possible this might not even
> +			   work. */
> +			printascii("Serial port clock get failure!\n");
> +#endif
> +		} else {
> +			clk_enable(clk);
> +			serial_std_platform_data[i].uartclk =
> +				clk_get_rate(clk);
> +		}
> +
> +		/* Setup UART clock modes for all UARTs, disable autoclock */
> +		clkmodes |= uartinit_data[i].ck_mode_mask;
> +
> +		/* pre-UART clock divider set to 1 */
> +		writel(0x0101, uartinit_data[i].pdiv_clk_reg);
> +	}
> +
> +	/* This needs to be done after all UART clocks are setup */
> +	writel(clkmodes, UARTCTL_CLKMODE(io_p2v(UART_CTRL_BASE)));
> +	for (i = 0; i < ARRAY_SIZE(uartinit_data) - 1; i++) {
> +		/* Force a flush of the RX FIFOs to work around a HW bug */
> +		puart = serial_std_platform_data[i].membase;
> +		writel(0xC1, UART_IIR_FCR(puart));
> +		writel(0x00, UART_DLL_FIFO(puart));
> +		clkmodes = 64;
> +		while (clkmodes--)
> +			tmp = readl(UART_DLL_FIFO(puart));
> +		writel(0, UART_IIR_FCR(puart));
> +	}
> +
> +	/* IrDA pulsing support on UART6. This only enables the IrDA mux */
> +	tmp = readl(UARTCTL_CTRL(io_p2v(UART_CTRL_BASE)));
> +#ifdef CONFIG_ARCH_LPC32XX_UART6_IRDAMODE
> +	tmp &= ~UART_UART6_IRDAMOD_BYPASS;
> +#else
> +	tmp |= UART_UART6_IRDAMOD_BYPASS;
> +#endif
> +	writel(tmp, UARTCTL_CTRL(io_p2v(UART_CTRL_BASE)));
> +
> +	/* Disable UART5->USB transparent mode or USB won't work */
> +	tmp = readl(UARTCTL_CTRL(io_p2v(UART_CTRL_BASE)));
> +	tmp &= ~UART_U5_ROUTE_TO_USB;
> +	writel(tmp, UARTCTL_CTRL(io_p2v(UART_CTRL_BASE)));
> +
> +	platform_add_devices(lpc32xx_serial_devs,
> +		ARRAY_SIZE(lpc32xx_serial_devs));
> +}
> diff --git a/arch/arm/mach-lpc32xx/timer.c  
> b/arch/arm/mach-lpc32xx/timer.c
> new file mode 100644
> index 0000000..9c06346
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/timer.c
> @@ -0,0 +1,187 @@
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
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  
> USA
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
> +#define TIMER0_IOBASE io_p2v(TIMER0_BASE)
> +#define TIMER1_IOBASE io_p2v(TIMER1_BASE)
> +
> +static cycle_t lpc32xx_clksrc_read(struct clocksource *cs)
> +{
> +	return (cycle_t)readl(TIMER_TC(TIMER1_IOBASE));
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
> +	unsigned long flags;
> +
> +	if (delta < 1)
> +		return -ETIME;
> +
> +	local_irq_save(flags);
> +
> +	writel(TIMER_CNTR_TCR_RESET, TIMER_TCR(TIMER0_IOBASE));
> +	writel(delta, TIMER_PR(TIMER0_IOBASE));
> +	writel(TIMER_CNTR_TCR_EN, TIMER_TCR(TIMER0_IOBASE));
> +
> +	local_irq_restore(flags);
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
> +		writel(0, TIMER_TCR(TIMER0_IOBASE));
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
> +	writel(TIMER_CNTR_MTCH_BIT(0), TIMER_IR(TIMER0_IOBASE));
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
> +	writel(
> +		(CLKPWR_TMRPWMCLK_TIMER0_EN | CLKPWR_TMRPWMCLK_TIMER1_EN),
> +		CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE));
> +
> +	/* The clock driver isn't initialized at this point. So determine if
> +	   the SYSCLK is driven from the PLL397 or main oscillator and then use
> +	   it to compute the PLL frequency and the PCLK divider to get the base
> +	   timer rates. This rate is needed to compute the tick rate. */
> +	if (clk_is_sysclk_mainosc() != 0)
> +		clkrate = MAIN_OSC_FREQ;
> +	else
> +		clkrate = 397 * CLOCK_OSC_FREQ;
> +
> +	/* Get ARM HCLKPLL register and convert it into a frequency*/
> +	pllreg = readl(CLKPWR_HCLKPLL_CTRL(CLKPWR_IOBASE)) & 0x1FFFF;
> +	clkrate = clk_get_pllrate_from_reg(clkrate, pllreg);
> +
> +	/* Get PCLK divider and divide ARM PLL clock by it to get timer rate */
> +	clkrate = clkrate / clk_get_pclk_div();
> +
> +	/* Initial timer setup */
> +	writel(0, TIMER_TCR(TIMER0_IOBASE));
> +	writel(TIMER_CNTR_MTCH_BIT(0), TIMER_IR(TIMER0_IOBASE));
> +	writel(1, TIMER_MR0(TIMER0_IOBASE));
> +	writel(TIMER_CNTR_MCR_MTCH(0) | TIMER_CNTR_MCR_STOP(0) |
> +	    TIMER_CNTR_MCR_RESET(0), TIMER_MCR(TIMER0_IOBASE));
> +
> +	/* Setup tick interrupt */
> +	setup_irq(IRQ_TIMER0, &lpc32xx_timer_irq);
> +
> +	/* Setup the clockevent structure. */
> +	lpc32xx_clkevt.mult = div_sc(clkrate, NSEC_PER_SEC,
> +		lpc32xx_clkevt.shift);
> +	lpc32xx_clkevt.max_delta_ns = clockevent_delta2ns(-1,
> +		&lpc32xx_clkevt);
> +	lpc32xx_clkevt.min_delta_ns = clockevent_delta2ns(1, &lpc32xx_clkevt);
> +	lpc32xx_clkevt.cpumask = cpumask_of(0);
> +	clockevents_register_device(&lpc32xx_clkevt);
> +
> +	/* Use timer1 as clock source. */
> +	writel(TIMER_CNTR_TCR_RESET, TIMER_TCR(TIMER1_IOBASE));
> +	writel(0, TIMER_PR(TIMER1_IOBASE));
> +	writel(0, TIMER_MCR(TIMER1_IOBASE));
> +	writel(TIMER_CNTR_TCR_EN, TIMER_TCR(TIMER1_IOBASE));
> +	lpc32xx_clksrc.mult = clocksource_hz2mult(clkrate,
> +		lpc32xx_clksrc.shift);
> +	clocksource_register(&lpc32xx_clksrc);
> +}
> +
> +struct sys_timer lpc32xx_timer = {
> +	.init		= &lpc32xx_timer_init,
> +};
> +
> -- 
> 1.6.6
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
