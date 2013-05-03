From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 4 May 2013 00:38:34 +0200 (CEST)
Subject: [RFC patch 7/8] genirq: generic chip: Add linear irq domain
 support
In-Reply-To: <20130503222300.GF18614@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1305031514230.2886@ionos>
 <20130503212258.385818955@linutronix.de>
 <20130503214629.810207749@linutronix.de>
 <20130503222300.GF18614@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1305040033000.2990@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 May 2013, Russell King - ARM Linux wrote:

> On Fri, May 03, 2013 at 09:50:53PM -0000, Thomas Gleixner wrote:
> > +	/* Init mask cache ? */
> > +	if (dgc->gc_flags & IRQ_GC_INIT_MASK_CACHE) {
> > +		raw_spin_lock_irqsave(&gc->lock, flags);
> > +		gc->mask_cache = irq_reg_readl(gc->reg_base + ct->regs.mask);
> > +		raw_spin_unlock_irqrestore(&gc->lock, flags);
> > +	}
> 
> This looks a little weird to me - it seems that it'll re-read this
> each time any irq is mapped in the domain, which is probably not
> wanted.

Yes, it's sloppy in two aspects.

1) It does not respect the per irq type mask cache, which got
   introduced in the same series

2) It rereads the mask cache for each mapping, but thats harmless
   because it's proper serialized. We can avoid that by clearing the
   IRQ_GC_INIT_MASK_CACHE bit when the first irq of that chip is
   mapped.

Congrats, you found a bug and as I said:

	  WARNING: It's compile tested only. So if you find bugs you can keep
	  them and fix them yourself :)

Thanks,

	tglx
