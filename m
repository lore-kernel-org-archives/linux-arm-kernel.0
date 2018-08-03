From: ck.hu@mediatek.com (CK Hu)
Date: Fri, 3 Aug 2018 13:33:25 +0800
Subject: [PATCH v2 13/15] drm/mediatek: use layer_nr function to get
 layer number to init plane
In-Reply-To: <1533265868-28110-14-git-send-email-stu.hsieh@mediatek.com>
References: <1533265868-28110-1-git-send-email-stu.hsieh@mediatek.com>
 <1533265868-28110-14-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1533274405.31144.16.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

On Fri, 2018-08-03 at 11:11 +0800, Stu Hsieh wrote:
> This patch use layer_nr function to get layer number to init plane
> 
> When plane init in crtc create,
> it use the number of OVL layer to init plane.
> That's OVL can read 4 memory address.
> 
> For mt2712 third ddp, it use RDMA to read memory.
> RDMA can read 1 memory address, so it just init one plane.
> 
> For compatibility, this patch use mtk_ddp_comp_layer_nr function
> to get layer number from their HW component in ddp for plane init.
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 26 ++++++++++++++++++--------
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.h |  2 +-
>  2 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 4bf636e466f2..b4d3dfca4003 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -45,7 +45,8 @@ struct mtk_drm_crtc {
>  	bool				pending_needs_vblank;
>  	struct drm_pending_vblank_event	*event;
>  
> -	struct drm_plane		planes[OVL_LAYER_NR];
> +	struct drm_plane		planes[MAX_LAYER_NR];

For the RDMA crtc, there is only one plane but here allocate 4 planes. I
would like the array size is depend on layer_nr to prevent wasting
memory.

> +	unsigned int			layer_nr;
>  	bool				pending_planes;
>  
>  	void __iomem			*config_regs;
> @@ -286,7 +287,7 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
>  	}
>  
>  	/* Initially configure all planes */
> -	for (i = 0; i < OVL_LAYER_NR; i++) {
> +	for (i = 0; i < mtk_crtc->layer_nr; i++) {
>  		struct drm_plane *plane = &mtk_crtc->planes[i];
>  		struct mtk_plane_state *plane_state;
>  
> @@ -351,7 +352,7 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
>  	}
>  
>  	if (mtk_crtc->pending_planes) {
> -		for (i = 0; i < OVL_LAYER_NR; i++) {
> +		for (i = 0; i < mtk_crtc->layer_nr; i++) {
>  			struct drm_plane *plane = &mtk_crtc->planes[i];
>  			struct mtk_plane_state *plane_state;
>  
> @@ -403,7 +404,7 @@ static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
>  		return;
>  
>  	/* Set all pending plane state to disabled */
> -	for (i = 0; i < OVL_LAYER_NR; i++) {
> +	for (i = 0; i < mtk_crtc->layer_nr; i++) {
>  		struct drm_plane *plane = &mtk_crtc->planes[i];
>  		struct mtk_plane_state *plane_state;
>  
> @@ -450,7 +451,7 @@ static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
>  
>  	if (mtk_crtc->event)
>  		mtk_crtc->pending_needs_vblank = true;
> -	for (i = 0; i < OVL_LAYER_NR; i++) {
> +	for (i = 0; i < mtk_crtc->layer_nr; i++) {
>  		struct drm_plane *plane = &mtk_crtc->planes[i];
>  		struct mtk_plane_state *plane_state;
>  
> @@ -596,6 +597,9 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>  			goto unprepare;
>  		}
>  
> +		if (i == 0)
> +			mtk_crtc->layer_nr = mtk_ddp_comp_layer_nr(comp);
> +
>  		if (i == 0 && (comp_id == DDP_COMPONENT_RDMA0 ||
>  			       comp_id == DDP_COMPONENT_RDMA1 ||
>  			       comp_id == DDP_COMPONENT_RDMA2)) {
> @@ -606,7 +610,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>  		mtk_crtc->ddp_comp[i] = comp;
>  	}
>  
> -	for (zpos = 0; zpos < OVL_LAYER_NR; zpos++) {
> +	for (zpos = 0; zpos < mtk_crtc->layer_nr; zpos++) {
>  		type = (zpos == 0) ? DRM_PLANE_TYPE_PRIMARY :
>  				(zpos == 1) ? DRM_PLANE_TYPE_CURSOR :
>  						DRM_PLANE_TYPE_OVERLAY;
> @@ -616,8 +620,14 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>  			goto unprepare;
>  	}
>  
> -	ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, &mtk_crtc->planes[0],
> -				&mtk_crtc->planes[1], pipe);
> +	if (mtk_crtc->layer_nr == 1) {
> +		ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, &mtk_crtc->planes[0],
> +					NULL, pipe);
> +	} else {
> +		ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, &mtk_crtc->planes[0],
> +					&mtk_crtc->planes[1], pipe);
> +	}

You could write as

ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, &mtk_crtc->planes[0],
			mtk_crtc->layer_nr > 1 ? &mtk_crtc->planes[1] : NULL, pipe);

Regards,
CK

> +
>  	if (ret < 0)
>  		goto unprepare;
>  	drm_mode_crtc_set_gamma_size(&mtk_crtc->base, MTK_LUT_SIZE);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> index 9d9410c67ae9..0399321b1414 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> @@ -18,7 +18,7 @@
>  #include "mtk_drm_ddp_comp.h"
>  #include "mtk_drm_plane.h"
>  
> -#define OVL_LAYER_NR	4
> +#define MAX_LAYER_NR	4
>  #define MTK_LUT_SIZE	512
>  #define MTK_MAX_BPC	10
>  #define MTK_MIN_BPC	3
