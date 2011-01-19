From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Jan 2011 11:39:09 -0000
Subject: [PATCH] RFC: ux500: add PMU resources
In-Reply-To: <1295391579-9166-1-git-send-email-linus.walleij@stericsson.com>
References: <1295391579-9166-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <000001cbb7cd$7cb9c840$762d58c0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

> The ux500 SoCs have PMUs, both DB8500 and DB5500. However on the
> DB8500 the individual per-core IRQs are not routed: instead they
> are OR:ed into one single IRQ.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> Hi Will especially, I remember discussing this issue with you
> back in Florida. IIRC you had some idea on how to go about with
> this, like we add some tweak for this board where we don't set
> affinity and let the IRQ be declared chained and then each CPU
> it's not coming from has to NACK it, do you think it is
> feasible and could you sort of point me into the right files
> to poke at?

Ah yes, I have some hazy memories of this conversation! I think you
have three options:

1.) Don't use the PMU interrupt and instead use a timer which is
    guaranteed to fire before we overflow. sh has this restriction
    because its PMU doesn't have an IRQ line at all. There's a comment 
    in arch/sh/kernel/perf_event.c:

	/*
	 * All of the on-chip counters are "limited", in that they have
	 * no interrupts, and are therefore unable to do sampling without
	 * further work and timer assistance.
	 */
	if (hwc->sample_period)
		return -EINVAL;
     
    
    but it might be worth asking if they have any preliminary code for
    this.

2.) Use IPI to cross-call the IRQ handler when the interrupted CPU doesn't
    have an interrupt asserted on its PMU. You'll need to sort out problems
    with re-enabling interrupts for the cross-call and also nesting of the
    PMU interrupt (because it could fire as a result of another PMU overflowing
    before you've completed the cross-call).

3.) Rework the GIC code so that an IRQ can target multiple CPUs and remove the
    distributor-level masking. I think this was originally done so that we can
    service different IRQs simultaneously, but with the deprecation of IRQF_DISABLED
    I'm not sure if this is still an issue. If not, then we can change to masking
    at the CPU interfaces which will make supporting your combined IRQ much easier.
    You'll need to talk to Russell about this as he has a better idea about the
    current approach that Linux takes than I do.

>  arch/arm/mach-ux500/cpu-db5500.c |   26 ++++++++++++++++++++++++--
>  arch/arm/mach-ux500/cpu-db8500.c |   28 ++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-ux500/cpu-db5500.c b/arch/arm/mach-ux500/cpu-db5500.c
> index af04e08..3912354 100644
> --- a/arch/arm/mach-ux500/cpu-db5500.c
> +++ b/arch/arm/mach-ux500/cpu-db5500.c
> @@ -11,6 +11,7 @@
>  #include <linux/irq.h>
> 
>  #include <asm/mach/map.h>
> +#include <asm/pmu.h>
> 
>  #include <plat/gpio.h>
> 
> @@ -43,6 +44,26 @@ static struct map_desc u5500_io_desc[] __initdata = {
>  	__IO_DEV_DESC(U5500_PRCMU_BASE, SZ_4K),
>  };
> 
> +static struct resource db5500_pmu_resources[] = {
> +	[0] = {
> +		.start		= IRQ_DB5500_PMU0,
> +		.end		= IRQ_DB5500_PMU0,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +	[1] = {
> +		.start		= IRQ_DB5500_PMU1,
> +		.end		= IRQ_DB5500_PMU1,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device db5500_pmu_device = {
> +	.name			= "arm-pmu",
> +	.id			= ARM_PMU_DEVICE_CPU,
> +	.num_resources		= ARRAY_SIZE(db5500_pmu_resources),
> +	.resource		= db5500_pmu_resources,
> +};
> +
>  static struct resource mbox0_resources[] = {
>  	{
>  		.name = "mbox_peer",
> @@ -127,7 +148,8 @@ static struct platform_device mbox2_device = {
>  	.num_resources = ARRAY_SIZE(mbox2_resources),
>  };
> 
> -static struct platform_device *u5500_platform_devs[] __initdata = {
> +static struct platform_device *db5500_platform_devs[] __initdata = {
> +	&db5500_pmu_device,
>  	&mbox0_device,
>  	&mbox1_device,
>  	&mbox2_device,
> @@ -172,6 +194,6 @@ void __init u5500_init_devices(void)
>  	db5500_dma_init();
>  	db5500_add_rtc();
> 
> -	platform_add_devices(u5500_platform_devs,
> +	platform_add_devices(db5500_platform_devs,
>  			     ARRAY_SIZE(u5500_platform_devs));
>  }

For the db5500 stuff:

Acked-by: Will Deacon <will.deacon@arm.com>

The db8500 code obviously won't work yet!

Will
