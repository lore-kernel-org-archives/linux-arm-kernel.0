From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 20 Aug 2013 11:13:24 +0100
Subject: [PATCH] of: reduce the number of PROBE_DEFERs
In-Reply-To: <20130820120105.55a4c0ce@armhf>
References: <20130820120105.55a4c0ce@armhf>
Message-ID: <CACxGe6vNKoi47-R3H2sYUhGuX5Lh0nokWaj6Bzw2zv2U0_Wgsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 11:01 AM, Jean-Francois Moine <moinejf@free.fr> wrote:
> This patch populates the platform from the device tree into two steps:
> the first step creates the nodes that are referenced by a phandle,
> the second step creates the other nodes.
>
> This permits to reduce the number of PROBE_DEFERs.
>
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
> A better way to reduce probe deferral could be sorting the nodes
> according to their phandle level in the DT blob at compilation time ...

Have you got measurements or statistics that show this making a
difference? I suspect you'll find for boot time it will have little to
no affect since the device driver probe order is more closely related
to the kernel link order than the order that devices were registered.

g.

> ---
>  drivers/of/platform.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index e0a6514..a2ea858 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -382,8 +382,23 @@ static int of_platform_bus_create(struct device_node *bus,
>         if (!dev || !of_match_node(matches, bus))
>                 return 0;
>
> +       /* first step: create the nodes that are referenced by phandle */
>         for_each_child_of_node(bus, child) {
> -               pr_debug("   create child: %s\n", child->full_name);
> +               if (child->phandle == 0)
> +                       continue;
> +               pr_debug("   create child 1: %s\n", child->full_name);
> +               rc = of_platform_bus_create(child, matches, lookup, &dev->dev, strict);
> +               if (rc) {
> +                       of_node_put(child);
> +                       return rc;
> +               }
> +       }
> +
> +       /* second step: create the other nodes */
> +       for_each_child_of_node(bus, child) {
> +               if (child->phandle != 0)
> +                       continue;
> +               pr_debug("   create child 2: %s\n", child->full_name);
>                 rc = of_platform_bus_create(child, matches, lookup, &dev->dev, strict);
>                 if (rc) {
>                         of_node_put(child);
>
>
> --
> Ken ar c'henta? |             ** Breizh ha Linux atav! **
> Jef             |               http://moinejf.free.fr/
