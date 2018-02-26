From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 26 Feb 2018 10:39:30 +0100
Subject: [PATCH 08/15] drm/sun4i: Fix polarity configuration for DW HDMI
 PHY
In-Reply-To: <20180224214545.3740-9-jernej.skrabec@siol.net>
References: <20180224214545.3740-1-jernej.skrabec@siol.net>
 <20180224214545.3740-9-jernej.skrabec@siol.net>
Message-ID: <20180226093930.mipjyr6sr35ldkw6@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 24, 2018 at 10:45:38PM +0100, Jernej Skrabec wrote:
> Current polarity configuration code is cleary wrong since it compares
> same flag two times. However, even if flag name is fixed, it won't work
> well for resolutions which have one polarity positive and another
> negative.
> 
> Fix that by properly set each bit according to each polarity. Since
> those two bits are not described in any documentation, relationships
> were obtained by experimentation.
> 
> Fixes: b7c7436a5ff0 ("drm/sun4i: Implement A83T HDMI driver")
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> index e5bfcdd43ec9..f48e8b70fabe 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> @@ -35,10 +35,11 @@ static int sun8i_hdmi_phy_config(struct dw_hdmi *hdmi, void *data,
>  	struct sun8i_hdmi_phy *phy = (struct sun8i_hdmi_phy *)data;
>  	u32 val = 0;
>  
> -	if ((mode->flags & DRM_MODE_FLAG_NHSYNC) &&
> -	    (mode->flags & DRM_MODE_FLAG_NHSYNC)) {
> -		val = 0x03;
> -	}
> +	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> +		val |= 0x01;
> +
> +	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
> +		val |= 0x02;

Can you introduce defines for those?

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180226/5dd2c855/attachment.sig>
