From: yangyingliang@huawei.com (Yang Yingliang)
Date: Mon, 7 Sep 2015 10:54:52 +0800
Subject: [RFC PATCH v1 0/4] arm/arm64: fix a migrating irq bug when
 hotplug cpu
In-Reply-To: <55EBF43E.8070501@linux.intel.com>
References: <1441513421-8092-1-git-send-email-yangyingliang@huawei.com>
 <55EBF43E.8070501@linux.intel.com>
Message-ID: <55ECFC7C.8060505@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/9/6 16:07, Jiang Liu wrote:
> On 2015/9/6 12:23, Yang Yingliang wrote:
>> Hi All,
>>
>> There is a bug:
>>
>> When cpu is disabled, all irqs will be migratged to another cpu.
>> In some cases, a new affinity is different, it needed to be coppied
>> to irq's affinity. But if the type of irq is LPI, it's affinity will
>> not be coppied because of irq_set_affinity's return value.
>>
>>
>>
>> As Marc and Will suggested, I refactor the arm/arm64 migrating interrupts
>> code and fix the migrating irq bug while cpu is offline.
>>
>> I'm trying let the core code do the migrating interrupts matter. kernel/irq/migration.c
>> depends on CONFIG_GENERIC_PENDING_IRQ, so I make it selected by CONFIG_SMP and
>> CONFIG_HOTPLUG_CPU and rename it to CONFIG_GENERIC_IRQ_MIGRATION for more general.
>> When CONFIG_GENERIC_IRQ_MIGRATION is enabled, an interrupt whose state_use_accessors
>> is not set with IRQD_MOVE_PCNTXT won't be migrated immediately in irq_set_affinity_locked().
>> So introduce irq_settings_set_move_pcntxt() helper to set the state in gic_irq_domain_map().
>>
>> With the above preparation, move the migrating interrupts code into kernel/irq/migration.c
>> and fix the bug by using irq_do_set_affinity().
> Hi Yingliang,
> 	As we are going to move migrate_irqs() to generic kernel
> code, and powerpc, metag, xtensa, sh, ia64 mn10300 also defines
>   migrate_irqs() too. It would be great if we could consolidate
> all these.
> 	And as we are going to refine these code, there's another
> issue need attention. On x86, we need to allocate a CPU vector
> if an irq is directed to a CPU. So there's possibility that
> we run out of CPU vectors after CPU hot-removal. So we have a
> mechanism to detect whether we will run out of CPU vector
> after removing a CPU, and reject CPU hot-removal if that will
> happen.
> 	So the key point is, if we a need to allocate some sort
> of resource on the target CPUs for an irq, we need two steps
> when removing a CPU
> 1) check whether resources are available after removing the CPU,
>     and reject CPU removal request if we ran out of resource
> 2) fix irqs after hot-removing the CPU.
> Thanks!
> Gerry
>

On arm, as I know, it doesn't need extra resource for an irq.
I am not sure other platform need this way besides x86.

I think we could consolidate all migrate_irqs() later. I am not
sure if it's good to do so big changing and modify other arch code in
a patchset that supposed to fix a bug of arm.
