From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 14 Nov 2012 11:54:24 +0200
Subject: [PATCH v4 2/2] ARM: OMAP3/4: iommu: adapt to runtime pm
In-Reply-To: <1352860489-19960-3-git-send-email-omar.luna@linaro.org>
References: <1352860489-19960-1-git-send-email-omar.luna@linaro.org>
 <1352860489-19960-3-git-send-email-omar.luna@linaro.org>
Message-ID: <CAK=WgbZm+sjavwb_Li_W5ygm0XuS9YMYfQEkdoB188Uir0arGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Omar,

On Wed, Nov 14, 2012 at 4:34 AM, Omar Ramirez Luna <omar.luna@linaro.org> wrote:
> Use runtime PM functionality interfaced with hwmod enable/idle
> functions, to replace direct clock operations and sysconfig
> handling.
>
> Dues to reset sequence, pm_runtime_put_sync must be used, to avoid
> possible operations with the module under reset.

There are some changes here that might not be trivial to understand in
hindsight; any chance you can add more explanations (even only in the
commit log) regarding:

> @@ -160,11 +160,10 @@ static int iommu_enable(struct omap_iommu *obj)
...
> -       clk_enable(obj->clk);
> +       pm_runtime_get_sync(obj->dev);
>
>         err = arch_iommu->enable(obj);
>
> -       clk_disable(obj->clk);
>         return err;
>  }

Why do we remove clk_disable here (instead of replacing it with a _put
variant) ?

> @@ -306,7 +303,7 @@ static int load_iotlb_entry(struct omap_iommu *obj, struct iotlb_entry *e)
>         if (!obj || !obj->nr_tlb_entries || !e)
>                 return -EINVAL;
>
> -       clk_enable(obj->clk);
> +       pm_runtime_get_sync(obj->dev);

If iommu_enable no longer disables obj->clk before returning, do we
really need to call ->get here (and in all the other similar
instances) ?

> @@ -816,9 +813,7 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
>         if (!obj->refcount)
>                 return IRQ_NONE;
>
> -       clk_enable(obj->clk);
>         errs = iommu_report_fault(obj, &da);
> -       clk_disable(obj->clk);

Why do we remove the clk_ invocations here (instead of replacing them
with get/put variants) ?

Most of the above questions imply this patch not only converts the
iommu to runtime PM, but may carry additional changes that may imply
previous implementation is sub-optimal. I hope we can clearly document
the motivation behind these changes too (maybe even consider
extracting them to a different patch ?).

> @@ -990,6 +981,9 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
>                 goto err_irq;
>         platform_set_drvdata(pdev, obj);
>
> +       pm_runtime_irq_safe(obj->dev);

Let's also document why _irq_safe is needed here ?

Thanks,
Ohad.
