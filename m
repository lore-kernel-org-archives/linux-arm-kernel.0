From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 26 Jan 2011 13:01:44 +0530
Subject: [PATCH 1/5] ARM: gic: Add hooks for architecture specific
	extensions
In-Reply-To: <AANLkTi=-JYqKW0abCZKDzVjM0DkYF+LMOXDa1R+HrJ2i@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com><1295859080-15259-2-git-send-email-santosh.shilimkar@ti.com><AANLkTikT=muk5A8MkSe0dXvE-GPsfMn4Am7KuOndvBdi@mail.gmail.com><AANLkTi=umZYcb2MozjjLhjjRD305t8iKw2jNr3Ke=9H7@mail.gmail.com><d33cd73f8207d4b92d02eb4bd2629590@mail.gmail.com>
	<AANLkTi=-JYqKW0abCZKDzVjM0DkYF+LMOXDa1R+HrJ2i@mail.gmail.com>
Message-ID: <ef807d5fb389a19b2bd046f5fc6d203b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: ccross at google.com [mailto:ccross at google.com] On Behalf Of
> Colin Cross
> Sent: Wednesday, January 26, 2011 12:54 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel at lists.infradead.org; linux-
> omap at vger.kernel.org; catalin.marinas at arm.com;
> linux at arm.linux.org.uk; linus.ml.walleij at gmail.com; Russell King
> Subject: Re: [PATCH 1/5] ARM: gic: Add hooks for architecture
> specific extensions
>
[....]

> >>
> > Great.
> > Can I fold below changes in my patch and add you ack and tested-
> by?
>
> Sure

After reading your initial comment, you mentioned you need to have
'gic_set_type' as well. Is this still true. If yes then we need to
have arch_extn call for that as well.
>
> >> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> >> index 0b6c043..7993f07 100644
> >> --- a/arch/arm/common/gic.c
> >> +++ b/arch/arm/common/gic.c
> >> @@ -90,6 +90,8 @@ static inline unsigned int gic_irq(struct
> irq_data
> >> *d)
> >> ?static void gic_ack_irq(struct irq_data *d)
> >> ?{
> >> ? ? ? spin_lock(&irq_controller_lock);
> >> + ? ? if (gic_arch_extn.irq_ack)
> >> + ? ? ? ? ? ? gic_arch_extn.irq_ack(d);
> >> ? ? ? writel(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
> >> ? ? ? spin_unlock(&irq_controller_lock);
> >> ?}
> >> @@ -161,6 +163,14 @@ static int gic_set_type(struct irq_data *d,
> >> unsigned int type)
> >> ? ? ? return 0;
> >> ?}
> >>
> >> +static int gic_retrigger(struct irq_data *d)
> >> +{
> >> + ? ? if (gic_arch_extn.irq_retrigger)
> >> + ? ? ? ? ? ? return gic_arch_extn.irq_retrigger(d);
> >> +
> >> + ? ? return 0;
> >> +}
> >> +
> >> ?#ifdef CONFIG_SMP
> >> ?static int
> >> ?gic_set_cpu(struct irq_data *d, const struct cpumask *mask_val,
> >> bool force)
> >> @@ -234,6 +244,7 @@ static struct irq_chip gic_chip = {
> >> ? ? ? .irq_mask ? ? ? ? ? ? ? = gic_mask_irq,
> >> ? ? ? .irq_unmask ? ? ? ? ? ? = gic_unmask_irq,
> >> ? ? ? .irq_set_type ? ? ? ? ? = gic_set_type,
> >> + ? ? .irq_retrigger ? ? ? ? ?= gic_retrigger,
> >> ?#ifdef CONFIG_SMP
> >> ? ? ? .irq_set_affinity ? ? ? = gic_set_cpu,
> >> ?#endif
> >
