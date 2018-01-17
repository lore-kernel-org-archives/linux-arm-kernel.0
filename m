From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 17 Jan 2018 10:57:18 +0800
Subject: [RFC PATCH V1 2/2] clk: add lock for clk_core_is_enabled
In-Reply-To: <20171227012918.GU7997@codeaurora.org>
References: <1513935965-12909-1-git-send-email-aisheng.dong@nxp.com>
 <1513935965-12909-2-git-send-email-aisheng.dong@nxp.com>
 <20171227012918.GU7997@codeaurora.org>
Message-ID: <20180117025718.GA7760@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 26, 2017 at 05:29:18PM -0800, Stephen Boyd wrote:
> On 12/22, Dong Aisheng wrote:
> > According to design doc, .is_enabled should be protected by enable lock.
> > Then users don't have to protect it against enable/disable operation
> > in clock drivers.
> > 
> > See: Documentation/clk.txt
> > "The enable lock is a spinlock and is held across calls to the .enable,
> > .disable and .is_enabled operations."
> > 
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  drivers/clk/clk.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index e24968f..d6e2d5c 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -198,14 +198,19 @@ static bool clk_core_is_prepared(struct clk_core *core)
> >  
> >  static bool clk_core_is_enabled(struct clk_core *core)
> >  {
> > +	unsigned long flags;
> >  	bool ret = false;
> >  
> > +	flags = clk_enable_lock();
> > +
> >  	/*
> >  	 * .is_enabled is only mandatory for clocks that gate
> >  	 * fall back to software usage counter if .is_enabled is missing
> >  	 */
> > -	if (!core->ops->is_enabled)
> > +	if (!core->ops->is_enabled) {
> > +		clk_enable_unlock(flags);
> >  		return core->enable_count;
> > +	}
> >  
> >  	/*
> >  	 * Check if clock controller's device is runtime active before
> > @@ -230,6 +235,8 @@ static bool clk_core_is_enabled(struct clk_core *core)
> >  	if (core->dev)
> >  		pm_runtime_put(core->dev);
> >  
> > +	clk_enable_unlock(flags);
> > +
> >  	return ret;
> >  }
> 
> It doesn't really make any sense to hold the enable lock inside
> the clk_core_is_enabled() function, unless you want to do
> something else with the information of the enable state with that
> lock held. Otherwise, seeing if a clk is enabled is a one-shot
> read of the enabled state, which could just as easily change
> after the function returns because the lock is released.
> 
> We should update the documentation.
> 

Yes, you're absolutely right.
I could draft a patch to update it later.

Thanks

Regards
Dong Aisheng

> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
