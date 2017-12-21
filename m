From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Dec 2017 15:20:32 -0800
Subject: [PATCH V4 1/1] clk: bulk: add of_clk_bulk_get()
In-Reply-To: <20171220135330.GA30461@b29396-OptiPlex-7040>
References: <1506415441-4435-1-git-send-email-aisheng.dong@nxp.com>
 <20170929224821.GM457@codeaurora.org>
 <20171220135330.GA30461@b29396-OptiPlex-7040>
Message-ID: <20171221232032.GD7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20, Dong Aisheng wrote:
> On Fri, Sep 29, 2017 at 03:48:21PM -0700, Stephen Boyd wrote:
> > On 09/26, Dong Aisheng wrote:
> > > here to handle this for DT users without 'clock-names' specified.
> 
> > > +#endif
> > >  
> > >  void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
> > >  {
> > > diff --git a/include/linux/clk.h b/include/linux/clk.h
> > > index 12c96d9..073cb3b 100644
> > > --- a/include/linux/clk.h
> > > +++ b/include/linux/clk.h
> > > @@ -680,10 +680,18 @@ static inline void clk_bulk_disable_unprepare(int num_clks,
> > >  }
> > >  
> > >  #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
> > > +int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
> > > +				 struct clk_bulk_data *clks);
> > >  struct clk *of_clk_get(struct device_node *np, int index);
> > >  struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
> > >  struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
> > >  #else
> > > +static inline int of_clk_bulk_get(struct device_node *np, int num_clks,
> > 
> > Do we need __must_check here too?
> 
> Yes, you're absolutely right.
> 
> of_clk_bulk_get is special as it returns error, so should add __must_check.
> 
> > We should do the same for the
> > other bulk get APIs. Seems we missed that part last time.
> > 
> 
> Currently for !CONFIG_HAVE_CLK case, all APIs return 0.
> !CONFIG_HAVE_CLK
> clk_bulk_get		return 0
> devm_clk_bulk_get	return 0
> clk_bulk_enable		return 0
> clk_bulk_prepare	return 0
> 
> Do you think we still need add __must_check for them?

Yes, we need it even when !CONFIG_HAVE_CLK because it allows us
to catch missing checking return values in the non-clk compile
configurations too. More test coverage.

> 
> And for CONFIG_HAVE_CLK case, all __must_check already added.
> 
> int __must_check clk_bulk_get
> int __must_check devm_clk_bulk_get
> int __must_check clk_bulk_enable
> int __must_check clk_bulk_prepare
> 
> And no need for void function.
> void clk_bulk_put
> void clk_bulk_unprepare
> void clk_bulk_disable
> 
> > I'll fix all these things up when applying.
> > 
> 
> I did not see this in latest tree.
> Suppose i should resend it with above things fixed, right?
> 

I dropped it because it seems like maybe we don't need
of_clk_bulk_get(), but more like clk_get_all() or something like
that to acquire all clks for a device. It seems like it isn't DT
specific, and so we should just provide the "all" API instead of
some DT specific one that needs to know how many clks to get. I
think I sent a similar reply on some other thread and added you
to it.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
