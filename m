From: ck.hu@mediatek.com (CK Hu)
Date: Fri, 13 May 2016 11:59:16 +0800
Subject: [RFC 2/3] drm/mediatek: add support for Mediatek SoC MT2701
In-Reply-To: <1463053795-55455-3-git-send-email-yt.shen@mediatek.com>
References: <1463053795-55455-1-git-send-email-yt.shen@mediatek.com>
 <1463053795-55455-3-git-send-email-yt.shen@mediatek.com>
Message-ID: <1463111956.12239.15.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:

On Thu, 2016-05-12 at 19:49 +0800, yt.shen at mediatek.com wrote:
> From: YT Shen <yt.shen@mediatek.com>
> 
> This patch add support for the Mediatek MT2701 DISP subsystem.
> There is only one OVL engine in MT2701, and we have shadow
> register support here.
> 
> Signed-off-by: YT Shen <yt.shen@mediatek.com>
> ---

> @@ -385,12 +422,16 @@ static void mtk_drm_crtc_atomic_begin(struct drm_crtc *crtc,
>  		mtk_crtc->event = state->base.event;
>  		state->base.event = NULL;
>  	}
> +
> +	if (priv->data->shadow_register)
> +		mtk_disp_mutex_acquire(mtk_crtc->mutex);
>  }
>  
> @@ -409,6 +450,11 @@ static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
>  	}
>  	if (pending_planes)
>  		mtk_crtc->pending_planes = true;
> +
> +	if (priv->data->shadow_register) {
> +		mtk_crtc_ddp_config(crtc);
> +		mtk_disp_mutex_release(mtk_crtc->mutex);
> +	}
>  }
>  

I think it's better to call mtk_disp_mutex_acquire() and
mtk_disp_mutex_release() as near as possible to prevent mutex locked for
a long time. All HW register access of this atomic setting is in
mtk_crtc_ddp_config(), so it's better to move mtk_disp_mutex_acquire()
just before mtk_crtc_ddp_config().

Regards,
CK
