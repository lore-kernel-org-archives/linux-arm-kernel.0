From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 7 May 2018 11:33:32 +0200
Subject: [PATCH v2 03/13] drm/kms/mode/exynos-dsi: using helper func
 drm_display_mode_to_videomode for calculating timing parameters
In-Reply-To: <1525663938-4172-1-git-send-email-satendra.t@samsung.com>
References: <920ac8d1-8d2d-1332-256d-21472f69fca5@arm.com>
 <CGME20180507033238epcas5p2601b5ccbba8fa02cdde4f1375e90abe9@epcas5p2.samsung.com>
 <1525663938-4172-1-git-send-email-satendra.t@samsung.com>
Message-ID: <000252e2-af94-f0af-d943-0c28aedc91f5@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Satendra Singh Thakur,

On 07.05.2018 05:32, Satendra Singh Thakur wrote:
> To avoid duplicate logic for the same
>
> Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
> Acked-by: Madhur Verma <madhur.verma@samsung.com>
> Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>

Whole exynos_dsi_mode_set callback is redundant, so I have posted patch
removing it [1], so this patch can be dropped.

[1]: https://marc.info/?l=dri-devel&m=152568538400712


Regards
Andrzej

> ---
>
>  v2: Removed Mr Robin from reviewed-by field	
>
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index 7904ffa..7fe84fd 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -1490,17 +1490,8 @@ static void exynos_dsi_mode_set(struct drm_encoder *encoder,
>  				struct drm_display_mode *adjusted_mode)
>  {
>  	struct exynos_dsi *dsi = encoder_to_dsi(encoder);
> -	struct videomode *vm = &dsi->vm;
> -	struct drm_display_mode *m = adjusted_mode;
> -
> -	vm->hactive = m->hdisplay;
> -	vm->vactive = m->vdisplay;
> -	vm->vfront_porch = m->vsync_start - m->vdisplay;
> -	vm->vback_porch = m->vtotal - m->vsync_end;
> -	vm->vsync_len = m->vsync_end - m->vsync_start;
> -	vm->hfront_porch = m->hsync_start - m->hdisplay;
> -	vm->hback_porch = m->htotal - m->hsync_end;
> -	vm->hsync_len = m->hsync_end - m->hsync_start;
> +
> +	drm_display_mode_to_videomode(adjusted_mode, &dsi->vm);
>  }
>  
>  static const struct drm_encoder_helper_funcs exynos_dsi_encoder_helper_funcs = {
