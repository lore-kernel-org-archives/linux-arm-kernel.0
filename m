From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Mon, 25 Jul 2016 14:24:05 +0800
Subject: [PATCH 3/4] drm/mediatek: fix the wrong pixel clock when
 resolution is 4K
In-Reply-To: <1469001443.11841.59.camel@mtksdaap41>
References: <1468987385-37353-1-git-send-email-bibby.hsieh@mediatek.com>
 <1468987385-37353-4-git-send-email-bibby.hsieh@mediatek.com>
 <1469001443.11841.59.camel@mtksdaap41>
Message-ID: <1469427845.26205.17.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, CK,

Thanks for your comments.

On Wed, 2016-07-20 at 15:57 +0800, CK Hu wrote:
> Hi, Bibby:
> 
> Some comments inline.
> 
> On Wed, 2016-07-20 at 12:03 +0800, Bibby Hsieh wrote:
> > From: Junzhi Zhao <junzhi.zhao@mediatek.com>
> > 
> > Pixel clock should be 297MHz when resolution is 4K.
> > 
> > Signed-off-by: Junzhi Zhao <junzhi.zhao@mediatek.com>
> > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dpi.c |  184 +++++++++++++++++++++++++-----------
> >  1 file changed, 131 insertions(+), 53 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > index d05ca79..c0f04d2 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > @@ -60,14 +60,35 @@ enum mtk_dpi_out_color_format {
> >  	MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL
> >  };
> >  
> > +enum mtk_dpi_clk_id {
> > +	MTK_DPI_CLK_DPI_ENGINE,
> > +	MTK_DPI_CLK_DPI_PIXEL,
> > +	MTK_DPI_CLK_TVD_PLL,
> > +	MTK_DPI_CLK_TVDPLL_MUX,
> > +	MTK_DPI_CLK_TVDPLL_D2,
> > +	MTK_DPI_CLK_TVDPLL_D4,
> > +	MTK_DPI_CLK_TVDPLL_D8,
> > +	MTK_DPI_CLK_TVDPLL_D16,
> > +	MTK_DPI_CLK_COUNT,
> > +};
> > +
> > +static const char * const mtk_dpi_clk_names[MTK_DPI_CLK_COUNT] = {
> > +	[MTK_DPI_CLK_DPI_ENGINE] = "engine",
> > +	[MTK_DPI_CLK_DPI_PIXEL] = "pixel",
> > +	[MTK_DPI_CLK_TVD_PLL] = "pll",
> > +	[MTK_DPI_CLK_TVDPLL_MUX] = "tvdpll_mux",
> > +	[MTK_DPI_CLK_TVDPLL_D2] = "tvdpll_d2",
> > +	[MTK_DPI_CLK_TVDPLL_D4] = "tvdpll_d4",
> > +	[MTK_DPI_CLK_TVDPLL_D8] = "tvdpll_d8",
> > +	[MTK_DPI_CLK_TVDPLL_D16] = "tvdpll_d16",
> > +};
> > +
> >  struct mtk_dpi {
> >  	struct mtk_ddp_comp ddp_comp;
> >  	struct drm_encoder encoder;
> >  	void __iomem *regs;
> >  	struct device *dev;
> > -	struct clk *engine_clk;
> > -	struct clk *pixel_clk;
> > -	struct clk *tvd_clk;
> > +	struct clk *clk[MTK_DPI_CLK_COUNT];
> >  	int irq;
> >  	struct drm_display_mode mode;
> >  	enum mtk_dpi_out_color_format color_format;
> > @@ -76,6 +97,7 @@ struct mtk_dpi {
> >  	enum mtk_dpi_out_channel_swap channel_swap;
> >  	bool power_sta;
> >  	u8 power_ctl;
> > +	void *data;
> >  };
> >  
> >  static inline struct mtk_dpi *mtk_dpi_from_encoder(struct drm_encoder *e)
> > @@ -114,6 +136,11 @@ struct mtk_dpi_yc_limit {
> >  	u16 c_bottom;
> >  };
> >  
> > +struct mtk_dpi_conf {
> > +	int (*parse_clk_from_dt)(struct mtk_dpi *dpi, struct device_node *np);
> > +	int (*clk_config)(struct mtk_dpi *dpi, struct drm_display_mode *mode);
> > +};
> > +
> >  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
> >  {
> >  	u32 tmp = readl(dpi->regs + offset) & ~mask;
> > @@ -377,8 +404,8 @@ static void mtk_dpi_power_off(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
> >  		return;
> >  
> >  	mtk_dpi_disable(dpi);
> > -	clk_disable_unprepare(dpi->pixel_clk);
> > -	clk_disable_unprepare(dpi->engine_clk);
> > +	clk_disable_unprepare(dpi->clk[MTK_DPI_CLK_DPI_PIXEL]);
> > +	clk_disable_unprepare(dpi->clk[MTK_DPI_CLK_DPI_ENGINE]);
> >  	dpi->power_sta = false;
> >  }
> >  
> > @@ -395,13 +422,13 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
> >  	if (dpi->power_sta)
> >  		return 0;
> >  
> > -	ret = clk_prepare_enable(dpi->engine_clk);
> > +	ret = clk_prepare_enable(dpi->clk[MTK_DPI_CLK_DPI_ENGINE]);
> >  	if (ret) {
> >  		dev_err(dpi->dev, "Failed to enable engine clock: %d\n", ret);
> >  		goto err_eng;
> >  	}
> >  
> > -	ret = clk_prepare_enable(dpi->pixel_clk);
> > +	ret = clk_prepare_enable(dpi->clk[MTK_DPI_CLK_DPI_PIXEL]);
> >  	if (ret) {
> >  		dev_err(dpi->dev, "Failed to enable pixel clock: %d\n", ret);
> >  		goto err_pixel;
> > @@ -412,7 +439,7 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
> >  	return 0;
> >  
> >  err_pixel:
> > -	clk_disable_unprepare(dpi->engine_clk);
> > +	clk_disable_unprepare(dpi->clk[MTK_DPI_CLK_DPI_ENGINE]);
> >  err_eng:
> >  	dpi->power_ctl &= ~pctl;
> >  	return ret;
> > @@ -428,34 +455,16 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
> >  	struct mtk_dpi_sync_param vsync_leven = { 0 };
> >  	struct mtk_dpi_sync_param vsync_rodd = { 0 };
> >  	struct mtk_dpi_sync_param vsync_reven = { 0 };
> > -	unsigned long pix_rate;
> > -	unsigned long pll_rate;
> > -	unsigned int factor;
> > +	struct mtk_dpi_conf *conf;
> > +	int ret;
> >  
> >  	if (!dpi) {
> >  		dev_err(dpi->dev, "invalid argument\n");
> >  		return -EINVAL;
> >  	}
> >  
> > -	pix_rate = 1000UL * mode->clock;
> > -	if (mode->clock <= 74000)
> > -		factor = 8 * 3;
> > -	else
> > -		factor = 4 * 3;
> > -	pll_rate = pix_rate * factor;
> > -
> > -	dev_dbg(dpi->dev, "Want PLL %lu Hz, pixel clock %lu Hz\n",
> > -		pll_rate, pix_rate);
> > -
> > -	clk_set_rate(dpi->tvd_clk, pll_rate);
> > -	pll_rate = clk_get_rate(dpi->tvd_clk);
> > -
> > -	pix_rate = pll_rate / factor;
> > -	clk_set_rate(dpi->pixel_clk, pix_rate);
> > -	pix_rate = clk_get_rate(dpi->pixel_clk);
> > -
> > -	dev_dbg(dpi->dev, "Got  PLL %lu Hz, pixel clock %lu Hz\n",
> > -		pll_rate, pix_rate);
> > +	conf = (struct mtk_dpi_conf *)dpi->data;
> > +	ret = conf->clk_config(dpi, mode);
> 
> Nothing to do with return error?
> 
Ok, I will fix that.
> >  
> >  	limit.c_bottom = 0x0010;
> >  	limit.c_top = 0x0FE0;
> > @@ -656,20 +665,109 @@ static const struct component_ops mtk_dpi_component_ops = {
> >  	.unbind = mtk_dpi_unbind,
> >  };
> >  
> > +static int mt8173_parse_clk_from_dt(struct mtk_dpi *dpi, struct device_node *np)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(mtk_dpi_clk_names); i++) {
> > +		dpi->clk[i] = of_clk_get_by_name(np,
> > +						  mtk_dpi_clk_names[i]);
> > +		if (IS_ERR(dpi->clk[i]))
> > +			return PTR_ERR(dpi->clk[i]);
> > +	}
> > +	return 0;
> > +}
> 
> I think parsing device tree is a pure SW behavior. Would this vary for
> different MTK soc?
> 
Yes
> > +
> > +static int mt8173_clk_config(struct mtk_dpi *dpi, struct drm_display_mode *mode)
> > +{
> > +	unsigned long pix_rate;
> > +	unsigned long pll_rate;
> > +	unsigned int factor;
> > +	struct clk *parent;
> > +	int ret;
> > +
> > +	if (mode->clock <= 27000) {
> > +		factor = 16 * 3;
> > +		parent = dpi->clk[MTK_DPI_CLK_TVDPLL_D16];
> > +	} else if (mode->clock <= 74250) {
> > +		factor = 8 * 3;
> > +		parent = dpi->clk[MTK_DPI_CLK_TVDPLL_D8];
> > +	} else if (mode->clock <= 167000) {
> > +		factor = 4 * 3;
> > +		parent = dpi->clk[MTK_DPI_CLK_TVDPLL_D4];
> > +	} else {
> > +		factor = 2 * 3;
> > +		parent = dpi->clk[MTK_DPI_CLK_TVDPLL_D2];
> > +	}
> > +
> > +	pix_rate = 1000UL * mode->clock;
> > +	pll_rate = pix_rate * factor;
> > +
> > +	dev_dbg(dpi->dev, "Want PLL %lu Hz, pixel clock %lu Hz\n",
> > +		pll_rate, pix_rate);
> > +
> > +	ret = clk_prepare_enable(dpi->clk[MTK_DPI_CLK_TVDPLL_MUX]);
> > +	if (ret) {
> > +		dev_err(dpi->dev, "tvdpll_mux enable fail\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = clk_set_parent(dpi->clk[MTK_DPI_CLK_TVDPLL_MUX], parent);
> > +	if (ret) {
> > +		dev_err(dpi->dev, "tvdpll_mux set parent fail\n");
> 
> Before return, you may undo something.
I think we can remove this function at the new version, because we make
some changes here according Philipp' comments.
> 
> > +		return ret;
> > +	}
> > +	clk_disable_unprepare(dpi->clk[MTK_DPI_CLK_TVDPLL_MUX]);
> > +
> > +	ret = clk_set_rate(dpi->clk[MTK_DPI_CLK_TVD_PLL], pll_rate);
> > +	if (ret) {
> > +		dev_err(dpi->dev, "dpi pll_rate set rate fail\n");
> > +		return ret;
> > +	}
> > +	pll_rate = clk_get_rate(dpi->clk[MTK_DPI_CLK_TVD_PLL]);
> > +	pix_rate = clk_get_rate(dpi->clk[MTK_DPI_CLK_DPI_PIXEL]);
> > +
> > +	dev_dbg(dpi->dev, "Got  PLL %lu Hz, pixel clock %lu Hz\n",
> > +		pll_rate, pix_rate);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct mtk_dpi_conf mt8173_conf = {
> > +	.parse_clk_from_dt = mt8173_parse_clk_from_dt,
> > +	.clk_config = mt8173_clk_config,
> > +};
> > +
> > +static const struct of_device_id mtk_dpi_of_ids[] = {
> > +	{ .compatible = "mediatek,mt8173-dpi",
> > +		.data = &mt8173_conf,
> > +	},
> > +	{}
> > +};
> > +
> >  static int mtk_dpi_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> >  	struct mtk_dpi *dpi;
> >  	struct resource *mem;
> > +	struct device_node *np = dev->of_node;
> >  	struct device_node *ep, *bridge_node = NULL;
> >  	int comp_id;
> > +	const struct of_device_id *match;
> > +	struct mtk_dpi_conf *conf;
> >  	int ret;
> >  
> > +	match = of_match_node(mtk_dpi_of_ids, dev->of_node);
> > +	if (!match)
> > +		return -ENODEV;
> > +
> >  	dpi = devm_kzalloc(dev, sizeof(*dpi), GFP_KERNEL);
> >  	if (!dpi)
> >  		return -ENOMEM;
> >  
> >  	dpi->dev = dev;
> > +	dpi->data = (void *)match->data;
> > +	conf = (struct mtk_dpi_conf *)match->data;
> >  
> >  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	dpi->regs = devm_ioremap_resource(dev, mem);
> > @@ -679,24 +777,9 @@ static int mtk_dpi_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
> >  
> > -	dpi->engine_clk = devm_clk_get(dev, "engine");
> > -	if (IS_ERR(dpi->engine_clk)) {
> > -		ret = PTR_ERR(dpi->engine_clk);
> > -		dev_err(dev, "Failed to get engine clock: %d\n", ret);
> > -		return ret;
> > -	}
> > -
> > -	dpi->pixel_clk = devm_clk_get(dev, "pixel");
> > -	if (IS_ERR(dpi->pixel_clk)) {
> > -		ret = PTR_ERR(dpi->pixel_clk);
> > -		dev_err(dev, "Failed to get pixel clock: %d\n", ret);
> > -		return ret;
> > -	}
> > -
> > -	dpi->tvd_clk = devm_clk_get(dev, "pll");
> > -	if (IS_ERR(dpi->tvd_clk)) {
> > -		ret = PTR_ERR(dpi->tvd_clk);
> > -		dev_err(dev, "Failed to get tvdpll clock: %d\n", ret);
> > +	ret = conf->parse_clk_from_dt(dpi, np);
> > +	if (ret) {
> > +		dev_err(dev, "parse tvd div clk failed!");
> >  		return ret;
> >  	}
> >  
> > @@ -754,11 +837,6 @@ static int mtk_dpi_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > -static const struct of_device_id mtk_dpi_of_ids[] = {
> > -	{ .compatible = "mediatek,mt8173-dpi", },
> > -	{}
> > -};
> > -
> >  struct platform_driver mtk_dpi_driver = {
> >  	.probe = mtk_dpi_probe,
> >  	.remove = mtk_dpi_remove,
> 
> Regards,
> CK
> 
