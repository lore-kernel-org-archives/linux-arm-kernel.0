From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 1 Jun 2016 15:13:19 -0500
Subject: [PATCH v2 2/5] of/numa: fix a memory@ node can only contains one
 memory block
In-Reply-To: <1464427377-12712-3-git-send-email-thunder.leizhen@huawei.com>
References: <1464427377-12712-1-git-send-email-thunder.leizhen@huawei.com>
 <1464427377-12712-3-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <CAL_JsqJO1jXpmAJWUhCW+OK2mpTvtwzCuy_--3sQNUQhTvyFdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 28, 2016 at 4:22 AM, Zhen Lei <thunder.leizhen@huawei.com> wrote:
> For a normal memory@ devicetree node, its reg property can contains more
> memory blocks.
>
> Because we don't known how many memory blocks maybe contained, so we try
> from index=0, increase 1 until error returned(the end).
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/of/of_numa.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
> index fb71b4e..fa85a51 100644
> --- a/drivers/of/of_numa.c
> +++ b/drivers/of/of_numa.c
> @@ -63,13 +63,9 @@ static int __init of_numa_parse_memory_nodes(void)
>         struct device_node *np = NULL;
>         struct resource rsrc;
>         u32 nid;
> -       int r = 0;
> -
> -       for (;;) {
> -               np = of_find_node_by_type(np, "memory");
> -               if (!np)
> -                       break;
> +       int i, r = 0;
>
> +       for_each_node_by_type(np, "memory") {
>                 r = of_property_read_u32(np, "numa-node-id", &nid);
>                 if (r == -EINVAL)
>                         /*
> @@ -78,21 +74,17 @@ static int __init of_numa_parse_memory_nodes(void)
>                          * "numa-node-id" property
>                          */
>                         continue;
> -               else if (r)
> -                       /* some other error */
> -                       break;
>
> -               r = of_address_to_resource(np, 0, &rsrc);
> -               if (r) {
> -                       pr_err("NUMA: bad reg property in memory node\n");
> -                       break;
> -               }
> +               for (i = 0; !r && !of_address_to_resource(np, i, &rsrc); i++)
> +                       r = numa_add_memblk(nid, rsrc.start, rsrc.end + 1);
>
> -               r = numa_add_memblk(nid, rsrc.start, rsrc.end + 1);
> -               if (r)
> +               if (!i || r) {
> +                       of_node_put(np);
> +                       pr_err("NUMA: bad property in memory node\n");
> +                       r = r ? : -EINVAL;
>                         break;
> +               }
>         }
> -       of_node_put(np);

I believe you still need this and not the one above. You only need it
within the loop if you return. Otherwise, the last node always need to
be put.

With that, for the series:

Acked-by: Rob Herring <robh@kernel.org>

Rob
