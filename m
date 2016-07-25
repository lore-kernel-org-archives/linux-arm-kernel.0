From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Mon, 25 Jul 2016 16:37:50 +0800
Subject: [PATCH 3/4] drm/mediatek: fix the wrong pixel clock when
 resolution is 4K
In-Reply-To: <1469429375.11841.69.camel@mtksdaap41>
References: <1468987385-37353-1-git-send-email-bibby.hsieh@mediatek.com>
 <1468987385-37353-4-git-send-email-bibby.hsieh@mediatek.com>
 <1469001443.11841.59.camel@mtksdaap41>
 <1469427845.26205.17.camel@mtksdaap41>
 <1469429375.11841.69.camel@mtksdaap41>
Message-ID: <1469435870.26205.20.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, CK,

Thanks for your comments.

On Mon, 2016-07-25 at 14:49 +0800, CK Hu wrote:
> Hi, Bibby:
> 
> On Mon, 2016-07-25 at 14:24 +0800, Bibby Hsieh wrote:
> > Hi, CK,
> > 
> > Thanks for your comments.
> > 
> > On Wed, 2016-07-20 at 15:57 +0800, CK Hu wrote:
> > > Hi, Bibby:
> > > 
> > > Some comments inline.
> > > 
> > > On Wed, 2016-07-20 at 12:03 +0800, Bibby Hsieh wrote:
> > > > From: Junzhi Zhao <junzhi.zhao@mediatek.com>
> > > > 
> > > > Pixel clock should be 297MHz when resolution is 4K.
> > > > 
> > > > Signed-off-by: Junzhi Zhao <junzhi.zhao@mediatek.com>
> > > > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > > > ---
> > > >  drivers/gpu/drm/mediatek/mtk_dpi.c |  184 +++++++++++++++++++++++++-----------
> > > >  1 file changed, 131 insertions(+), 53 deletions(-)
> > > > 
> 
> [snip...]
> 
> > > >  
> > > > +static int mt8173_parse_clk_from_dt(struct mtk_dpi *dpi, struct device_node *np)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < ARRAY_SIZE(mtk_dpi_clk_names); i++) {
> > > > +		dpi->clk[i] = of_clk_get_by_name(np,
> > > > +						  mtk_dpi_clk_names[i]);
> > > > +		if (IS_ERR(dpi->clk[i]))
> > > > +			return PTR_ERR(dpi->clk[i]);
> > > > +	}
> > > > +	return 0;
> > > > +}
> > > 
> > > I think parsing device tree is a pure SW behavior. Would this vary for
> > > different MTK soc?
> > > 
> > Yes
> 
> I can not imaging that, so could you give me an example source code of
> other MTK soc for parse_clk_from_dt()?
> 
I will do some changes according to your comments. 

> > > > +
> > > > +
> > > > +static const struct mtk_dpi_conf mt8173_conf = {
> > > > +	.parse_clk_from_dt = mt8173_parse_clk_from_dt,
> > > > +	.clk_config = mt8173_clk_config,
> > > > +};
> > > > +
> > > > +static const struct of_device_id mtk_dpi_of_ids[] = {
> > > > +	{ .compatible = "mediatek,mt8173-dpi",
> > > > +		.data = &mt8173_conf,
> > > > +	},
> > > > +	{}
> > > > +};
> > > > +
> > > >  static int mtk_dpi_probe(struct platform_device *pdev)
> > > >  {
> > > >  	struct device *dev = &pdev->dev;
> > > >  	struct mtk_dpi *dpi;
> > > >  	struct resource *mem;
> > > > +	struct device_node *np = dev->of_node;
> > > >  	struct device_node *ep, *bridge_node = NULL;
> > > >  	int comp_id;
> > > > +	const struct of_device_id *match;
> > > > +	struct mtk_dpi_conf *conf;
> > > >  	int ret;
> > > >  
> > > > +	match = of_match_node(mtk_dpi_of_ids, dev->of_node);
> > > > +	if (!match)
> > > > +		return -ENODEV;
> > > > +
> > > >  	dpi = devm_kzalloc(dev, sizeof(*dpi), GFP_KERNEL);
> > > >  	if (!dpi)
> > > >  		return -ENOMEM;
> > > >  
> > > >  	dpi->dev = dev;
> > > > +	dpi->data = (void *)match->data;
> > > > +	conf = (struct mtk_dpi_conf *)match->data;
> > > >  
> > > >  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > >  	dpi->regs = devm_ioremap_resource(dev, mem);
> > > > @@ -679,24 +777,9 @@ static int mtk_dpi_probe(struct platform_device *pdev)
> > > >  		return ret;
> > > >  	}
> > > >  
> > > > -	dpi->engine_clk = devm_clk_get(dev, "engine");
> > > > -	if (IS_ERR(dpi->engine_clk)) {
> > > > -		ret = PTR_ERR(dpi->engine_clk);
> > > > -		dev_err(dev, "Failed to get engine clock: %d\n", ret);
> > > > -		return ret;
> > > > -	}
> > > > -
> > > > -	dpi->pixel_clk = devm_clk_get(dev, "pixel");
> > > > -	if (IS_ERR(dpi->pixel_clk)) {
> > > > -		ret = PTR_ERR(dpi->pixel_clk);
> > > > -		dev_err(dev, "Failed to get pixel clock: %d\n", ret);
> > > > -		return ret;
> > > > -	}
> > > > -
> > > > -	dpi->tvd_clk = devm_clk_get(dev, "pll");
> > > > -	if (IS_ERR(dpi->tvd_clk)) {
> > > > -		ret = PTR_ERR(dpi->tvd_clk);
> > > > -		dev_err(dev, "Failed to get tvdpll clock: %d\n", ret);
> > > > +	ret = conf->parse_clk_from_dt(dpi, np);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "parse tvd div clk failed!");
> > > >  		return ret;
> > > >  	}
> > > >  
> > > > @@ -754,11 +837,6 @@ static int mtk_dpi_remove(struct platform_device *pdev)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > -static const struct of_device_id mtk_dpi_of_ids[] = {
> > > > -	{ .compatible = "mediatek,mt8173-dpi", },
> > > > -	{}
> > > > -};
> > > > -
> > > >  struct platform_driver mtk_dpi_driver = {
> > > >  	.probe = mtk_dpi_probe,
> > > >  	.remove = mtk_dpi_remove,
> > > 
> > > Regards,
> > > CK
> > > 
> > 
> 
> 
> Regards,
> CK
> > 
> 
> 
