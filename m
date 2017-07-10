From: oliver+list@schinagl.nl (Olliver Schinagl)
Date: Mon, 10 Jul 2017 16:22:21 +0200
Subject: [linux-sunxi] [PATCH v3] drm/sun4i: Implement drm_driver
 lastclose to restore fbdev console
In-Reply-To: <20170710065504.31497-1-net147@gmail.com>
References: <20170710065504.31497-1-net147@gmail.com>
Message-ID: <9dd1080b-1a0c-888a-b336-bc321c823e80@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Jonathan,

since I reported this to you on IRC, it's only fair that you can have my:

Tested-by: Olliver Schinagl <oliver@schinagl.nl>

For those interessted, I've tested it on an Olimex OLinuXino Lime2 with 
their 4.3 LCD.

Olliver

On 10-07-17 08:55, Jonathan Liu wrote:
> The drm_driver lastclose callback is called when the last userspace
> DRM client has closed. Call drm_fbdev_cma_restore_mode to restore
> the fbdev console otherwise the fbdev console will stop working.
>
> Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
> Cc: stable at vger.kernel.org
> Signed-off-by: Jonathan Liu <net147@gmail.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes for v3:
>  - Add 'Fixes:' tag
>  - Add CC to stable
>  - Add 'Reviewed-by: Chen-Yu Tsai <wens@csie.org>'
>
> Changes for v2:
>  - Rename sun4i_drm_lastclose to sun4i_drv_lastclose
>
>  drivers/gpu/drm/sun4i/sun4i_drv.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index abc7d8fe06b4..a45a627283a1 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -25,12 +25,20 @@
>  #include "sun4i_framebuffer.h"
>  #include "sun4i_tcon.h"
>
> +static void sun4i_drv_lastclose(struct drm_device *dev)
> +{
> +	struct sun4i_drv *drv = dev->dev_private;
> +
> +	drm_fbdev_cma_restore_mode(drv->fbdev);
> +}
> +
>  DEFINE_DRM_GEM_CMA_FOPS(sun4i_drv_fops);
>
>  static struct drm_driver sun4i_drv_driver = {
>  	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME | DRIVER_ATOMIC,
>
>  	/* Generic Operations */
> +	.lastclose		= sun4i_drv_lastclose,
>  	.fops			= &sun4i_drv_fops,
>  	.name			= "sun4i-drm",
>  	.desc			= "Allwinner sun4i Display Engine",
>
