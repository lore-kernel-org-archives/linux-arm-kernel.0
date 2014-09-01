From: inki.dae@samsung.com (Inki Dae)
Date: Mon, 01 Sep 2014 22:37:44 +0900
Subject: [PATCH 12/29] DRM: Exynos: fix window clear code
In-Reply-To: <1407235677-26324-13-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
 <1407235677-26324-13-git-send-email-m.szyprowski@samsung.com>
Message-ID: <540476A8.8030502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On 2014? 08? 05? 19:47, Marek Szyprowski wrote:
> To correctly disable hardware window during driver init, both enable bits
> (WINCONx_ENWIN in WINCON and SHADOWCON_CHx_ENABLE in SHADOWCON) must be
> cleared, otherwise hardware fails to re-enable such window later.
> 
> While touching this function, also temporarily disable ctx->suspended flag
> to let fimd_wait_for_vblank function really to do its job.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> index 41904df..7a363d2 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> @@ -165,27 +165,38 @@ static void fimd_wait_for_vblank(struct exynos_drm_manager *mgr)
>  		DRM_DEBUG_KMS("vblank wait timed out.\n");
>  }
>  
> -
>  static void fimd_clear_channel(struct exynos_drm_manager *mgr)
>  {
>  	struct fimd_context *ctx = mgr->ctx;
> -	int win, ch_enabled = 0;
> +	int state, win, ch_enabled = 0;

It doesn't need to declare state variable here because this variable is
used only when ch_enabled is 1.

>  
>  	DRM_DEBUG_KMS("%s\n", __FILE__);
>  
>  	/* Check if any channel is enabled. */
>  	for (win = 0; win < WINDOWS_NR; win++) {
> -		u32 val = readl(ctx->regs + SHADOWCON);
> -		if (val & SHADOWCON_CHx_ENABLE(win)) {
> -			val &= ~SHADOWCON_CHx_ENABLE(win);
> -			writel(val, ctx->regs + SHADOWCON);
> +		u32 val = readl(ctx->regs + WINCON(win));

WARNING: Missing a blank line after declarations

> +		if (val & WINCONx_ENWIN) {
> +			/* wincon */
> +			val &= ~WINCONx_ENWIN;
> +			writel(val, ctx->regs + WINCON(win));
> +
> +			/* unprotect windows */
> +			if (ctx->driver_data->has_shadowcon) {
> +				val = readl(ctx->regs + SHADOWCON);
> +				val &= ~SHADOWCON_CHx_ENABLE(win);
> +				writel(val, ctx->regs + SHADOWCON);
> +			}
>  			ch_enabled = 1;
>  		}
>  	}
>  
>  	/* Wait for vsync, as disable channel takes effect at next vsync */
> -	if (ch_enabled)
> +	if (ch_enabled) {
> +		state = ctx->suspended;

int state = ctx->suspended;

> +		ctx->suspended = 0;
>  		fimd_wait_for_vblank(mgr);
> +		ctx->suspended = state;
> +	}
>  }
>  
>  static int fimd_mgr_initialize(struct exynos_drm_manager *mgr,
> 

Above is trivial so I fixed them. Picked it up.

Thanks,
Inki Dae
