From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 25 May 2016 09:46:49 -0500
Subject: [PATCH v4 01/18] of/platform: Add common method to populate
 default bus
In-Reply-To: <1463054775-18170-2-git-send-email-wangkefeng.wang@huawei.com>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
 <1463054775-18170-2-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <CAL_JsqJt9qa+3eAO95kvM7h2beRfq3q1Bi39K7uhURTp=f_DtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 7:05 AM, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> The arch code calls of_platform_populate() with default match table
> when it want to populate default bus.
>
> This patch introduce a new of_platform_default_populate_init() and make it
> arch_initcall_sync(it should be later than some iommu configration, eg,
> of_iommu_init() and swiotlb_late_init in arm64), then we can finish above
> job in common method.
>
> In order to avoid the default bus being populated twice, simply checking
> the flag of bus node whether has be set OF_POPULATED_BUS or not.
>
> After that, we can safely remove the caller in arch code.
>
> Btw, add debug print in of_platform_populate(), and use __func__ to
> print function's name of of_platform_bus_create().
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/of/platform.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 8d103e4..f601b30 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -11,6 +11,7 @@
>   *  2 of the License, or (at your option) any later version.
>   *
>   */
> +#include <linux/acpi.h>
>  #include <linux/errno.h>
>  #include <linux/module.h>
>  #include <linux/amba/bus.h>
> @@ -345,6 +346,12 @@ static int of_platform_bus_create(struct device_node *bus,
>                 return 0;
>         }
>
> +       if (of_node_check_flag(bus, OF_POPULATED_BUS)) {
> +               pr_debug("%s() - skipping %s, already populated\n",
> +                       __func__, bus->full_name);
> +               return 0;
> +       }
> +
>         auxdata = of_dev_lookup(lookup, bus);
>         if (auxdata) {
>                 bus_id = auxdata->name;
> @@ -396,7 +403,7 @@ int of_platform_bus_probe(struct device_node *root,
>         if (!root)
>                 return -EINVAL;
>
> -       pr_debug("of_platform_bus_probe()\n");
> +       pr_debug("%s()\n", __func__);
>         pr_debug(" starting at: %s\n", root->full_name);
>
>         /* Do a self check of bus type, if there's a match, create children */
> @@ -448,6 +455,9 @@ int of_platform_populate(struct device_node *root,
>         if (!root)
>                 return -EINVAL;
>
> +       pr_debug("%s()\n", __func__);
> +       pr_debug(" starting at: %s\n", root->full_name);
> +
>         for_each_child_of_node(root, child) {
>                 rc = of_platform_bus_create(child, matches, lookup, parent, true);
>                 if (rc) {
> @@ -471,6 +481,17 @@ int of_platform_default_populate(struct device_node *root,
>  }
>  EXPORT_SYMBOL_GPL(of_platform_default_populate);
>
> +static int __init of_platform_default_populate_init(void)
> +{
> +       if (of_have_populated_dt())
> +               of_platform_default_populate(NULL, NULL, NULL);
> +       else if (acpi_disabled)

This ACPI dependency needs to go. The error msg is somewhat pointless
as if both DT and ACPI are not used, the boot will be horribly broken
and I'm not sure that you would actually see the message given you
have no information to setup a console.

Rob
