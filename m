From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 29 Aug 2016 10:46:23 -0700
Subject: [PATCH v12 1/4] clk: mediatek: Add MT2701 clock support
In-Reply-To: <1472271377.21203.12.camel@mtksdaap41>
References: <1471854565-19810-1-git-send-email-erin.lo@mediatek.com>
 <1471854565-19810-2-git-send-email-erin.lo@mediatek.com>
 <20160824174917.GB19826@codeaurora.org>
 <1472271377.21203.12.camel@mtksdaap41>
Message-ID: <20160829174623.GB19826@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27, James Liao wrote:
> On Wed, 2016-08-24 at 10:49 -0700, Stephen Boyd wrote:
> > On 08/22, Erin Lo wrote:
> > > +
> > > +static void __init mtk_infrasys_init_early(struct device_node *node)
> > > +{
> > > +	int r, i;
> > > +
> > > +	if (!infra_clk_data) {
> > > +		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
> > > +
> > > +		for (i = 0; i < CLK_INFRA_NR; i++)
> > > +			infra_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
> > > +	}
> > > +
> > > +	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
> > > +						infra_clk_data);
> > > +
> > > +	r = of_clk_add_provider(node, of_clk_src_onecell_get, infra_clk_data);
> > > +	if (r)
> > > +		pr_err("%s(): could not register clock provider: %d\n",
> > > +			__func__, r);
> > > +}
> > > +CLK_OF_DECLARE(mtk_infra, "mediatek,mt2701-infracfg", mtk_infrasys_init_early);
> > 
> > This should use CLK_OF_DECLARE_DRIVER? Has this been tested on
> > latest clk-next? Some recent patches make it so that
> > CLK_OF_DECLARE() prevents platform devices from being created for
> > the associated DT nodes that match during of_clk_init().
> 
> Oops, you are right. Clocks in infra_clks are gone on clk-next, but they
> are good on v4.8-rc1.
> 
> I register clk13m in infra_fixed_divs through CLK_OF_DECLARE() so that
> it can be registered as early as possible because it will be referred by
> the timer driver. Is there a formal way to separate clock registrations
> on the same clock provider? Or should I move infra_clks registration
> into CLK_OF_DECLARE()?

The way to do this is use CLK_OF_DECLARE_DRIVER() and then do the
early clks in the CLK_OF callback and the rest of them in the
driver probe.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
