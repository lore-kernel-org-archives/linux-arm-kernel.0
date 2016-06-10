From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 10 Jun 2016 15:22:24 +0900
Subject: [PATCH v2 3/7] iommu/rockchip: support virtual iommu slave device
In-Reply-To: <1465392392-2003-4-git-send-email-zhengsq@rock-chips.com>
References: <1465392392-2003-1-git-send-email-zhengsq@rock-chips.com>
 <1465392392-2003-4-git-send-email-zhengsq@rock-chips.com>
Message-ID: <CAAFQd5DuAc-B17AqOg0mGcfLCGwztEOaukPL+c5jmL4a-AEeBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 8, 2016 at 10:26 PM, Shunqian Zheng <zhengsq@rock-chips.com> wrote:
> An virtual master device like DRM need to attach to iommu
> domain to share the domain with VOP(the one with actual
> iommu slave). We currently check the group is NULL to indicate
> a virtual master, which is not true since we decide to use
> the common iommu api to attach device in DRM.
>
> With this patch, we can probe a virtual iommu device and
> allow the DRM attaching to it. The virtual iommu is needed also
> because we want convert to use DMA API for map/unmap, cache flush,
> so that DRM buffer alloc still work even VOP is disabled.

I'm not really convinced that this is a good idea. This will require
creating fake devices in the system and generally looks really hacky.
Please see my alternative proposal inline.

>
> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
> ---
>  drivers/iommu/rockchip-iommu.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 3c16ec3..d6c3051 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -75,6 +75,11 @@
>
>  #define IOMMU_REG_POLL_COUNT_FAST 1000
>
> +/* A virtual iommu in device-tree registered without reg or
> + * interrupts, so the num_mmu is zero.
> + */
> +#define RK_IOMMU_IS_VIRTUAL(iommu) (iommu->num_mmu == 0)
> +
>  struct rk_iommu_domain {
>         struct list_head iommus;
>         u32 *dt; /* page directory table */
> @@ -789,13 +794,13 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>         int ret, i;
>         phys_addr_t dte_addr;
>
> -       /*
> -        * Allow 'virtual devices' (e.g., drm) to attach to domain.
> -        * Such a device does not belong to an iommu group.
> -        */
>         iommu = rk_iommu_from_dev(dev);
> -       if (!iommu)

Could we instead allocate such virtual rk_iommu struct here (dev could
be used as iommu->dev for logging purposes and a fake group could be
allocated too)?

> +
> +       iommu->domain = domain;
> +       if (RK_IOMMU_IS_VIRTUAL(iommu)) {
> +               dev_dbg(dev, "Attach virtual device to iommu domain\n");
>                 return 0;
> +       }
>
>         ret = rk_iommu_enable_stall(iommu);
>         if (ret)
> @@ -805,7 +810,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>         if (ret)
>                 return ret;
>
> -       iommu->domain = domain;
>
>         ret = devm_request_irq(iommu->dev, iommu->irq, rk_iommu_irq,
>                                IRQF_SHARED, dev_name(dev), iommu);
> @@ -842,10 +846,13 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
>         unsigned long flags;
>         int i;
>
> -       /* Allow 'virtual devices' (eg drm) to detach from domain */
>         iommu = rk_iommu_from_dev(dev);
> -       if (!iommu)
> +
> +       iommu->domain = NULL;

I don't think it's a good idea to set the domain to NULL before
disabling the real IOMMU. It might still trigger an interrupt at this
point and things won't behave correctly. I guess the original line
could be left as is and simply same assignment added under the if
below.

Best regards,
Tomasz
