From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 19 Nov 2018 09:38:33 +0100
Subject: [PATCH v2 06/12] drm/sun4i: sun6i_mipi_dsi: Probe tcon0 during
 dsi_bind
In-Reply-To: <20181116163916.29621-7-jagan@amarulasolutions.com>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-7-jagan@amarulasolutions.com>
Message-ID: <20181119083833.d7ysiv3tenabtrdj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 10:09:10PM +0530, Jagan Teki wrote:
> Probe tcon0 during dsi_bind, so-that the tcon attributes like
> divider value, clock rate can get whenever it need.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 +++++++
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index d60955880c43..66a01061e51d 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -25,6 +25,7 @@
>  #include <drm/drm_panel.h>
>  
>  #include "sun4i_drv.h"
> +#include "sun4i_tcon.h"
>  #include "sun6i_mipi_dsi.h"
>  
>  #include <video/mipi_display.h>
> @@ -1007,6 +1008,7 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
>  	struct drm_device *drm = data;
>  	struct sun4i_drv *drv = drm->dev_private;
>  	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
> +	struct sun4i_tcon *tcon0 = sun4i_get_tcon0(drm);
>  	int ret;
>  
>  	if (!dsi->panel)
> @@ -1014,6 +1016,11 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
>  
>  	dsi->drv = drv;
>  
> +	if (!tcon0)
> +		return -EPROBE_DEFER;

You can't fall in that condition. The component framework won't call
bind unless every components have been probed.

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181119/da3b971c/attachment.sig>
