From: ryder.lee@mediatek.com (Ryder Lee)
Date: Tue, 20 Mar 2018 14:38:52 +0800
Subject: [PATCH v4 3/6] clk: mediatek: add audsys support for MT2701
In-Reply-To: <152149148431.242365.4625152577833480987@swboyd.mtv.corp.google.com>
References: <cover.1520327262.git.ryder.lee@mediatek.com>
 <f1445b95864af04f1f90d3be96d0a485d1bb4560.1520327262.git.ryder.lee@mediatek.com>
 <152149148431.242365.4625152577833480987@swboyd.mtv.corp.google.com>
Message-ID: <1521527932.21199.4.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-03-19 at 13:31 -0700, Stephen Boyd wrote:
> Quoting Ryder Lee (2018-03-06 01:09:28)
> > +
> > +static const struct of_device_id of_match_clk_mt2701_aud[] = {
> > +       { .compatible = "mediatek,mt2701-audsys", },
> > +       {}
> > +};
> > +
> > +static int clk_mt2701_aud_probe(struct platform_device *pdev)
> > +{
> > +       struct clk_onecell_data *clk_data;
> > +       struct device_node *node = pdev->dev.of_node;
> > +       int r;
> > +
> > +       clk_data = mtk_alloc_clk_data(CLK_AUD_NR);
> > +
> > +       mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
> > +                              clk_data);
> > +
> > +       r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> > +       if (r) {
> > +               dev_err(&pdev->dev,
> > +                       "could not register clock provider: %s: %d\n",
> > +                       pdev->name, r);
> > +
> > +               return r;
> > +       }
> 
> This fails to remove the clk provider when devm_of_platform_populate()
> returns an error.
> 
> > +
> > +       return devm_of_platform_populate(&pdev->dev);
> > +}

I've sent a new one to fix it.

Thanks
