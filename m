From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 Jan 2012 14:13:13 +0000
Subject: [PATCH] ARM: smp: allow get the core count from L2 control on A15
In-Reply-To: <04be01cce011$6b3b3550$41b19ff0$%kim@samsung.com>
References: <04be01cce011$6b3b3550$41b19ff0$%kim@samsung.com>
Message-ID: <20120131141313.GA31004@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Tue, Jan 31, 2012 at 12:11:10PM +0000, Kukjin Kim wrote:
> 
> Actually, the number of A15 CPU core gets from L2 control
> register not SCU configuration.
> 
> Suggested-by: Changhwan Youn <chaos.youn@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> ---

NAK.

> diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
> index 1e5717a..b67084f 100644
> --- a/arch/arm/include/asm/smp.h
> +++ b/arch/arm/include/asm/smp.h
> @@ -71,6 +71,11 @@ extern void platform_secondary_init(unsigned int cpu);
>  extern void platform_smp_prepare_cpus(unsigned int);
>  
>  /*
> + * Get the number of CPU cores from the L2 control register on A15
> + */
> +extern unsigned long a15_get_core_count(void);
> +
> +/*
>   * Logical CPU mapping.
>   */
>  extern int __cpu_logical_map[NR_CPUS];
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

This doesn't belong in smp.c but, more importantly, this doesn't work for
multi-cluster configurations at all. Since all A15 implementations will be
on new platforms, the code will be device-tree only and so we should use
that to determine the CPU topology as, unfortunately, there is no architected
way of doing this.

I believe Lorenzo posted some patches which you could look at.

Will
