From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 9 May 2016 15:29:50 -0700
Subject: [PATCH v7 4/9] clk: mediatek: Add MT2701 clock support
In-Reply-To: <1462775888.5344.20.camel@mtksdaap41>
References: <1460621514-65191-1-git-send-email-jamesjj.liao@mediatek.com>
 <1460621514-65191-5-git-send-email-jamesjj.liao@mediatek.com>
 <20160506231151.GI3492@codeaurora.org>
 <1462775888.5344.20.camel@mtksdaap41>
Message-ID: <20160509222950.GV3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09, James Liao wrote:
> Hi Stephen,
> 
> On Fri, 2016-05-06 at 16:11 -0700, Stephen Boyd wrote:
> > On 04/14, James Liao wrote:
> > > diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
> > > new file mode 100644
> > > index 0000000..b4db141
> > > --- /dev/null
> > > +++ b/drivers/clk/mediatek/clk-mt2701.c
> > > +static void __init mtk_infrasys_init(struct device_node *node)
> > > +{
> > > +	struct clk_onecell_data *clk_data;
> > > +	int r;
> > > +
> > > +	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
> > > +
> > > +	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
> > > +						clk_data);
> > > +	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
> > > +						clk_data);
> > > +
> > > +	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> > > +	if (r)
> > > +		pr_err("%s(): could not register clock provider: %d\n",
> > > +			__func__, r);
> > > +}
> > > +CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt2701-infracfg", mtk_infrasys_init);
> > 
> > I'm still lost on the usage of CLK_OF_DECLARE here. What part of
> > these clk controllers needs to be registered to make the timer
> > work?
> 
> GPT (mtk-timer.c) may need infracfg and topckgen clocks. MT8173 for
> example:
> 
> 	timer: timer at 10008000 {
> 	[...]
> 		clocks = <&infracfg CLK_INFRA_CLK_13M>,
> 			 <&topckgen CLK_TOP_RTC_SEL>;
> 	};

Ok. It should be possible to only register the clk tree for these
clks in CLK_OF_DECLARE() and then register the other clks that
the clk provider provides with a regular driver probe routine.
That way we can get the advantage of the device framework, etc.
but still register the clks we need to make the timer work early
on.

> 
> > > +	GATE_DISP1(CLK_MM_DPI_DIGL, "mm_dpi_digl", "dpi0_sel", 2),
> > > +	GATE_DISP1(CLK_MM_DPI_ENGINE, "mm_dpi_eng", "mm_sel", 3),
> > > +	GATE_DISP1(CLK_MM_DPI1_DIGL, "mm_dpi1_digl", "dpi1_sel", 4),
> > > +	GATE_DISP1(CLK_MM_DPI1_ENGINE, "mm_dpi1_eng", "mm_sel", 5),
> > > +	GATE_DISP1(CLK_MM_TVE_OUTPUT, "mm_tve_output", "tve_sel", 6),
> > > +	GATE_DISP1(CLK_MM_TVE_INPUT, "mm_tve_input", "dpi0_sel", 7),
> > > +	GATE_DISP1(CLK_MM_HDMI_PIXEL, "mm_hdmi_pixel", "dpi1_sel", 8),
> > > +	GATE_DISP1(CLK_MM_HDMI_PLL, "mm_hdmi_pll", "hdmi_sel", 9),
> > > +	GATE_DISP1(CLK_MM_HDMI_AUDIO, "mm_hdmi_audio", "apll_sel", 10),
> > > +	GATE_DISP1(CLK_MM_HDMI_SPDIF, "mm_hdmi_spdif", "apll_sel", 11),
> > > +	GATE_DISP1(CLK_MM_TVE_FMM, "mm_tve_fmm", "mm_sel", 14),
> > > +};
> > 
> > I also don't understand why we don't have different files and
> > drivers for all these different clock controllers? They all have
> > a similar probe structure, sure, but otherwise these are
> > different devices with different clks for them. The whole #ifdef
> > thing in the later patch would go away too.
> 
> Yes, you are right. So you prefer to support subsystem clocks in
> separated files such as clk-mt2701-mm.c, clk-mt2701-bdp.c and so on,
> right?
> 
> But even if we implement subsystem clock in separated files, we still
> need a way to make them optional. So the config options and #ifdef may
> not be removed.

Presumably different files could just not be compiled if the
config is disabled, thus removing any need for #ifdef.

> 
> > > +	GATE_BDP1(CLK_BDP_BRG_RT_B, "brg_rt_bclk", "mm_sel", 12),
> > > +	GATE_BDP1(CLK_BDP_BRG_RT_DRAM, "brg_rt_dram", "mm_sel", 13),
> > > +	GATE_BDP1(CLK_BDP_LARBRT_DRAM, "larbrt_dram", "mm_sel", 14),
> > > +	GATE_BDP1(CLK_BDP_TMDS_SYN, "tmds_syn", "hdmi_0_pll340m", 15),
> > > +	GATE_BDP1(CLK_BDP_HDMI_MON, "hdmi_mon", "hdmi_0_pll340m", 16),
> > > +};
> > > +
> > > +static void __init mtk_bdpsys_init(struct device_node *node)
> > 
> > Shouldn't be __init because it's driver probe path.
> 
> I use builtin_platform_driver_probe(clk_drv, clk_probe) to register this
> driver, and it looks can be __init.

Ok, but that doesn't work with deferred probe right? It may be
better to avoid it then.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
