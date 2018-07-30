From: ck.hu@mediatek.com (CK Hu)
Date: Mon, 30 Jul 2018 11:53:06 +0800
Subject: [PATCH] drm/mediatek: Convert drm_atomic_helper_suspend/resume()
In-Reply-To: <20180728133845.GA15261@jordon-HP-15-Notebook-PC>
References: <20180728133845.GA15261@jordon-HP-15-Notebook-PC>
Message-ID: <1532922786.3723.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Souptick:

On Sat, 2018-07-28 at 19:08 +0530, Souptick Joarder wrote:
> convert drm_atomic_helper_suspend/resume() to use
> drm_mode_config_helper_suspend/resume().
> 

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index a2ca90f..1fcda2de 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -520,29 +520,24 @@ static int mtk_drm_sys_suspend(struct device *dev)
>  {
>  	struct mtk_drm_private *private = dev_get_drvdata(dev);
>  	struct drm_device *drm = private->drm;
> +	int ret;
>  
> -	drm_kms_helper_poll_disable(drm);
> -
> -	private->suspend_state = drm_atomic_helper_suspend(drm);
> -	if (IS_ERR(private->suspend_state)) {
> -		drm_kms_helper_poll_enable(drm);
> -		return PTR_ERR(private->suspend_state);
> -	}
> -
> +	ret = drm_mode_config_helper_suspend(drm);
>  	DRM_DEBUG_DRIVER("mtk_drm_sys_suspend\n");
> -	return 0;
> +
> +	return ret;
>  }
>  
>  static int mtk_drm_sys_resume(struct device *dev)
>  {
>  	struct mtk_drm_private *private = dev_get_drvdata(dev);
>  	struct drm_device *drm = private->drm;
> +	int ret;
>  
> -	drm_atomic_helper_resume(drm, private->suspend_state);
> -	drm_kms_helper_poll_enable(drm);
> -
> +	ret = drm_mode_config_helper_resume(drm);
>  	DRM_DEBUG_DRIVER("mtk_drm_sys_resume\n");
> -	return 0;
> +
> +	return ret;
>  }
>  #endif
>  
