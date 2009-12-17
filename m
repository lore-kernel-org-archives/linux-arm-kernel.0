From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Dec 2009 16:14:22 -0000
Subject: [PATCH 1/5] arm: provide a mechanism to reserve performance
	counters
In-Reply-To: <1260875712-29712-2-git-send-email-jamie.iles@picochip.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-2-git-send-email-jamie.iles@picochip.com>
Message-ID: <001101ca7f33$fe8ddc90$fba995b0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

Just a small thing I noticed with the PMU reservation:

*Jamie Iles wrote:

> diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
> new file mode 100644
> index 0000000..3a178bb
> --- /dev/null
> +++ b/arch/arm/kernel/pmu.c
<snip>
> +static const int irqs[] = {
> +#ifdef CONFIG_ARCH_PC3XX
> +	IRQ_NPMUIRQ,
> +#elif defined(CONFIG_ARCH_OMAP2)
> +	3,
> +#elif defined(CONFIG_ARCH_BCMRING)
> +	IRQ_PMUIRQ,
> +#elif defined(CONFIG_MACH_REALVIEW_EB)
> +	IRQ_EB11MP_PMU_CPU0,
> +	IRQ_EB11MP_PMU_CPU1,
> +	IRQ_EB11MP_PMU_CPU2,
> +	IRQ_EB11MP_PMU_CPU3,
> +#elif defined(CONFIG_ARCH_OMAP3)
> +	INT_34XX_BENCH_MPU_EMUL,
> +#elif defined(CONFIG_ARCH_IOP32X)
> +	IRQ_IOP32X_CORE_PMU,
> +#elif defined(CONFIG_ARCH_IOP33X)
> +	IRQ_IOP33X_CORE_PMU,
> +#elif defined(CONFIG_ARCH_PXA)
> +	IRQ_PMU,
> +#endif
> +};
> +
> +static const struct pmu_irqs pmu_irqs = {
> +	.irqs	    = irqs,
> +	.num_irqs   = ARRAY_SIZE(irqs),
> +};
> +
> +static DECLARE_MUTEX(pmu_mutex);
> +
> +const struct pmu_irqs *
> +reserve_pmu(void)
> +{
> +	int ret = down_trylock(&pmu_mutex) ? -EBUSY : 0;
> +
> +	return ret ? ERR_PTR(ret) : &pmu_irqs;
> +}

I think it would be sensible to return an error (-ENODEV) if
pmu_irqs.num_irqs == 0. Not doing so can cause applications
to fail silently when they are running on unsupported boards.

Will
