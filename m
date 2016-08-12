From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 12 Aug 2016 16:46:06 +0900
Subject: [PATCH 7/8] iommu: of: Handle IOMMU lookup failure with deferred
 probing or error
In-Reply-To: <1470696550-3416-8-git-send-email-sricharan@codeaurora.org>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
 <1470696550-3416-8-git-send-email-sricharan@codeaurora.org>
Message-ID: <CAAFQd5C8BuOCc5ySw_3tVELDG4S+r_5VyDvOPnBBuVr-6CBfxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 9, 2016 at 7:49 AM, Sricharan R <sricharan@codeaurora.org> wrote:
> +
> +               if (ops->add_device)
> +                       ops = ops->add_device(dev) ? ops : NULL;

Patch description fails to mention anything about this change. Also it
looks slightly incorrect to lose the error condition here. I think we
should at least print some error message here and tell the user that
we are falling back to non-IOMMU setup.

>
>                 of_node_put(np);
>                 idx++;
> @@ -200,7 +213,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>
>  err_put_node:
>         of_node_put(np);
> -       return NULL;
> +       return ops;
>  }
>
>  void __init of_iommu_init(void)
> @@ -211,7 +224,7 @@ void __init of_iommu_init(void)
>         for_each_matching_node_and_match(np, matches, &match) {
>                 const of_iommu_init_fn init_fn = match->data;
>
> -               if (init_fn(np))
> +               if (init_fn && init_fn(np))

When is it possible to have NULL init_fn?

>                         pr_err("Failed to initialise IOMMU %s\n",
>                                 of_node_full_name(np));
>         }
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index e1fad50..92e02dc 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -149,6 +149,8 @@ int of_dma_configure_ops(struct device *dev, struct device_node *np)
>                 coherent ? " " : " not ");
>
>         iommu = of_iommu_configure(dev, np);
> +       if (IS_ERR(iommu))
> +               return PTR_ERR(iommu);

nit: Would be good to add a blank line here for improved readability.

>         dev_dbg(dev, "device is%sbehind an iommu\n",
>                 iommu ? " " : " not ");
>

Best regards,
Tomasz
