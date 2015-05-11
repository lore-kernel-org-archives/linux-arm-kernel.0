From: inki.dae@samsung.com (Inki Dae)
Date: Mon, 11 May 2015 22:29:25 +0900
Subject: [RFT PATCH v2 2/3] drm/exynos: Constify exynos_drm_crtc_ops
In-Reply-To: <1430957086-25005-3-git-send-email-k.kozlowski@samsung.com>
References: <1430957086-25005-1-git-send-email-k.kozlowski@samsung.com>
 <1430957086-25005-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5550AEB5.4020709@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015? 05? 07? 09:04, Krzysztof Kozlowski wrote:
> From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> 
> The Exynos DRM code does not modify the ops provided by CRTC driver in
> exynos_drm_crtc_create() call.

Please check coding style with checkpatch.pl before posting it. I can
see below warning,

WARNING: line over 80 characters
#146: FILE: drivers/gpu/drm/exynos/exynos_drm_crtc.c:244:
+					       const struct exynos_drm_crtc_ops *ops,

WARNING: line over 80 characters
#159: FILE: drivers/gpu/drm/exynos/exynos_drm_crtc.h:24:
+					       const struct exynos_drm_crtc_ops *ops,


I modified and merged all patches.

Thanks,
Inki Dae

> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> 
> ---
> Changes since v1:
> New patch.
> ---
>  drivers/gpu/drm/exynos/exynos7_drm_decon.c | 2 +-
>  drivers/gpu/drm/exynos/exynos_drm_crtc.c   | 2 +-
>  drivers/gpu/drm/exynos/exynos_drm_crtc.h   | 2 +-
>  drivers/gpu/drm/exynos/exynos_drm_drv.h    | 2 +-
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c   | 2 +-
>  drivers/gpu/drm/exynos/exynos_drm_vidi.c   | 2 +-
>  drivers/gpu/drm/exynos/exynos_mixer.c      | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
> index 1f7e33f59de6..3d00df76220d 100644
> --- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
> +++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
> @@ -710,7 +710,7 @@ static void decon_dpms(struct exynos_drm_crtc *crtc, int mode)
>  	}
>  }
>  
> -static struct exynos_drm_crtc_ops decon_crtc_ops = {
> +static const struct exynos_drm_crtc_ops decon_crtc_ops = {
>  	.dpms = decon_dpms,
>  	.mode_fixup = decon_mode_fixup,
>  	.commit = decon_commit,
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_crtc.c b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
> index eb49195cec5c..93f873f11f64 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_crtc.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
> @@ -241,7 +241,7 @@ struct exynos_drm_crtc *exynos_drm_crtc_create(struct drm_device *drm_dev,
>  					       struct drm_plane *plane,
>  					       int pipe,
>  					       enum exynos_drm_output_type type,
> -					       struct exynos_drm_crtc_ops *ops,
> +					       const struct exynos_drm_crtc_ops *ops,
>  					       void *ctx)
>  {
>  	struct exynos_drm_crtc *exynos_crtc;
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_crtc.h b/drivers/gpu/drm/exynos/exynos_drm_crtc.h
> index 0ecd8fc45cff..ed0994b3cb47 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_crtc.h
> +++ b/drivers/gpu/drm/exynos/exynos_drm_crtc.h
> @@ -21,7 +21,7 @@ struct exynos_drm_crtc *exynos_drm_crtc_create(struct drm_device *drm_dev,
>  					       struct drm_plane *plane,
>  					       int pipe,
>  					       enum exynos_drm_output_type type,
> -					       struct exynos_drm_crtc_ops *ops,
> +					       const struct exynos_drm_crtc_ops *ops,
>  					       void *context);
>  int exynos_drm_crtc_enable_vblank(struct drm_device *dev, int pipe);
>  void exynos_drm_crtc_disable_vblank(struct drm_device *dev, int pipe);
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
> index 44f128a03aea..0e951226ca06 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
> @@ -226,7 +226,7 @@ struct exynos_drm_crtc {
>  	unsigned int			dpms;
>  	wait_queue_head_t		pending_flip_queue;
>  	struct drm_pending_vblank_event	*event;
> -	struct exynos_drm_crtc_ops	*ops;
> +	const struct exynos_drm_crtc_ops	*ops;
>  	void				*ctx;
>  };
>  
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> index 2fb95ccb5841..5c1a148525f8 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> @@ -962,7 +962,7 @@ static void fimd_dp_clock_enable(struct exynos_drm_crtc *crtc, bool enable)
>  	writel(DP_MIE_CLK_DP_ENABLE, ctx->regs + DP_MIE_CLKCON);
>  }
>  
> -static struct exynos_drm_crtc_ops fimd_crtc_ops = {
> +static const struct exynos_drm_crtc_ops fimd_crtc_ops = {
>  	.dpms = fimd_dpms,
>  	.mode_fixup = fimd_mode_fixup,
>  	.commit = fimd_commit,
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> index 27e84ec21694..1b3479a8db5f 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
> @@ -217,7 +217,7 @@ static int vidi_ctx_initialize(struct vidi_context *ctx,
>  	return 0;
>  }
>  
> -static struct exynos_drm_crtc_ops vidi_crtc_ops = {
> +static const struct exynos_drm_crtc_ops vidi_crtc_ops = {
>  	.dpms = vidi_dpms,
>  	.enable_vblank = vidi_enable_vblank,
>  	.disable_vblank = vidi_disable_vblank,
> diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
> index fbec750574e6..d4afd1abe373 100644
> --- a/drivers/gpu/drm/exynos/exynos_mixer.c
> +++ b/drivers/gpu/drm/exynos/exynos_mixer.c
> @@ -1126,7 +1126,7 @@ int mixer_check_mode(struct drm_display_mode *mode)
>  	return -EINVAL;
>  }
>  
> -static struct exynos_drm_crtc_ops mixer_crtc_ops = {
> +static const struct exynos_drm_crtc_ops mixer_crtc_ops = {
>  	.dpms			= mixer_dpms,
>  	.enable_vblank		= mixer_enable_vblank,
>  	.disable_vblank		= mixer_disable_vblank,
> 
