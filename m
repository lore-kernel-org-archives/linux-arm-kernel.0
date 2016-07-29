From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Jul 2016 16:45:02 +0200
Subject: [PATCH v2 3/3] drm/mediatek: fix the wrong pixel clock when
 resolution is 4K
In-Reply-To: <1469608292-6106-4-git-send-email-bibby.hsieh@mediatek.com>
References: <1469608292-6106-1-git-send-email-bibby.hsieh@mediatek.com>
 <1469608292-6106-4-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <20160729144502.GC3864@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2016 at 04:31:32PM +0800, Bibby Hsieh wrote:
> From: Junzhi Zhao <junzhi.zhao@mediatek.com>
> 
> Pixel clock should be 297MHz when resolution is 4K.
> 
> Signed-off-by: Junzhi Zhao <junzhi.zhao@mediatek.com>
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c |  149 +++++++++++++++++++++++-------------
>  1 file changed, 96 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index d05ca79..fa390e0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -60,14 +60,25 @@ enum mtk_dpi_out_color_format {
>  	MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL
>  };
>  
> +enum mtk_dpi_clk_id {
> +	MTK_DPI_CLK_DPI_ENGINE,
> +	MTK_DPI_CLK_DPI_PIXEL,
> +	MTK_DPI_CLK_TVD_PLL,
> +	MTK_DPI_CLK_COUNT,
> +};
> +
> +static const char * const mtk_dpi_clk_names[MTK_DPI_CLK_COUNT] = {
> +	[MTK_DPI_CLK_DPI_ENGINE] = "engine",
> +	[MTK_DPI_CLK_DPI_PIXEL] = "pixel",
> +	[MTK_DPI_CLK_TVD_PLL] = "pll",
> +};
> +
>  struct mtk_dpi {
>  	struct mtk_ddp_comp ddp_comp;
>  	struct drm_encoder encoder;
>  	void __iomem *regs;
>  	struct device *dev;
> -	struct clk *engine_clk;
> -	struct clk *pixel_clk;
> -	struct clk *tvd_clk;
> +	struct clk *clk[MTK_DPI_CLK_COUNT];

This looks to me like a step backwards. All accesses to these clocks are
now very clumsy and I don't see any advantage in using this array rather
than individually named clocks.

Also, that change seems completely unrelated to the description in the
commit message.

>  	int irq;
>  	struct drm_display_mode mode;
>  	enum mtk_dpi_out_color_format color_format;
> @@ -76,6 +87,7 @@ struct mtk_dpi {
>  	enum mtk_dpi_out_channel_swap channel_swap;
>  	bool power_sta;
>  	u8 power_ctl;
> +	void *data;

This should probably be const. It's a bad idea to cast away the const
from the of_device_id.data that this is assigned from.

> +static const struct of_device_id mtk_dpi_of_ids[] = {
> +	{ .compatible = "mediatek,mt8173-dpi",
> +		.data = &mt8173_conf,
> +	},

Please align this in some standard way. It all fits on one line, so the
most obvious choice would've been:

	{ .compatible = "mediatek,mt8173-dpi", .data = &mt8173_conf },

> +	{}
> +};
> +
>  static int mtk_dpi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct mtk_dpi *dpi;
>  	struct resource *mem;
> +	struct device_node *np = dev->of_node;
>  	struct device_node *ep, *bridge_node = NULL;
>  	int comp_id;
> +	const struct of_device_id *match;
> +	struct mtk_dpi_conf *conf;
>  	int ret;
>  
> +	match = of_match_node(mtk_dpi_of_ids, dev->of_node);
> +	if (!match)
> +		return -ENODEV;

You introduce a variable np = dev->of_node above, but then you add code
that uses dev->of_node directly?

That said, you should use of_device_get_match_data() anyway, so that you
can omit...

> +
>  	dpi = devm_kzalloc(dev, sizeof(*dpi), GFP_KERNEL);
>  	if (!dpi)
>  		return -ENOMEM;
>  
>  	dpi->dev = dev;
> +	dpi->data = (void *)match->data;
> +	conf = (struct mtk_dpi_conf *)match->data;

... the dereferences here. Also, like I said before you should make
dpi->data and conf both const to avoid casting away the constness of the
data. If you do that you can even drop the casts because you'd be
casting from a const void * to a const foo *, which gets casted
automatically.

> @@ -754,11 +802,6 @@ static int mtk_dpi_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct of_device_id mtk_dpi_of_ids[] = {
> -	{ .compatible = "mediatek,mt8173-dpi", },
> -	{}
> -};

Another advantage of using of_device_get_match_data() is that it doesn't
need direct access to the of_device_id table (it'll obtain it via an
indirect dev->driver->of_match_table), so you don't have to move this
around and make this patch overall less churn.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160729/de5bab71/attachment.sig>
