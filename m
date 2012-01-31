From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jan 2012 18:03:47 +0000
Subject: [PATCH] ARM: smp: allow get the core count from L2 control on A15
In-Reply-To: <04be01cce011$6b3b3550$41b19ff0$%kim@samsung.com>
References: <04be01cce011$6b3b3550$41b19ff0$%kim@samsung.com>
Message-ID: <20120131180347.GB8338@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 09:11:10PM +0900, Kukjin Kim wrote:
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 57db122..be4d31d 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -233,6 +233,22 @@ void __ref cpu_die(void)
>  }
>  #endif /* CONFIG_HOTPLUG_CPU */
>  
> +/*
> + * Get the number of CPU cores from the L2 control register on A15
> + */
> +unsigned long a15_get_core_count(void)
> +{
> +	unsigned long val;
> +
> +	/* Read L2 control register */
> +	asm volatile("mrc p15, 1, %0, c9, c0, 2" : "=r"(val));
> +
> +	/* [25:24] of L2 control register means core count - 1 */
> +	val = ((val >> 24) & 0x3) + 1;
> +
> +	return val;
> +}
> +

This is *definitely* the wrong place for this.  Do we have the reading
of the number of cores from the SCU in smp.c ?  No.  Do we want to litter
smp.c with each architecture revisions own way of reading this information?
No.

Keep this kind of crap out of the main smp.c file please.  It contains
zero CPU and platform specifics and should stay that way.
