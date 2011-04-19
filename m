From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 19 Apr 2011 23:54:21 +0200 (CEST)
Subject: [PATCH 04/10] clk: implement parent pass through functions
In-Reply-To: <20110419190910.GQ31131@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-5-git-send-email-s.hauer@pengutronix.de>
	<4DADC45C.1020202@codeaurora.org>
	<20110419175318.GB15233@pengutronix.de>
	<20110419190910.GQ31131@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Apr 2011, Uwe Kleine-K?nig wrote:
> > +1 for letting the core enable/disable and prepare/unprepare the parent
> > clocks. I scanned the different arm clock implementations and they all
> > do it, except the ones which do not implement parents at all.
> Then the question is if all do handle parents in the same way. (i.e.
> in enable do parent first, in disable do child first?)

That's not a question at all. Anything which does it the other way
round is broken. Period.
 
> If one layer of indirection is acceptable this can easily be
> accomplished (unless I oversee something):
> 
> 	struct clk_with_parent {
> 		struct clk clk;
> 		const struct clk_ops *ops;
> 		struct clk *parent;
> 	}
> 
> Then the callbacks in clk_with_parent.clk would handle the parent and
> then call the respective callbacks in clk_with_parent.ops.

Why the heck do you want to do that? That's a complete and utter
failure. You invent indirections for no value at all which just
violate any sense of abstraction and layering.

clk_en/disable should just do (simplified):

clk_enable(clk)
{
	if (!clk)
	   return 0;

	ret = clk_enable(clk->parent);
	if (ret)
	   return ret;

	clk_refcnt++;

	if (!clk->enable) 
	   return 0;

   	ret = clk->enable();
	if (!ret)
	   return 0;

	clk_refcnt--;
	clk_disable(clk->parent);

	return ret;	
}

Now go figure how clk_disable should look like.

No clk should care about the parent at all, except for handing down
the pointer. And it should not even check for the pointer being NULL
or not. It does not matter at all, as long as clk_enable/disable
return sensible error codes.

Anything else is just overengineered clusterfuck for no value at all,
which makes error handling way more complex than it needs to be.

Thanks,

	tglx
