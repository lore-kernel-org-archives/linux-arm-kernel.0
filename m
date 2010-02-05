From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 5 Feb 2010 02:18:13 -0800
Subject: [RFC PATCH 2/3] [ARM] Preliminary support for dynamic IRQ
In-Reply-To: <20100205081315.GE13267@trinity.fluff.org>
References: <f17812d71002041111i1171b055t5d0d0bf585bfba5d@mail.gmail.com>
	<20100205081315.GE13267@trinity.fluff.org>
Message-ID: <f17812d71002050218u78ace11fm33edae1ba3bbf42f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 5, 2010 at 12:13 AM, Ben Dooks <ben-linux@fluff.org> wrote:
>
> On Thu, Feb 04, 2010 at 11:11:58AM -0800, Eric Miao wrote:
> > To solve the mess that a heavy usage of board IRQs on ARM and the
> > diversity, we might end up with a dynamic solution, where SPARSE_IRQ
> > looks so far fit at least.
>
> I'm not sure that SPARSE_IRQ is really the right solution at the moment,
> having just spent some time thinking about this wrt to the samsung range
> of socs, it doesn't seem to be a huge gain.
>

Thanks Ben, for the thoughts.

Currently, looks to be the only framework that we can make immediate
use. Otherwise we may end up writing something from scratch.

> I think a better solution would be to have a lazy interrupt solution based
> around the same methods as the sparse irq where each soc registers the
> ranges of interrupts supported and then when request_irq() is called the
> irq_desc is created. Currently some of the Samsung range have nearly 28KiB
> of irq_desc allocated...
>

That's really good idea, and I think it's something doable on-top-of
sparse IRQ. Once it's converted, all can be benefited.

> > commit 59e902671333e2b3c39cb39a47e2c6b673c9f406
> > Author: Eric Miao <eric.y.miao@gmail.com>
> > Date: ? Wed Feb 3 18:16:43 2010 -0800
> >
> > ? ? [ARM] Preliminary support for dynamic IRQ
> >
> > ? ? Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 4c33ca8..c95484c 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -920,6 +920,18 @@ config ARM_ERRATA_460075
> > ? ? ? ? ACTLR register. Note that setting specific bits in the ACTLR register
> > ? ? ? ? may not be available in non-secure mode.
> >
> > +config SPARSE_IRQ
> > + ? ? bool "Support sparse irq numbering"
> > + ? ? depends on EXPERIMENTAL
> > + ? ? help
> > + ? ? ? This enables support for sparse irqs. This is useful in general
> > + ? ? ? as most CPUs have a fairly sparse array of IRQ vectors, which
> > + ? ? ? the irq_desc then maps directly on to. Systems with a high
> > + ? ? ? number of off-chip IRQs will want to treat this as
> > + ? ? ? experimental until they have been independently verified.
> > +
> > + ? ? ? If you don't know what to do here, say N.
> > +
> > ?endmenu
> >
> > ?source "arch/arm/common/Kconfig"
> > diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
> > index 328f14a..a1ea728 100644
> > --- a/arch/arm/include/asm/irq.h
> > +++ b/arch/arm/include/asm/irq.h
> > @@ -7,6 +7,8 @@
> > ?#define irq_canonicalize(i) ?(i)
> > ?#endif
> >
> > +#define NR_IRQS_LEGACY ? ? ? 16
> > +
>
> Do we really want to set this for everyone?
>

This is a kind of PC concept, mostly for legacy ISA IRQ which
in their mind not able to get rid of. But anyway, this is the
minimum number of IRQs to allocate, not something in extra,
so unless a platform has less than 16 IRQs and really cares
about the additional irq_desc[] being allocated (in which case,
we might still be able to reduce this), this should be fine.

> > ?/*
> > ? * Use this value to indicate lack of interrupt
> > ? * capability
> > diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> > index b7cb45b..e62f39b 100644
> > --- a/arch/arm/kernel/irq.c
> > +++ b/arch/arm/kernel/irq.c
> > @@ -54,6 +54,7 @@ unsigned long irq_err_count;
> > ?int show_interrupts(struct seq_file *p, void *v)
> > ?{
> > ? ? ? int i = *(loff_t *) v, cpu;
> > + ? ? struct irq_desc *desc;
> > ? ? ? struct irqaction * action;
> > ? ? ? unsigned long flags;
> >
> > @@ -68,24 +69,25 @@ int show_interrupts(struct seq_file *p, void *v)
> > ? ? ? ? ? ? ? seq_putc(p, '\n');
> > ? ? ? }
> >
> > - ? ? if (i < NR_IRQS) {
> > - ? ? ? ? ? ? raw_spin_lock_irqsave(&irq_desc[i].lock, flags);
> > - ? ? ? ? ? ? action = irq_desc[i].action;
> > + ? ? if (i < nr_irqs) {
> > + ? ? ? ? ? ? desc = irq_to_desc(i);
> > + ? ? ? ? ? ? raw_spin_lock_irqsave(&desc->lock, flags);
> > + ? ? ? ? ? ? action = desc->action;
> > ? ? ? ? ? ? ? if (!action)
> > ? ? ? ? ? ? ? ? ? ? ? goto unlock;
> >
> > ? ? ? ? ? ? ? seq_printf(p, "%3d: ", i);
> > ? ? ? ? ? ? ? for_each_present_cpu(cpu)
> > ? ? ? ? ? ? ? ? ? ? ? seq_printf(p, "%10u ", kstat_irqs_cpu(i, cpu));
> > - ? ? ? ? ? ? seq_printf(p, " %10s", irq_desc[i].chip->name ? : "-");
> > + ? ? ? ? ? ? seq_printf(p, " %10s", desc->chip->name ? : "-");
> > ? ? ? ? ? ? ? seq_printf(p, " ?%s", action->name);
> > ? ? ? ? ? ? ? for (action = action->next; action; action = action->next)
> > ? ? ? ? ? ? ? ? ? ? ? seq_printf(p, ", %s", action->name);
> >
> > ? ? ? ? ? ? ? seq_putc(p, '\n');
> > ?unlock:
> > - ? ? ? ? ? ? raw_spin_unlock_irqrestore(&irq_desc[i].lock, flags);
> > - ? ? } else if (i == NR_IRQS) {
> > + ? ? ? ? ? ? raw_spin_unlock_irqrestore(&desc->lock, flags);
> > + ? ? } else if (i == nr_irqs) {
> > ?#ifdef CONFIG_FIQ
> > ? ? ? ? ? ? ? show_fiq_list(p, v);
> > ?#endif
> > @@ -113,7 +115,7 @@ asmlinkage void __exception asm_do_IRQ(unsigned
> > int irq, struct pt_regs *regs)
> > ? ? ? ?* Some hardware gives randomly wrong interrupts. ?Rather
> > ? ? ? ?* than crashing, do something sensible.
> > ? ? ? ?*/
> > - ? ? if (unlikely(irq >= NR_IRQS)) {
> > + ? ? if (unlikely(irq >= nr_irqs)) {
> > ? ? ? ? ? ? ? if (printk_ratelimit())
> > ? ? ? ? ? ? ? ? ? ? ? printk(KERN_WARNING "Bad IRQ%u\n", irq);
> > ? ? ? ? ? ? ? ack_bad_irq(irq);
> > @@ -133,12 +135,12 @@ void set_irq_flags(unsigned int irq, unsigned int iflags)
> > ? ? ? struct irq_desc *desc;
> > ? ? ? unsigned long flags;
> >
> > - ? ? if (irq >= NR_IRQS) {
> > + ? ? if (irq >= nr_irqs) {
> > ? ? ? ? ? ? ? printk(KERN_ERR "Trying to set irq flags for IRQ%d\n", irq);
> > ? ? ? ? ? ? ? return;
> > ? ? ? }
> >
> > - ? ? desc = irq_desc + irq;
> > + ? ? desc = irq_to_desc(irq);
> > ? ? ? raw_spin_lock_irqsave(&desc->lock, flags);
> > ? ? ? desc->status |= IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
> > ? ? ? if (iflags & IRQF_VALID)
> > @@ -152,14 +154,25 @@ void set_irq_flags(unsigned int irq, unsigned int iflags)
> >
> > ?void __init init_IRQ(void)
> > ?{
> > + ? ? struct irq_desc *desc;
> > ? ? ? int irq;
> >
> > - ? ? for (irq = 0; irq < NR_IRQS; irq++)
> > - ? ? ? ? ? ? irq_desc[irq].status |= IRQ_NOREQUEST | IRQ_NOPROBE;
> > + ? ? for (irq = 0; irq < nr_irqs; irq++) {
> > + ? ? ? ? ? ? desc = irq_to_desc_alloc_node(irq, 0);
> > + ? ? ? ? ? ? desc->status |= IRQ_NOREQUEST | IRQ_NOPROBE;
> > + ? ? }
>
> looks like we'll just end up with everyone allocating an IRQ.
>

That's safest way at the moment. We are not yet taking the
advantage of its being dynamically allocated, we are taking
only the advantage of its being dynamically number-ed.
