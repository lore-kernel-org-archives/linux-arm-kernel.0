From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 02 Mar 2018 23:49:06 +0200
Subject: [PATCH v9 5/5] drm/bridge/synopsys: dw-hdmi: Add missing bridge
 detach
In-Reply-To: <20180302175757.28192-6-enric.balletbo@collabora.com>
References: <20180302175757.28192-1-enric.balletbo@collabora.com>
 <20180302175757.28192-6-enric.balletbo@collabora.com>
Message-ID: <2714218.VptbnhJPkd@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Enric,

Thank you for the patch.

On Friday, 2 March 2018 19:57:57 EET Enric Balletbo i Serra wrote:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> We inited connector in attach(), so need a detach() to cleanup.

Do we ? The dw-hdmi driver already sets drm_connector_cleanup() as the 
connector .destroy() handler, and the .destroy() operation is called by the 
DRM core. None of the other bridge drivers call drm_connector_cleanup() 
directly.

> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v9: None
> 
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> f9802399cc0d..5626922f95f9 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1985,6 +1985,13 @@ static int dw_hdmi_bridge_attach(struct drm_bridge
> *bridge) return 0;
>  }
> 
> +static void dw_hdmi_bridge_detach(struct drm_bridge *bridge)
> +{
> +	struct dw_hdmi *hdmi = bridge->driver_private;
> +
> +	drm_connector_cleanup(&hdmi->connector);
> +}
> +
>  static enum drm_mode_status
>  dw_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
>  			  const struct drm_display_mode *mode)
> @@ -2041,6 +2048,7 @@ static void dw_hdmi_bridge_enable(struct drm_bridge
> *bridge)
> 
>  static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
>  	.attach = dw_hdmi_bridge_attach,
> +	.detach = dw_hdmi_bridge_detach,
>  	.enable = dw_hdmi_bridge_enable,
>  	.disable = dw_hdmi_bridge_disable,
>  	.mode_set = dw_hdmi_bridge_mode_set,

-- 
Regards,

Laurent Pinchart
