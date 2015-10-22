From: yangyingliang@huawei.com (Yang Yingliang)
Date: Thu, 22 Oct 2015 18:56:29 +0800
Subject: [RFC PATCH v6 3/3] arm: fix a migrating irq bug when hotplug cpu
In-Reply-To: <20151022092629.GQ32532@n2100.arm.linux.org.uk>
References: <1443087135-17044-1-git-send-email-yangyingliang@huawei.com>
 <1443087135-17044-4-git-send-email-yangyingliang@huawei.com>
 <CAMuHMdWyvaecQHOzFnxVZus_Pfkxjw1XfkGdcLK=D2ThaoJMzA@mail.gmail.com>
 <20151021202907.GN32532@n2100.arm.linux.org.uk>
 <20151022092629.GQ32532@n2100.arm.linux.org.uk>
Message-ID: <5628C0DD.50900@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/10/22 17:26, Russell King - ARM Linux wrote:
> On Wed, Oct 21, 2015 at 09:29:08PM +0100, Russell King - ARM Linux wrote:
>> On Wed, Oct 21, 2015 at 01:47:49PM +0200, Geert Uytterhoeven wrote:
>>> On Thu, Sep 24, 2015 at 11:32 AM, Yang Yingliang
>>> <yangyingliang@huawei.com> wrote:
>>>> When cpu is disabled, all irqs will be migratged to another cpu.
>>>> In some cases, a new affinity is different, the old affinity need
>>>> to be updated and if irq_set_affinity's return value is IRQ_SET_MASK_OK_DONE,
>>>> the old affinity can not be updated. Fix it by using irq_do_set_affinity.
>>>>
>>>> And migrating interrupts is a core code matter, so use the generic
>>>> function irq_migrate_all_off_this_cpu() to migrate interrupts in
>>>> kernel/irq/migration.c.
>>>>
>>>> Cc: Jiang Liu <jiang.liu@linux.intel.com>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
>>>> Cc: Hanjun Guo <hanjun.guo@linaro.org>
>>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>>> ---
>>>>   arch/arm/Kconfig           |  1 +
>>>>   arch/arm/include/asm/irq.h |  1 -
>>>>   arch/arm/kernel/irq.c      | 62 ----------------------------------------------
>>>>   arch/arm/kernel/smp.c      |  2 +-
>>>>   4 files changed, 2 insertions(+), 64 deletions(-)
>>>>
>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>> index 72ad724..bffba78 100644
>>>> --- a/arch/arm/Kconfig
>>>> +++ b/arch/arm/Kconfig
>>>> @@ -1492,6 +1492,7 @@ config NR_CPUS
>>>>   config HOTPLUG_CPU
>>>>          bool "Support for hot-pluggable CPUs"
>>>>          depends on SMP
>>>> +       select GENERIC_IRQ_MIGRATION
>>>
>>> This causes the following warnings during s2ram on r8a7791/koelsch
>>> (dual-core CA15):
>>
>> Thanks for the report.  I'll see what tonight's boot run says for my
>> platforms.  Hopefully, the author of these changes can help debug
>> this.
>
> What's happened is that:
>
> -	c = irq_data_get_irq_chip(d);
> -	if (!c->irq_set_affinity)
> -		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
>
> has become:
>
> +	c = irq_data_get_irq_chip(d);
> +	if (!c->irq_set_affinity) {
> +		pr_warn_ratelimited("IRQ%u: unable to set affinity\n", d->irq);
>
> which makes things more noisy.
>
> This is a change that was not described in the commit message for the
> patch Thomas merged.

I described it in v2 cover letter and kept the change history in v6
cover letter. There is no comment on the change when patch the was
reviewing in v2, so I thought it's ok and I kept the change in the
next versions.

Need I send a patch to the Thomas branch to revert the change ?

Thanks,
Yang
