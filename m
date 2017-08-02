From: honghui.zhang@mediatek.com (Honghui Zhang)
Date: Wed, 2 Aug 2017 10:02:50 +0800
Subject: [PATCH v2] memory: mtk-smi: Use of_device_get_match_data helper
In-Reply-To: <1501072660-10435-1-git-send-email-honghui.zhang@mediatek.com>
References: <1501072660-10435-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1501639370.5572.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-07-26 at 20:37 +0800, honghui.zhang at mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> Replace custom code with generic helper to retrieve driver data.

Hi, Joerg, would you please take this one, because my last
patch[1]([patch v2 0/3] Add larbid init routine for mediatek's gen1 smi
larb driver) was base on this patch. Or should I put this one together
with the last patchset[1] and resend it with Matthias's reviewed-by
tag[2]?

[1]https://www.spinics.net/lists/arm-kernel/msg596629.html
[2]https://lkml.org/lkml/2017/7/31/197

thanks
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 4afbc41..2b798bb4 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -240,20 +240,15 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *smi_node;
>  	struct platform_device *smi_pdev;
> -	const struct of_device_id *of_id;
>  
>  	if (!dev->pm_domain)
>  		return -EPROBE_DEFER;
>  
> -	of_id = of_match_node(mtk_smi_larb_of_ids, pdev->dev.of_node);
> -	if (!of_id)
> -		return -EINVAL;
> -
>  	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
>  	if (!larb)
>  		return -ENOMEM;
>  
> -	larb->larb_gen = of_id->data;
> +	larb->larb_gen = of_device_get_match_data(dev);
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	larb->base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(larb->base))
> @@ -319,7 +314,6 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct mtk_smi *common;
>  	struct resource *res;
> -	const struct of_device_id *of_id;
>  	enum mtk_smi_gen smi_gen;
>  
>  	if (!dev->pm_domain)
> @@ -338,17 +332,13 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>  	if (IS_ERR(common->clk_smi))
>  		return PTR_ERR(common->clk_smi);
>  
> -	of_id = of_match_node(mtk_smi_common_of_ids, pdev->dev.of_node);
> -	if (!of_id)
> -		return -EINVAL;
> -
>  	/*
>  	 * for mtk smi gen 1, we need to get the ao(always on) base to config
>  	 * m4u port, and we need to enable the aync clock for transform the smi
>  	 * clock into emi clock domain, but for mtk smi gen2, there's no smi ao
>  	 * base.
>  	 */
> -	smi_gen = (enum mtk_smi_gen)of_id->data;
> +	smi_gen = (enum mtk_smi_gen)of_device_get_match_data(dev);
>  	if (smi_gen == MTK_SMI_GEN1) {
>  		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  		common->smi_ao_base = devm_ioremap_resource(dev, res);
