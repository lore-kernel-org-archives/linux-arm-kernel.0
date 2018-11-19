From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 19 Nov 2018 09:19:34 +0100
Subject: [PATCH] drm/sun4i: hdmi: Improve compatibility with non-hotplug
 capable connectors
In-Reply-To: <20181116171830.23465-1-plaes@plaes.org>
References: <20181116171830.23465-1-plaes@plaes.org>
Message-ID: <20181119081934.ohjg36zjcb52nrrq@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 16, 2018 at 07:18:29PM +0200, Priit Laes wrote:
> From: Priit Laes <priit.laes@paf.com>
> 
> Even though HDMI connector features hotplug detect pin (HPD), there are
> devices that which do not support it.

Which devices?

> For these devices fall back to additional check on I2C bus. Of
> course, there might be also devices that do not wire DDC pins too,
> so we don't really know whether cable has been connected.

Again, which devices?

> 
> Signed-off-by: Priit Laes <plaes@plaes.org>
> Signed-off-by: Priit Laes <priit.laes@paf.com>

You only need one :)

> ---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> index 061d2e0d9011..bded09af1340 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> @@ -238,14 +238,18 @@ sun4i_hdmi_connector_detect(struct drm_connector *connector, bool force)
>  	struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
>  	unsigned long reg;
>  
> -	if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_HPD_REG, reg,
> +	if (!readl_poll_timeout(hdmi->base + SUN4I_HDMI_HPD_REG, reg,
>  			       reg & SUN4I_HDMI_HPD_HIGH,
>  			       0, 500000)) {
> -		cec_phys_addr_invalidate(hdmi->cec_adap);
> -		return connector_status_disconnected;
> +		return connector_status_connected;
>  	}
>  
> -	return connector_status_connected;
> +	if (!IS_ERR(hdmi->i2c) && drm_probe_ddc(hdmi->i2c))
> +		return connector_status_connected;
> +
> +	cec_phys_addr_invalidate(hdmi->cec_adap);
> +
> +	return connector_status_unknown;

You're doing basically two things in that patch, first adding the
fallback to the DDC probe if the hotplug mechanism couldn't detect the
display, and then returning a status unknown if both fail.

While I don't really have an opinion on the first one, it's mandatory
for every HDMI device to be able to retrieve the EDID through the
DDC. If a device was to disallow that, it would violate the HDMI, and
I'm not sure we want to start supporting those devices.

Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181119/83ff0540/attachment.sig>
