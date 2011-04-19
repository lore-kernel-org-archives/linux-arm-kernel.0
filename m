From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 19 Apr 2011 22:58:00 +0200
Subject: [PATCH 04/10] clk: implement parent pass through functions
In-Reply-To: <20110419190910.GQ31131@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-5-git-send-email-s.hauer@pengutronix.de>
	<4DADC45C.1020202@codeaurora.org>
	<20110419175318.GB15233@pengutronix.de>
	<20110419190910.GQ31131@pengutronix.de>
Message-ID: <20110419205800.GC15233@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 09:09:10PM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> > 
> > +1 for letting the core enable/disable and prepare/unprepare the parent
> > clocks. I scanned the different arm clock implementations and they all
> > do it, except the ones which do not implement parents at all.
> Then the question is if all do handle parents in the same way. (i.e.
> in enable do parent first, in disable do child first?)

Yes, they do.

> 
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

I fail to see what you are trying to archieve. struct clk already has a ops
pointer, what's the purpose of the additional *ops here?
Other than that I prefer not to hardcode parent pointers. Often enough I
have looked at clock trees and wondered if the clock tree is in sync
with the hardware. When we read the mux values back from the hardware in
clk_get_parent the trees are in sync by definition (modulo refcounting
when you play with the registers somewhere else).

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
