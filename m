From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Apr 2014 13:10:41 +0200
Subject: [PATCH v2 07/12] ARM: hisi: add hip04 SoC support
In-Reply-To: <1396944052-9887-8-git-send-email-haojian.zhuang@linaro.org>
References: <1396944052-9887-1-git-send-email-haojian.zhuang@linaro.org>
 <1396944052-9887-8-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <4584675.BJyVXFoGau@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 April 2014 16:00:47 Haojian Zhuang wrote:
> diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
> index 741faf3..10a605f 100644
> --- a/arch/arm/mach-hisi/hisilicon.c
> +++ b/arch/arm/mach-hisi/hisilicon.c
> @@ -14,6 +14,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/clocksource.h>
>  #include <linux/irqchip.h>
> +#include <linux/memblock.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  
> @@ -88,3 +89,21 @@ DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
>  	.smp		= smp_ops(hi3xxx_smp_ops),
>  	.restart	= hi3xxx_restart,
>  MACHINE_END
> +
> +static const char *hip04_compat[] __initconst = {
> +	"hisilicon,hip04-d01",
> +	NULL,
> +};
> +
> +static void __init hip04_reserve(void)
> +{
> +	memblock_reserve(HIP04_BOOTWRAPPER_PHYS, HIP04_BOOTWRAPPER_SIZE);
> +}

Can you explain why you do this? Shouldn't that memory just be listed
in the DT?

> +DT_MACHINE_START(HIP04, "Hisilicon HiP04 (Flattened Device Tree)")
> +	.dt_compat	= hip04_compat,
> +#ifdef CONFIG_MCPM
> +	.smp_init	= smp_init_ops(hip04_smp_init_ops),
> +#endif
> +	.reserve	= hip04_reserve,
> +MACHINE_END

I think the #ifdef is not needed here, you already hide hip04_smp_init_ops
if CONFIG_SMP is disabled, and SMP implies MCPM based on your Kconfig.

> diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
> index 471f1ee..3a5833f 100644
> --- a/arch/arm/mach-hisi/platsmp.c
> +++ b/arch/arm/mach-hisi/platsmp.c


>  };
> +
> +#ifdef CONFIG_MCPM
> +/* bits definition in SC_CPU_RESET_REQ[x]/SC_CPU_RESET_DREQ[x]
> + * 1 -- unreset; 0 -- reset
> + */
> ...

It would seem appropriate to put all of this into a separate
source file -- there is no shared code between the two SMP
implementations.

> +static int __init hip04_mcpm_init(void)
> +{
> +	struct device_node *np;
> +	int ret = -ENODEV;
> +
> +	np = of_find_compatible_node(NULL, NULL, "hisilicon,hip04-mcpm");
> +	if (!np) {
> +		pr_err("failed to find hisilicon,hip04-mcpm node\n");
> +		goto err;
> +	}

This shouldn't be a fatal error: if you run the kernel on a platform
other than hip04, the code will still be executed here but it won't
find the node and should just ignore the device silently.

> +	relocation = of_iomap(np, 0);
> +	if (!relocation) {
> +		pr_err("failed to get relocation space\n");
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	sysctrl = of_iomap(np, 1);
> +	if (!sysctrl) {
> +		pr_err("failed to get sysctrl base\n");
> +		ret = -ENOMEM;
> +		goto err_sysctrl;
> +	}

sysctrl sounds like a shared device that you probably don't want
to map here, but rather use a "syscon" node.

> +}
> +early_initcall(hip04_mcpm_init);

Actually, I guess it would be better to do this from one of the
various calls you already have for SMP initialization than
doing an initcall.

	Arnd
