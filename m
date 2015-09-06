From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 6 Sep 2015 13:01:00 +0800
Subject: [PATCH V3] ARM: imx: add cpuidle support for i.mx6ul
In-Reply-To: <1438880182-6260-1-git-send-email-b20788@freescale.com>
References: <1438880182-6260-1-git-send-email-b20788@freescale.com>
Message-ID: <20150906050100.GF30746@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 07, 2015 at 12:56:22AM +0800, Anson Huang wrote:
> This patch adds cpuidle support for i.MX6UL,
> it shares cpuidle driver with i.MX6SX, total
> 3 levels of cpuidle are supported as below:
> 
> 1. ARM WFI;
> 2. SOC in WAIT mode;
> 3. SOC in WAIT mode + ARM power off.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
> I am NOT sure if using cpu_is_xxx() here to distinguish i.MX6UL
> from i.MX6SX is good enough, as I saw many other patches
> are trying to avoid using such cpu_is_xxx() API.

Right, the use of cpu_is_xxx() should be avoid where possible.

> 
> Obviously we have many other ways to identify if the ARM core
> is a Cortex-A9 or Cortex-A7, they have different L2 cache implemented,
> so cache operation is different.
> 
> Please advise if you have better idea about this point, thanks!

We can have a variable to be initialized per different SoC type, which
in turn can be figured out from device tree with
of_machine_is_compatible().

Shawn

> 
>  arch/arm/mach-imx/cpuidle-imx6sx.c | 8 +++++++-

We will need the following additional line in
arch/arm/mach-imx/Makefile, right?

obj-$(CONFIG_SOC_IMX6UL) += cpuidle-imx6sx.o

Shawn

>  arch/arm/mach-imx/mach-imx6ul.c    | 9 +++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle-imx6sx.c
> index 3c6672b..e1ce40c 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6sx.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (C) 2014 Freescale Semiconductor, Inc.
> + * Copyright (C) 2014-2015 Freescale Semiconductor, Inc.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -9,14 +9,20 @@
>  #include <linux/cpuidle.h>
>  #include <linux/cpu_pm.h>
>  #include <linux/module.h>
> +#include <asm/cacheflush.h>
>  #include <asm/cpuidle.h>
>  #include <asm/suspend.h>
>  
>  #include "common.h"
>  #include "cpuidle.h"
> +#include "hardware.h"
>  
>  static int imx6sx_idle_finish(unsigned long val)
>  {
> +	/* flush internal L2 cache if necessary */
> +	if (cpu_is_imx6ul())
> +		flush_cache_all();
> +
>  	cpu_do_idle();
>  
>  	return 0;
> diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
> index f206506..3fe37ab 100644
> --- a/arch/arm/mach-imx/mach-imx6ul.c
> +++ b/arch/arm/mach-imx/mach-imx6ul.c
> @@ -11,6 +11,7 @@
>  #include <asm/mach/map.h>
>  
>  #include "common.h"
> +#include "cpuidle.h"
>  
>  static void __init imx6ul_init_machine(void)
>  {
> @@ -29,6 +30,13 @@ static void __init imx6ul_init_irq(void)
>  	imx_init_revision_from_anatop();
>  	imx_src_init();
>  	irqchip_init();
> +	imx6_pm_ccm_init("fsl,imx6ul-ccm");
> +}
> +
> +static void __init imx6ul_init_late(void)
> +{
> +	/* share cpuidle driver with i.MX6SX */
> +	imx6sx_cpuidle_init();
>  }
>  
>  static const char *imx6ul_dt_compat[] __initconst = {
> @@ -40,4 +48,5 @@ DT_MACHINE_START(IMX6UL, "Freescale i.MX6 Ultralite (Device Tree)")
>  	.init_irq	= imx6ul_init_irq,
>  	.init_machine	= imx6ul_init_machine,
>  	.dt_compat	= imx6ul_dt_compat,
> +	.init_late	= imx6ul_init_late,
>  MACHINE_END
> -- 
> 1.9.1
> 
