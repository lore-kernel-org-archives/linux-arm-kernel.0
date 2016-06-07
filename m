From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 7 Jun 2016 08:51:54 +0800
Subject: [PATCH 10/20] drm: rockchip: Rely on the default ->best_encoder()
 behavior
In-Reply-To: <1464877907-27723-11-git-send-email-boris.brezillon@free-electrons.com>
References: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464877907-27723-11-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <57561AAA.5060500@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?06?02? 22:31, Boris Brezillon wrote:
> All outputss have a 1:1 relationship between connectors and encoders
> and the driver is relying on the atomic helpers: we can drop the custom
> ->best_encoder() implementations  and let the core call
> drm_atomic_helper_best_encoder() for us.

Good, All connectors and encoders is 1:1 relationship on rockchip 
outputs, so

Acked-by: Mark Yao <mark.yao@rock-chips.com>

>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>   drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 9 ---------
>   drivers/gpu/drm/rockchip/inno_hdmi.c   | 9 ---------
>   2 files changed, 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index dedc65b..ca22e5e 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -964,18 +964,9 @@ static enum drm_mode_status dw_mipi_dsi_mode_valid(
>   	return mode_status;
>   }
>   
> -static struct drm_encoder *dw_mipi_dsi_connector_best_encoder(
> -					struct drm_connector *connector)
> -{
> -	struct dw_mipi_dsi *dsi = con_to_dsi(connector);
> -
> -	return &dsi->encoder;
> -}
> -
>   static struct drm_connector_helper_funcs dw_mipi_dsi_connector_helper_funcs = {
>   	.get_modes = dw_mipi_dsi_connector_get_modes,
>   	.mode_valid = dw_mipi_dsi_mode_valid,
> -	.best_encoder = dw_mipi_dsi_connector_best_encoder,
>   };
>   
>   static enum drm_connector_status
> diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
> index f8b4feb..006260d 100644
> --- a/drivers/gpu/drm/rockchip/inno_hdmi.c
> +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
> @@ -579,14 +579,6 @@ inno_hdmi_connector_mode_valid(struct drm_connector *connector,
>   	return MODE_OK;
>   }
>   
> -static struct drm_encoder *
> -inno_hdmi_connector_best_encoder(struct drm_connector *connector)
> -{
> -	struct inno_hdmi *hdmi = to_inno_hdmi(connector);
> -
> -	return &hdmi->encoder;
> -}
> -
>   static int
>   inno_hdmi_probe_single_connector_modes(struct drm_connector *connector,
>   				       uint32_t maxX, uint32_t maxY)
> @@ -613,7 +605,6 @@ static struct drm_connector_funcs inno_hdmi_connector_funcs = {
>   static struct drm_connector_helper_funcs inno_hdmi_connector_helper_funcs = {
>   	.get_modes = inno_hdmi_connector_get_modes,
>   	.mode_valid = inno_hdmi_connector_mode_valid,
> -	.best_encoder = inno_hdmi_connector_best_encoder,
>   };
>   
>   static int inno_hdmi_register(struct drm_device *drm, struct inno_hdmi *hdmi)


-- 
?ark Yao
