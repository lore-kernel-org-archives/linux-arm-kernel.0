From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 4 May 2017 12:11:34 +0800
Subject: [PATCH v2 15/20] drm/sun4i: Ignore the generic connectors for
 components
In-Reply-To: <88de0f79b508e51b5fbf38fac058921a3c748807.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
 <88de0f79b508e51b5fbf38fac058921a3c748807.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64+2_qMbWf=Vd=FFhCfhoAun0eEMu66Vx2Bg6Gjrfrt9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 3, 2017 at 7:59 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The generic connectors such as hdmi-connector doesn't have any driver in,
> so if they are added to the component list, we will be waiting forever for
> a non-existing driver to probe.
>
> Add a list of the connectors we want to ignore when building our component
> list.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_drv.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index 8ddd72cd5873..8c9d2e36be55 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -164,6 +164,11 @@ static const struct component_master_ops sun4i_drv_master_ops = {
>         .unbind = sun4i_drv_unbind,
>  };
>
> +static bool sun4i_drv_node_is_connector(struct device_node *node)
> +{
> +       return of_device_is_compatible(node, "hdmi-connector");
> +}
> +
>  static bool sun4i_drv_node_is_frontend(struct device_node *node)
>  {
>         return of_device_is_compatible(node, "allwinner,sun5i-a13-display-frontend") ||
> @@ -204,7 +209,8 @@ static int sun4i_drv_add_endpoints(struct device *dev,
>             !of_device_is_available(node))
>                 return 0;
>
> -       if (!sun4i_drv_node_is_frontend(node)) {
> +       if (!sun4i_drv_node_is_connector(node) &&

I think it's better to just bail out (return 0) if the current node
is a connector. The connector is the end of the pipeline anyway.
Nothing after it should be considered for the component graph.
The way you currently have it, traversal will continue beyond
the connector node.

ChenYu

> +           !sun4i_drv_node_is_frontend(node)) {
>                 /* Add current component */
>                 DRM_DEBUG_DRIVER("Adding component %s\n",
>                                  of_node_full_name(node));
> --
> git-series 0.8.11
