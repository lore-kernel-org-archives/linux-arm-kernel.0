From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 29 Aug 2015 19:12:40 +0100
Subject: [PATCH] arm64: fix a migrating irq bug when hotplug cpu
In-Reply-To: <55E1CBE9.6080705@linux.intel.com>
References: <55E1AD09.7020701@huawei.com> <55E1CBE9.6080705@linux.intel.com>
Message-ID: <66e158e6da958d355d54543ef69e5e94@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-08-29 16:12, Jiang Liu wrote:
> On 2015/8/29 21:00, Yang Yingliang wrote:
>> From: Yang Yingliang <yangyingliang@huawei.com>
>>
>> When cpu is disabled, all irqs will be migratged to another cpu.
>> In some cases, a new affinity is different, it needed to be coppied
>> to irq's affinity. But if the type of irq is LPI, it's affinity will
>> not be coppied because of irq_set_affinity's return value.
>> So copy the affinity, when the return value is IRQ_SET_MASK_OK_DONE.
> Hi Yingliang,
> 	If irq_set_affinity callback returns IRQ_SET_MASK_OK_DONE,
> it means that irq_set_affinity has copied the new CPU mask to irq
> affinity mask. It would be better to change irq_set_affinity for LPI
> to follow this rule.

The main issue here seems to be that we do not call irq_set_affinity, 
but
that we directly call into the top-level irqchip method, which relies 
on
the core code to do the copy (see irq_do_set_affinity). Too bad.

It feels like the arm/arm64 code would probably be better consolidated 
into
kernel/irq/migration.c, which already deals with some of this for x86
and ia64. It would save us the duplication and will make sure we don't
miss things next time we add a new return code, as irq_do_set_affinity
would handle this properly.

Thoughts?

          M.
-- 
Fast, cheap, reliable. Pick two.
