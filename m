From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 14 Jun 2016 12:01:18 -0500
Subject: [PATCH v2 3/7] of/irq: Break out msi-map lookup (again)
In-Reply-To: <2cbffa9a341edfd10114994f6486f6b08d0c390c.1464966939.git.robin.murphy@arm.com>
References: <cover.1464966939.git.robin.murphy@arm.com>
 <2cbffa9a341edfd10114994f6486f6b08d0c390c.1464966939.git.robin.murphy@arm.com>
Message-ID: <CAL_JsqJ4km0dH2PxHma9-cPwC20WR0ejn_14UeV0vBWJ+XLBBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 3, 2016 at 12:15 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> The PCI msi-map code is already doing double-duty translating IDs and
> retrieving MSI parents, which unsurprisingly is the same functionality
> we need for the identically-formatted PCI iommu-map property. Drag the
> core parsing routine up yet another layer into the general OF-PCI code,
> and further generalise it for either kind of lookup in either flavour
> of map property.
>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Frank Rowand <frowand.list@gmail.com>
> CC: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> v2: No change.
>
>  drivers/of/irq.c       |  70 ++-------------------------------
>  drivers/of/of_pci.c    | 102 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_pci.h |   8 ++++
>  3 files changed, 114 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index e7bfc175b8e1..0c9118d849ee 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -24,6 +24,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
> +#include <linux/of_pci.h>
>  #include <linux/string.h>
>  #include <linux/slab.h>
>
> @@ -586,13 +587,7 @@ static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
>                             u32 rid_in)
>  {
>         struct device *parent_dev;
> -       struct device_node *msi_controller_node;
> -       struct device_node *msi_np = *np;
> -       u32 map_mask, masked_rid, rid_base, msi_base, rid_len, phandle;
> -       int msi_map_len;
> -       bool matched;
>         u32 rid_out = rid_in;
> -       const __be32 *msi_map = NULL;
>
>         /*
>          * Walk up the device parent links looking for one with a
> @@ -602,71 +597,14 @@ static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
>                 if (!parent_dev->of_node)
>                         continue;
>
> -               msi_map = of_get_property(parent_dev->of_node,
> -                                         "msi-map", &msi_map_len);
> -               if (!msi_map)
> +               if (!of_property_read_bool(parent_dev->of_node, "msi-map"))

But msi-map is not bool, right? I think we allow bools to have values
for historical reasons, but really bool with a value should be an
error. So don't rely on current behavior.

>                         continue;
>
> -               if (msi_map_len % (4 * sizeof(__be32))) {
> -                       dev_err(parent_dev, "Error: Bad msi-map length: %d\n",
> -                               msi_map_len);
> -                       return rid_out;
> -               }
>                 /* We have a good parent_dev and msi_map, let's use them. */
> +               of_pci_map_rid(parent_dev->of_node, "msi-map", rid_in, np,
> +                              &rid_out);

Seems like this could return an error code and then you could continue
based on the return code. Then you wouldn't be looking up msi-map
twice. Probably could get rid of the !parent_dev->of_node check too.

Rob
