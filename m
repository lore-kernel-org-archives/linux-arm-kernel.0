From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Thu, 15 Dec 2011 20:59:23 -0600
Subject: [PATCH v4 4/4] OMAP3/4: iommu: adapt to runtime pm
In-Reply-To: <CAMP44s2YFqwFgWeWjMdzDH_00x1NAkFRwgSvp+f8NggcD2eiOw@mail.gmail.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
 <1323922709-6986-5-git-send-email-omar.ramirez@ti.com>
 <CAMP44s2YFqwFgWeWjMdzDH_00x1NAkFRwgSvp+f8NggcD2eiOw@mail.gmail.com>
Message-ID: <CAB-zwWg1CUbL+kFSTxAOpNE=mBsDKODcJpm-fHkS=t6KRhTwPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 6:33 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Dec 15, 2011 at 6:18 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
>> @@ -123,11 +123,10 @@ static int iommu_enable(struct omap_iommu *obj)
>> ? ? ? ?if (!arch_iommu)
>> ? ? ? ? ? ? ? ?return -ENODEV;
>>
>> - ? ? ? clk_enable(obj->clk);
>> + ? ? ? pm_runtime_get_sync(obj->dev);
>>
>> ? ? ? ?err = arch_iommu->enable(obj);
>>
>> - ? ? ? clk_disable(obj->clk);
>> ? ? ? ?return err;
>> ?}
>
> Hmm, this is called on omap_iommu_attach, and iommu_disable is not
> called until omap_iommu_detach, so this means the device will never
> sleep. Why don't you call pm_runtime_put() instead of clk_disable()?

Here once you call pm_runtime_put, the hwmod should turn off iva2_ck
leaving device unpowered, not usable if it is part of an independent
module and that module is still awake, but since the module clock
feeds both the dsp and the mmu this doesn't occur. However might be
possible if there is a specific clock to feed the mmu and another for
the mmu user.

In theory iommu should be independent on handling its clock resources,
take tidspbridge, it powers iva2_clk which indirectly powers iva_mmu,
so as long as the dsp is powered and using the mmu (omap_iommu_attach)
the iommu should be ON, once you omap_iommu_detach means that the
device is no longer using the iommu and can be put to sleep.

This could be helpful if your main processor can go to sleep
independently of other processors, say you attach the iommu and leave
the dsp doing calculations and memory accesses through mmu while the
main processor decides to enter sleep.

> All the rest of the calls to pm_runtime_get/put after this are
> basically no-ops, because the count will never go below 1.

I didn't try but without calling iommu_attach the other functions that
use pm_runtime_get/put can still be called as they are exported
symbols. I believe omap-iommu-debug.c does something like this to dump
stuff. This should be cleaned up/audited, IMHO, but it doesn't seem to
belong to this conversion series.

> You mention some irq issues, but could it be due to some bad clocks in
> the hwmod data?

There are no "issues" with irqs, just a weird case, see below...

...
>> @@ -780,9 +777,7 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
>> ? ? ? ?if (!obj->refcount)
>> ? ? ? ? ? ? ? ?return IRQ_NONE;
>>
>> - ? ? ? clk_enable(obj->clk);
>> ? ? ? ?errs = iommu_report_fault(obj, &da);
>> - ? ? ? clk_disable(obj->clk);
>
> Why?

In order to get an irq from the mmu, the mmu should be functional and
have a clock, but iommu_enable used to enable and disable the clock.

In the end you are able to get an irq because someone else
(tidspbridge) has the mmu indirectly powered (since they share the
same clock), I felt this shouldn't be and the iommu should handle its
own clocks even if they are shared with other modules.

Hence iommu_enable does pm_runtime_get for the life time of the user of the mmu.

...
>> @@ -996,7 +987,8 @@ static int __devexit omap_iommu_remove(struct platform_device *pdev)
>> ? ? ? ?release_mem_region(res->start, resource_size(res));
>> ? ? ? ?iounmap(obj->regbase);
>>
>> - ? ? ? clk_put(obj->clk);
>> + ? ? ? pm_runtime_disable(obj->dev);
>
> I'm not sure if this is needed; you want to resume the driver? AFAICS
> kfree will take care of that _without_ resuming.

No, the driver should resume only if there are outstanding wake up
requests, right? I don't seem to get this question.

Thanks,

Omar
