From: ck.hu@mediatek.com (CK Hu)
Date: Mon, 30 Apr 2018 18:42:42 +0800
Subject: [v3 04/10] drm/mediatek: mt2701: switch to mfd probing.
In-Reply-To: <b50d32fb140dcf25ac467f0b5e7a84353c8d31d3.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
 <b50d32fb140dcf25ac467f0b5e7a84353c8d31d3.1524820923.git.mbrugger@suse.com>
Message-ID: <1525084962.25456.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Matthias:


On Fri, 2018-04-27 at 11:23 +0200, matthias.bgg at kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> With the mtk-mmsys MFD device in place, we switch the probing for
> mt2701 from device-tree to mfd.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

Reviewed-by: CK Hu <ck.hu@mediatek.com>

Regards,
CK

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index a48e28adad09..88ee35907744 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -386,7 +386,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct mtk_drm_private *private;
> -	struct device_node *node;
> +	struct device_node *node, *parent_node, *mmsys_node;
>  	struct component_match *match = NULL;
>  	int ret;
>  	int i;
> @@ -399,12 +399,23 @@ static int mtk_drm_probe(struct platform_device *pdev)
>  	INIT_WORK(&private->commit.work, mtk_atomic_work);
>  	private->data = of_device_get_match_data(dev);
>  
> -	private->config_regs = syscon_node_to_regmap(dev->of_node);
> -	if (IS_ERR(private->config_regs))
> -		return PTR_ERR(private->config_regs);
> +	/* Check if called from mfd */
> +	if (!dev->of_node) {
> +		mmsys_node = pdev->dev.parent->of_node;
> +		private->data = (struct mtk_mmsys_driver_data *)
> +				platform_get_device_id(pdev)->driver_data;
> +		private->config_regs =
> +			syscon_node_to_regmap(mmsys_node);
> +		parent_node = mmsys_node->parent;
> +	} else {
> +		private->config_regs = syscon_node_to_regmap(dev->of_node);
> +		if (IS_ERR(private->config_regs))
> +			return PTR_ERR(private->config_regs);
> +		parent_node = dev->of_node->parent;
> +	}
>  
>  	/* Iterate over sibling DISP function blocks */
> -	for_each_child_of_node(dev->of_node->parent, node) {
> +	for_each_child_of_node(parent_node, node) {
>  		const struct of_device_id *of_id;
>  		enum mtk_ddp_comp_type comp_type;
>  		int comp_id;
> @@ -545,13 +556,17 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
>  			 mtk_drm_sys_resume);
>  
>  static const struct of_device_id mtk_drm_of_ids[] = {
> -	{ .compatible = "mediatek,mt2701-mmsys",
> -	  .data = &mt2701_mmsys_driver_data},
>  	{ .compatible = "mediatek,mt8173-mmsys",
>  	  .data = &mt8173_mmsys_driver_data},
>  	{ }
>  };
>  
> +static const struct platform_device_id mtk_drm_ids[] = {
> +	{ "drm-mt2701-mm", (kernel_ulong_t)&mt2701_mmsys_driver_data },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(platform, mtk_drm_ids);
> +
>  static struct platform_driver mtk_drm_platform_driver = {
>  	.probe	= mtk_drm_probe,
>  	.remove	= mtk_drm_remove,
> @@ -560,6 +575,7 @@ static struct platform_driver mtk_drm_platform_driver = {
>  		.of_match_table = mtk_drm_of_ids,
>  		.pm     = &mtk_drm_pm_ops,
>  	},
> +	.id_table = mtk_drm_ids,
>  };
>  
>  static struct platform_driver * const mtk_drm_drivers[] = {
