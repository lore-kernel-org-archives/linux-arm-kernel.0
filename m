From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 16 Apr 2018 10:55:33 +0200
Subject: [PATCH v6 25/30] drm/rockchip: Cancel PSR enable work before
 changing the state
In-Reply-To: <20180405095000.9756-26-enric.balletbo@collabora.com>
References: <20180405095000.9756-1-enric.balletbo@collabora.com>
 <CGME20180405095309epcas2p429f551f81c6fee6e6c7ed674318f4bf2@epcas2p4.samsung.com>
 <20180405095000.9756-26-enric.balletbo@collabora.com>
Message-ID: <39f15f1d-c984-d328-4d1f-dc115f71b98f@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.04.2018 11:49, Enric Balletbo i Serra wrote:
> From: Tomasz Figa <tfiga@chromium.org>
>
> If we change the state first and reschedule later, we might have the
> work executed according to previous scheduled time and end up with PSR
> re-enabled instantly. Let's cancel the work before changing the state.
>
> While at it, consolidate psr_disable_handler() to just call
> rockchip_drm_do_flush(), as they are both supposed to do the same.
>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>
>  drivers/gpu/drm/rockchip/rockchip_drm_psr.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> index a107845ba97c..c8655e625ba2 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
> @@ -138,18 +138,6 @@ static void psr_flush_handler(struct work_struct *work)
>  	mutex_unlock(&psr->lock);
>  }
>  
> -static void psr_disable_handler(struct work_struct *work)
> -{
> -	struct psr_drv *psr = container_of(work, struct psr_drv, disable_work);
> -
> -	/* If the state has changed since we initiated the flush, do nothing */
> -	mutex_lock(&psr->lock);
> -	if (psr->state == PSR_ENABLE)
> -		psr_set_state_locked(psr, PSR_FLUSH);
> -	mutex_unlock(&psr->lock);
> -	mod_delayed_work(system_wq, &psr->flush_work, PSR_FLUSH_TIMEOUT_MS);
> -}
> -
>  /**
>   * rockchip_drm_psr_activate - activate PSR on the given pipe
>   * @encoder: encoder to obtain the PSR encoder
> @@ -198,6 +186,7 @@ EXPORT_SYMBOL(rockchip_drm_psr_deactivate);
>  
>  static void rockchip_drm_do_flush(struct psr_drv *psr)
>  {
> +	cancel_delayed_work_sync(&psr->flush_work);
>  	psr_set_state(psr, PSR_FLUSH);
>  	mod_delayed_work(system_wq, &psr->flush_work, PSR_FLUSH_TIMEOUT_MS);

I guess you can change it to schedule_delayed_work then.

Anyway:
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

?--
Regards
Andrzej


>  }
> @@ -244,6 +233,13 @@ void rockchip_drm_psr_flush_all(struct drm_device *dev)
>  }
>  EXPORT_SYMBOL(rockchip_drm_psr_flush_all);
>  
> +static void psr_disable_handler(struct work_struct *work)
> +{
> +	struct psr_drv *psr = container_of(work, struct psr_drv, disable_work);
> +
> +	rockchip_drm_do_flush(psr);
> +}
> +
>  static void psr_input_event(struct input_handle *handle,
>  			    unsigned int type, unsigned int code,
>  			    int value)
