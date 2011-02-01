From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 1 Feb 2011 15:18:37 +0100
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <20110201131512.GH31216@n2100.arm.linux.org.uk>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201105449.GY1147@pengutronix.de>
	<20110201131512.GH31216@n2100.arm.linux.org.uk>
Message-ID: <20110201141837.GA1147@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 01:15:12PM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 01, 2011 at 11:54:49AM +0100, Uwe Kleine-K?nig wrote:
> > Alternatively don't force the sleep in clk_prepare (e.g. by protecting
> > prepare_count by a spinlock (probably enable_lock)) and call clk_prepare
> > before calling clk->ops->enable?
> 
> That's a completely bad idea.  I assume you haven't thought about this
> very much.
Right, but I thought it a bit further than you did.  Like the following:
 
int clk_prepare(struct clk *clk)
{
	int ret = 0, first;
	unsigned long flags;

	spin_lock_irqsave(&clk->enable_lock, flags);
	if (clk->flags & CLK_BUSY) {
		/* 
		 * this must not happen, please serialize calls to
		 * clk_prepare/clk_enable
		 */
		ret = -EBUSY;
		goto out_unlock;
	}
	first = clk->prepare_count++ == 0;
	if (first)
		clk->flags |= CLK_BUSY;
	spin_unlock_irqrestore(&clk->enable_lock, flags);

	if (!first)
		return 0;

	if (clk->ops->prepare) {
		might_sleep();
		ret = clk->ops->prepare(clk);
	}

	spin_lock_irqsave(&clk->enable_lock, flags);
	clk->flags &= ~CLK_BUSY;
	if (ret)
		clk->prepare_count--;
out_unlock:
	spin_unlock_irqrestore(&clk->enable_lock, flags);

	return ret;
}

If you now find a problem with that you can blame me not having thought
it to an end.

And note, this is only a suggestion.  I.e. I don't know what is the best
to do in the case where I implemented returning -EBUSY above.  BUG?
Wait for CLK_BUSY to be cleared?

I'm not sure I like "clk_prepare sleeps iff unprepared but preparable".
Still I think the approach is worth to be discussed.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
