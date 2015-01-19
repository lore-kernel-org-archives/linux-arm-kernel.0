From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 19 Jan 2015 16:27:47 +0100
Subject: [PATCH v4 18/18] iommu: exynos: add callback for initializing
 devices from device tree
In-Reply-To: <1421399592-7482-19-git-send-email-m.szyprowski@samsung.com>
References: <1421399592-7482-1-git-send-email-m.szyprowski@samsung.com>
 <1421399592-7482-19-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CABxcv=nkcY0biXuDH1BHDdOZhrzYWr-YNP13QWzdLfZfQrxouA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marek,

I wanted to test your IOMMU series on an Exynos5420 Peach Pit but the
kernel hangs with your series + dependencies on top of 3.19-rc5.

Bisecting I found that $subject is the offending commit. I've pushed
my test branch [0] in case I missed something.

On Fri, Jan 16, 2015 at 10:13 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> This patch adds implementation of of_xlate callback, which prepares
> masters device for attaching to IOMMU. This callback is called during
> creating devices from device tree.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index ea2659159e63..5432b443abfc 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1077,6 +1077,33 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
>         return phys;
>  }
>
> +static int exynos_iommu_of_xlate(struct device *dev,
> +                                struct of_phandle_args *spec)
> +{
> +       struct exynos_iommu_owner *owner = dev->archdata.iommu;
> +       struct platform_device *sysmmu = of_find_device_by_node(spec->np);
> +       struct sysmmu_drvdata *data;
> +
> +       if (!sysmmu)
> +               return -ENODEV;
> +
> +       data = platform_get_drvdata(sysmmu);
> +       if (!data)
> +               return -ENODEV;
> +
> +       if (!owner) {
> +               owner = kzalloc(sizeof(*owner), GFP_KERNEL);
> +               if (!owner)
> +                       return -ENOMEM;
> +
> +               INIT_LIST_HEAD(&owner->clients);
> +               dev->archdata.iommu = owner;
> +       }
> +
> +       list_add_tail(&data->owner_node, &owner->clients);

This is the line that causes the kernel to hang, if I comment the
list_add_tail() call then the kernel boots.

I checked that neither data nor owner are NULL and that the
owner->clients list_head is initialized. Do you have any ideas what
could be happening?

Thanks a lot and best regards,
Javier

[0]: git://git.collabora.co.uk/git/user/javier/linux.git exynos-sysmmu-3.19-rc5
