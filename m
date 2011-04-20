From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Apr 2011 20:59:22 +0200
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <alpine.LFD.2.02.1104201704350.3323@ionos>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
Message-ID: <20110420185922.GD31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 06:16:39PM +0200, Thomas Gleixner wrote:
> On Wed, 20 Apr 2011, Uwe Kleine-K?nig wrote:
> 
> Very useful changelog.
IMHO OK for a RFC patch.

> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> > 
> > only compile tested so far.
> 
> You are not listening at all, right?
>  
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
> 
> Why the hell is this conditional? I told you that a proper abstraction
I made it conditional because the new behaviour is new and so minimizes
surprises. OK for me to drop this flag.

> is for the sane cases which are the majority of the hardware and we
> don't code for the buggy HW case unless we have evidence that it
> exists. Once we have that evidence we can decide what to do - add a
> flag or a separate function.
> 
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
> 
> And this whole mess should be written:
> 
>     ret = clk_prepare(clk->parent);
>     if (ret)
> 		return ret;
> 
> Which returns 0 when there is no parent and it also returns 0 when
> there is no prepare callback for the parent. Why the hell do we need
> all this ERRPTR checking mess and all this conditional crap ?

struct clk has no parent member, there is only clk_get_parent(). If
there is no parent it returns ERR_PTR(-ENOSYS) and if you pass that to
clk_prepare it tries to dereference it. So either it must not be called
with an error pointer or clk_prepare et al. need adaption to handle
these error pointers. I choosed the former. Ah, or clk_get_parent must
be changed that it cannot fail and returns NULL to signal that there is
no parent.

I found some problems with my patch, so I will try if I can make you
more happy with a v2.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
