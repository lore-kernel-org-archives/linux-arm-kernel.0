From: eric@anholt.net (Eric Anholt)
Date: Thu, 18 May 2017 11:31:20 -0700
Subject: [PATCH v1 1/3] drm/stm: ltdc: Add bridge support
In-Reply-To: <1494600989-13507-2-git-send-email-philippe.cornu@st.com>
References: <1494600989-13507-1-git-send-email-philippe.cornu@st.com>
 <1494600989-13507-2-git-send-email-philippe.cornu@st.com>
Message-ID: <87y3tuj9tz.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Philippe CORNU <philippe.cornu@st.com> writes:

> Add the bridge support, used by DSI host and HDMI/LVDS bridges.
>
> Signed-off-by: Philippe CORNU <philippe.cornu@st.com>

> @@ -987,19 +1024,36 @@ static struct drm_panel *ltdc_get_panel(struct drm_device *ddev)
>  
>  		port = of_graph_get_remote_port_parent(entity);
>  		if (port) {
> +			struct drm_bridge *bridge;
> +			struct drm_panel *panel;
> +
> +			bridge = of_drm_find_bridge(port);
>  			panel = of_drm_find_panel(port);
> -			of_node_put(port);
> +			if (!bridge && !panel) {
> +				of_node_put(entity);
> +				return -EPROBE_DEFER;
> +			}
> +
> +			if (bridge) {
> +				if (!ldev->bridge) {
> +					ldev->bridge = bridge;
> +					DRM_INFO("remote bridge %s\n",
> +						 port->full_name);
> +				}
> +			}
> +
>  			if (panel) {
> -				DRM_DEBUG_DRIVER("remote panel %s\n",
> +				if (!ldev->panel) {
> +					ldev->panel = panel;
> +					DRM_INFO("remote panel %s\n",
>  						 port->full_name);
> -			} else {
> -				DRM_DEBUG_DRIVER("panel missing\n");
> -				of_node_put(entity);
> +				}
>  			}
> +			of_node_put(port);

Is it possible to use drm_of_find_panel_or_bridge() instead?  I don't
think it makes sense to have both a bridge and a panel for the same
node, does it?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170518/55a135d8/attachment.sig>
