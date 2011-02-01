From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Feb 2011 14:39:32 +0000
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <20110201141837.GA1147@pengutronix.de>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201105449.GY1147@pengutronix.de>
	<20110201131512.GH31216@n2100.arm.linux.org.uk>
	<20110201141837.GA1147@pengutronix.de>
Message-ID: <20110201143932.GK31216@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 03:18:37PM +0100, Uwe Kleine-K?nig wrote:
> On Tue, Feb 01, 2011 at 01:15:12PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Feb 01, 2011 at 11:54:49AM +0100, Uwe Kleine-K?nig wrote:
> > > Alternatively don't force the sleep in clk_prepare (e.g. by protecting
> > > prepare_count by a spinlock (probably enable_lock)) and call clk_prepare
> > > before calling clk->ops->enable?
> > 
> > That's a completely bad idea.  I assume you haven't thought about this
> > very much.
> Right, but I thought it a bit further than you did.  Like the following:
>  
> int clk_prepare(struct clk *clk)
> {
> 	int ret = 0, first;
> 	unsigned long flags;
> 
> 	spin_lock_irqsave(&clk->enable_lock, flags);
> 	if (clk->flags & CLK_BUSY) {
> 		/* 
> 		 * this must not happen, please serialize calls to
> 		 * clk_prepare/clk_enable
> 		 */

How do different drivers serialize calls to clk_prepare?  Are you
really suggesting that we should have a global mutex somewhere to
prevent this?

> 		ret = -EBUSY;
> 		goto out_unlock;
> 	}
> 	first = clk->prepare_count++ == 0;
> 	if (first)
> 		clk->flags |= CLK_BUSY;
> 	spin_unlock_irqrestore(&clk->enable_lock, flags);
> 
> 	if (!first)
> 		return 0;
> 
> 	if (clk->ops->prepare) {
> 		might_sleep();
> 		ret = clk->ops->prepare(clk);
> 	}
> 
> 	spin_lock_irqsave(&clk->enable_lock, flags);
> 	clk->flags &= ~CLK_BUSY;
> 	if (ret)
> 		clk->prepare_count--;
> out_unlock:
> 	spin_unlock_irqrestore(&clk->enable_lock, flags);
> 
> 	return ret;
> }
> 
> If you now find a problem with that you can blame me not having thought
> it to an end.
> 
> And note, this is only a suggestion.  I.e. I don't know what is the best
> to do in the case where I implemented returning -EBUSY above.  BUG?
> Wait for CLK_BUSY to be cleared?

So what're you proposing that a driver writer should do when he sees
-EBUSY returned from this function?  Abandon the probe() returning -EBUSY
and hope the user retries later?  Or maybe:

	do {
		err = clk_prepare(clk);
	} while (err == -EBUSY);

?

I don't think that's reasonable to offload this onto driver writers, who
already have a big enough problem already.  The less complexity that
driver writers have to deal with, the better.
