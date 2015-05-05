From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 5 May 2015 18:11:12 +0200
Subject: [PATCH 4/6] clk: mediatek: Add basic clocks for Mediatek MT8135.
In-Reply-To: <CABuKBeLfJKMR5uyQ7vQrzv0wW-F+wc6n3AsOVqH3Yy=7M6dH1g@mail.gmail.com>
References: <1429778143-2074-1-git-send-email-s.hauer@pengutronix.de>
 <1429778143-2074-5-git-send-email-s.hauer@pengutronix.de>
 <CABuKBeLfJKMR5uyQ7vQrzv0wW-F+wc6n3AsOVqH3Yy=7M6dH1g@mail.gmail.com>
Message-ID: <20150505161112.GC6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 05, 2015 at 05:51:33PM +0200, Matthias Brugger wrote:
> 2015-04-23 10:35 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> > From: James Liao <jamesjj.liao@mediatek.com>
> >
> > This patch adds basic clocks for MT8135, including TOPCKGEN, PLLs,
> > INFRA and PERI clocks.
> >
> > +
> > +static void __init mtk_infrasys_init(struct device_node *node)
> > +{
> > +       struct clk_onecell_data *clk_data;
> > +       int r;
> > +
> > +       clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
> > +
> > +       mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
> > +                                               clk_data);
> > +
> > +       clk_prepare_enable(clk_data->clks[CLK_INFRA_M4U]);
> > +
> > +       r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> > +       if (r)
> > +               pr_err("%s(): could not register clock provider: %d\n",
> > +                       __func__, r);
> > +
> > +       mtk_register_reset_controller(node, 2, 0x30);
> > +}
> > +CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8135-infracfg", mtk_infrasys_init);
> > +
> > +static void __init mtk_pericfg_init(struct device_node *node)
> > +{
> > +       struct clk_onecell_data *clk_data;
> > +       int r;
> > +       void __iomem *base;
> > +
> > +       base = of_iomap(node, 0);
> > +       if (!base) {
> > +               pr_err("%s(): ioremap failed\n", __func__);
> > +               return;
> > +       }
> > +
> > +       clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
> > +
> > +       mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
> > +                                               clk_data);
> > +       mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
> > +                       &mt8135_clk_lock, clk_data);
> 
> Composite clocks in pericfg should use regmap.

I would, but there is no regmap support for composite clocks. I have
looked into it and came to the conclusion that it's a significant amount
of work to add regmap support to all the basic clk types. Adding this
would delay this series probably even further (due to work time and the
necessary review/resend cycles) and I must say that after v12 I'm really
losing motivation to further work on this series (I will because it's my
job, but otherwise I would have run far away by now).

So yes, you're right, regmap should be used, but I have verified that
the registers used by the clk code are completely orthogonal to the ones
used in the reset controller, thus it should be safe to use readl/writel
here.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
