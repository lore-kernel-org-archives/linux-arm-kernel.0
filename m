From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 1 Feb 2011 22:40:37 +0800
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <20110201141837.GA1147@pengutronix.de>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201131512.GH31216@n2100.arm.linux.org.uk>
	<20110201141837.GA1147@pengutronix.de>
Message-ID: <201102012240.38100.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Thanks for the feedback, I'm not sure I like the more complex approach though:

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
> 		ret = -EBUSY;
> 		goto out_unlock;

Why is this an error? Two separate drivers may be clk_prepare()-ing at the 
same time, which should be acceptable. Both calls should block until the 
prepare is complete.

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

Cheers,


Jeremy
