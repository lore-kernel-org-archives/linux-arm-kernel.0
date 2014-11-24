From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 24 Nov 2014 19:20:07 +0100 (CET)
Subject: [PATCH 3.18-rc3 v8 1/4] irqchip: gic: Make gic_raise_softirq()
 FIQ-safe
In-Reply-To: <1415968543-29469-2-git-send-email-daniel.thompson@linaro.org>
References: <1415183260-6389-1-git-send-email-daniel.thompson@linaro.org>
 <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>
 <1415968543-29469-2-git-send-email-daniel.thompson@linaro.org>
Message-ID: <alpine.DEB.2.11.1411241918090.6439@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Nov 2014, Daniel Thompson wrote:
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 38493ff28fa5..0db62a6f1ee3 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -73,6 +73,13 @@ struct gic_chip_data {
>  static DEFINE_RAW_SPINLOCK(irq_controller_lock);
>  
>  /*
> + * This lock may be locked for reading by FIQ handlers. Thus although
> + * read locking may be used liberally, write locking must only take
> + * place only when local FIQ handling is disabled.
> + */
> +static DEFINE_RWLOCK(fiq_safe_cpu_map_lock);
> +
> +/*
>   * The GIC mapping of CPU interfaces does not necessarily match
>   * the logical CPU numbering.  Let's use a mapping as returned
>   * by the GIC itself.
> @@ -624,7 +631,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>  	int cpu;
>  	unsigned long flags, map = 0;
>  
> -	raw_spin_lock_irqsave(&irq_controller_lock, flags);
> +	read_lock_irqsave(&fiq_safe_cpu_map_lock, flags);

Just for the record:

You might have noticed that you replace a raw lock with a non raw
one. That's not an issue on mainline, but that pretty much renders
that code broken for RT.
  
Surely nothing I worry too much about given the current state of RT.

Thanks,

	tglx
