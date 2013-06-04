From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 4 Jun 2013 12:19:49 +0100
Subject: [PATCH] ARM: psci: fix building without HOTPLUG_CPU
In-Reply-To: <18058683.rI3Z0PFpBd@wuerfel>
References: <18058683.rI3Z0PFpBd@wuerfel>
Message-ID: <alpine.DEB.2.02.1306041218200.4589@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jun 2013, Arnd Bergmann wrote:
> The cpu_die field in smp_operations is not valid with CONFIG_HOTPLUG_CPU,
> so we must enclose it in #ifdef, but at least that lets us remove
> two other lines.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>

Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


> KernelVersion: devel-stable
> 
> diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
> index 23a1142..219f1d7 100644
> --- a/arch/arm/kernel/psci_smp.c
> +++ b/arch/arm/kernel/psci_smp.c
> @@ -68,8 +68,6 @@ void __ref psci_cpu_die(unsigned int cpu)
>         /* We should never return */
>         panic("psci: cpu %d failed to shutdown\n", cpu);
>  }
> -#else
> -#define psci_cpu_die NULL
>  #endif
>  
>  bool __init psci_smp_available(void)
> @@ -80,5 +78,7 @@ bool __init psci_smp_available(void)
>  
>  struct smp_operations __initdata psci_smp_ops = {
>  	.smp_boot_secondary	= psci_boot_secondary,
> +#ifdef CONFIG_HOTPLUG_CPU
>  	.cpu_die		= psci_cpu_die,
> +#endif
>  };
> 
