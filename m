From: mturquette@ti.com (Turquette, Mike)
Date: Sun, 6 May 2012 16:41:59 -0700
Subject: [PATCH 1/3] clk: always pass parent_rate into .round_rate
In-Reply-To: <20120502095108.GF20478@pengutronix.de>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
 <1334235019-15553-1-git-send-email-shawn.guo@linaro.org>
 <20120502095108.GF20478@pengutronix.de>
Message-ID: <CAJOA=zM7nkwadYGoPcYYJgkfhr9d05BTSmw30ez+h5KhWfK=-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120502-11:51, Sascha Hauer wrote:
> On Thu, Apr 12, 2012 at 08:50:17PM +0800, Shawn Guo wrote:
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index af2bf12..19caa0a 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -582,7 +582,7 @@ EXPORT_SYMBOL_GPL(clk_get_rate);
> >   */
> >  unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
> >  {
> > -	unsigned long unused;
> > +	unsigned long parent_rate = 0;
> >
> >  	if (!clk)
> >  		return -EINVAL;
> > @@ -590,10 +590,10 @@ unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
> >  	if (!clk->ops->round_rate)
> >  		return clk->rate;
> >
> > -	if (clk->flags & CLK_SET_RATE_PARENT)
> > -		return clk->ops->round_rate(clk->hw, rate, &unused);
> > -	else
> > -		return clk->ops->round_rate(clk->hw, rate, NULL);
> > +	if (clk->parent)
> > +		parent_rate = clk->parent->rate;
> > +
> > +	return clk->ops->round_rate(clk->hw, rate, &parent_rate);
> >  }
> >
> >  /**
> > @@ -763,7 +763,7 @@ static void clk_calc_subtree(struct clk *clk, unsigned long new_rate)
> >  static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
> >  {
> >  	struct clk *top = clk;
> > -	unsigned long best_parent_rate;
> > +	unsigned long best_parent_rate = 0;
> >  	unsigned long new_rate;
> >
> >  	/* sanity */
> > @@ -775,9 +775,6 @@ static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
> >  		if (!clk->ops->round_rate) {
> >  			clk->new_rate = clk->rate;
> >  			return NULL;
> > -		} else {
> > -			new_rate = clk->ops->round_rate(clk->hw, rate, NULL);
> > -			goto out;
> >  		}
> >  	}
>
>
> This patch allows a clk to change a parent clk rate even when
> CLK_SET_RATE_PARENT is not set.
>
> Before this patch we used to pass a NULL pointer as parent clk rate when
> a clk was not allowed to change a parent rate. Now we rely on the
> goodwill of the clk not changing the parent rate. I'll prepare a patch
> catching this in the framework.

I've cooked up a patch for this and will push it to the list for comments.

Regards,
Mike
