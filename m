From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 18 Apr 2011 11:48:35 +0200
Subject: [PATCH 04/10] clk: implement parent pass through functions
In-Reply-To: <20110418092504.GD31131@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-5-git-send-email-s.hauer@pengutronix.de>
	<20110418092504.GD31131@pengutronix.de>
Message-ID: <20110418094835.GI14770@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 11:25:04AM +0200, Uwe Kleine-K?nig wrote:
> On Fri, Apr 15, 2011 at 09:08:09PM +0200, Sascha Hauer wrote:
> > A common case for clocks is that certain operations are not implemented
> > and shall be passed through to the parent. Add convenience functions
> > for this purpose
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
> > ---
> >  drivers/clk/clk.c   |   77 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/clk.h |    9 ++++++
> >  2 files changed, 86 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 264c809..7e2c182 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -171,3 +171,80 @@ struct clk_ops clk_fixed_ops = {
> >  	.get_rate = clk_fixed_get_rate,
> >  };
> >  EXPORT_SYMBOL_GPL(clk_fixed_ops);
> > +
> > +int clk_parent_prepare(struct clk *clk)
> > +{
> > +	struct clk *parent = clk_get_parent(clk);
> > +
> > +	if (IS_ERR(parent))
> > +		return -ENOSYS;
> > +
> > +	return clk_prepare(parent);
> > +}
> > +EXPORT_SYMBOL_GPL(clk_parent_prepare);
> > +
> > +void clk_parent_unprepare(struct clk *clk)
> > +{
> > +	struct clk *parent = clk_get_parent(clk);
> > +
> > +	if (IS_ERR(parent))
> > +		return;
> > +
> > +	clk_unprepare(parent);
> > +}
> > +EXPORT_SYMBOL_GPL(clk_parent_unprepare);
> > +
> > +int clk_parent_enable(struct clk *clk)
> > +{
> > +	struct clk *parent = clk_get_parent(clk);
> > +
> > +	if (IS_ERR(parent))
> > +		return 0;
> Do you really want to return 0 here? IMHO something is fishy if a clock
> has .enable = clk_parent_enable but has no parent.

However we decide, it should return the same value as clk_parent_prepare
above. Yes, -ENOSYS seems better here.

> >  
> > +/* generic pass-through-to-parent functions */
> > +int clk_parent_prepare(struct clk *clk);
> > +void clk_parent_unprepare(struct clk *clk);
> > +int clk_parent_enable(struct clk *clk);
> > +void clk_parent_disable(struct clk *clk);
> > +unsigned long clk_parent_get_rate(struct clk *clk);
> > +long clk_parent_round_rate(struct clk *clk, unsigned long rate);
> > +int clk_parent_set_rate(struct clk *clk, unsigned long rate);
> > +
> Technically they don't need to depend on USE_COMMON_STRUCT_CLK.

Indeed. Maybe this dependency can add some motivation to switch to
common struct clk.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
