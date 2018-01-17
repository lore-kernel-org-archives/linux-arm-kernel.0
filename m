From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 17 Jan 2018 14:44:26 +0900
Subject: [PATCH v2 11/13] iommu/rockchip: Use OF_IOMMU to attach devices
 automatically
In-Reply-To: <20180116132540.18939-12-jeffy.chen@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
 <20180116132540.18939-12-jeffy.chen@rock-chips.com>
Message-ID: <CAAFQd5C=SM21CmL8J334HseJ6SJH1wAVzKhrsk_cXMmpf8mK8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 10:25 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> Converts the rockchip-iommu driver to use the OF_IOMMU infrastructure,
> which allows attaching master devices to their IOMMUs automatically
> according to DT properties.
>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
> Changes in v2: None
>
>  drivers/iommu/rockchip-iommu.c | 116 +++++++++++------------------------------
>  1 file changed, 31 insertions(+), 85 deletions(-)
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 51e4f982c4a6..c2d3ac82184e 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
[snip]
> +static int rk_iommu_of_xlate(struct device *dev,
> +                            struct of_phandle_args *args)
> +{
> +       struct platform_device *iommu_dev;
> +
> +       iommu_dev = of_find_device_by_node(args->np);
> +       if (!iommu_dev) {
> +               dev_err(dev, "iommu %pOF not found\n", args->np);
> +               return -ENODEV;
> +       }
> +
> +       dev->archdata.iommu = platform_get_drvdata(iommu_dev);

This will work only if that iommu was already probed. Do we have any
guarantees that this callback is not called earlier?

Best regards,
Tomasz
