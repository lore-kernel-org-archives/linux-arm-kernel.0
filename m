From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 9 May 2018 17:08:24 +0200
Subject: [PATCH v2 01/26] drm/bridge: allow optionally specifying an
 owner .odev device
In-Reply-To: <20180504135212.26977-2-peda@axentia.se>
References: <20180504135212.26977-1-peda@axentia.se>
 <CGME20180504135245epcas4p1d0463b6b3c73d1dd2550c6ed5a4e3986@epcas4p1.samsung.com>
 <20180504135212.26977-2-peda@axentia.se>
Message-ID: <4e92fdea-0609-0fff-0e3f-d9f78f596eb7@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.05.2018 15:51, Peter Rosin wrote:
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
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/drm_bridge.c             | 3 ++-
>  drivers/gpu/drm/rockchip/rockchip_lvds.c | 4 +++-

What is the reason to put rockchip here? Shouldn't be in separate patch?

>  include/drm/drm_bridge.h                 | 2 ++
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 1638bfe9627c..3872f5379998 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -365,7 +365,8 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
>  	mutex_lock(&bridge_lock);
>  
>  	list_for_each_entry(bridge, &bridge_list, list) {
> -		if (bridge->of_node == np) {
> +		if ((bridge->odev && bridge->odev->of_node == np) ||
> +		    bridge->of_node == np) {
>  			mutex_unlock(&bridge_lock);
>  			return bridge;
>  		}
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

I guess odev should be NULL here, or have I missed something.

Regards
Andrzej

>  	if (of_property_read_string(dev->of_node, "rockchip,output", &name))
>  		/* default set it as output rgb */
>  		lvds->output = DISPLAY_OUTPUT_RGB;
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 3270fec46979..7c17977c3537 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -254,6 +254,7 @@ struct drm_bridge_timings {
>  
>  /**
>   * struct drm_bridge - central DRM bridge control structure
> + * @odev: device that owns the bridge
>   * @dev: DRM device this bridge belongs to
>   * @encoder: encoder to which this bridge is connected
>   * @next: the next bridge in the encoder chain
> @@ -265,6 +266,7 @@ struct drm_bridge_timings {
>   * @driver_private: pointer to the bridge driver's internal context
>   */
>  struct drm_bridge {
> +	struct device *odev;
>  	struct drm_device *dev;
>  	struct drm_encoder *encoder;
>  	struct drm_bridge *next;
