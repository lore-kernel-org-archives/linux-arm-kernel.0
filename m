From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 26 Dec 2013 11:31:01 -0800
Subject: [PATCH v4 03/15] clk: Add regmap core helpers for
 enable/disable/is_enabled
In-Reply-To: <20131224150741.GG8064@book.gsilab.sittig.org>
References: <1387847559-18330-1-git-send-email-sboyd@codeaurora.org>
 <1387847559-18330-4-git-send-email-sboyd@codeaurora.org>
 <20131224150741.GG8064@book.gsilab.sittig.org>
Message-ID: <20131226193101.GH31766@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/24, Gerhard Sittig wrote:
> On Mon, Dec 23, 2013 at 17:12 -0800, Stephen Boyd wrote:
> > 
> > The clock framework already has support for simple gate clocks
> > but if drivers want to use the gate clock functionality they need
> > to wrap the gate clock in another struct and chain the ops by
> > calling the gate ops from their own custom ops. Plus the gate
> > clock implementation only supports MMIO accessors so other bus
> > type clocks don't benefit from the potential code reuse. Add some
> > simple regmap helpers for enable/disable/is_enabled that drivers
> > can use as drop in replacements for their clock ops or as simple
> > functions they call from their own custom ops. This is based on 
> > similar helps in the regulator framework.
> 
> The same comment applies as to the previous version.  Is it
> useful to introduce copies of the gate handling while the
> difference in only in how the hardware registers get accessed?
> 

I don't plan to use the clk-gate.c implementation because I need
more than just a bit toggling clock. We can easily make
clk-gate.c use these helpers if you're worried about the very
small amount of code duplication between the two. I'd be glad to
do that, I just didn't include it here because I don't have a use
for it.

> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -177,11 +177,21 @@ struct clk_init_data {
> > [ ... ]
> > @@ -447,6 +457,9 @@ struct clk *__clk_lookup(const char *name);
> >  long __clk_mux_determine_rate(struct clk_hw *hw, unsigned long rate,
> >  			      unsigned long *best_parent_rate,
> >  			      struct clk **best_parent_p);
> > +int clk_is_enabled_regmap(struct clk_hw *hw);
> > +int clk_enable_regmap(struct clk_hw *hw);
> > +void clk_disable_regmap(struct clk_hw *hw);
> 
> Looking at the patch:  Do you expect callers to remember whether
> a clock gate is backed by mmio or by regmap access, to call a
> different set of routines? 

There are only regmap functions. I'm not sure where the choice
is, but I expect the callers to know what they're doing. If you
look at the rest of this series you'll see that I assign these
functions directly to the clk_ops, or I call them from the
enable/disable functions that need to do some status bit polling
after the clock is enabled or disabled.

> Should this not be hidden behind the
> API and be transparent after clock registration?

I don't really understand what you mean by hiding it behind the
API? What API? If we're talking about clk_register_gate() I think
we would need to add a clk_register_regmap_gate() function
because the reg argument is an __iomem pointer. It doesn't look
like it can be transparent unless that pointer is reused as an
offset. I don't attempt to do anything about that here though
because I don't use the clk-gate.c code.

> 
> I'd suggest to fold regmap support into Tero Kristo's ll_ops
> approach, and to discuss this in his v12 thread.

Sure, I'll go look at and reply to that thread. How do you think
I can benefit from Tero's patch series? From what I can tell
ll_ops are a simplified version of regmap. Was regmap dismissed
because the omap clock driver is not actually a platform driver?
There doesn't seem to be any details in the thread(s) about why
the ll_ops were proposed over regmap. From my perspective, using
a regmap like is proposed in my patches is the better way to do
this and it doesn't require any thing like ll_ops or clk_readl()
to do it.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
