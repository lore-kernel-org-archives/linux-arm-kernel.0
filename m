From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Feb 2015 09:46:39 +0100
Subject: [PATCH] drm: exynos: clean up dma_addr_t use
In-Reply-To: <2463296.ej1sNijqo7@wuerfel>
References: <2463296.ej1sNijqo7@wuerfel>
Message-ID: <2303513.m1GhqAXJBa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 February 2015 16:36:46 Arnd Bergmann wrote:

> @@ -671,6 +671,7 @@ static void fimd_win_commit(struct exynos_drm_crtc *crtc, int zpos)
>  	struct fimd_win_data *win_data;
>  	int win = zpos;
>  	unsigned long val, alpha, size;
> +	dma_addr_t end;
>  	unsigned int last_x;
>  	unsigned int last_y;
>  
> @@ -705,16 +706,16 @@ static void fimd_win_commit(struct exynos_drm_crtc *crtc, int zpos)
>  	/* buffer end address */
>  	size = win_data->fb_width * win_data->ovl_height * (win_data->bpp >> 3);
> -	val = (unsigned long)(win_data->dma_addr + size);
> +	end = win_data->dma_addr + size;
>  	writel(val, ctx->regs + VIDWx_BUF_END(win, 0));
>  
> -	DRM_DEBUG_KMS("start addr = 0x%lx, end addr = 0x%lx, size = 0x%lx\n",
> -			(unsigned long)win_data->dma_addr, val, size);
> +	DRM_DEBUG_KMS("start addr = %pad, end addr = %pad, size = 0x%lx\n",
> +			&win_data->dma_addr, end, size);
>  	DRM_DEBUG_KMS("ovl_width = %d, ovl_height = %d\n",
>  			win_data->ovl_width, win_data->ovl_height);
>  

Unfortunately, I introduced a new bug here, please disregard this version
and use v2 of this patch instead.

	Arnd
