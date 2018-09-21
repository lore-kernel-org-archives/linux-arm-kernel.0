From: ck.hu@mediatek.com (CK Hu)
Date: Fri, 21 Sep 2018 17:47:34 +0800
Subject: [PATCH v3 05/12] drm/mediatek: convert dpi driver to use
 drm_of_find_panel_or_bridge
In-Reply-To: <20180921032822.30771-6-bibby.hsieh@mediatek.com>
References: <20180921032822.30771-1-bibby.hsieh@mediatek.com>
 <20180921032822.30771-6-bibby.hsieh@mediatek.com>
Message-ID: <1537523254.20660.9.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Bibby:

On Fri, 2018-09-21 at 11:28 +0800, Bibby Hsieh wrote:
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> Convert dpi driver to use drm_of_find_panel_or_bridge.
> This changes some error messages to debug messages (in the graph core).
> Graph connections are often "no connects" depending on the particular
> board, so we want to avoid spurious messages. Plus the kernel is not a
> DT validator.
> related links:
> [1] https://lkml.org/lkml/2017/2/3/716
> [2] https://lkml.org/lkml/2017/2/3/719
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 022ccec49cea..7a4868a0afec 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -14,6 +14,7 @@
>  #include <drm/drmP.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_of.h>
>  #include <linux/kernel.h>
>  #include <linux/component.h>
>  #include <linux/platform_device.h>
> @@ -697,7 +698,6 @@ static int mtk_dpi_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct mtk_dpi *dpi;
>  	struct resource *mem;
> -	struct device_node *bridge_node;
>  	int comp_id;
>  	int ret;
>  
> @@ -743,16 +743,14 @@ static int mtk_dpi_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	bridge_node = of_graph_get_remote_node(dev->of_node, 0, 0);
> -	if (!bridge_node)
> -		return -ENODEV;
> -
> -	dev_info(dev, "Found bridge node: %pOF\n", bridge_node);
> -
> -	dpi->bridge = of_drm_find_bridge(bridge_node);
> -	of_node_put(bridge_node);
> -	if (!dpi->bridge)
> +	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
> +					  NULL, &dpi->bridge);
> +	if (ret) {
> +		dev_err(dev, "Failed to find panel or bridge: %d\n", ret);
>  		return -EPROBE_DEFER;

I've traced into drm_of_find_panel_or_bridge(), it may return -ENODEV
when device tree has error, why do you treat this error to
-EPROBE_DEFER? I think you may modify this as

if (ret)
	return ret;

Regards,
CK

> +	}
> +
> +	dev_info(dev, "Found bridge node: %pOF\n", dpi->bridge->of_node);
>  
>  	comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DPI);
>  	if (comp_id < 0) {
