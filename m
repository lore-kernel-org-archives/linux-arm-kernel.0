From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 19 May 2015 16:36:32 -0400 (EDT)
Subject: [PATCH] ARM: hisi: fix hip04 build without HOTPLUG_CPU
In-Reply-To: <5060758.bQYeG67z55@wuerfel>
References: <5060758.bQYeG67z55@wuerfel>
Message-ID: <alpine.LFD.2.11.1505191635450.4843@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 May 2015, Arnd Bergmann wrote:

> The hip04 smp implementation provides the hotplug operations (cpu_die
> and cpu_kill) unconditionally at the moment, which leads to a build
> error when HOTPLUG_CPU is disabled:
> 
> mach-hisi/platmcpm.c:242:13: note: (near initialization for 'hip04_smp_ops')
> mach-hisi/platmcpm.c:242:2: error: unknown field 'cpu_die' specified in initializer
> mach-hisi/platmcpm.c:243:2: error: unknown field 'cpu_kill' specified in initializer
> 
> This uses an #ifdef to remove the code from the build when that
> option is not set.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 905cdf9dda5d ("ARM: hisi/hip04: remove the MCPM overhead")

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
> The patch causing this is currently part of rmk's devel-stable branch.
> 
> diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
> index 880cbfa9c343..b5f8f5ffda79 100644
> --- a/arch/arm/mach-hisi/platmcpm.c
> +++ b/arch/arm/mach-hisi/platmcpm.c
> @@ -152,6 +152,7 @@ out:
>  	return 0;
>  }
>  
> +#ifdef CONFIG_HOTPLUG_CPU
>  static void hip04_cpu_die(unsigned int l_cpu)
>  {
>  	unsigned int mpidr, cpu, cluster;
> @@ -236,11 +237,14 @@ err:
>  	spin_unlock_irq(&boot_lock);
>  	return 0;
>  }
> +#endif
>  
>  static struct smp_operations __initdata hip04_smp_ops = {
>  	.smp_boot_secondary	= hip04_boot_secondary,
> +#ifdef CONFIG_HOTPLUG_CPU
>  	.cpu_die		= hip04_cpu_die,
>  	.cpu_kill		= hip04_cpu_kill,
> +#endif
>  };
>  
>  static bool __init hip04_cpu_table_init(void)
> 
> 
