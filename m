From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 4 Jan 2018 23:47:19 +0800
Subject: [PATCH v2 08/12] drm/sun4i: backend: Wire in the frontend
In-Reply-To: <9e8c0ce7192dc9ec59da6906e8f6e8f282ac3809.1513609024.git-series.maxime.ripard@free-electrons.com>
References: <cover.baf97666d4bb722f2acfdc2c98c0461e58f31b9e.1513609024.git-series.maxime.ripard@free-electrons.com>
 <9e8c0ce7192dc9ec59da6906e8f6e8f282ac3809.1513609024.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67zQVq_iqdKg2Rq0Dw27D8Or4U82Z2bK=EqXmuPPcdVQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 10:57 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Now that we have a driver, we can make use of it. This is done by
> adding a flag to our custom plane state that will trigger whether we should
> use the frontend on that particular plane or not.
>
> The rest is just plumbing to set up the backend to not perform the DMA but
> receive its data from the frontend.
>
> Note that we're still not making any use of the frontend itself, as no one
> is setting the flag yet.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_backend.c | 90 ++++++++++++++++++++++++++++-
>  drivers/gpu/drm/sun4i/sun4i_backend.h |  8 ++-
>  drivers/gpu/drm/sun4i/sun4i_crtc.c    |  1 +-
>  drivers/gpu/drm/sun4i/sun4i_layer.c   | 33 +++++++++-
>  drivers/gpu/drm/sun4i/sun4i_layer.h   |  1 +-
>  5 files changed, 130 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index f971d3fb5ee4..29e1ca7e01fe 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -26,6 +26,7 @@
>
>  #include "sun4i_backend.h"
>  #include "sun4i_drv.h"
> +#include "sun4i_frontend.h"
>  #include "sun4i_layer.h"
>  #include "sunxi_engine.h"
>
> @@ -203,6 +204,30 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
>         return 0;
>  }
>
> +int sun4i_backend_update_layer_frontend(struct sun4i_backend *backend,
> +                                       int layer, uint32_t fmt)
> +{
> +       u32 val;
> +       int ret;
> +
> +       ret = sun4i_backend_drm_format_to_layer(NULL, fmt, &val);
> +       if (ret) {
> +               DRM_DEBUG_DRIVER("Invalid format\n");
> +               return ret;
> +       }
> +
> +       regmap_update_bits(backend->engine.regs,
> +                          SUN4I_BACKEND_ATTCTL_REG0(layer),
> +                          SUN4I_BACKEND_ATTCTL_REG0_LAY_VDOEN,
> +                          SUN4I_BACKEND_ATTCTL_REG0_LAY_VDOEN);

You also need to select which frontend to use by setting LAY_VDOSEL.

> +
> +       regmap_update_bits(backend->engine.regs,
> +                          SUN4I_BACKEND_ATTCTL_REG1(layer),
> +                          SUN4I_BACKEND_ATTCTL_REG1_LAY_FBFMT, val);
> +
> +       return 0;
> +}
> +
>  int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
>                                       int layer, struct drm_plane *plane)
>  {
> @@ -246,6 +271,36 @@ int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
>         return 0;
>  }
>
> +static void sun4i_backend_vblank_quirk(struct sunxi_engine *engine)
> +{
> +       struct sun4i_backend *backend = engine_to_sun4i_backend(engine);
> +       struct sun4i_frontend *frontend = backend->frontend;
> +
> +       if (!frontend)
> +               return;
> +
> +       /*
> +        * In a teardown scenario with the frontend involved, we have
> +        * to keep the frontend enabled until the next vblank, and
> +        * only then disable it.
> +        *
> +        * This is due to the fact that the backend will not take into
> +        * account the new configuration (with the plane that used to
> +        * be fed by the frontend now disabled) until we write to the
> +        * commit bit and the hardware fetches the new configuration
> +        * during the next vblank.
> +        *
> +        * So we keep the frontend around in order to prevent any
> +        * visual artifacts.
> +        */
> +       spin_lock(&backend->frontend_lock);
> +       if (backend->frontend_teardown) {
> +               sun4i_frontend_exit(frontend);
> +               backend->frontend_teardown = false;
> +       }
> +       spin_unlock(&backend->frontend_lock);
> +};
> +
>  static int sun4i_backend_init_sat(struct device *dev) {
>         struct sun4i_backend *backend = dev_get_drvdata(dev);
>         int ret;
> @@ -330,11 +385,40 @@ static int sun4i_backend_of_get_id(struct device_node *node)
>         return ret;
>  }
>
> +static struct sun4i_frontend *sun4i_backend_find_frontend(struct sun4i_drv *drv,
> +                                                         struct device_node *node)
> +{
> +       struct device_node *port, *ep, *remote;
> +       struct sun4i_frontend *frontend;
> +
> +       port = of_graph_get_port_by_id(node, 0);
> +       if (!port)
> +               return ERR_PTR(-EINVAL);
> +
> +       for_each_available_child_of_node(port, ep) {
> +               remote = of_graph_get_remote_port_parent(ep);
> +               if (!remote)
> +                       continue;
> +
> +               /* does this node match any registered engines? */
> +               list_for_each_entry(frontend, &drv->frontend_list, list) {
> +                       if (remote == frontend->node) {
> +                               of_node_put(remote);
> +                               of_node_put(port);
> +                               return frontend;

This would return the same frontend for both backends in a dual pipeline setup.
Remember that we now have cross-connecting links between frontends and backends
of both pipelines.

Instead just match the frontend's ID to the backend's ID. BTW I think you left
out the ID thing in the frontend driver.

The rest looks good.

ChenYu
