From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 11 Jan 2011 00:46:13 +0100
Subject: [PATCH 4/5 v2] ARM: pxa: Fix suspend/resume array index
	miscalculation
In-Reply-To: <AANLkTi=+0M_j0r8sy_RbVrJ3fufm7E-tREm8TepAwdzq@mail.gmail.com>
References: <1294699993-4712-1-git-send-email-marek.vasut@gmail.com>
	<1294699993-4712-4-git-send-email-marek.vasut@gmail.com>
	<AANLkTi=+0M_j0r8sy_RbVrJ3fufm7E-tREm8TepAwdzq@mail.gmail.com>
Message-ID: <201101110046.13141.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 January 2011 00:41:26 Eric Miao wrote:
> On Mon, Jan 10, 2011 at 4:53 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > ---
> > v2: Fix loop condition as proposed by Sergei
> > 
> >  arch/arm/mach-pxa/irq.c |    8 ++++----
> >  1 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
> > index 78f0e0c..a7deff5 100644
> > --- a/arch/arm/mach-pxa/irq.c
> > +++ b/arch/arm/mach-pxa/irq.c
> > @@ -156,7 +156,7 @@ static inline void __iomem *irq_base(int i)
> >                0x40d00130,
> >        };
> > 
> > -       return (void __iomem *)io_p2v(phys_base[i >> 5]);
> > +       return (void __iomem *)io_p2v(phys_base[i]);
> >  }
> > 
> >  void __init pxa_init_irq(int irq_nr, set_wake_t fn)
> > @@ -168,7 +168,7 @@ void __init pxa_init_irq(int irq_nr, set_wake_t fn)
> >        pxa_internal_irq_nr = irq_nr;
> > 
> >        for (n = 0; n < irq_nr; n += 32) {
> > -               void __iomem *base = irq_base(n);
> > +               void __iomem *base = irq_base(n >> 5);
> > 
> >                __raw_writel(0, base + ICMR);   /* disable all IRQs */
> >                __raw_writel(0, base + ICLR);   /* all IRQs are IRQ, not
> > FIQ */ @@ -200,7 +200,7 @@ static int pxa_irq_suspend(struct sys_device
> > *dev, pm_message_t state) {
> >        int i;
> > 
> > -       for (i = 0; i < pxa_internal_irq_nr; i += 32) {
> > +       for (i = 0; i < pxa_internal_irq_nr / 32; i++) {
> >                void __iomem *base = irq_base(i);
> 
> I prefer it to be IRQ number based instead of IRQ bank based,
> 
> in other word, I'd rather to change the statement below:
> >                saved_icmr[i] = __raw_readl(base + ICMR);
> 
> to something:
> 
> saved_icmr[i / 32] = __raw_read(base + ICMR);

Exactly what I wanted to avoid ... won't you be doing a division "# of bank"-
times instead of once there ?

> 
> > @@ -219,7 +219,7 @@ static int pxa_irq_resume(struct sys_device *dev)
> >  {
> >        int i;
> > 
> > -       for (i = 0; i < pxa_internal_irq_nr; i += 32) {
> > +       for (i = 0; i < pxa_internal_irq_nr / 32; i++) {
> >                void __iomem *base = irq_base(i);
> > 
> >                __raw_writel(saved_icmr[i], base + ICMR);
> > --
> > 1.7.2.3
