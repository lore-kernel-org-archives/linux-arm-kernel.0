From: ck.hu@mediatek.com (CK Hu)
Date: Tue, 13 Jun 2017 15:45:20 +0800
Subject: [PATCH] drm/mediatek: check for memory allocation failure
In-Reply-To: <20170609192712.18155-1-christophe.jaillet@wanadoo.fr>
References: <20170609192712.18155-1-christophe.jaillet@wanadoo.fr>
Message-ID: <1497339920.16952.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Christophe:

Applied to my branch mediatek-drm-next-4.13, thanks.

Regards,
CK

On Fri, 2017-06-09 at 21:27 +0200, Christophe JAILLET wrote:
> If 'devm_kmalloc_array' returns NULL, we should return -ENOMEM as already
> done a few lines above instead of deferencing a NULL pointer a few lines
> below.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 6582e1f56d37..cb32c9369f3a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -559,6 +559,8 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>  	mtk_crtc->ddp_comp = devm_kmalloc_array(dev, mtk_crtc->ddp_comp_nr,
>  						sizeof(*mtk_crtc->ddp_comp),
>  						GFP_KERNEL);
> +	if (!mtk_crtc->ddp_comp)
> +		return -ENOMEM;
>  
>  	mtk_crtc->mutex = mtk_disp_mutex_get(priv->mutex_dev, pipe);
>  	if (IS_ERR(mtk_crtc->mutex)) {
