From: will.deacon@arm.com (Will Deacon)
Date: Fri, 25 Nov 2011 15:41:57 +0000
Subject: GIC irq_start detection breaks 3.2 boot on platforms without PPIs
In-Reply-To: <CAL_Jsq+xZayXkOy2v7y+BittjRfC85mw-bCMrDFwDJOvnMnS8Q@mail.gmail.com>
References: <20111124163548.GC22031@mudshark.cambridge.arm.com>
 <CAL_Jsq+xZayXkOy2v7y+BittjRfC85mw-bCMrDFwDJOvnMnS8Q@mail.gmail.com>
Message-ID: <20111125154157.GP12047@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2011 at 03:19:47PM +0000, Rob Herring wrote:
> Will,

Hello Rob,

> On Thu, Nov 24, 2011 at 10:35 AM, Will Deacon <will.deacon@arm.com> wrote:
> > In commit 4294f8baa ("ARM: gic: add irq_domain support"), you define
> > irq_start as irq_start = (irq_start & ~31) + 16; (later this was predicated
> > on irq_start > 0).
> >
> > For platforms without any PPIs (i.e. irq_start is passed as a multiple of
> > 32) then this leads to IRQs being off by 16. Something like this fixes it:
> >
> 
> Which platform? I thought I surveyed all the users. I was assuming we
> only skip over PPIs on secondary GICs and primary GICs alway have PPIs
> allocated. There's not really any cost to always allocating PPIs.

This showed problems on Realview PB1176 and PBA8. If irq_start is passed as
32, then we set it to irq_start = (32 & ~31) + 16, so it ends up being 48
and everything goes wrong.

> >
> > diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> > index 0e6ae47..0c2d077 100644
> > --- a/arch/arm/common/gic.c
> > +++ b/arch/arm/common/gic.c
> > @@ -581,13 +581,16 @@ void __init gic_init(unsigned int gic_nr, int irq_start,
> > ? ? ? ? * For primary GICs, skip over SGIs.
> > ? ? ? ? * For secondary GICs, skip over PPIs, too.
> > ? ? ? ? */
> > + ? ? ? domain->hwirq_base = 32;
> > ? ? ? ?if (gic_nr == 0) {
> > ? ? ? ? ? ? ? ?gic_cpu_base_addr = cpu_base;
> > - ? ? ? ? ? ? ? domain->hwirq_base = 16;
> > - ? ? ? ? ? ? ? if (irq_start > 0)
> > - ? ? ? ? ? ? ? ? ? ? ? irq_start = (irq_start & ~31) + 16;
> > - ? ? ? } else
> > - ? ? ? ? ? ? ? domain->hwirq_base = 32;
> > +
> > + ? ? ? ? ? ? ? if ((irq_start & 31) > 0) {
> > + ? ? ? ? ? ? ? ? ? ? ? domain->hwirq_base = 16;
> > + ? ? ? ? ? ? ? ? ? ? ? if (irq_start != -1)
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? irq_start = (irq_start & ~31) + 16;
> > + ? ? ? ? ? ? ? }
> > + ? ? ? }
> >
> > ? ? ? ?/*
> > ? ? ? ? * Find out how many interrupts are supported.
> >
> >
> > which I can't say I'm especially pleased with but this code is really hard to
> > get right!
> >
> 
> Obviously! The problem is the meaning of irq_start is overloaded. It
> defines the number of PPIs and the Linux irq # base.

Indeed, and there's the magic -1 for SPARSE_IRQ as well...

> Otherwise, looks fine.

Ok, if you're happy with my logic then I can put the patch into Russell's
patch system.

Cheers,

Will
