From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 20 Mar 2018 10:15:28 -0700
Subject: [PATCH v5 09/12] clk: actions: Add fixed factor clock support
In-Reply-To: <20180320090400.6bgugy6fgze3ohsd@linaro.org>
References: <20180317100952.28538-1-manivannan.sadhasivam@linaro.org>
 <20180317100952.28538-10-manivannan.sadhasivam@linaro.org>
 <152150820384.254778.6585368643028088392@swboyd.mtv.corp.google.com>
 <20180320090400.6bgugy6fgze3ohsd@linaro.org>
Message-ID: <152156612855.183971.17769572831805053841@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Manivannan Sadhasivam (2018-03-20 02:04:00)
> On Mon, Mar 19, 2018 at 06:10:03PM -0700, Stephen Boyd wrote:
> > > +        * nop.
> > > +        */
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +const struct clk_ops owl_fix_fact_ops = {
> > > +       .round_rate     = owl_fix_fact_round_rate,
> > > +       .recalc_rate    = owl_fix_fact_recalc_rate,
> > > +       .set_rate       = owl_fix_fact_set_rate,
> > > +};
> > 
> > Why can't you use the regular fixed factor clk code and ops?
> >
> 
> That's going to be really messy. Since I'm having the clk_hw embedded inside
> owl_clk_common and using it for registering all the clocks, using generic
> fixed factor functions will be a different approach _only_ for this clock and
> it won't look good I guess. Also, it may become complicated with composite
> clocks.
> 
> If you still want to use the generic fixed factor code, I can do that in
> next revision.
> 

The qcom clk driver has support for the 'regmap' clk_hws and the
non-regmap based clk_hws. I suggest having a list of clk_hw pointers
that you register in a loop and then have other lists that you use to
register wrapper structs, etc. Otherwise we're left with a bunch of code
that's copy/pasted around.
