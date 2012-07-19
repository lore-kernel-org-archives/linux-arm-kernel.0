From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Jul 2012 15:22:23 +0000
Subject: [RFC PATCH v2] ARM: Make a compile firmware conditionally
In-Reply-To: <20120716022956.GA619@july>
References: <20120716022956.GA619@july>
Message-ID: <201207191522.24047.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 July 2012, Kyungmin Park wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Some boards can use the firmware at trustzone but others can't use this.
> However we need to build it simultaneously. To address this issue,
> introduce arm firmware support and use it at each board files.
> 
> e.g., In boot_secondary at mach-exynos/platsmp.c
> 
>         __raw_writel(virt_to_phys(exynos4_secondary_startup),
>                 CPU1_BOOT_REG);
> 
>         if (IS_ENABLED(CONFIG_ARM_FIRMWARE)) {
>                 /* Call Exynos specific smc call */
> 		firmware_ops.cpu_boot(cpu);
>         }
> 
>         gic_raise_softirq(cpumask_of(cpu), 1);
> 
>         if (pen_release == -1)
> 
> Now smp_ops is not yet merged, now just call the firmware_init at init_early
>  at board file
> 
> e.g., exynos4412 based board 
> 
> static void __init board_init_early(void)
> {
> 	exynos_firmware_init();
> }
> 
> TODO
> 	1. DT support.
> 	2. call firmware init by smp_ops.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Yes, this all looks reasonable to me. One possible idea though:

> +
> +int __init exynos_firmware_init(void)
> +{
> +	firmware_ops.do_idle = exynos_do_idle;
> +	firmware_ops.cpu_boot = exynos_cpu_boot;
> +	return 0;
> +}

Instead of initializing each field separately, how about copying
the entire data structure and do

static struct firmware_ops exynos_firmware_ops __initdata = {
	.do_idle = exynos_do_idle,
	.cpu_boot = exynos_cpu_boot,
};

void __init exynos_firmware_init(void)
{
	firmware_ops = exynos_firmware_ops;
}

	Arnd
