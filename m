From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 12 Jul 2017 12:00:49 +0200
Subject: [PATCH v2 06/12] drm/mediatek: Handle
 drm_atomic_helper_swap_state failure
In-Reply-To: <20170711143314.2148-7-maarten.lankhorst@linux.intel.com>
References: <20170711143314.2148-1-maarten.lankhorst@linux.intel.com>
 <20170711143314.2148-7-maarten.lankhorst@linux.intel.com>
Message-ID: <1499853649.6374.16.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-07-11 at 16:33 +0200, Maarten Lankhorst wrote:
> drm_atomic_helper_swap_state() will be changed to interruptible waiting
> in the next few commits, so all drivers have to be changed to handling
> failure.
> 
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: CK Hu <ck.hu@mediatek.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-mediatek at lists.infradead.org
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 56f802d0a51c..9a130c84c861 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -109,7 +109,12 @@ static int mtk_atomic_commit(struct drm_device *drm,
>  	mutex_lock(&private->commit.lock);
>  	flush_work(&private->commit.work);
>  
> -	drm_atomic_helper_swap_state(state, true);
> +	ret = drm_atomic_helper_swap_state(state, true);
> +	if (ret) {
> +		mutex_unlock(&private->commit.lock);
> +		drm_atomic_helper_cleanup_planes(drm, state);
> +		return ret;
> +	}
>  
>  	drm_atomic_state_get(state);
>  	if (async)

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
