From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 13 Jun 2018 09:46:21 +0200
Subject: [PATCH v2 14/27] drm/sun4i: Don't check for panel or bridge on
 TV TCONs
In-Reply-To: <20180612200036.21483-15-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-15-jernej.skrabec@siol.net>
Message-ID: <20180613074621.5phumovcyymbkfbn@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2018 at 10:00:23PM +0200, Jernej Skrabec wrote:
> TV TCONs are always connected to TV or HDMI encoder, so it doesn't make
> sense to check if panel or bridge is connected to them.
> 
> Check if TCON has channel 0 and only then check for connected panel or
> bridges.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index b1205a7bc20f..c9ffa5381185 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -1189,13 +1189,19 @@ static const struct component_ops sun4i_tcon_ops = {
>  static int sun4i_tcon_probe(struct platform_device *pdev)
>  {
>  	struct device_node *node = pdev->dev.of_node;
> +	const struct sun4i_tcon_quirks *quirks;
>  	struct drm_bridge *bridge;
>  	struct drm_panel *panel;
>  	int ret;
>  
> -	ret = drm_of_find_panel_or_bridge(node, 1, 0, &panel, &bridge);
> -	if (ret == -EPROBE_DEFER)
> -		return ret;
> +	quirks = of_device_get_match_data(&pdev->dev);

We should probably check ofr the pointer value before dereferencing it.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180613/86d5ae0a/attachment-0001.sig>
