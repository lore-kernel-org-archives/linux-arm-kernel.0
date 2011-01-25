From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Jan 2011 15:41:33 +0000
Subject: [PATCH v2 04/28] ARM: mm: cache-l2x0: Add support for
	re-enabling l2x0
In-Reply-To: <1295968464.10109.264.camel@e102109-lin.cambridge.arm.com>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
	<1295834493-5019-5-git-send-email-ccross@android.com>
	<1295968464.10109.264.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20110125154133.GB17280@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 03:14:24PM +0000, Catalin Marinas wrote:
> On Mon, 2011-01-24 at 02:01 +0000, Colin Cross wrote:
> > --- a/arch/arm/mm/cache-l2x0.c
> > +++ b/arch/arm/mm/cache-l2x0.c
> > @@ -252,16 +252,26 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
> >         spin_unlock_irqrestore(&l2x0_lock, flags);
> >  }
> > 
> > +/* enables l2x0 after l2x0_disable, does not invalidate */
> > +void l2x0_enable(void)
> > +{
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&l2x0_lock, flags);
> > +       writel_relaxed(1, l2x0_base + L2X0_CTRL);
> > +       spin_unlock_irqrestore(&l2x0_lock, flags);
> > +}
> > +
> >  static void l2x0_disable(void)
> >  {
> >         unsigned long flags;
> > 
> >         spin_lock_irqsave(&l2x0_lock, flags);
> > -       writel(0, l2x0_base + L2X0_CTRL);
> > +       writel_relaxed(0, l2x0_base + L2X0_CTRL);
> >         spin_unlock_irqrestore(&l2x0_lock, flags);
> >  }
> > 
> > -void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
> > +void l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
> >  {
> >         __u32 aux;
> >         __u32 cache_id;
> 
> So this assumes that the L2 registers are accessible. I suspect the
> platform code calling it should know this.
> 
> The patch looks fine.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I think we need to come up with some proper way to deal with cpuidle
which doesn't involve adding lots of globally visible functions to all
sorts of bits of code and having platforms call them individually,
otherwise this is going to get _really_ messy in the future.

Maybe we need a notifier list which can be told when cpuidle events
happen, so that parts of the system such as VFP and L2 cache support
can do the right thing without having platforms add lots of stuff like

	gic_secondary_init();
	gic_restore_interrupt_types();
	vfp_enable();
	l2x0_enable();
	twd_enable();
	... etc ...

in their SoC specific code.
