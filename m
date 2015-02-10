From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Feb 2015 21:15:25 +0000
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <54DA725E.6080305@codeaurora.org>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
 <54D95DB8.9010308@codeaurora.org>
 <20150210151416.GD9432@leverpostej>
 <54DA6E92.3090109@codeaurora.org> <54DA725E.6080305@codeaurora.org>
Message-ID: <20150210211525.GO8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 10, 2015 at 01:04:30PM -0800, Stephen Boyd wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> Subject: [PATCH] ARM: smp: Only expose /sys/.../cpuX/online if hotpluggable
> 
> Writes to /sys/.../cpuX/online fail if we determine the platform
> doesn't support hotplug for that CPU. Let's figure this out
> befoer we make the sysfs nodes so that the online file doesn't
> even exist if it's not possible to hotplug the CPU.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/include/asm/smp.h |  6 ++++++
>  arch/arm/kernel/setup.c    |  2 +-
>  arch/arm/kernel/smp.c      | 11 ++++-------
>  3 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
> index 18f5a554134f..9f82430efd59 100644
> --- a/arch/arm/include/asm/smp.h
> +++ b/arch/arm/include/asm/smp.h
> @@ -123,4 +123,10 @@ struct of_cpu_method {
>   */
>  extern void smp_set_ops(struct smp_operations *);
>  
> +#ifdef CONFIG_HOTPLUG_CPU
> +extern int platform_can_hotplug_cpu(unsigned int cpu);
> +#else
> +static inline int platform_can_hotplug_cpu(unsigned int cpu) { return 0; }

Please split this across four lines like a normal function.

> +#endif
> +
>  #endif /* ifndef __ASM_ARM_SMP_H */
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 715ae19bc7c8..c61c09defc78 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -974,7 +974,7 @@ static int __init topology_init(void)
>  
>  	for_each_possible_cpu(cpu) {
>  		struct cpuinfo_arm *cpuinfo = &per_cpu(cpu_data, cpu);
> -		cpuinfo->cpu.hotpluggable = 1;
> +		cpuinfo->cpu.hotpluggable = platform_can_hotplug_cpu(cpu);
>  		register_cpu(&cpuinfo->cpu, cpu);
>  	}
>  
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index fe0386c751b2..4d213b24db60 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -174,18 +174,19 @@ static int platform_cpu_kill(unsigned int cpu)
>  	return 1;
>  }
>  
> -static int platform_cpu_disable(unsigned int cpu)
> +int platform_can_hotplug_cpu(unsigned int cpu)
>  {
>  	if (smp_ops.cpu_disable)
> -		return smp_ops.cpu_disable(cpu);
> +		return smp_ops.cpu_disable(cpu) ? 0 : 1;
>  
>  	/*
>  	 * By default, allow disabling all CPUs except the first one,
>  	 * since this is special on a lot of platforms, e.g. because
>  	 * of clock tick interrupts.
>  	 */
> -	return cpu == 0 ? -EPERM : 0;
> +	return cpu == 0 ? 0 : 1;
>  }
> +
>  /*
>   * __cpu_disable runs on the processor to be shutdown.
>   */
> @@ -194,10 +195,6 @@ int __cpu_disable(void)
>  	unsigned int cpu = smp_processor_id();
>  	int ret;
>  
> -	ret = platform_cpu_disable(cpu);
> -	if (ret)
> -		return ret;
> -

I would much rather prefer smp_ops.cpu_disable() to be renamed in this
case - name it smp_ops.cpu_can_disable() so that it's clear that it's
no longer part of the __cpu_disable() path.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
