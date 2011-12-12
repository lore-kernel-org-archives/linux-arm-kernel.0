From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 12 Dec 2011 17:54:58 +0800
Subject: [PATCH] irq: convert generic-chip to use irq_domain
In-Reply-To: <4EE56C66.5000909@gmail.com>
References: <1323470689-6200-1-git-send-email-robherring2@gmail.com>
 <20111211160025.GA9572@S2100-06.ap.freescale.net>
 <4EE554BA.9040408@gmail.com> <4EE56C66.5000909@gmail.com>
Message-ID: <20111212095457.GI9572@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 11, 2011 at 08:52:22PM -0600, Rob Herring wrote:
> Actually, there's a much simpler fix:
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 200ce83..3832ac6 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -135,6 +135,9 @@ int irq_domain_simple_dt_translate(struct irq_domain *d,
>                 return -EINVAL;
>         if (intsize < 1)
>                 return -EINVAL;
> +       if ((intspec[0] < d->hwirq_base) ||
> +           (intspec[0] >= d->hwirq_base + d->nr_irq))
> +               return -EINVAL;
> 
>         *out_hwirq = intspec[0];
>         *out_type = IRQ_TYPE_NONE;
> 
Thanks, Rob.  It works for me with some additional changes to your
patch.

8<-------------------------

diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 48eeb29..3ac7de4 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -252,14 +252,16 @@ void irq_setup_generic_chip(struct irq_chip_generic *gc, u32 msk,
                gc->mask_cache = irq_reg_readl(gc->reg_base + ct->regs.mask);

        gc->domain->nr_irq = fls(msk);
-       irq = irq_alloc_descs(gc->domain->irq_base, 1, gc->domain->nr_irq,
-                             numa_node_id());
-       if (irq > 0)
-               gc->domain->irq_base = irq;
+       if ((int) gc->domain->irq_base < 0) {
+               irq = irq_alloc_descs(gc->domain->irq_base, 1,
+                                     gc->domain->nr_irq, numa_node_id());
+               if (irq > 0)
+                       gc->domain->irq_base = irq;
+       }

        irq_domain_add(gc->domain);

-       for (i = 0; msk; msk >>= 1, i++) {
+       for (i = gc->domain->hwirq_base; msk; msk >>= 1, i++) {
                if (!(msk & 0x01))
                        continue;

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 200ce83..7947252 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -39,7 +39,7 @@ void irq_domain_add(struct irq_domain *domain)
                        return;
                }
                d->domain = domain;
-               d->hwirq = hwirq;
+               d->hwirq = hwirq - d->domain->hwirq_base;
        }

        mutex_lock(&irq_domain_mutex);
@@ -136,6 +136,10 @@ int irq_domain_simple_dt_translate(struct irq_domain *d,
        if (intsize < 1)
                return -EINVAL;

+       if ((intspec[0] < d->hwirq_base) ||
+           (intspec[0] >= d->hwirq_base + d->nr_irq))
+               return -EINVAL;
+
        *out_hwirq = intspec[0];
        *out_type = IRQ_TYPE_NONE;
        if (intsize > 1)

------------------------->8

Regards,
Shawn
