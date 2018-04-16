From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 16 Apr 2018 11:53:43 +0200
Subject: [PATCH v6 30/30] drm/rockchip: psr: Remove flush by CRTC
In-Reply-To: <20180405095000.9756-31-enric.balletbo@collabora.com>
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
 <CGME20180405095121epcas3p36dd90bcde69f6502ed09d9eb96545744@epcas3p3.samsung.com>
 <20180405095000.9756-31-enric.balletbo@collabora.com>
Message-ID: <d88a9b84-f39f-7d12-8397-0eb1cca56d92@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.04.2018 11:50, Enric Balletbo i Serra wrote:
> From: Tomasz Figa <tfiga@chromium.org>
>
> It is not used anymore after last changes and it was not even correct to
> begin with as it assumed a 1:1 relation between a CRTC and encoder,
> while in fact a CRTC can be attached to multiple encoders.
>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

?--
Regards
Andrzej

> ---
>
>  drivers/gpu/drm/rockchip/rockchip_drm_psr.c | 35 -----------------------------
>  drivers/gpu/drm/rockchip/rockchip_drm_psr.h |  1 -
>  2 files changed, 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> index 1bf5cba9a64d..b1988ac758d5 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> @@ -40,23 +40,6 @@ struct psr_drv {
>  	int (*set)(struct drm_encoder *encoder, bool enable);
>  };
>  
> -static struct psr_drv *find_psr_by_crtc(struct drm_crtc *crtc)
> -{
> -	struct rockchip_drm_private *drm_drv = crtc->dev->dev_private;
> -	struct psr_drv *psr;
> -
> -	mutex_lock(&drm_drv->psr_list_lock);
> -	list_for_each_entry(psr, &drm_drv->psr_list, list) {
> -		if (psr->encoder->crtc == crtc)
> -			goto out;
> -	}
> -	psr = ERR_PTR(-ENODEV);
> -
> -out:
> -	mutex_unlock(&drm_drv->psr_list_lock);
> -	return psr;
> -}
> -
>  static struct psr_drv *find_psr_by_encoder(struct drm_encoder *encoder)
>  {
>  	struct rockchip_drm_private *drm_drv = encoder->dev->dev_private;
> @@ -173,24 +156,6 @@ static void rockchip_drm_do_flush(struct psr_drv *psr)
>  	mutex_unlock(&psr->lock);
>  }
>  
> -/**
> - * rockchip_drm_psr_flush - flush a single pipe
> - * @crtc: CRTC of the pipe to flush
> - *
> - * Returns:
> - * 0 on success, -errno on fail
> - */
> -int rockchip_drm_psr_flush(struct drm_crtc *crtc)
> -{
> -	struct psr_drv *psr = find_psr_by_crtc(crtc);
> -	if (IS_ERR(psr))
> -		return PTR_ERR(psr);
> -
> -	rockchip_drm_do_flush(psr);
> -	return 0;
> -}
> -EXPORT_SYMBOL(rockchip_drm_psr_flush);
> -
>  /**
>   * rockchip_drm_psr_flush_all - force to flush all registered PSR encoders
>   * @dev: drm device
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
> index 40e026c14168..860c62494496 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
> @@ -16,7 +16,6 @@
>  #define __ROCKCHIP_DRM_PSR___
>  
>  void rockchip_drm_psr_flush_all(struct drm_device *dev);
> -int rockchip_drm_psr_flush(struct drm_crtc *crtc);
>  
>  int rockchip_drm_psr_inhibit_put(struct drm_encoder *encoder);
>  int rockchip_drm_psr_inhibit_get(struct drm_encoder *encoder);
