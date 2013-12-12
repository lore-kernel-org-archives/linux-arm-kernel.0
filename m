From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 12 Dec 2013 09:02:53 -0500
Subject: [PATCH v5 1/3] ARM: Introduce atomic MMIO modify
In-Reply-To: <20131212135819.GH12617@mudshark.cambridge.arm.com>
References: <1386686497-20335-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1386686497-20335-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131210164907.GA11468@sirena.org.uk>
 <20131210170025.GA4360@n2100.arm.linux.org.uk>
 <20131211204942.GF5461@localhost>
 <20131212135819.GH12617@mudshark.cambridge.arm.com>
Message-ID: <20131212140253.GO10053@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 01:58:19PM +0000, Will Deacon wrote:
> On Wed, Dec 11, 2013 at 08:49:43PM +0000, Ezequiel Garcia wrote:
> > On Tue, Dec 10, 2013 at 05:00:25PM +0000, Russell King - ARM Linux wrote:
> > > On Tue, Dec 10, 2013 at 04:49:07PM +0000, Mark Brown wrote:
> > > > On Tue, Dec 10, 2013 at 11:41:35AM -0300, Ezequiel Garcia wrote:
> > > > 
> > > > > +void atomic_io_modify_relaxed(void __iomem *reg, u32 mask, u32 set)
> > > > > +{
> > > > > +	unsigned long flags;
> > > > > +	u32 value;
> > > > > +
> > > > > +	raw_spin_lock_irqsave(&__io_lock, flags);
> > > > > +	value = readl_relaxed(reg) & ~mask;
> > > > > +	value |= (set & mask);
> > > > > +	writel_relaxed(value, reg);
> > > > > +	raw_spin_unlock_irqrestore(&__io_lock, flags);
> > > > > +}
> > > > > +EXPORT_SYMBOL(atomic_io_modify_relaxed);
> > > > 
> > > > This looks quite generic - why is it in architecture specific code?
> > > 
> > > because the _relaxed IO operators don't exist on other architectures, and
> > > there's been some discussion around whether they should with no conclusions
> > > being reached.
> > 
> > Exactly.
> > 
> > Will? Catalin? Any comments on this?
> 
> Yes: BenH and I managed to come up with an agreement on the relaxed I/O
> accessors during kernel summit which I need to write up and send out again.
> This would allow for a generic definition of the accessors, then this could
> potentially be done in core code.

Do you prefer this series to wait then?

thx,

Jason.
