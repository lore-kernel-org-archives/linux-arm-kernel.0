From: ben@trinity.fluff.org (Ben Dooks)
Date: Thu, 13 May 2010 01:30:56 +0100
Subject: [PATCH v2] ARM: S5PV210: Add S5PV210 GPIO support.
In-Reply-To: <1273659531-6151-1-git-send-email-kgene.kim@samsung.com>
References: <1273659531-6151-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100513003056.GL6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 12, 2010 at 07:18:51PM +0900, Kukjin Kim wrote:
> From: Pannaga Bhushan <p.bhushan@samsung.com>
> 
> This patch adds GPIOlib support for S5PV210.
> 
> Signed-off-by: Pannaga Bhushan <p.bhushan@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s5pv210/Makefile            |    2 +-
>  arch/arm/mach-s5pv210/gpio.c              |  259 +++++++++++++++++++++++++++++
>  arch/arm/mach-s5pv210/include/mach/gpio.h |   18 ++-
>  3 files changed, 275 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv210/gpio.c
> 
> diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
> index 8ebf51c..cb1553c 100644
> --- a/arch/arm/mach-s5pv210/Makefile
> +++ b/arch/arm/mach-s5pv210/Makefile
> @@ -12,7 +12,7 @@ obj-				:=
>  
>  # Core support for S5PV210 system
>  
> -obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o
> +obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o gpio.o
>  
>  # machine support
>  
> diff --git a/arch/arm/mach-s5pv210/gpio.c b/arch/arm/mach-s5pv210/gpio.c
> new file mode 100644
> index 0000000..8196bd2
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/gpio.c
> @@ -0,0 +1,259 @@
> +/* linux/arch/arm/mach-s5pv210/gpio.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5PV210 - GPIOlib support
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
> +#include <plat/gpio-core.h>
> +#include <plat/gpio-cfg.h>
> +#include <plat/gpio-cfg-helpers.h>
> +
> +static struct s3c_gpio_cfg gpio_cfg = {
> +	.cfg_eint	= 0xf,
> +	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
> +	.set_pull	= s3c_gpio_setpull_updown,
> +	.get_pull	= s3c_gpio_getpull_updown,
> +};
