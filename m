From: hjk@linutronix.de (Hans J. Koch)
Date: Fri, 16 Apr 2010 15:09:58 +0200
Subject: [PATCH 2/7 v4] Add the clock framework for Telechips TCC8xxx
	processors.
In-Reply-To: <20100414133507.GB21526@n2100.arm.linux.org.uk>
References: <20100331144543.GA2035@bluebox.local>
	<20100331145056.GC2035@bluebox.local>
	<20100414133507.GB21526@n2100.arm.linux.org.uk>
Message-ID: <20100416130957.GB1998@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 14, 2010 at 02:35:07PM +0100, Russell King - ARM Linux wrote:
> On Wed, Mar 31, 2010 at 04:50:58PM +0200, Hans J. Koch wrote:
> > +static void __clk_disable(struct clk *clk)
> > +{
> > +	if (!clk)
> > +		return;
> > +
> > +	BUG_ON(clk->refcount == 0);
> > +
> > +	if (!(--clk->refcount) && clk->disable)
> > +		clk->disable(clk);
> > +	__clk_disable(clk->parent);
> > +}
> > +
> > +static int __clk_enable(struct clk *clk)
> > +{
> > +	if (!clk)
> > +		return -EINVAL;
> > +
> > +	__clk_enable(clk->parent);
> 
> Here, every enable of the child clock causes the parent to be enabled
> one more time.  This is a bad idea in conjunction with...

Something went completely wrong here. These functions should recursively
enable/disable the parents when their refcount changes from/to zero. It's
mentioned in the comments, but not implemented.

> 
> > +
> > +	if (clk->refcount++ == 0 && clk->enable)
> > +		clk->enable(clk);
> > +
> > +	return 0;
> > +}
> 
> > +/* Set the clock's parent to another clock source */
> > +int clk_set_parent(struct clk *clk, struct clk *parent)
> > +{
> > +	int ret = -EINVAL;
> > +
> > +	if (!clk)
> > +		return ret;
> > +	if (!clk->set_parent || !parent)
> > +		return ret;
> > +
> > +	mutex_lock(&clocks_mutex);
> > +	ret = clk->set_parent(clk, parent);
> > +	if (ret == 0)
> > +		clk->parent = parent;
> 
> ... reparenting of clocks.
> 
> Reparenting is much easier to deal with if you only enable/disable the
> parent clock on the first enable and last disable of the child clock.
> Then you can do:
> 
> 	if (clk->refcount)
> 		__clk_enable(parent);
> 	ret = clk->set_parent(clk, parent);
> 	if (ret == 0) {
> 		old = clk->parent;
> 		clk->parent = parent;
> 	} else {
> 		old = parent;
> 	}
> 	if (clk->refcount)
> 		__clk_disable(old);
> 
> here, which will keep the refcounts straight.

Yep, you're right. With __clk_enable and __clk_disable fixed as mentioned
above, it looks a bit different. I hope I got it right this time...

> 
> > +	mutex_unlock(&clocks_mutex);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(clk_set_parent);
> 
> >  /* Clock controller registers */
> > -#define CKC_BASE		(APB1_PERI_BASE_VIRT + 0x6000)
> > -#define CKC_BASE_PHYS		(APB1_PERI_BASE + 0x6000)
> > +#define CKC_BASE	(void __iomem *)(APB1_PERI_BASE_VIRT + 0x6000)
> 
> This has the possibility of causing unexpected side effects.  With any
> macro which is more than just a number, it's always worth adding a set
> of parens around it to ensure that evaluation happens in the order you
> expect.

Fixed.

Thanks a lot for your review. I'll reply to this mail with the fixed version
of this patch. If it looks OK to you, I'll rebase the whole series to current
mainline (it's still -rc3 now) and submit v5 of the whole lot.

Thanks,
Hans
