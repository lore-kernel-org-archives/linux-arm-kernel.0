From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 16 Dec 2011 02:33:08 +0200
Subject: [PATCH v4 4/4] OMAP3/4: iommu: adapt to runtime pm
In-Reply-To: <1323922709-6986-5-git-send-email-omar.ramirez@ti.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
 <1323922709-6986-5-git-send-email-omar.ramirez@ti.com>
Message-ID: <CAMP44s2YFqwFgWeWjMdzDH_00x1NAkFRwgSvp+f8NggcD2eiOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 6:18 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> @@ -123,11 +123,10 @@ static int iommu_enable(struct omap_iommu *obj)
> ? ? ? ?if (!arch_iommu)
> ? ? ? ? ? ? ? ?return -ENODEV;
>
> - ? ? ? clk_enable(obj->clk);
> + ? ? ? pm_runtime_get_sync(obj->dev);
>
> ? ? ? ?err = arch_iommu->enable(obj);
>
> - ? ? ? clk_disable(obj->clk);
> ? ? ? ?return err;
> ?}

Hmm, this is called on omap_iommu_attach, and iommu_disable is not
called until omap_iommu_detach, so this means the device will never
sleep. Why don't you call pm_runtime_put() instead of clk_disable()?

All the rest of the calls to pm_runtime_get/put after this are
basically no-ops, because the count will never go below 1.

You mention some irq issues, but could it be due to some bad clocks in
the hwmod data?

> @@ -136,11 +135,9 @@ static void iommu_disable(struct omap_iommu *obj)
> ? ? ? ?if (!obj)
> ? ? ? ? ? ? ? ?return;
>
> - ? ? ? clk_enable(obj->clk);
> -
> ? ? ? ?arch_iommu->disable(obj);
>
> - ? ? ? clk_disable(obj->clk);
> + ? ? ? pm_runtime_put(obj->dev);
> ?}
>
> ?/*
> @@ -263,7 +260,7 @@ static int load_iotlb_entry(struct omap_iommu *obj, struct iotlb_entry *e)
> ? ? ? ?if (!obj || !obj->nr_tlb_entries || !e)
> ? ? ? ? ? ? ? ?return -EINVAL;
>
> - ? ? ? clk_enable(obj->clk);
> + ? ? ? pm_runtime_get_sync(obj->dev);
>
> ? ? ? ?iotlb_lock_get(obj, &l);
> ? ? ? ?if (l.base == obj->nr_tlb_entries) {
> @@ -293,7 +290,7 @@ static int load_iotlb_entry(struct omap_iommu *obj, struct iotlb_entry *e)
>
> ? ? ? ?cr = iotlb_alloc_cr(obj, e);
> ? ? ? ?if (IS_ERR(cr)) {
> - ? ? ? ? ? ? ? clk_disable(obj->clk);
> + ? ? ? ? ? ? ? pm_runtime_put(obj->dev);
> ? ? ? ? ? ? ? ?return PTR_ERR(cr);
> ? ? ? ?}
>
> @@ -307,7 +304,7 @@ static int load_iotlb_entry(struct omap_iommu *obj, struct iotlb_entry *e)
> ? ? ? ? ? ? ? ?l.vict = l.base;
> ? ? ? ?iotlb_lock_set(obj, &l);
> ?out:
> - ? ? ? clk_disable(obj->clk);
> + ? ? ? pm_runtime_put(obj->dev);
> ? ? ? ?return err;
> ?}
>
> @@ -337,7 +334,7 @@ static void flush_iotlb_page(struct omap_iommu *obj, u32 da)
> ? ? ? ?int i;
> ? ? ? ?struct cr_regs cr;
>
> - ? ? ? clk_enable(obj->clk);
> + ? ? ? pm_runtime_get_sync(obj->dev);
>
> ? ? ? ?for_each_iotlb_cr(obj, obj->nr_tlb_entries, i, cr) {
> ? ? ? ? ? ? ? ?u32 start;
> @@ -356,7 +353,7 @@ static void flush_iotlb_page(struct omap_iommu *obj, u32 da)
> ? ? ? ? ? ? ? ? ? ? ? ?iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
> ? ? ? ? ? ? ? ?}
> ? ? ? ?}
> - ? ? ? clk_disable(obj->clk);
> + ? ? ? pm_runtime_put(obj->dev);
>
> ? ? ? ?if (i == obj->nr_tlb_entries)
> ? ? ? ? ? ? ? ?dev_dbg(obj->dev, "%s: no page for %08x\n", __func__, da);
> @@ -370,7 +367,7 @@ static void flush_iotlb_all(struct omap_iommu *obj)
> ?{
> ? ? ? ?struct iotlb_lock l;
>
> - ? ? ? clk_enable(obj->clk);
> + ? ? ? pm_runtime_get_sync(obj->dev);
>
> ? ? ? ?l.base = 0;
> ? ? ? ?l.vict = 0;
> @@ -378,7 +375,7 @@ static void flush_iotlb_all(struct omap_iommu *obj)
>
> ? ? ? ?iommu_write_reg(obj, 1, MMU_GFLUSH);
>
> - ? ? ? clk_disable(obj->clk);
> + ? ? ? pm_runtime_put(obj->dev);
> ?}
>
> ?#if defined(CONFIG_OMAP_IOMMU_DEBUG) || defined(CONFIG_OMAP_IOMMU_DEBUG_MODULE)
> @@ -388,11 +385,11 @@ ssize_t omap_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t bytes)
> ? ? ? ?if (!obj || !buf)
> ? ? ? ? ? ? ? ?return -EINVAL;
>
> - ? ? ? clk_enable(obj->clk);
> + ? ? ? pm_runtime_get_sync(obj->dev);
>
> ? ? ? ?bytes = arch_iommu->dump_ctx(obj, buf, bytes);
>
> - ? ? ? clk_disable(obj->clk);
> + ? ? ? pm_runtime_put(obj->dev);
>
> ? ? ? ?return bytes;
> ?}
> @@ -406,7 +403,7 @@ __dump_tlb_entries(struct omap_iommu *obj, struct cr_regs *crs, int num)
> ? ? ? ?struct cr_regs tmp;
> ? ? ? ?struct cr_regs *p = crs;
>
> - ? ? ? clk_enable(obj->clk);
> + ? ? ? pm_runtime_get_sync(obj->dev);
> ? ? ? ?iotlb_lock_get(obj, &saved);
>
> ? ? ? ?for_each_iotlb_cr(obj, num, i, tmp) {
> @@ -416,7 +413,7 @@ __dump_tlb_entries(struct omap_iommu *obj, struct cr_regs *crs, int num)
> ? ? ? ?}
>
> ? ? ? ?iotlb_lock_set(obj, &saved);
> - ? ? ? clk_disable(obj->clk);
> + ? ? ? pm_runtime_put(obj->dev);
>
> ? ? ? ?return ?p - crs;
> ?}
> @@ -780,9 +777,7 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
> ? ? ? ?if (!obj->refcount)
> ? ? ? ? ? ? ? ?return IRQ_NONE;
>
> - ? ? ? clk_enable(obj->clk);
> ? ? ? ?errs = iommu_report_fault(obj, &da);
> - ? ? ? clk_disable(obj->clk);

Why?

> ? ? ? ?if (errs == 0)
> ? ? ? ? ? ? ? ?return IRQ_HANDLED;
>
> @@ -920,10 +915,6 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
> ? ? ? ?if (!obj)
> ? ? ? ? ? ? ? ?return -ENOMEM;
>
> - ? ? ? obj->clk = clk_get(&pdev->dev, pdata->clk_name);
> - ? ? ? if (IS_ERR(obj->clk))
> - ? ? ? ? ? ? ? goto err_clk;
> -
> ? ? ? ?obj->nr_tlb_entries = pdata->nr_tlb_entries;
> ? ? ? ?obj->name = pdata->name;
> ? ? ? ?obj->dev = &pdev->dev;
> @@ -966,6 +957,8 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
> ? ? ? ? ? ? ? ?goto err_irq;
> ? ? ? ?platform_set_drvdata(pdev, obj);
>
> + ? ? ? pm_runtime_enable(obj->dev);
> +
> ? ? ? ?dev_info(&pdev->dev, "%s registered\n", obj->name);
> ? ? ? ?return 0;
>
> @@ -974,8 +967,6 @@ err_irq:
> ?err_ioremap:
> ? ? ? ?release_mem_region(res->start, resource_size(res));
> ?err_mem:
> - ? ? ? clk_put(obj->clk);
> -err_clk:
> ? ? ? ?kfree(obj);
> ? ? ? ?return err;
> ?}
> @@ -996,7 +987,8 @@ static int __devexit omap_iommu_remove(struct platform_device *pdev)
> ? ? ? ?release_mem_region(res->start, resource_size(res));
> ? ? ? ?iounmap(obj->regbase);
>
> - ? ? ? clk_put(obj->clk);
> + ? ? ? pm_runtime_disable(obj->dev);

I'm not sure if this is needed; you want to resume the driver? AFAICS
kfree will take care of that _without_ resuming.

> ? ? ? ?dev_info(&pdev->dev, "%s removed\n", obj->name);
> ? ? ? ?kfree(obj);
> ? ? ? ?return 0;

Cheers.

-- 
Felipe Contreras
