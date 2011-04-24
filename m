From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 24 Apr 2011 22:14:30 +0200
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110424094557.GA2310@richard-laptop>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110424094557.GA2310@richard-laptop>
Message-ID: <20110424201430.GR31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 24, 2011 at 05:45:57PM +0800, Richard Zhao wrote:
> Hi Uwe,
> On Wed, Apr 20, 2011 at 04:07:37PM +0200, Uwe Kleine-K?nig wrote:
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> > 
> > only compile tested so far.
> > 
> > Best regards
> > Uwe
> > 
> >  drivers/clk/clk.c   |   43 +++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/clk.h |    8 ++++++++
> >  2 files changed, 51 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 264c809..7627815 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -14,10 +14,23 @@
> >  int clk_prepare(struct clk *clk)
> >  {
> >  	int ret = 0;
> > +	struct clk *parent = ERR_PTR(-ENOSYS);
> >  
> >  	if (!clk)
> >  		return 0;
> >  
> > +	if (clk->ops->flags & CLK_OPS_GENERIC_PARENT) {
> > +		parent = clk_get_parent(clk);
> > +
> > +		if (!IS_ERR(parent)) {
> > +			ret = clk_prepare(parent);
> > +			if (ret)
> > +				return ret;
> > +		} else if (PTR_ERR(parent) != -ENOSYS)
> > +			/* -ENOSYS means no parent and is OK */
> > +			return PTR_ERR(parent);
> > +	}
> Is this supposed to be in prepare_lock? If prepare_count > 1, we need do nothing.
> Other parent operations need to be in lock protect too.
Yeah, I noticed that myself, too. Also it would be nice to handle the
set_parent callback.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
