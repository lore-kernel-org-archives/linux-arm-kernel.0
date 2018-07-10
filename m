From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Jul 2018 23:40:14 +0800
Subject: [PATCH 09/17] drm/sun4i: mixer: Read id from DT
In-Reply-To: <20180706175113.26698-10-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-10-jernej.skrabec@siol.net>
Message-ID: <CAGb2v64zBrzpqV9pvJPeaxbpLai8Ky0gTcwbSPv0m-vS-2JXKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Currently, TCON supports 2 ways to match TCON with engine (mixer in this
> case). Old way is to just traverse of graph backwards and compare node
> pointer. New way is to match TCON and engine by their respective ids.
> All SoCs with DE2 enabled till now used the old way, which means mixer
> id was never used and thus never implemented.
>
> However, for R40, only the new way will be used. To prepare for that,
> implemend fetching mixer id from DT.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 35 +++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> index ee8febb25903..11221f96746d 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -23,6 +23,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/reset.h>
>  #include <linux/of_device.h>
> +#include <linux/of_graph.h>

These should be alphabetically ordered.

>
>  #include "sun4i_drv.h"
>  #include "sun8i_mixer.h"
> @@ -322,6 +323,37 @@ static struct regmap_config sun8i_mixer_regmap_config = {
>         .max_register   = 0xbfffc, /* guessed */
>  };
>
> +static int sun8i_mixer_of_get_id(struct device_node *node)
> +{
> +       struct device_node *port, *ep;
> +       int ret = -EINVAL;
> +
> +       /* output is port 1 */
> +       port = of_graph_get_port_by_id(node, 1);
> +       if (!port)
> +               return -EINVAL;
> +
> +       /* try finding an upstream endpoint */

You mean downstream.

> +       for_each_available_child_of_node(port, ep) {
> +               struct device_node *remote;
> +               u32 reg;
> +
> +               remote = of_graph_get_remote_endpoint(ep);
> +               if (!remote)
> +                       continue;
> +
> +               ret = of_property_read_u32(remote, "reg", &reg);
> +               if (ret)
> +                       continue;

This is somewhat redundant, given the current code structure will loop
over all available child nodes. What you want is probably an early
termination condition instead, i.e. if (!ret).

Also, remember to call of_node_put on the remote node.

ChenYu

> +
> +               ret = reg;
> +       }
> +
> +       of_node_put(port);
> +
> +       return ret;
> +}
> +
>  static int sun8i_mixer_bind(struct device *dev, struct device *master,
>                               void *data)
>  {
> @@ -353,8 +385,7 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
>         dev_set_drvdata(dev, mixer);
>         mixer->engine.ops = &sun8i_engine_ops;
>         mixer->engine.node = dev->of_node;
> -       /* The ID of the mixer currently doesn't matter */
> -       mixer->engine.id = -1;
> +       mixer->engine.id = sun8i_mixer_of_get_id(dev->of_node);
>
>         mixer->cfg = of_device_get_match_data(dev);
>         if (!mixer->cfg)
> --
> 2.18.0
>
