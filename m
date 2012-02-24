From: robherring2@gmail.com (Rob Herring)
Date: Fri, 24 Feb 2012 10:49:02 -0600
Subject: [PATCH] gic : check if there are pending interrupts
In-Reply-To: <1330091148-15291-1-git-send-email-daniel.lezcano@linaro.org>
References: <1330091148-15291-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <4F47BF7E.5020707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2012 07:45 AM, Daniel Lezcano wrote:
> The following patch checks if there are pending interrupts on the gic.
> 
> This function is needed for example for the ux500 cpuidle driver.
> When the A9 cores and the gic are decoupled from the PRCMU, the idle
> routine has to check if an interrupt is pending on the gic before entering
> in retention mode.

That sounds racy. Soon as you check an interrupt can assert.

> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/common/gic.c               |   37 +++++++++++++++++++++++++++++++++++
>  arch/arm/include/asm/hardware/gic.h |    2 +-
>  2 files changed, 38 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index aa52699..2528094 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -750,6 +750,43 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>  }
>  #endif
>  
> +/*
> + * gic_pending_irq - checks if there are pending interrupts on the gic
> + *
> + * Disabling an interrupt only disables the forwarding of the
> + * interrupt to any CPU interface. It does not prevent the interrupt
> + * from changing state, for example becoming pending, or active and
> + * pending if it is already active. For this reason, we have to check
> + * the interrupt is pending *and* is enabled.
> + *
> + * Returns true if there are pending and enabled interrupts, false
> + * otherwise.
> + */
> +bool gic_pending_irq(unsigned int gic_nr)

Seems like this should be solved with a generic interface and not gic
specific.

Would we ever need this for a secondary gic (gic_nr != 0)?

> +{
> +	u32 pr; /* Pending register */
> +	u32 er; /* Enable register */
> +	void __iomem *dist_base;
> +	int gic_irqs;
> +	int i;
> +
> +	BUG_ON(gic_nr >= MAX_GIC_NR);
> +
> +	gic_irqs = gic_data[gic_nr].gic_irqs;
> +	dist_base = gic_data_dist_base(&gic_data[gic_nr]);
> +
> +	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 32); i++) {

Wouldn't you want to skip PPIs if the CPU interface is disabled?

> +
> +		pr = readl_relaxed(dist_base + GIC_DIST_PENDING_SET + i * 4);
> +		er = readl_relaxed(dist_base + GIC_DIST_ENABLE_SET + i * 4);
> +

What if an interrupt is pending, but routed to a core which is not
getting put into low power state?

Rob

> +		if (pr & er)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  #ifdef CONFIG_OF
>  static int gic_cnt __initdata = 0;
>  
> diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
> index 4b1ce6c..d198ac0 100644
> --- a/arch/arm/include/asm/hardware/gic.h
> +++ b/arch/arm/include/asm/hardware/gic.h
> @@ -45,7 +45,7 @@ void gic_secondary_init(unsigned int);
>  void gic_handle_irq(struct pt_regs *regs);
>  void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
>  void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
> -
> +bool gic_pending_irq(unsigned int gic_nr);
>  static inline void gic_init(unsigned int nr, int start,
>  			    void __iomem *dist , void __iomem *cpu)
>  {
