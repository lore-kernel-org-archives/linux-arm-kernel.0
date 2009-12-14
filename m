From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Dec 2009 11:25:19 +0000
Subject: [RFC PATCH 2/2] ARM: cache-l2x0: make better use of
	backgroundcache handling
In-Reply-To: <20091214105202.GA9939@n2100.arm.linux.org.uk>
References: <E1NJVx6-0006um-Do@rmk-PC.arm.linux.org.uk>
	<1260786519.17159.19.camel@pc1117.cambridge.arm.com>
	<20091214105202.GA9939@n2100.arm.linux.org.uk>
Message-ID: <1260789919.17159.46.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-12-14 at 10:52 +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 14, 2009 at 10:28:39AM +0000, Catalin Marinas wrote:
> > On Sat, 2009-12-12 at 17:40 +0000, Russell King - ARM Linux wrote:
> > > There's no point having the hardware support background operations
> > > if we issue a cache operation, and then wait for it to complete
> > > before calculating the address of the next operation.  We gain no
> > > advantage in the cache controller stalling the bus until completion.
> > >
> > > What we should be doing is using the 'wait' time productively by
> > > calculating the address of the next operation, and only then waiting
> > > for the previous operation to complete.  This means that cache
> > > operations can occur in parallel with the CPU calculating the next
> > > address.
> > [...]
> > >  static void l2x0_inv_range(unsigned long start, unsigned long end)
> > >  {
> > > +   void __iomem *base = l2x0_base;
> > >     unsigned long flags;
> > > 
> > >     spin_lock_irqsave(&l2x0_lock, flags);
> > >     if (start & (CACHE_LINE_SIZE - 1)) {
> > >             start &= ~(CACHE_LINE_SIZE - 1);
> > > -           sync_writel(start, L2X0_CLEAN_INV_LINE_PA, 1);
> > > +           cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
> > > +           writel(start, base + L2X0_CLEAN_INV_LINE_PA);
> > >             start += CACHE_LINE_SIZE;
> > >     }
> > > 
> > >     if (end & (CACHE_LINE_SIZE - 1)) {
> > >             end &= ~(CACHE_LINE_SIZE - 1);
> > > -           sync_writel(end, L2X0_CLEAN_INV_LINE_PA, 1);
> > > +           cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
> > > +           writel(end, base + L2X0_CLEAN_INV_LINE_PA);
> > >     }
> >
> > Do we need a cache_wait() on L2X0_CLEAN_INV_LINE_PA here? Actually, do
> > we need the cache_wait() before writel()? Can we have it after?
> 
> I'm afraid that you've completely missed the whole point of this patch as
> you've made that statement.
> 
> The point here is that rather than spinning on the L2 controller, waiting
> for it to say that it's completed, and _then_ calculating the data for
> the next operation, we do the two operations in parallel - while the L2
> controller is busy, we can be preparing the next operation.

I got this point and it makes sense in the loop but for these two cases
there was no loop (and all the loops have an additional cache_wait at
the end).

> Now, as for "do we need a cache_wait() on L2X0_CLEAN_INV_LINE_PA", I've
> no idea.
> 
> The specs are not entirely clear, but from my reading of them, _any_
> "register 7" read will do.  What I need is for someone to talk to the
> hardware people to confirm that - for PL210, PL220 and PL310.  You will
> find further details on this in my email to you on the 19th November
> with the subject of "cache-l2x0.c".

OK, I think the spec is pretty clear that there is only one C bit for
background operation in progress and it can be read from several
registers. I just confirmed with the hardware people and the C bit is
indeed common to all registers. In this case:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
