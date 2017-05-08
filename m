From: dongas86@gmail.com (Dong Aisheng)
Date: Mon, 8 May 2017 19:34:59 +0800
Subject: [RFC PATCH 1/3] clk: add clk_bulk_get accessories
In-Reply-To: <20170422031647.GW7065@codeaurora.org>
References: <1491969809-20154-1-git-send-email-aisheng.dong@nxp.com>
 <1491969809-20154-2-git-send-email-aisheng.dong@nxp.com>
 <20170422031647.GW7065@codeaurora.org>
Message-ID: <20170508113459.GB18153@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 08:16:47PM -0700, Stephen Boyd wrote:
> On 04/12, Dong Aisheng wrote:
> >  
> >  #ifdef CONFIG_HAVE_CLK
> > @@ -230,6 +257,32 @@ static inline void clk_unprepare(struct clk *clk)
> >  struct clk *clk_get(struct device *dev, const char *id);
> >  
> >  /**
> > + * clk_bulk_get - lookup and obtain a number of references to clock producer.
> > + * @dev: device for clock "consumer"
> > + * @num_clks: the number of clk_bulk_data
> > + * @clks: the clk_bulk_data table of consumer
> > + *
> > + * This helper function allows drivers to get several clk consumers in one
> > + * operation. If any of the clk cannot be acquired then any clks
> > + * that were obtained will be freed before returning to the caller.
> > + *
> > + * Returns 0 if all clocks specified in clk_bulk_data table are obtained
> > + * successfully, or valid IS_ERR() condition containing errno.
> > + * The implementation uses @dev and @clk_bulk_data.id to determine the
> > + * clock consumer, and thereby the clock producer.
> > + * (IOW, @id may be identical strings, but clk_get may return different
> > + * clock producers depending on @dev.) The clock returned is stored in
> 
> This comment is inaccurate. Only one dev is possible with this
> API.
> 

Good catch! Will fix it.

> > + * each @clk_bulk_data.clk field.
> > + *
> > + * Drivers must assume that the clock source is not enabled.
> > + *
> > + * clk_bulk_get should not be called from within interrupt context.
> > + */
> > +
> 
> Drop space.
> 

Got it

> > +int __must_check clk_bulk_get(struct device *dev, int num_clks,
> > +			      struct clk_bulk_data *clks);
> > +
> > +/**
> >   * devm_clk_get - lookup and obtain a managed reference to a clock producer.
> >   * @dev: device for clock "consumer"
> >   * @id: clock consumer ID
> > @@ -279,6 +332,20 @@ struct clk *devm_get_clk_from_child(struct device *dev,
> >  int clk_enable(struct clk *clk);
> >  
> >  /**
> > + * clk_bulk_enable - inform the system when the bulk of clock source should
> > + *		     be running.
> > + * @num_clks: the number of clk_bulk_data
> > + * @clks: the clk_bulk_data table of consumer
> > + *
> > + * If the clock can not be enabled/disabled all, this should return success.
> > + *
> > + * May be called from atomic contexts.
> > + *
> > + * Returns success (0) or negative errno.
> > + */
> > +int __must_check clk_bulk_enable(int num_clks, struct clk_bulk_data *clks);
> > +
> > +/**
> >   * clk_disable - inform the system when the clock source is no longer required.
> >   * @clk: clock source
> >   *
> > @@ -295,6 +362,24 @@ int clk_enable(struct clk *clk);
> >  void clk_disable(struct clk *clk);
> >  
> >  /**
> > + * clk_bulk_disable - inform the system when the bulk of clock source is no
> > + *		      longer required.
> > + * @num_clks: the number of clk_bulk_data
> > + * @clks: the clk_bulk_data table of consumer
> > + *
> > + * Inform the system that a bulk of clock source is no longer required by
> > + * a driver and may be shut down.
> > + *
> > + * May be called from atomic contexts.
> > + *
> > + * Implementation detail: if the bulk of clock source is shared between
> 
> I'm not sure "bulk of clock source" is the correct terminology.
> Perhaps "set of clks"?
> 

Good to me, will change.

> > + * multiple drivers, clk_bulk_enable() calls must be balanced by the
> > + * same number of clk_bulk_disable() calls for the clock source to be
> > + * disabled.
> > + */
> > +void clk_bulk_disable(int num_clks, struct clk_bulk_data *clks);
> 
> We can mark clk_bulk_data structure as const here? Probably
> applies in other places as well in this patch.
> 

Sounds good, will change the following API,
clk_bulk_{enable|disable}
clk_bulk_{prepare|unprepare}
except clk_bulk_{get|put} which needs update clk_bulk_date.

Regards
Dong Aisheng
