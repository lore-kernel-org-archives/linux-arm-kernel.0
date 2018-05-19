From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 19 May 2018 18:07:33 +0200
Subject: [PATCH v3 01/26] drm/bridge: allow optionally specifying an owner
 .odev device
In-Reply-To: <20180516101510.13215-2-peda@axentia.se>
References: <20180516101510.13215-1-peda@axentia.se>
 <20180516101510.13215-2-peda@axentia.se>
Message-ID: <21812146.Dm3JJO5T5a@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Am Mittwoch, 16. Mai 2018, 12:14:45 CEST schrieb Peter Rosin:
> Bridge drivers can now (temporarily, in a transition phase) select if
> they want to provide a full owner device or keep just providing an
> of_node.
> 
> By providing a full owner device, the bridge drivers no longer need
> to provide an of_node since that node is available via the owner
> device.
> 
> When all bridge drivers provide an owner device, that will become
> mandatory and the .of_node member will be removed.
> 
> There is an interaction with the rockchip lvds driver, since that
> driver peeks into somewhat private parts of the bridge struct in
> order to find out things about the remote bridge. When there are
> now two ways to get to the remote bridge, the rockchip lvds driver
> has to adapt. That said, the correct thing to do for the rockchip
> lvds driver is to use some other way than DT to find things out
> about the remote bridge, but that is orthogonal to this patch.
> 
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Peter Rosin <peda@axentia.se>

> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> index 4bd94b167d2c..557e0079c98d 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> @@ -377,8 +377,10 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  	}
>  	if (lvds->panel)
>  		remote = lvds->panel->dev->of_node;
> -	else
> +	else if (lvds->bridge->of_node)
>  		remote = lvds->bridge->of_node;
> +	else
> +		remote = lvds->bridge->odev->of_node;
>  	if (of_property_read_string(dev->of_node, "rockchip,output", &name))
>  		/* default set it as output rgb */
>  		lvds->output = DISPLAY_OUTPUT_RGB;

for the Rockchip-part
Acked-by: Heiko Stuebner <heiko@sntech.de>
