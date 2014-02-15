From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 15 Feb 2014 13:42:54 +0100 (CET)
Subject: [PATCH v1 1/2] clocksource: mct: remove request_irq from
 exynos4_local_timer_setup
In-Reply-To: <1392260923-31659-2-git-send-email-t.dakhran@samsung.com>
References: <1392260923-31659-1-git-send-email-t.dakhran@samsung.com>
 <1392260923-31659-2-git-send-email-t.dakhran@samsung.com>
Message-ID: <alpine.DEB.2.02.1402151321120.21991@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Feb 2014, Tarek Dakhran wrote:

> exynos4_local_timer_setup called on the secondary cpu before
> irqs are enabled. request_irq can sleep, which produces next warning:
> 
> 	BUG: sleeping function called from invalid context at mm/slub.c:965
> 	in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/3
> 
> Call setup_irq for each local timer in exynos4_timer_resources,
> and only call enable_irq during percpu timer setup.
> 
> Signed-off-by: Tarek Dakhran <t.dakhran@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c |   38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 48f76bc..1cde3de 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -82,6 +82,7 @@ static void __iomem *reg_base;
>  static unsigned long clk_rate;
>  static unsigned int mct_int_type;
>  static int mct_irqs[MCT_NR_IRQS];
> +static struct irqaction __percpu *mct_LX_irqaction;
>  
>  struct mct_clock_event_device {
>  	struct clock_event_device evt;
> @@ -402,6 +403,25 @@ static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static void exynos4_setup_irqaction_spi(unsigned int cpu)
> +{
> +	struct irqaction *pcpu_irqaction = per_cpu_ptr(mct_LX_irqaction, cpu);
> +	unsigned int irq = mct_irqs[MCT_L0_IRQ + cpu];
> +	int err;
> +
> +	pcpu_irqaction->name = per_cpu(percpu_mct_tick, cpu).name;
> +	pcpu_irqaction->flags  = IRQF_TIMER | IRQF_NOBALANCING;
> +	pcpu_irqaction->handler = exynos4_mct_tick_isr;
> +	pcpu_irqaction->dev_id = &per_cpu(percpu_mct_tick, cpu);
> +
> +	err = setup_irq(irq, pcpu_irqaction);

This is just crap. Why don't you use request_irq()?

> +	if (err) {
> +		pr_err("MCT: can't setup IRQ %d (%d)\n", irq, err);
> +		return;
> +	}
> +	disable_irq(irq);

This is completely backwards. We have flags which tell the core not to
enable an interrupt at setup time. Also what's wrong with enabling the
interrupt in the first place? When the timer is stopped then no
interrupts happen and it does not matter a bit whether the irq line is
enabled or not.

Thanks,

	tglx
