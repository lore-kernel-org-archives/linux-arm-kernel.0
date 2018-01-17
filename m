From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 17 Jan 2018 15:20:30 +0900
Subject: [PATCH v2 12/13] iommu/rockchip: Add runtime PM support
In-Reply-To: <20180116132540.18939-13-jeffy.chen@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
 <20180116132540.18939-13-jeffy.chen@rock-chips.com>
Message-ID: <CAAFQd5DCxgsL52+5XetV9MRDecL7dN6_QdHysKUOWaEqSf=ijw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 10:25 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> When the power domain is powered off, the IOMMU cannot be accessed and
> register programming must be deferred until the power domain becomes
> enabled.
>
> Add runtime PM support, and use runtime PM device link from IOMMU to
> master to startup and shutdown IOMMU.
[snip]
> @@ -875,28 +889,19 @@ static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
>
>  static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
>  {
> -       return dev->archdata.iommu;
> +       struct rk_iommudata *data = dev->archdata.iommu;
> +
> +       return data ? data->iommu : NULL;
>  }

Is this change intentionally added to this patch? I see this
potentially relevant for the previous patch in this series.

[snip]
> +static int rk_iommu_startup(struct rk_iommu *iommu)
>  {
> -       struct rk_iommu *iommu;
> +       struct iommu_domain *domain = iommu->domain;
>         struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
> -       unsigned long flags;
>         int ret, i;
>
> -       /*
> -        * Allow 'virtual devices' (e.g., drm) to attach to domain.
> -        * Such a device does not belong to an iommu group.
> -        */
> -       iommu = rk_iommu_from_dev(dev);
> -       if (!iommu)
> -               return 0;
> -
> -       if (iommu->domain)
> -               rk_iommu_detach_device(iommu->domain, dev);
> -
>         ret = rk_iommu_enable_clocks(iommu);
>         if (ret)
>                 return ret;
>

Don't we need to check here (and in _shutdown() too) if we have a
domain attached?

> +       mutex_lock(&iommu->pm_mutex);
>         ret = rk_iommu_enable_stall(iommu);
>         if (ret)
> -               goto err_disable_clocks;
> +               goto err_unlock_mutex;
[snip]
> +       iommu->domain = NULL;
> +
> +       spin_lock_irqsave(&rk_domain->iommus_lock, flags);
> +       list_del_init(&iommu->node);
> +       spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
> +
> +       if (pm_runtime_get_if_in_use(iommu->dev) > 0) {

Actually, if the above call returns -EINVAL, don't we still need to
call rk_iommu_shutdown(), because it just means runtime PM is disabled
and the IOMMU is always powered on?

> +               rk_iommu_shutdown(iommu);
> +               pm_runtime_put(iommu->dev);
> +       }
> +}
[snip]
> +       spin_lock_irqsave(&rk_domain->iommus_lock, flags);
> +       list_add_tail(&iommu->node, &rk_domain->iommus);
> +       spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
> +
> +       if (pm_runtime_get_if_in_use(iommu->dev) <= 0)

Ditto.

> +               return 0;
> +
> +       ret = rk_iommu_startup(iommu);
> +       if (ret)
> +               rk_iommu_detach_device(data->domain, dev);
[snip]
> @@ -1108,7 +1175,9 @@ static int rk_iommu_of_xlate(struct device *dev,
>                 return -ENODEV;
>         }
>
> -       dev->archdata.iommu = platform_get_drvdata(iommu_dev);
> +       data->iommu = platform_get_drvdata(iommu_dev);
> +       dev->archdata.iommu = data;
> +

I think this change might be mistakenly squashed to this patch instead
of previous.

Best regards,
Tomasz
