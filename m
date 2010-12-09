From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Thu, 9 Dec 2010 17:47:22 +0100
Subject: [PATCH v3 07/15] ARM: mxs: Add gpio support
In-Reply-To: <1291907569-8925-7-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291907569-8925-7-git-send-email-shawn.guo@freescale.com>
Message-ID: <19713.2074.562086.117710@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> MXS-based SoCs implement gpio support in block PINCTRL.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changes for v3:
>  - include/mach/gpio.h: remove the inclusion of hardware.h
>  - gpio.c: change inclusion of hardware.h to mx23.h plus mx28.h
>  - Remove spinlock totally since SET/CLE can be used in all the
>    gpio register access
> 
> Changes for v2:
>  - Create arch/arm/mach-mxs/gpio.h to accommodate stuff private for mach-mxs
>  - Use GPIO_INT_LEV_MASK and GPIO_INT_POL_MASK instead of constant
>  - Remove both edges IRQ support which is not needed
>  - Use SET and CLR register of PINCTRL_DOE in _set_gpio_direction()
>  - Use pr_info over printk(KERN_INFO)
> 
>  arch/arm/mach-mxs/gpio.c              |  321 +++++++++++++++++++++++++++++++++
>  arch/arm/mach-mxs/gpio.h              |   33 ++++
>  arch/arm/mach-mxs/include/mach/gpio.h |   34 ++++
>  3 files changed, 388 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/gpio.c
>  create mode 100644 arch/arm/mach-mxs/gpio.h
>  create mode 100644 arch/arm/mach-mxs/include/mach/gpio.h
> 
> diff --git a/arch/arm/mach-mxs/gpio.c b/arch/arm/mach-mxs/gpio.c
> new file mode 100644
> index 0000000..d88acf3
> --- /dev/null
> +++ b/arch/arm/mach-mxs/gpio.c
> @@ -0,0 +1,321 @@
> +/*
> + * MXC GPIO support. (c) 2008 Daniel Mack <daniel@caiaq.de>
> + * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
> + *
> + * Based on code from Freescale,
> + * Copyright (C) 2004-2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/gpio.h>
> +#include <mach/mx23.h>
> +#include <mach/mx28.h>
> +#include <asm-generic/bug.h>
> +
> +#include "gpio.h"
> +
> +static struct mxs_gpio_port *mxs_gpio_ports;
> +static int gpio_table_size;
> +
> +#define PINCTRL_DOUT(n)		((cpu_is_mx23() ? 0x0500 : 0x0700) + (n) * 0x10)
> +#define PINCTRL_DIN(n)		((cpu_is_mx23() ? 0x0600 : 0x0900) + (n) * 0x10)
> +#define PINCTRL_DOE(n)		((cpu_is_mx23() ? 0x0700 : 0x0b00) + (n) * 0x10)
> +#define PINCTRL_PIN2IRQ(n)	((cpu_is_mx23() ? 0x0800 : 0x1000) + (n) * 0x10)
> +#define PINCTRL_IRQEN(n)	((cpu_is_mx23() ? 0x0900 : 0x1100) + (n) * 0x10)
> +#define PINCTRL_IRQLEV(n)	((cpu_is_mx23() ? 0x0a00 : 0x1200) + (n) * 0x10)
> +#define PINCTRL_IRQPOL(n)	((cpu_is_mx23() ? 0x0b00 : 0x1300) + (n) * 0x10)
> +#define PINCTRL_IRQSTAT(n)	((cpu_is_mx23() ? 0x0c00 : 0x1400) + (n) * 0x10)
> +
> +#define GPIO_INT_FALL_EDGE	0x0
> +#define GPIO_INT_LOW_LEV	0x1
> +#define GPIO_INT_RISE_EDGE	0x2
> +#define GPIO_INT_HIGH_LEV	0x3
> +#define GPIO_INT_LEV_MASK	(1 << 0)
> +#define GPIO_INT_POL_MASK	(1 << 1)
> +
> +/* Note: This driver assumes 32 GPIOs are handled in one register */
> +
> +static void _clear_gpio_irqstatus(struct mxs_gpio_port *port, u32 index)
> +{
> +	__raw_writel(1 << index,
> +			port->base + PINCTRL_IRQSTAT(port->id) + MXS_CLR_ADDR);
> +}
> +
> +static void _set_gpio_irqenable(struct mxs_gpio_port *port, u32 index,
> +				int enable)
> +{
> +	if (enable == 0) {
> +		__raw_writel(1 << index,
> +			port->base + PINCTRL_PIN2IRQ(port->id) + MXS_CLR_ADDR);
> +		__raw_writel(1 << index,
> +			port->base + PINCTRL_IRQEN(port->id) + MXS_CLR_ADDR);
This will loose interrupt pulses that happen while IRQs are disabled.
IMO PIN2IRQ should only be cleared when an IRQ is freed, not when it
is disabled.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
