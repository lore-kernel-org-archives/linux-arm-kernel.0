From: horms@verge.net.au (Simon Horman)
Date: Fri, 13 Feb 2015 15:20:04 -0500
Subject: [PATCH v2] ARM: smp: Only expose /sys/.../cpuX/online if
 hotpluggable
In-Reply-To: <1423850799-4028-1-git-send-email-sboyd@codeaurora.org>
References: <1423850799-4028-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150213202002.GB29727@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Feb 13, 2015 at 10:06:39AM -0800, Stephen Boyd wrote:
> Writes to /sys/.../cpuX/online fail if we determine the platform
> doesn't support hotplug for that CPU. Furthermore, if the cpu_die
> op isn't specified the system hangs when we try to offline a CPU
> and it comes right back online unexpectedly. Let's figure this
> stuff out before we make the sysfs nodes so that the online file
> doesn't even exist if it isn't (at least sometimes) possible to
> hotplug the CPU.
> 
> We re-purpose the cpu_disable smp op here and rename it to
> cpu_can_disable because all users use the op to indicate if a CPU
> can be hotplugged or not in a static fashion.  With PSCI we may
> need to reintroduce the cpu_disable op so that the secure OS can
> be migrated off the CPU we're trying to hotplug. We'll need to
> indicate that all CPUs are hotpluggable in that case but this
> shouldn't be any worse than something like x86 where we indicate
> that all CPUs are hotpluggable but occasionally we can't offline
> a CPU due to check_irq_vectors_for_cpu_disable().
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: <linux-sh@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

[snip]

> diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
> index 3923e09e966d..a614cef18db1 100644
> --- a/arch/arm/mach-shmobile/platsmp.c
> +++ b/arch/arm/mach-shmobile/platsmp.c
> @@ -31,8 +31,8 @@ void shmobile_smp_hook(unsigned int cpu, unsigned long fn, unsigned long arg)
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> -int shmobile_smp_cpu_disable(unsigned int cpu)
> +int shmobile_smp_cpu_can_disable(unsigned int cpu)
>  {
> -	return 0; /* Hotplug of any CPU is supported */
> +	return 1; /* Hotplug of any CPU is supported */
>  }
>  #endif
> diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
> index 3f761f839043..b45206f93ddf 100644
> --- a/arch/arm/mach-shmobile/smp-r8a7779.c
> +++ b/arch/arm/mach-shmobile/smp-r8a7779.c
> @@ -124,19 +124,12 @@ static int r8a7779_cpu_kill(unsigned int cpu)
>  
>  	return 0;
>  }
> -
> -static int r8a7779_cpu_disable(unsigned int cpu)
> -{
> -	/* only CPU1->3 have power domains, do not allow hotplug of CPU0 */
> -	return cpu == 0 ? -EPERM : 0;
> -}
>  #endif /* CONFIG_HOTPLUG_CPU */
>  
>  struct smp_operations r8a7779_smp_ops  __initdata = {
>  	.smp_prepare_cpus	= r8a7779_smp_prepare_cpus,
>  	.smp_boot_secondary	= r8a7779_boot_secondary,
>  #ifdef CONFIG_HOTPLUG_CPU
> -	.cpu_disable		= r8a7779_cpu_disable,
>  	.cpu_die		= shmobile_smp_scu_cpu_die,
>  	.cpu_kill		= r8a7779_cpu_kill,
>  #endif

Its not clear to me why r8a7779_cpu_disable() has been
removed rather than replaced by r8a7779_cpu_can_disable()
