From: fkan@apm.com (Feng Kan)
Date: Tue, 12 May 2015 19:25:08 -0700
Subject: [PATCH v4 2/3] irqchip: GIC: Add support for irq_{get,
 set}_irqchip_state
In-Reply-To: <1426676484-21812-3-git-send-email-marc.zyngier@arm.com>
References: <1426676484-21812-1-git-send-email-marc.zyngier@arm.com>
 <1426676484-21812-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAL85gmBrkonMcKdUVGmYx6zT3wSe-e2jPhnL_+Tkf3s4jsAiWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc:

Sorry for top posting. It seems with GIC-400, the get_irqstate is not a reliable
way of accessing the GPIO status. In our case, the gpio interrupt status can
only be read correctly with the SPISR register. So it seems we have to go
back to the old way of mapping the SPISR portion of the GIC in our GPIO
driver. We wanted to ask you if that is acceptable since SPISR in not
standard in all GIC, perhaps we can treat it differently.

On Wed, Mar 18, 2015 at 4:01 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Add the required hooks for the internal state of an interrupt
> to be exposed to other subsystems.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/irq-gic.c | 69 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 65 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 471e1cd..0b4a4d0 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -151,13 +151,24 @@ static inline unsigned int gic_irq(struct irq_data *d)
>  /*
>   * Routines to acknowledge, disable and enable interrupts
>   */
> -static void gic_mask_irq(struct irq_data *d)
> +static void gic_poke_irq(struct irq_data *d, u32 offset)
> +{
> +       u32 mask = 1 << (gic_irq(d) % 32);
> +       writel_relaxed(mask, gic_dist_base(d) + offset + (gic_irq(d) / 32) * 4);
> +}
> +
> +static int gic_peek_irq(struct irq_data *d, u32 offset)
>  {
>         u32 mask = 1 << (gic_irq(d) % 32);
> +       return !!(readl_relaxed(gic_dist_base(d) + offset + (gic_irq(d) / 32) * 4) & mask);
> +}
> +
> +static void gic_mask_irq(struct irq_data *d)
> +{
>         unsigned long flags;
>
>         raw_spin_lock_irqsave(&irq_controller_lock, flags);
> -       writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
> +       gic_poke_irq(d, GIC_DIST_ENABLE_CLEAR);
>         if (gic_arch_extn.irq_mask)
>                 gic_arch_extn.irq_mask(d);
>         raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
> @@ -165,13 +176,12 @@ static void gic_mask_irq(struct irq_data *d)
>
>  static void gic_unmask_irq(struct irq_data *d)
>  {
> -       u32 mask = 1 << (gic_irq(d) % 32);
>         unsigned long flags;
>
>         raw_spin_lock_irqsave(&irq_controller_lock, flags);
>         if (gic_arch_extn.irq_unmask)
>                 gic_arch_extn.irq_unmask(d);
> -       writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_SET + (gic_irq(d) / 32) * 4);
> +       gic_poke_irq(d, GIC_DIST_ENABLE_SET);
>         raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
>  }
>
> @@ -186,6 +196,55 @@ static void gic_eoi_irq(struct irq_data *d)
>         writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
>  }
>
> +static int gic_irq_set_irqchip_state(struct irq_data *d,
> +                                    enum irqchip_irq_state which, bool val)
> +{
> +       u32 reg;
> +
> +       switch (which) {
> +       case IRQCHIP_STATE_PENDING:
> +               reg = val ? GIC_DIST_PENDING_SET : GIC_DIST_PENDING_CLEAR;
> +               break;
> +
> +       case IRQCHIP_STATE_ACTIVE:
> +               reg = val ? GIC_DIST_ACTIVE_SET : GIC_DIST_ACTIVE_CLEAR;
> +               break;
> +
> +       case IRQCHIP_STATE_MASKED:
> +               reg = val ? GIC_DIST_ENABLE_CLEAR : GIC_DIST_ENABLE_SET;
> +               break;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       gic_poke_irq(d, reg);
> +       return 0;
> +}
> +
> +static int gic_irq_get_irqchip_state(struct irq_data *d,
> +                                     enum irqchip_irq_state which, bool *val)
> +{
> +       switch (which) {
> +       case IRQCHIP_STATE_PENDING:
> +               *val = gic_peek_irq(d, GIC_DIST_PENDING_SET);
> +               break;
> +
> +       case IRQCHIP_STATE_ACTIVE:
> +               *val = gic_peek_irq(d, GIC_DIST_ACTIVE_SET);
> +               break;
> +
> +       case IRQCHIP_STATE_MASKED:
> +               *val = !gic_peek_irq(d, GIC_DIST_ENABLE_SET);
> +               break;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static int gic_set_type(struct irq_data *d, unsigned int type)
>  {
>         void __iomem *base = gic_dist_base(d);
> @@ -329,6 +388,8 @@ static struct irq_chip gic_chip = {
>         .irq_set_affinity       = gic_set_affinity,
>  #endif
>         .irq_set_wake           = gic_set_wake,
> +       .irq_get_irqchip_state  = gic_irq_get_irqchip_state,
> +       .irq_set_irqchip_state  = gic_irq_set_irqchip_state,
>  };
>
>  void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
