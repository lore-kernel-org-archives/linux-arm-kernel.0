From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Wed, 06 Jan 2010 13:00:56 +0100
Subject: [PATCH 1/5] arm: provide a mechanism to reserve performance
	counters
In-Reply-To: <1262602122-10373-2-git-send-email-jamie.iles@picochip.com>
References: <1262602122-10373-1-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-2-git-send-email-jamie.iles@picochip.com>
Message-ID: <op.u530zufm7p4s8u@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 04 Jan 2010 11:48:38 +0100, Jamie Iles <jamie.iles@picochip.com> wrote:
> To add support for perf events and to allow the hardware
> counters to be shared with oprofile, we need a way to reserve
> access to the pmu (performance monitor unit).
>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Jamie Iles <jamie.iles@picochip.com>

> diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
> new file mode 100644
> index 0000000..5840d2d
> --- /dev/null
> +++ b/arch/arm/include/asm/pmu.h
> @@ -0,0 +1,74 @@

[...]

> +#ifndef __ARM_PMU_H__
> +#define __ARM_PMU_H__
> +
> +#ifdef CONFIG_CPU_HAS_PMU

[...]

> +#else /* CONFIG_CPU_HAS_PMU */
> +
> +static inline const struct pmu_irqs *
> +reserve_pmu(void)
> +{
> +	ERR_PTR(-ENODEV);

-	ERR_PTR(-ENODEV);
+	return ERR_PTR(-ENODEV);

> +}
> +
> +static inline int
> +release_pmu(const struct pmu_irqs *irqs)
> +{

+	return -ENODEV;

> +}
> +
> +static inline int
> +init_pmu(void)
> +{
> +	return -ENODEV;
> +}
> +
> +#endif /* CONFIG_CPU_HAS_PMU */
> +
> +#endif /* __ARM_PMU_H__ */

> diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
> new file mode 100644
> index 0000000..a8c015d
> --- /dev/null
> +++ b/arch/arm/kernel/pmu.c
> @@ -0,0 +1,107 @@

[...]

> +static const int irqs[] = {

[...]

> +};
> +
> +static const struct pmu_irqs pmu_irqs = {
> +	.irqs	    = irqs,
> +	.num_irqs   = ARRAY_SIZE(irqs),
> +};
> +
> +static DECLARE_MUTEX(pmu_mutex);

Isn't mutex an overkill? A bit field would be enough:

-static DECLARE_MUTEX(pmu_mutex);
+static volatile long pmu_mutex;

> +
> +const struct pmu_irqs *
> +reserve_pmu(void)
> +{
> +	int ret = down_trylock(&pmu_mutex) ? -EBUSY : 0;
> +
> +	return ret ? ERR_PTR(ret) : &pmu_irqs;

-	int ret = down_trylock(&pmu_mutex) ? -EBUSY : 0;
-
-	return ret ? ERR_PTR(ret) : &pmu_irqs;
+	return test_and_set_bit_lock(0, &pmu_mutex) ? ERR_PTR(-EBUSY) : &pmm_irqs;

> +}
> +EXPORT_SYMBOL_GPL(reserve_pmu);
> +
> +int
> +release_pmu(const struct pmu_irqs *irqs)
> +{
> +	if (WARN_ON(irqs != &pmu_irqs))
> +		return -EINVAL;
> +	up(&pmu_mutex);

-	up(&pmu_mutex);
+	clear_bit_unlock(&pmm_mutex);

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(release_pmu);

[...]


-- 
Best regards,                                           _     _
  .o. | Liege of Serenely Enlightened Majesty of       o' \,=./ `o
  ..o | Computer Science,  Micha? "mina86" Nazarewicz     (o o)
  ooo +---<mina86@mina86.com>---<mina86@jabber.org>---ooO--(_)--Ooo--
