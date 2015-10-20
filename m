From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Oct 2015 15:46:00 +0200
Subject: [PATCH 3/5] irqchip: armada-370-xp: re-enable per-CPU interrupts
 at resume time
In-Reply-To: <1445347435-2333-4-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Tue, 20 Oct 2015 15:23:53 +0200")
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1445347435-2333-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87vba1ejqf.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mar., oct. 20 2015, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Commit d17cab4451df1 ("irqchip: Kill off set_irq_flags usage") changed
> the code of armada_370_xp_mpic_irq_map() from using set_irq_flags() to
> irq_set_probe().
>
> While the commit log seems to imply that there are no functional
> changes, there are indeed functional changes introduced by this
> commit: the IRQ_NOAUTOEN flag is no longer cleared. This functional
> change causes a regression on Armada XP, which no longer works
> properly after suspend/resume because per-CPU interrupts remain
> disabled.
>
> Due to how the hardware registers work, the irq-armada-370-xp cannot
> simply save/restore a bunch of registers at suspend/resume to make
> sure that the interrupts remain in the same state after
> resuming. Therefore, it relies on the kernel to say whether the
> interrupt is disabled or not, using the irqd_irq_disabled()
> function. This was all working fine while the IRQ_NOAUTOEN flag was
> cleared.
>
> With the change introduced by Rob Herring in d17cab4451df1, the
> IRQ_NOAUTOEN flag is now set for all interrupts. irqd_irq_disabled()
> returns false for per-CPU interrupts, and therefore our per-CPU
> interrupts are no longer re-enabled after resume.
>
> This commit fixes that by using irqd_irq_disabled() only for global
> interrupts, and using the newly introduced is_enabled_percpu_irq() for
> per-CPU interrupts.
>
> Also, it fixes a related problems that per-CPU interrupts were only
> re-enabled on the boot CPU and not other CPUs. Until now this wasn't a
> problem since on this platform, only the local timers are using
> per-CPU interrupts and the local timers of secondary CPUs are turned
> off/on during CPU hotplug before suspend, after after resume. However,
> in Linux 4.4, we will also be using per-CPU interrupts for the network
> controller, so we need to properly restore the per-CPU interrupts on
> secondary CPUs as well.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/irqchip/irq-armada-370-xp.c | 45 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 39 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
> index f5afe81..106ac4c 100644
> --- a/drivers/irqchip/irq-armada-370-xp.c
> +++ b/drivers/irqchip/irq-armada-370-xp.c
> @@ -311,7 +311,6 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
>  		irq_set_percpu_devid(virq);
>  		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
>  					handle_percpu_devid_irq);
> -
>  	} else {
>  		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
>  					handle_level_irq);
> @@ -377,12 +376,35 @@ static void armada_mpic_send_doorbell(const struct cpumask *mask,
>  static int armada_xp_mpic_secondary_init(struct notifier_block *nfb,
>  					 unsigned long action, void *hcpu)
>  {
> +	unsigned int nirqs, irq;
> +
>  	if (action != CPU_STARTING && action != CPU_STARTING_FROZEN)
>  		return NOTIFY_OK;
>  
>  	armada_xp_mpic_perf_init();
>  	armada_xp_mpic_smp_cpu_init();
>  
> +	/* Re-enable per-CPU interrupts that were enabled before suspend */
> +	nirqs = (readl(main_int_base + ARMADA_370_XP_INT_CONTROL) >> 2) & 0x3ff;
> +	for (irq = 0; irq < nirqs; irq++) {

Actually we could reduce this loop by using
ARMADA_370_XP_MAX_PER_CPU_IRQS, as we know that we can't have more per
cpu irq. 


> +		struct irq_data *data;
> +		int virq;
> +
> +		virq = irq_linear_revmap(armada_370_xp_mpic_domain, irq);
> +		if (virq == 0)
> +			continue;
> +
> +		data = irq_get_irq_data(virq);
> +
> +		if (irq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
> +			continue;

So eventually you only manage the timer IRQs?

If it is intentional you could it differently, but I wonder why you don't
enable again the other percpu IRQ.
> +
> +		if (!is_enabled_percpu_irq(virq))
> +			continue;
> +
> +		armada_370_xp_irq_unmask(data);
> +	}
> +
>  	return NOTIFY_OK;
>  }
>  

The following chunk will conflict with "irqchip: armada-370-xp: Rework
per-cpu interrupts handling" which is in Linux next. But as this patch
is for 4.3, you can't do anything...

> @@ -550,16 +572,27 @@ static void armada_370_xp_mpic_resume(void)
>  		if (virq == 0)
>  			continue;
>  
> -		if (irq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ)
> +		data = irq_get_irq_data(virq);
> +
> +		if (irq != ARMADA_370_XP_TIMER0_PER_CPU_IRQ) {
> +			/* Non per-CPU interrupts */
>  			writel(irq, per_cpu_int_base +
>  			       ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
> -		else
> +			if (!irqd_irq_disabled(data))
> +				armada_370_xp_irq_unmask(data);
> +		} else {
> +			/* Per-CPU interrupts */
>  			writel(irq, main_int_base +
>  			       ARMADA_370_XP_INT_SET_ENABLE_OFFS);
>  
> -		data = irq_get_irq_data(virq);
> -		if (!irqd_irq_disabled(data))
> -			armada_370_xp_irq_unmask(data);
> +			/*
> +			 * Re-enable on the current CPU,
> +			 * armada_xp_mpic_secondary_init() will take
> +			 * care of secondary CPUs when they come up.
> +			 */
> +			if (is_enabled_percpu_irq(virq))
> +				armada_370_xp_irq_unmask(data);
> +		}
>  	}
>  
>  	/* Reconfigure doorbells for IPIs and MSIs */
> -- 
> 2.6.2
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
