From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 7 Nov 2017 14:58:28 +0100
Subject: [PATCH v1 2/2] drm/stm: ltdc: add a 2nd endpoint
In-Reply-To: <1509018489-19641-3-git-send-email-philippe.cornu@st.com>
References: <1509018489-19641-1-git-send-email-philippe.cornu@st.com>
 <1509018489-19641-3-git-send-email-philippe.cornu@st.com>
Message-ID: <CA+M3ks6T5zcHr3uoyRCdg69LS5be-Erc20YHX7_e645WkmvTmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-10-26 13:48 GMT+02:00 Philippe Cornu <philippe.cornu@st.com>:
> ltdc can have up to 2 endpoints:
>  - dpi external gpios: for rgb panels or external bridge ICs.
>  - dpi internal ios: connected internally to dsi.
>
> Note: Refer to the reference manual to know if the dsi is
> present on your device.

Applied on drm-misc-next
Thanks

Benjamin

> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>  drivers/gpu/drm/stm/ltdc.c | 64 ++++++++++++++++++++++++++++++++--------------
>  1 file changed, 45 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index d5c8a42..38a6739 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -33,6 +33,8 @@
>
>  #define MAX_IRQ 4
>
> +#define MAX_ENDPOINTS 2
> +
>  #define HWVER_10200 0x010200
>  #define HWVER_10300 0x010300
>  #define HWVER_20101 0x020101
> @@ -886,18 +888,33 @@ int ltdc_load(struct drm_device *ddev)
>         struct ltdc_device *ldev = ddev->dev_private;
>         struct device *dev = ddev->dev;
>         struct device_node *np = dev->of_node;
> -       struct drm_bridge *bridge;
> -       struct drm_panel *panel;
> +       struct drm_bridge *bridge[MAX_ENDPOINTS] = {NULL};
> +       struct drm_panel *panel[MAX_ENDPOINTS] = {NULL};
>         struct drm_crtc *crtc;
>         struct reset_control *rstc;
>         struct resource *res;
> -       int irq, ret, i;
> +       int irq, ret, i, endpoint_not_ready = -ENODEV;
>
>         DRM_DEBUG_DRIVER("\n");
>
> -       ret = drm_of_find_panel_or_bridge(np, 0, 0, &panel, &bridge);
> -       if (ret)
> -               return ret;
> +       /* Get endpoints if any */
> +       for (i = 0; i < MAX_ENDPOINTS; i++) {
> +               ret = drm_of_find_panel_or_bridge(np, 0, i, &panel[i],
> +                                                 &bridge[i]);
> +
> +               /*
> +                * If at least one endpoint is ready, continue probing,
> +                * else if at least one endpoint is -EPROBE_DEFER and
> +                * there is no previous ready endpoints, defer probing.
> +                */
> +               if (!ret)
> +                       endpoint_not_ready = 0;
> +               else if (ret == -EPROBE_DEFER && endpoint_not_ready)
> +                       endpoint_not_ready = -EPROBE_DEFER;
> +       }
> +
> +       if (endpoint_not_ready)
> +               return endpoint_not_ready;
>
>         rstc = devm_reset_control_get_exclusive(dev, NULL);
>
> @@ -958,19 +975,25 @@ int ltdc_load(struct drm_device *ddev)
>
>         DRM_INFO("ltdc hw version 0x%08x - ready\n", ldev->caps.hw_version);
>
> -       if (panel) {
> -               bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_DPI);
> -               if (IS_ERR(bridge)) {
> -                       DRM_ERROR("Failed to create panel-bridge\n");
> -                       ret = PTR_ERR(bridge);
> -                       goto err;
> +       /* Add endpoints panels or bridges if any */
> +       for (i = 0; i < MAX_ENDPOINTS; i++) {
> +               if (panel[i]) {
> +                       bridge[i] = drm_panel_bridge_add(panel[i],
> +                                                       DRM_MODE_CONNECTOR_DPI);
> +                       if (IS_ERR(bridge[i])) {
> +                               DRM_ERROR("panel-bridge endpoint %d\n", i);
> +                               ret = PTR_ERR(bridge[i]);
> +                               goto err;
> +                       }
>                 }
> -       }
>
> -       ret = ltdc_encoder_init(ddev, bridge);
> -       if (ret) {
> -               DRM_ERROR("Failed to init encoder\n");
> -               goto err;
> +               if (bridge[i]) {
> +                       ret = ltdc_encoder_init(ddev, bridge[i]);
> +                       if (ret) {
> +                               DRM_ERROR("init encoder endpoint %d\n", i);
> +                               goto err;
> +                       }
> +               }
>         }
>
>         crtc = devm_kzalloc(dev, sizeof(*crtc), GFP_KERNEL);
> @@ -998,7 +1021,8 @@ int ltdc_load(struct drm_device *ddev)
>         return 0;
>
>  err:
> -       drm_panel_bridge_remove(bridge);
> +       for (i = 0; i < MAX_ENDPOINTS; i++)
> +               drm_panel_bridge_remove(bridge[i]);
>
>         clk_disable_unprepare(ldev->pixel_clk);
>
> @@ -1008,10 +1032,12 @@ int ltdc_load(struct drm_device *ddev)
>  void ltdc_unload(struct drm_device *ddev)
>  {
>         struct ltdc_device *ldev = ddev->dev_private;
> +       int i;
>
>         DRM_DEBUG_DRIVER("\n");
>
> -       drm_of_panel_bridge_remove(ddev->dev->of_node, 0, 0);
> +       for (i = 0; i < MAX_ENDPOINTS; i++)
> +               drm_of_panel_bridge_remove(ddev->dev->of_node, 0, i);
>
>         clk_disable_unprepare(ldev->pixel_clk);
>  }
> --
> 1.9.1
>
