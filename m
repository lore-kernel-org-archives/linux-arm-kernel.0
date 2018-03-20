From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 20 Mar 2018 13:01:54 -0700
Subject: [PATCH v3 03/10] clk: qcom: Add CPU clock driver for msm8996
In-Reply-To: <015201d3c056$658ff510$30afdf30$@codeaurora.org>
References: <1518616792-29028-1-git-send-email-ilialin@codeaurora.org>
 <1518616792-29028-4-git-send-email-ilialin@codeaurora.org>
 <152148100496.242365.3846617702949655708@swboyd.mtv.corp.google.com>
 <015201d3c056$658ff510$30afdf30$@codeaurora.org>
Message-ID: <152157611468.125118.11602572683762995667@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting ilialin at codeaurora.org (2018-03-20 07:18:57)
> > From: Stephen Boyd <sboyd@kernel.org>
> > 
> > > +       struct clk_regmap *clkr = to_clk_regmap(hw);
> > > +       struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
> > > +       unsigned int mask = GENMASK(cpuclk->width + cpuclk->shift - 1,
> > > +                                   cpuclk->shift);
> > > +
> > > +       val = index;
> > > +       val <<= cpuclk->shift;
> > > +
> > > +       return regmap_update_bits(clkr->regmap, cpuclk->reg, mask,
> > > +val); }
> > > +
> > > +static int
> > > +clk_cpu_8996_mux_determine_rate(struct clk_hw *hw, struct
> > > +clk_rate_request *req) {
> > > +       struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
> > > +       struct clk_hw *parent = cpuclk->pll;
> > > +
> > > +       if (!cpuclk->pll)
> > > +               return -EINVAL;
> > 
> > Does this happen?
> 
> On successful probe it shouldn't. May I omit pointer checks in this case? Future maintenance ma y change the flow.
> 

Yes please omit useless checks.

> > 
> > > +
> > > +       req->best_parent_rate = clk_hw_round_rate(parent, req->rate);
> > > +       req->best_parent_hw = parent;
> > 
> > Is the parent index always the same? Perhaps just call
> > clk_hw_get_parent_by_index() then instead of adding a pointer to the
> > clk_cpu_8996_mux.
> > 
> 
> > 
> > > +       },
> > > +};
> > > +
> > > +static const struct regmap_config cpu_msm8996_regmap_config = {
> > > +       .reg_bits               = 32,
> > > +       .reg_stride             = 4,
> > > +       .val_bits               = 32,
> > > +       .max_register           = 0x80210,
> > > +       .fast_io                = true,
> > > +       .val_format_endian      = REGMAP_ENDIAN_LITTLE,
> > > +};
> > > +
> > > +static const struct of_device_id match_table[] = {
> > 
> > Move this next to driver structure and give it a more specific name.
> 
> Will be changed in the next spin.
> 
> > 
> > > +       { .compatible = "qcom-msm8996-apcc" },
> > 
> > Bad compatible? Should be qcom,msm8996-apcc?
> 
> The naming is per Rob Herring's requirement.
> 

Hmm, maybe Rob made a typo?
