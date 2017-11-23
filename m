From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 23 Nov 2017 10:12:57 +0100
Subject: [PATCH 3/8] drm/mediatek: mt2701: switch to mfd probing.
In-Reply-To: <20171114214114.15793-4-mbrugger@suse.com>
References: <20171114214114.15793-1-mbrugger@suse.com>
 <20171114214114.15793-4-mbrugger@suse.com>
Message-ID: <1511428377.7685.9.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-11-14 at 22:41 +0100, Matthias Brugger wrote:
> With the mtk-mmsys MFD device in place, we switch the probing for
> mt2701 from device-tree to mfd.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index dd249cf5121e..5a263aa3ab6e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -21,6 +21,7 @@
>  #include <drm/drm_of.h>
>  #include <linux/component.h>
>  #include <linux/iommu.h>
> +#include <linux/mfd/mmsys.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
> @@ -392,9 +393,10 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
>  
>  static int mtk_drm_probe(struct platform_device *pdev)
>  {
> +	struct mmsys_dev *mmsys_private;
>  	struct device *dev = &pdev->dev;
>  	struct mtk_drm_private *private;
> -	struct device_node *node;
> +	struct device_node *node, *parent_node;
>  	struct component_match *match = NULL;
>  	int ret;
>  	int i;
> @@ -407,12 +409,23 @@ static int mtk_drm_probe(struct platform_device *pdev)
>  	INIT_WORK(&private->commit.work, mtk_atomic_work);
>  	private->data = of_device_get_match_data(dev);
>  
> -	private->config_regs = syscon_node_to_regmap(dev->of_node);
> -	if (IS_ERR(private->config_regs))
> -		return PTR_ERR(private->config_regs);
> +	/* Check if called from mfd */
> +	if (!dev->of_node) {
> +		mmsys_private = dev_get_drvdata(pdev->dev.parent);
> +		private->data = (struct mtk_mmsys_driver_data *)
> +				platform_get_device_id(pdev)->driver_data;
> +		private->config_regs =
> +			syscon_node_to_regmap(mmsys_private->of_node);
> +		parent_node = mmsys_private->of_node->parent;

I think this could be just:

		mmsys_node = pdev->dev.parent->of_node;
		private->data = (struct mtk_mmsys_driver_data *)> +	
			platform_get_device_id(pdev)->driver_data;
		private->config_regs = syscon_node_to_regmap(mmsys_node);
		parent_node = mmsys_node->parent;

regards
Philipp
