From: jamesjj.liao@mediatek.com (James Liao)
Date: Mon, 15 Feb 2016 17:50:57 +0800
Subject: [PATCH v6 7/7] clk: mediatek: Enable critical clocks for MT2701
In-Reply-To: <20160211213542.26445.82983@quark.deferred.io>
References: <1454665050-37776-1-git-send-email-jamesjj.liao@mediatek.com>
 <1454665050-37776-8-git-send-email-jamesjj.liao@mediatek.com>
 <20160211213542.26445.82983@quark.deferred.io>
Message-ID: <1455529857.29688.36.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Thu, 2016-02-11 at 13:35 -0800, Michael Turquette wrote:
> Hi James,
> 
> Quoting James Liao (2016-02-05 01:37:30)
> > Some system clocks should be turned on by default on MT2701.
> > This patch enable these clocks when related clocks have
> > been registered.
> > 
> > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> > ---
> >  drivers/clk/mediatek/clk-mt2701.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
> > index 01722e0..f7b4d52 100644
> > --- a/drivers/clk/mediatek/clk-mt2701.c
> > +++ b/drivers/clk/mediatek/clk-mt2701.c
> > @@ -573,6 +573,21 @@ static const struct mtk_gate top_clks[] __initconst = {
> >         GATE_TOP_AUD(CLK_TOP_AUD_I2S6_MCLK, "aud_i2s6_mclk", "aud_k6_src_div", 28),
> >  };
> >  
> > +static struct clk_onecell_data *top_clk_data __initdata;
> > +static struct clk_onecell_data *pll_clk_data __initdata;
> > +
> > +static void __init mtk_clk_enable_critical(void)
> > +{
> > +       if (!top_clk_data || !pll_clk_data)
> > +               return;
> > +
> > +       clk_prepare_enable(pll_clk_data->clks[CLK_APMIXED_ARMPLL]);
> > +       clk_prepare_enable(top_clk_data->clks[CLK_TOP_AXI_SEL]);
> > +       clk_prepare_enable(top_clk_data->clks[CLK_TOP_MEM_SEL]);
> > +       clk_prepare_enable(top_clk_data->clks[CLK_TOP_DDRPHYCFG_SEL]);
> > +       clk_prepare_enable(top_clk_data->clks[CLK_TOP_RTC_SEL]);
> > +}
> 
> I think we're close to having a better solution. Please see this patch
> series[0] and let me know if it provides a better way for you to enable
> these critical clocks instead of the open-coded solution.
> 
> [0] http://lkml.kernel.org/r/<1455225554-13267-1-git-send-email-mturquette@baylibre.com>
> 

I took a quick view of this patchset, CLK_ENABLE_HAND_OFF is not
suitable for these critical clocks. I'm not sure CLK_IS_CRITICAL
suitable or not. A clock with CLK_IS_CRITICAL will be prepare_enable
when it is registered. But if its parent is not registered into CCF, it
will not be enabled even the parent clock register into CCF later.

> > +
> >  static void __init mtk_topckgen_init(struct device_node *node)
> >  {
> >         struct clk_onecell_data *clk_data;
> > @@ -585,7 +600,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
> >                 return;
> >         }
> >  
> > -       clk_data = mtk_alloc_clk_data(CLK_TOP_NR);
> > +       top_clk_data = clk_data = mtk_alloc_clk_data(CLK_TOP_NR);
> >  
> >         mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
> >                                                                 clk_data);
> > @@ -606,6 +621,8 @@ static void __init mtk_topckgen_init(struct device_node *node)
> >         if (r)
> >                 pr_err("%s(): could not register clock provider: %d\n",
> >                         __func__, r);
> > +
> > +       mtk_clk_enable_critical();
> 
> So you call the function here, and ...
> >  }
> >  CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt2701-topckgen", mtk_topckgen_init);
> >  
> > @@ -1201,7 +1218,7 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
> >         struct clk_onecell_data *clk_data;
> >         int r;
> >  
> > -       clk_data = mtk_alloc_clk_data(ARRAY_SIZE(apmixed_plls));
> > +       pll_clk_data = clk_data = mtk_alloc_clk_data(ARRAY_SIZE(apmixed_plls));
> >         if (!clk_data)
> >                 return;
> >  
> > @@ -1212,6 +1229,8 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
> >         if (r)
> >                 pr_err("%s(): could not register clock provider: %d\n",
> >                         __func__, r);
> > +
> > +       mtk_clk_enable_critical();
> 
> ... here as well. So the prepare_count and enable_count will be 2? I'm
> not sure that this makes sense. If you have different clocks that need
> to be enabled at different times (due to the split registration scheme
> that you employ in this driver) then why not pass an array of those
> clocks into mtk_clk_enable_critical?

No. After topckgen and apmixedsys initialized, critical clocks'
reference count will be 1.

There is a guard at the beginning of mtk_clk_enable_critical():

	if (!top_clk_data || !pll_clk_data)
		return;

So this function will be only executed when topckgen and apmixedsys init
done.

We need to enable critical clocks:

1. As early as possible.
2. After critical clocks and their parents are registered into CCF.

We need to wait all necessary clock providers because parents of
critical clocks must be enabled at the same time. For example,
CLK_TOP_AXI_SEL may have different parent on different platforms. We
also need to keep new parent clock on if CLK_TOP_AXI_SEL change its
parent dynamically.

Because we can't ensure the init ordering of clock providers, we can
only check all necessary providers are registered or not in each init
function.

> Anyways, like I mentioned above I think we're close to a solution to
> handle this in the framework.
> 
> One question: do you ever want these critical clocks to be gated by a
> driver, or do you want them always on, forever?

In this patch, these clocks should be always on (in SW view) even if
there are other drivers controlling them.

If these is a common way to keep critical clocks and their parents on, I
would like to use the common way. But the solution in your patch series
[0] looks not handle parent clocks well. What's your suggestion to
implement critical clocks base on [0]?


Best regards,

James

> >  }
> >  CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt2701-apmixedsys",
> >                                                         mtk_apmixedsys_init);
> > -- 
> > 1.9.1
> > 
