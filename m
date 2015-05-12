From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 May 2015 00:23:22 +0100
Subject: [PATCH] ARM: berlin: add CPU hotplug support
In-Reply-To: <1431440186-14075-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1431440186-14075-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20150512232322.GR2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 04:16:26PM +0200, Antoine Tenart wrote:
> Adds CPU hotplug support for Berlin SoCs (currently BG2 and BG2Q). The
> CPUs are put in WFI after disabling the coherency.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  arch/arm/mach-berlin/platsmp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/mach-berlin/platsmp.c b/arch/arm/mach-berlin/platsmp.c
> index 702e7982015a..d9c62057be76 100644
> --- a/arch/arm/mach-berlin/platsmp.c
> +++ b/arch/arm/mach-berlin/platsmp.c
> @@ -14,6 +14,7 @@
>  #include <linux/of_address.h>
>  
>  #include <asm/cacheflush.h>
> +#include <asm/cp15.h>

I don't see anything being added by this patch which would need this
include.

>  #include <asm/smp_plat.h>
>  #include <asm/smp_scu.h>
>  
> @@ -92,8 +93,20 @@ unmap_scu:
>  	iounmap(scu_base);
>  }
>  
> +#ifdef CONFIG_HOTPLUG_CPU
> +static void berlin_cpu_die(unsigned int cpu)
> +{
> +	v7_exit_coherency_flush(louis);
> +	while (1)
> +		cpu_do_idle();
> +}
> +#endif
> +
>  static struct smp_operations berlin_smp_ops __initdata = {
>  	.smp_prepare_cpus	= berlin_smp_prepare_cpus,
>  	.smp_boot_secondary	= berlin_boot_secondary,
> +#ifdef CONFIG_HOTPLUG_CPU
> +	.cpu_die		= berlin_cpu_die,
> +#endif
>  };
>  CPU_METHOD_OF_DECLARE(berlin_smp, "marvell,berlin-smp", &berlin_smp_ops);
> -- 
> 2.4.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
