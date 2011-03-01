From: balbi@ti.com (Felipe Balbi)
Date: Tue, 1 Mar 2011 19:12:00 +0200
Subject: [patch v1 3/3] arm: omap4: support pmu
In-Reply-To: <1298998711-8165-4-git-send-email-tom.leiming@gmail.com>
References: <1298998711-8165-1-git-send-email-tom.leiming@gmail.com>
	<1298998711-8165-4-git-send-email-tom.leiming@gmail.com>
Message-ID: <20110301171200.GC2488@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2011 at 12:58:31AM +0800, tom.leiming at gmail.com wrote:
> From: Ming Lei <tom.leiming@gmail.com>
> 
> This patch supports pmu irq routed from CTI, so
> make pmu/perf working on OMAP4.
> 
> The idea is from Woodruff Richard in the disscussion
> "Oprofile on Pandaboard / Omap4" of pandaboard at googlegroups.com.
> 
> Cc: Woodruff Richard <r-woodruff2@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap at vger.kernel.org
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  arch/arm/mach-omap2/dbg44xx.h |   18 +++++++++++++
>  arch/arm/mach-omap2/devices.c |   55 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 72 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/dbg44xx.h
> 
> diff --git a/arch/arm/mach-omap2/dbg44xx.h b/arch/arm/mach-omap2/dbg44xx.h
> new file mode 100644
> index 0000000..e447ad5
> --- /dev/null
> +++ b/arch/arm/mach-omap2/dbg44xx.h
> @@ -0,0 +1,18 @@
> +/*
> + * OMAP44xx on-chip debug support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * XXX This file needs to be updated to align on one of "OMAP4", "OMAP44XX",
> + *     or "OMAP4430".
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_DBG44XX_H
> +#define __ARCH_ARM_MACH_OMAP2_DBG44XX_H
> +
> +#define OMAP44XX_CTI0_BASE		0x54148000
> +#define OMAP44XX_CTI1_BASE		0x54149000
> +
> +#endif
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index d216976..0420a58 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -35,6 +35,7 @@
>  
>  #include "mux.h"
>  #include "control.h"
> +#include "dbg44xx.h"
>  
>  #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
>  
> @@ -322,19 +323,71 @@ static struct resource omap3_pmu_resource = {
>  	.flags	= IORESOURCE_IRQ,
>  };
>  
> +static struct resource omap4_pmu_resource[] = {
> +	{
> +	.start	= OMAP44XX_IRQ_CTI0,
> +	.end	= OMAP44XX_IRQ_CTI0,
> +	.flags	= IORESOURCE_IRQ,
> +	},
> +	{
> +	.start	= OMAP44XX_IRQ_CTI1,
> +	.end	= OMAP44XX_IRQ_CTI1,
> +	.flags	= IORESOURCE_IRQ,
> +	}
> +};

indentation is wrong.

>  static void omap_init_pmu(void)
>  {
>  	if (cpu_is_omap24xx())
>  		omap_pmu_device.resource = &omap2_pmu_resource;
>  	else if (cpu_is_omap34xx())
>  		omap_pmu_device.resource = &omap3_pmu_resource;

missing add braces to these two.

-- 
balbi
