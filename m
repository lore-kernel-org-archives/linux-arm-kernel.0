From: ck.hu@mediatek.com (CK Hu)
Date: Mon, 28 May 2018 16:30:14 +0800
Subject: [PATCH v1 2/7] drm/mediatek: fix to get right bridge for dpi
 encoder
In-Reply-To: <20180514075243.5442-3-bibby.hsieh@mediatek.com>
References: <20180514075243.5442-1-bibby.hsieh@mediatek.com>
 <20180514075243.5442-3-bibby.hsieh@mediatek.com>
Message-ID: <1527496214.396.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Bibby:

Some inline comment.

On Mon, 2018-05-14 at 15:52 +0800, Bibby Hsieh wrote:
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> 1, dpi is an encoder, there is an bridge in the struct
> of decoder, we could use it.

The encoder.bridge is assigned in drm_bridge_attach(), so I think the
design is to assign this member in drm_bridge_attach().
Any assignment outside this function may conflict with this design.

> 2, using of_graph_get_remote_port_parent to get right
> bridge in device tree.
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 0a44ab175422..2b8b34c72697 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -63,7 +63,6 @@ enum mtk_dpi_out_color_format {
>  struct mtk_dpi {
>  	struct mtk_ddp_comp ddp_comp;
>  	struct drm_encoder encoder;
> -	struct drm_bridge *bridge;
>  	void __iomem *regs;
>  	struct device *dev;
>  	struct clk *engine_clk;
> @@ -643,8 +642,8 @@ static int mtk_dpi_bind(struct device *dev, struct device *master, void *data)
>  
>  	/* Currently DPI0 is fixed to be driven by OVL1 */
>  	dpi->encoder.possible_crtcs = BIT(1);
> -
> -	ret = drm_bridge_attach(&dpi->encoder, dpi->bridge, NULL);
> +	dpi->encoder.bridge->encoder = &dpi->encoder;

This is done inside drm_bridge_attach().

> +	ret = drm_bridge_attach(&dpi->encoder, dpi->encoder.bridge, NULL);
>  	if (ret) {
>  		dev_err(dev, "Failed to attach bridge: %d\n", ret);
>  		goto err_cleanup;
> @@ -709,7 +708,7 @@ static int mtk_dpi_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct mtk_dpi *dpi;
>  	struct resource *mem;
> -	struct device_node *bridge_node;
> +	struct device_node *ep, *bridge_node;
>  	int comp_id;
>  	const struct of_device_id *match;
>  	int ret;
> @@ -759,15 +758,21 @@ static int mtk_dpi_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	bridge_node = of_graph_get_remote_node(dev->of_node, 0, 0);
> -	if (!bridge_node)
> +	ep = of_graph_get_next_endpoint(dev->of_node, NULL);
> +	if (ep) {
> +		bridge_node = of_graph_get_remote_port_parent(ep);
> +		of_node_put(ep);
> +	}
> +	if (!bridge_node) {
> +		dev_err(dev, "Failed to find bridge node\n");
>  		return -ENODEV;
> +	}

This looks like mt8173 has the same bug, so send this patch
independently and it would be more quick to merge.
For mtk_dsi, it use drm_of_find_panel_or_bridge(), so I think you could
use the same function to get bridge.

Regards,
CK

>  
>  	dev_info(dev, "Found bridge node: %pOF\n", bridge_node);
>  
> -	dpi->bridge = of_drm_find_bridge(bridge_node);
> +	dpi->encoder.bridge = of_drm_find_bridge(bridge_node);
>  	of_node_put(bridge_node);
> -	if (!dpi->bridge)
> +	if (!dpi->encoder.bridge)
>  		return -EPROBE_DEFER;
>  
>  	comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DPI);
