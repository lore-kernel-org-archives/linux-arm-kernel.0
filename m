From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 26 May 2015 16:36:03 +0800
Subject: [PATCH 2/5] clk: mediatek: mt8173: Fix enabling of critical clocks
In-Reply-To: <20150526074608.GE6325@pengutronix.de>
References: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
 <1432192376-6712-3-git-send-email-jamesjj.liao@mediatek.com>
 <20150526074608.GE6325@pengutronix.de>
Message-ID: <1432629363.15597.5.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-05-26 at 09:46 +0200, Sascha Hauer wrote:
> > +static struct clk_onecell_data *mt8173_top_clk_data;
> > +static struct clk_onecell_data *mt8173_pll_clk_data;
> > +
> > +static void mtk_clk_enable_critical(void)
> > +{
> > +	if (!mt8173_top_clk_data || !mt8173_pll_clk_data)
> > +		return;
> > +
> > +	clk_prepare_enable(mt8173_top_clk_data->clks[CLK_TOP_MEM_SEL]);
> > +	clk_prepare_enable(mt8173_top_clk_data->clks[CLK_TOP_DDRPHYCFG_SEL]);
> > +	clk_prepare_enable(mt8173_top_clk_data->clks[CLK_TOP_CCI400_SEL]);
> > +	clk_prepare_enable(mt8173_top_clk_data->clks[CLK_TOP_RTC_SEL]);
> 
> Is CLK_TOP_RTC_SEL really a critical clock?

CLK_TOP_RTC_SEL is the main 32k clock used by some system hardware such
sleep controller on MT8173. This clock should not be turned off even
when software/CPU is sleeping. So it's a better way to set
CLK_TOP_RTC_SEL as a critical clock (an always on clock).


Best regards,

James
