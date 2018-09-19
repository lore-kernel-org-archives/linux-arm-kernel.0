From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 19 Sep 2018 19:56:35 +0800
Subject: [PATCH v1 1/1] drm/mediatek: add function to match the
 connector and crtc
In-Reply-To: <1536732170-30046-2-git-send-email-stu.hsieh@mediatek.com>
References: <1536732170-30046-1-git-send-email-stu.hsieh@mediatek.com>
 <1536732170-30046-2-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1537358195.5124.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Wed, 2018-09-12 at 14:02 +0800, Stu Hsieh wrote:
> This patch add function to match the connector and crtc
> 
> Because the connector set the possible_crtc to match the crtc.
> 
> This function would search the connector in every ddp path and
> return the corresponding value for possible_crtc.
> 
> Change-Id: Id51de53b95039f8174462d483eb9bfee31b3b93b
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 41 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  2 ++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index ff974d82a4a6..1f734b806a00 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -245,6 +245,22 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
>  	[DDP_COMPONENT_WDMA1]	= { MTK_DISP_WDMA,	1, NULL },
>  };
>  
> +static bool mtk_drm_find_comp_in_ddp(struct mtk_ddp_comp ddp_comp,
> +				     const enum mtk_ddp_comp_id *path,
> +				     unsigned int path_len)
> +{
> +	int i;
> +
> +	if (!path)
> +		return false;
> +
> +	for (i = 0; i < path_len; i++)
> +		if (ddp_comp.id == path[i])
> +			return true;
> +
> +	return false;
> +}
> +
>  int mtk_ddp_comp_get_id(struct device_node *node,
>  			enum mtk_ddp_comp_type comp_type)
>  {
> @@ -260,6 +276,31 @@ int mtk_ddp_comp_get_id(struct device_node *node,
>  	return -EINVAL;
>  }
>  
> +unsigned int mtk_drm_find_possible_crtc_by_comp(struct drm_device *drm,
> +						struct mtk_ddp_comp ddp_comp)
> +{
> +	struct mtk_drm_private *private = drm->dev_private;
> +	unsigned int ret;
> +
> +	if (mtk_drm_find_comp_in_ddp(ddp_comp, private->data->main_path,
> +				     private->data->main_len) == true) {
> +		ret = BIT(0);
> +	} else if (mtk_drm_find_comp_in_ddp(ddp_comp,
> +					    private->data->ext_path,
> +					    private->data->ext_len) == true) {
> +		ret = BIT(1);
> +	} else if (mtk_drm_find_comp_in_ddp(ddp_comp,
> +					    private->data->third_path,
> +					    private->data->third_len) == true) {
> +		ret = BIT(2);
> +	} else {
> +		DRM_INFO("Failed to find comp in ddp table\n");
> +		ret = 0;
> +	}

The variable naming is very important. If one day there are fourth path,
fifth path, and sixth path, you would find everywhere where are such 'if
else'. So I would like you to change main_path, ext_path, third_path to
an array such as path[]. So this patch would be only a simple for-loop
and when you add more path, you need not to modify this function.

And would you also send the patch that include the caller call
mtk_drm_find_possible_crtc_by_comp(), so I could understand how do you
pass the parameter.

Regards,
CK

> +
> +	return ret;
> +}
> +
>  int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
>  		      struct mtk_ddp_comp *comp, enum mtk_ddp_comp_id comp_id,
>  		      const struct mtk_ddp_comp_funcs *funcs)
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index 8399229e6ad2..f882e69088b8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -166,6 +166,8 @@ static inline void mtk_ddp_gamma_set(struct mtk_ddp_comp *comp,
>  		comp->funcs->gamma_set(comp, state);
>  }
>  
> +unsigned int mtk_drm_find_possible_crtc_by_comp(struct drm_device *drm,
> +						struct mtk_ddp_comp ddp_comp);
>  int mtk_ddp_comp_get_id(struct device_node *node,
>  			enum mtk_ddp_comp_type comp_type);
>  int mtk_ddp_comp_init(struct device *dev, struct device_node *comp_node,
