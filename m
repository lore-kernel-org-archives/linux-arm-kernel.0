From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Sep 2011 20:53:07 +0200
Subject: [PATCH 4/6] arm/imx6q: add smp and cpu hotplug support
In-Reply-To: <1315303120-24203-5-git-send-email-shawn.guo@linaro.org>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-5-git-send-email-shawn.guo@linaro.org>
Message-ID: <1588593.gaQsrFqt8B@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 September 2011 17:58:38 Shawn Guo wrote:
> It adds smp and cpu hotplug support for imx6q.
> +static u32 twd_saved_regs[4];
> +static int twd_irq;
> +
> +/*
> + * Resuming from ARM Dormant/Shutdown mode, the boot procedure will
> + * re-setup local timer for secondary cores.  For primary core, it
> + * has to take care of itself with the following pair of functions
> + * during suspend/resume.
> + */
> +void imx_local_timer_pre_suspend(void)
> +{
> +	twd_saved_regs[0] = __raw_readl(twd_base + TWD_TIMER_LOAD);
> +	twd_saved_regs[1] = __raw_readl(twd_base + TWD_TIMER_COUNTER);
> +	twd_saved_regs[2] = __raw_readl(twd_base + TWD_TIMER_CONTROL);
> +	twd_saved_regs[3] = __raw_readl(twd_base + TWD_TIMER_INTSTAT);
> +}
> +
> +void imx_local_timer_post_resume(void)
> +{
> +	__raw_writel(twd_saved_regs[0], twd_base + TWD_TIMER_LOAD);
> +	__raw_writel(twd_saved_regs[1], twd_base + TWD_TIMER_COUNTER);
> +	__raw_writel(twd_saved_regs[2], twd_base + TWD_TIMER_CONTROL);
> +	__raw_writel(twd_saved_regs[3], twd_base + TWD_TIMER_INTSTAT);
> +
> +	gic_enable_ppi(twd_irq);
> +}

readl_relaxed()?

> +extern void v7_secondary_startup(void);
> +
> +#define IMX_SCU_VIRT_BASE	0xf4a00000
> +
> +static void __iomem *scu_base = ((void __iomem *)(IMX_SCU_VIRT_BASE));

It's a little bit silly to have a variable for the base and then initialize
it statically. Not sure what the best solution is here.

> +static struct map_desc scu_io_desc __initdata = {
> +	.virtual	= IMX_SCU_VIRT_BASE,
> +	.pfn		= 0, /* run-time */
> +	.length		= SZ_4K,
> +	.type		= MT_DEVICE,
> +};
> +
> +void __init imx_scu_map_io(void)
> +{
> +	unsigned long base;
> +
> +	/* Get SCU base */
> +	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
> +
> +	scu_io_desc.pfn = __phys_to_pfn(base);
> +	iotable_init(&scu_io_desc, 1);
> +}

Maybe we can simply define a platform-independent where the SCU gets mapped?
That would get rid of most of the platform specific SCU code, at least for
those platforms that can reliably read the scu base.

> +/*
> + * Initialise the CPU possible map early - this describes the CPUs
> + * which may be present or become present in the system.
> + */
> +void __init smp_init_cpus(void)
> +{
> +	int i, ncores;
> +
> +	ncores = scu_get_core_count(scu_base);
> +
> +	for (i = 0; i < ncores; i++)
> +		set_cpu_possible(i, true);
> +
> +	set_smp_cross_call(gic_raise_softirq);
> +}
> +
> +void imx_smp_prepare(void)
> +{
> +	scu_enable(scu_base);
> +}
> +
> +void __init platform_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +	imx_smp_prepare();
> +}

Then these functions could also be moved into the smp_scu file as generic
helpers that can be used by all similar platforms.

	Arnd
