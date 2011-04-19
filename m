From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 19 Apr 2011 21:09:10 +0200
Subject: [PATCH 04/10] clk: implement parent pass through functions
In-Reply-To: <20110419175318.GB15233@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-5-git-send-email-s.hauer@pengutronix.de>
	<4DADC45C.1020202@codeaurora.org>
	<20110419175318.GB15233@pengutronix.de>
Message-ID: <20110419190910.GQ31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Apr 19, 2011 at 07:53:18PM +0200, Sascha Hauer wrote:
> On Tue, Apr 19, 2011 at 10:20:28AM -0700, Stephen Boyd wrote:
> > On 04/15/2011 12:08 PM, Sascha Hauer wrote:
> > > A common case for clocks is that certain operations are not implemented
> > > and shall be passed through to the parent. Add convenience functions
> > > for this purpose
> > >
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
> > >
> > 
> > I was hoping we could just build the parent handling into the core
> > instead of having every clk_ops->enable call the parent ops.
> > 
> > Something like: if the clk_ops doesn't have a get_parent,
> > clk_get_parent() would return NULL, and if the clk_ops doesn't have a
> > set_parent, clk_set_parent() would do nothing.
> 
> That's the current behaviour (except that ERR_PTR(-ENOSYS) is returned
> instead of NULL).
> 
> > 
> > Then clk_enable()/clk_disable() would call clk_get_parent() and then
> > clk_enable() on that (whatever it is) before calling down into the
> > ops->enable() function. Of course this means NULL is now the "no parent"
> > value as opposed to ERR_PTR(-ENOSYS) but I'm willing to live with that
> > since it makes things a bit simpler when you only have to check for NULL
> > in the clk_enable()/clk_disable() path as opposed to NULL and IS_ERR.
> > 
> > I'm afraid this patch means every time the clk_ops wants to enable its
> > parent (which is almost always the case), it has to do so explicitly
> > when we really just want to concentrate on what enabling means for that
> > clock (namely setting some bits in some registers). Thoughts?
> 
> +1 for letting the core enable/disable and prepare/unprepare the parent
> clocks. I scanned the different arm clock implementations and they all
> do it, except the ones which do not implement parents at all.
Then the question is if all do handle parents in the same way. (i.e.
in enable do parent first, in disable do child first?)

If one layer of indirection is acceptable this can easily be
accomplished (unless I oversee something):

	struct clk_with_parent {
		struct clk clk;
		const struct clk_ops *ops;
		struct clk *parent;
	}

Then the callbacks in clk_with_parent.clk would handle the parent and
then call the respective callbacks in clk_with_parent.ops.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
