From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 20 Jul 2016 11:55:05 +0200
Subject: [PATCH 4/4] drm/mediatek: adjust VENCPLL clock for 4K HDMI output
In-Reply-To: <1468987385-37353-5-git-send-email-bibby.hsieh@mediatek.com>
References: <1468987385-37353-1-git-send-email-bibby.hsieh@mediatek.com>
 <1468987385-37353-5-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1469008505.5809.41.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bibby,

Am Mittwoch, den 20.07.2016, 12:03 +0800 schrieb Bibby Hsieh:
> if MT8173 display module can support 4K HDMI output,
> we have to adjust VENCPLL clock from default 660MHz
> to 800MHz.

Is vencpll(_d2) the active source for the mm_sel mux? If so, it seems to
me that mm_sel or rather one of its children should be set to 800 MHz,
and the clock framework should propagate it up to vencpll. I suppose the
requirement is that the input clocks to all the display units (ovl,
rdma, and so on) need to be sufficiently above the pixel clock.

Also, this reads as if we want to keep the clock at 660 MHz if 4K is not
supported at all (for example because of a bridge connected at the
outside).
Actually, would it be desirable to switch vencpll to 660 MHz even on 4K
capable devices as long as only lower pixel clocks are active?

regards
Philipp

> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c |    9 +++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h |    1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index b1223d5..f159189 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -23,6 +23,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/clk.h>
>  
>  #include "mtk_drm_crtc.h"
>  #include "mtk_drm_ddp.h"
> @@ -363,6 +364,14 @@ static int mtk_drm_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	private->vencpll_clk = devm_clk_get(dev, "vencpll");
> +	if (IS_ERR(private->vencpll_clk)) {
> +		ret = PTR_ERR(private->vencpll_clk);
> +		dev_err(dev, "Failed to get vencpll clock: %d\n", ret);
> +		return ret;
> +	}
> +	clk_set_rate(private->vencpll_clk, 800000000);
> +
>  	/* Iterate over sibling DISP function blocks */
>  	for_each_child_of_node(dev->of_node->parent, node) {
>  		const struct of_device_id *of_id;
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index aa93894..273ad02 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -40,6 +40,7 @@ struct mtk_drm_private {
>  	void __iomem *config_regs;
>  	struct device_node *comp_node[DDP_COMPONENT_ID_MAX];
>  	struct mtk_ddp_comp *ddp_comp[DDP_COMPONENT_ID_MAX];
> +	struct clk *vencpll_clk;
>  
>  	struct {
>  		struct drm_atomic_state *state;
