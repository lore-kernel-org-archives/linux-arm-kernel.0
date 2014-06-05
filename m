From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 5 Jun 2014 17:05:00 +0100
Subject: [PATCH 3.10 005/103] irqchip: Gic: Support forced affinity setting
In-Reply-To: <20140604232547.006861681@linuxfoundation.org>
References: <20140604232546.704156131@linuxfoundation.org>
 <20140604232547.006861681@linuxfoundation.org>
Message-ID: <20140605160500.GD31564@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Thu, Jun 05, 2014 at 12:24:28AM +0100, Greg Kroah-Hartman wrote:
> 3.10-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> commit ffde1de64012c406dfdda8690918248b472f24e4 upstream.
> 
> To support the affinity setting of per cpu timers in the early startup
> of a not yet online cpu, implement the force logic, which disables the
> cpu online check.
> 
> Tagged for stable to allow a simple fix of the affected SoC clock
> event drivers.

This patch alone has the possiblity of breaking CPU hotplug on arm and
arm64 (specifically it breaks hot unplugging CPU0 where interrupts may
be left targetting the offline CPU).

For arm64 [1] that's fixed by commit 601c942176d8 (arm64: use
cpu_online_mask when using forced irq_set_affinity).

Unfortunately there is not an equivalent fix for arm - Russell objected
to the approach [2,3,4], and that's not yet settled.

Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/254836.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/254838.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/259245.html
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/259255.html

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Tomasz Figa <t.figa@samsung.com>,
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: linux-arm-kernel at lists.infradead.org,
> Link: http://lkml.kernel.org/r/20140416143315.916984416 at linutronix.de
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  drivers/irqchip/irq-gic.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -246,10 +246,14 @@ static int gic_set_affinity(struct irq_d
>  			    bool force)
>  {
>  	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
> -	unsigned int shift = (gic_irq(d) % 4) * 8;
> -	unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
> +	unsigned int cpu, shift = (gic_irq(d) % 4) * 8;
>  	u32 val, mask, bit;
>  
> +	if (!force)
> +		cpu = cpumask_any_and(mask_val, cpu_online_mask);
> +	else
> +		cpu = cpumask_first(mask_val);
> +
>  	if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
>  		return -EINVAL;
>  
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
