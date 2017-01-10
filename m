From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 10 Jan 2017 11:18:28 +0100
Subject: [PATCH] drm/exynos: constify exynos_drm_crtc_ops structures
In-Reply-To: <1483984493-25284-1-git-send-email-bhumirks@gmail.com>
References: <1483984493-25284-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20170110101828.dtvivdtty44k7snd@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 11:24:53PM +0530, Bhumika Goyal wrote:
> Declare exynos_drm_crtc_ops structures as const as they are only passed
> as an argument to the function exynos_drm_crtc_create. This argument is
> of type const struct exynos_drm_crtc_ops *, so exynos_drm_crtc_ops
> structures having this property can be declared const.
> Done using Coccinelle:
> 
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct exynos_drm_crtc_ops i at p={...};
> 
> @ok@
> position p;
> identifier r.i;
> @@
> exynos_drm_crtc_create(...,&i at p,...)
> 
> @bad@
> position p!={r.p,ok.p};
> identifier r.i;
> @@
> i at p
> 
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> +const
> struct exynos_drm_crtc_ops i;
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    5008	    280	      0	   5288	   14a8	exynos/exynos5433_drm_decon.o
> 
> File size after:
>    text	   data	    bss	    dec	    hex	filename
>    5120	    176	      0	   5296	   14b0 exynos/exynos5433_drm_decon.o
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied to drm-misc, thanks.
-Daniel

> ---
>  drivers/gpu/drm/exynos/exynos5433_drm_decon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
> index 6ca1f31..12b9bf0 100644
> --- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
> +++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
> @@ -470,7 +470,7 @@ static void decon_clear_channels(struct exynos_drm_crtc *crtc)
>  		clk_disable_unprepare(ctx->clks[i]);
>  }
>  
> -static struct exynos_drm_crtc_ops decon_crtc_ops = {
> +static const struct exynos_drm_crtc_ops decon_crtc_ops = {
>  	.enable			= decon_enable,
>  	.disable		= decon_disable,
>  	.enable_vblank		= decon_enable_vblank,
> -- 
> 1.9.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
