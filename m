From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 4 Sep 2012 08:46:21 +0000
Subject: [PATCH 7/9] ARM: OMAP2+: Prepare for irqs.h removal
In-Reply-To: <20120831005237.28732.96766.stgit@muffinssi.local>
References: <20120831004828.28732.902.stgit@muffinssi.local>
 <20120831005237.28732.96766.stgit@muffinssi.local>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9DC9F4@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Fri, Aug 31, 2012 at 06:22:37, Tony Lindgren wrote:
> As the interrupts should only be defined in the platform_data, and
> eventually coming from device tree, there's no need to define them
> in header files.
> 
> Let's remove the hardcoded references to irqs.h and fix up the includes
> so we don't rely on headers included in irqs.h. While at it, sort
> the includes the standard way.

>  arch/arm/mach-omap2/gpmc.c                         |   11 +++++---

> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c

>  /* GPMC register offsets */
>  #define GPMC_REVISION		0x00
>  #define GPMC_SYSCONFIG		0x10
> @@ -846,16 +849,16 @@ static int __init gpmc_init(void)
>  			l = OMAP2420_GPMC_BASE;
>  		else
>  			l = OMAP34XX_GPMC_BASE;
> -		gpmc_irq = INT_34XX_GPMC_IRQ;
> +		gpmc_irq = 20;
>  	} else if (cpu_is_omap34xx()) {
>  		ck = "gpmc_fck";
>  		l = OMAP34XX_GPMC_BASE;
> -		gpmc_irq = INT_34XX_GPMC_IRQ;
> +		gpmc_irq = 20;
>  	} else if (cpu_is_omap44xx() || soc_is_omap54xx()) {
>  		/* Base address and irq number are same for OMAP4/5 */
>  		ck = "gpmc_ck";
>  		l = OMAP44XX_GPMC_BASE;
> -		gpmc_irq = OMAP44XX_IRQ_GPMC;
> +		gpmc_irq = 20 + OMAP44XX_IRQ_GIC_START;

I have a suggestion to avoid above hardcoded patching on gpmc.c.
With driver conversion series it again would have to be patched.


I have made a basic gpmc driver conversion, which is expected to
be non-controversial. This was done over your devel-gpmc branch.
It is working fine, has only 3 patches

1. Add hwmod entry
2. Adapt to hwmod
3. Basic driver conversion

Here the basic driver gets resources and clk in driver probe
using con-id "fck", it has no platform data as of now

It is available
@git://gitorious.org/x0148406-public/linux-kernel.git gpmc-simple-drv


Originally this was made on top of my series,
"OMAP-GPMC: generic time calc, prepare for driver"
It was modified so that it can be applied to your devel-gpmc branch.

*I am not sending the patches now to avoid confusion by way of having
too many patch series*

In case you like this, let me know, I will post.

As I am proceeding with Paul's suggestion on hwmod reset,
I hope Paul can take the first one.

Regards
Afzal
