From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 6 Jun 2011 01:42:42 -0600
Subject: [PATCH v4 3/3] gpio/mxs: Remove the use of gpio-mxs.h
In-Reply-To: <1307289545-6993-4-git-send-email-shawn.guo@linaro.org>
References: <1307289545-6993-1-git-send-email-shawn.guo@linaro.org>
	<1307289545-6993-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110606074242.GA10410@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 05, 2011 at 11:59:05PM +0800, Shawn Guo wrote:
> The patch moves "struct mxs_gpio_port" into gpio-mxs.c, as it needs
> not to be public at all.  And then the header
> arch/arm/mach-mxs/include/mach/gpio-mxs.h can be deleted.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-mxs/include/mach/gpio-mxs.h |   34 -----------------------------
>  drivers/gpio/gpio-mxs.c                   |   10 +++++++-
>  2 files changed, 9 insertions(+), 35 deletions(-)
>  delete mode 100644 arch/arm/mach-mxs/include/mach/gpio-mxs.h

$ git grep mach/gpio-mxs.h
arch/arm/mach-mxs/mach-mx28evk.c:#include <mach/gpio-mxs.h>

You missed removing an include.  I fixed it up.  In fact, now that I
see that mach-mx28evk.h doesn't actually use anything in that file,
I've squashed patch 1 & 3 together.

Applied, thanks.

g.

> 
> diff --git a/arch/arm/mach-mxs/include/mach/gpio-mxs.h b/arch/arm/mach-mxs/include/mach/gpio-mxs.h
> deleted file mode 100644
> index 005bb06..0000000
> --- a/arch/arm/mach-mxs/include/mach/gpio-mxs.h
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -/*
> - * Copyright 2007 Freescale Semiconductor, Inc. All Rights Reserved.
> - * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version 2
> - * of the License, or (at your option) any later version.
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> - * MA  02110-1301, USA.
> - */
> -
> -#ifndef __MXS_GPIO_H__
> -#define __MXS_GPIO_H__
> -
> -struct mxs_gpio_port {
> -	void __iomem *base;
> -	int id;
> -	int irq;
> -	int irq_high;
> -	int virtual_irq_start;
> -	struct gpio_chip chip;
> -};
> -
> -int mxs_gpio_init(struct mxs_gpio_port*, int);
> -
> -#endif /* __MXS_GPIO_H__ */
> diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
> index 6fd9f01..a287614 100644
> --- a/drivers/gpio/gpio-mxs.c
> +++ b/drivers/gpio/gpio-mxs.c
> @@ -28,7 +28,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <mach/mxs.h>
> -#include <mach/gpio-mxs.h>
>  
>  #define MXS_SET		0x4
>  #define MXS_CLR		0x8
> @@ -49,6 +48,15 @@
>  #define GPIO_INT_LEV_MASK	(1 << 0)
>  #define GPIO_INT_POL_MASK	(1 << 1)
>  
> +struct mxs_gpio_port {
> +	void __iomem *base;
> +	int id;
> +	int irq;
> +	int irq_high;
> +	int virtual_irq_start;
> +	struct gpio_chip chip;
> +};
> +
>  /* Note: This driver assumes 32 GPIOs are handled in one register */
>  
>  static void clear_gpio_irqstatus(struct mxs_gpio_port *port, u32 index)
> -- 
> 1.7.4.1
> 
