From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 11 Jun 2013 16:34:59 -0700
Subject: [PATCH 6/6] mtd: ofpart: add compatible check for child nodes
In-Reply-To: <1370860014-1770-7-git-send-email-josh.wu@atmel.com>
References: <1370860014-1770-1-git-send-email-josh.wu@atmel.com>
 <1370860014-1770-7-git-send-email-josh.wu@atmel.com>
Message-ID: <CAN8TOE-JuVAAKBR84cbs9Hge+bQ6hQpFyoSDywKvCMe7h+Lc4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On Mon, Jun 10, 2013 at 3:26 AM, Josh Wu <josh.wu@atmel.com> wrote:
> If the child node has compatible property then it is a driver not partition.
>
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
>  drivers/mtd/ofpart.c |   14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
> index 553d6d6..61ce1f8 100644
> --- a/drivers/mtd/ofpart.c
> +++ b/drivers/mtd/ofpart.c
> @@ -20,6 +20,10 @@
>  #include <linux/slab.h>
>  #include <linux/mtd/partitions.h>
>
> +static bool node_has_compatible(struct device_node *pp, int *len)
> +{
> +       return of_get_property(pp, "compatible", len);
> +}

The way the interface is named, it seems like a user only would ever
need the bool return value, not the implicit 'len' return value. So I
would write it like this:

static bool node_has_compatible(struct device_node *pp)
{
       return of_get_property(pp, "compatible", NULL);
}

>  static int parse_ofpart_partitions(struct mtd_info *master,
>                                    struct mtd_partition **pparts,
>                                    struct mtd_part_parser_data *data)
> @@ -40,8 +44,13 @@ static int parse_ofpart_partitions(struct mtd_info *master,
>         /* First count the subnodes */
>         pp = NULL;
>         nr_parts = 0;
> -       while ((pp = of_get_next_child(node, pp)))
> +       while ((pp = of_get_next_child(node, pp))) {
> +               int len;
> +               if (node_has_compatible(pp, &len))

Then this would just be:

if (node_has_compatible(pp))
...
etc. (rest snipped)

On a more important question, why does a NAND device node have
sub-nodes that are not partitions? And if such devices exist, wouldn't
it be more foolproof to establish a "compatible" property for ofpart
partitions? Of course, we'd still have to retain
backward-compatibility and allow partitions without a "compatible"
prop. But this question probably should be addressed in the commit log
and documented in Documentation/devicetree/bindings/mtd/partition.txt
; either specifying that all sub-nodes without a compatible property
must be partitions, or else some other explanation.

Brian
