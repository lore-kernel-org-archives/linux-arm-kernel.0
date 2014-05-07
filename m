From: sw0312.kim@samsung.com (Seung-Woo Kim)
Date: Wed, 07 May 2014 14:14:36 +0900
Subject: [PATCH 2/4] drm/exynos/mixer: use MXR_GRP_SXY_SY
In-Reply-To: <1399217181-26442-3-git-send-email-djkurtz@chromium.org>
References: <1399217181-26442-1-git-send-email-djkurtz@chromium.org>
 <1399217181-26442-3-git-send-email-djkurtz@chromium.org>
Message-ID: <5369C13C.3080506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 2014? 05? 05? 00:26, Daniel Kurtz wrote:
> Mixer hardware supports offsetting dma from start of source buffer using
> the MXR_GRP_SXY register.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  drivers/gpu/drm/exynos/exynos_mixer.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
> index 475eb49..40cf39b 100644
> --- a/drivers/gpu/drm/exynos/exynos_mixer.c
> +++ b/drivers/gpu/drm/exynos/exynos_mixer.c
> @@ -529,13 +529,11 @@ static void mixer_graph_buffer(struct mixer_context *ctx, int win)
>  
>  	dst_x_offset = win_data->crtc_x;
>  	dst_y_offset = win_data->crtc_y;
> +	src_x_offset = win_data->fb_x;
> +	src_y_offset = win_data->fb_y;
>  
>  	/* converting dma address base and source offset */
> -	dma_addr = win_data->dma_addr
> -		+ (win_data->fb_x * win_data->bpp >> 3)
> -		+ (win_data->fb_y * win_data->fb_width * win_data->bpp >> 3);
> -	src_x_offset = 0;
> -	src_y_offset = 0;
> +	dma_addr = win_data->dma_addr;

Basically, you are right and source offset register can be used. But
because of limitation of resolution for mixer up to 1920x1080, I
considered modified soruce dma address to set one frame buffer, which is
bigger than 1920x1080, on to both fimd and hdmi.

Regards,
- Seung-Woo Kim

>  
>  	if (win_data->scan_flags & DRM_MODE_FLAG_INTERLACE)
>  		ctx->interlace = true;
> 

-- 
Seung-Woo Kim
Samsung Software R&D Center
--
