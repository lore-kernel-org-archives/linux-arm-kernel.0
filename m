From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 1 Jul 2016 11:21:01 -0500
Subject: [PATCH 09/11] arm64: pmu: Add routines for detecting differing
 PMU types in the system
In-Reply-To: <871t3de54p.fsf@e105922-lin.cambridge.arm.com>
References: <1466529109-21715-1-git-send-email-jeremy.linton@arm.com>
 <1466529109-21715-10-git-send-email-jeremy.linton@arm.com>
 <87mvm1e9ye.fsf@e105922-lin.cambridge.arm.com> <57768431.7080508@arm.com>
 <871t3de54p.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <5776986D.6090806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2016 10:43 AM, Punit Agrawal wrote:
> Jeremy Linton <jeremy.linton@arm.com> writes:
>
>> On 07/01/2016 08:58 AM, Punit Agrawal wrote:
>>> Jeremy Linton <jeremy.linton@arm.com> writes:
>>>
>>>> In preparation for enabling heterogeneous PMUs on ACPI systems
>>>> add routines that detect this and group the resulting PMUs and
>>>> interrupts.
>>>>
>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>> ---
>>>>    drivers/perf/arm_pmu_acpi.c | 137 +++++++++++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 134 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
>>>> index a24cdd0..482a54d 100644
>>>> --- a/drivers/perf/arm_pmu_acpi.c
>>>> +++ b/drivers/perf/arm_pmu_acpi.c
>>>> @@ -1,23 +1,36 @@
>>>>    /*
>>>> - * PMU support
>>>> + * ARM ACPI PMU support
>>>>     *
>>>>     * Copyright (C) 2015 Red Hat Inc.
>>>> + * Copyright (C) 2016 ARM Ltd.
>>>>     * Author: Mark Salter <msalter@redhat.com>
>>>> + *         Jeremy Linton <jeremy.linton@arm.com>
>>>>     *
>>>>     * This work is licensed under the terms of the GNU GPL, version 2.  See
>>>>     * the COPYING file in the top-level directory.
>>>>     *
>>>>     */
>>>>
>>>> +#define pr_fmt(fmt) "ACPI-PMU: " fmt
>>>> +
>>>> +#include <asm/cpu.h>
>>>>    #include <linux/perf/arm_pmu.h>
>>>>    #include <linux/platform_device.h>
>>>>    #include <linux/acpi.h>
>>>>    #include <linux/irq.h>
>>>>    #include <linux/irqdesc.h>
>>>> +#include <linux/list.h>
>>>>
>>>>    struct pmu_irq {
>>>> -	int gsi;
>>>> -	int trigger;
>>>> +	int  gsi;
>>>> +	int  trigger;
>>>> +	bool registered;
>>>> +};
>>>> +
>>>> +struct pmu_types {
>>>> +	struct list_head list;
>>>> +	int		 cpu_type;
>>>> +	int		 cpu_count;
>>>>    };
>>>
>>> You can stash the associated resources in the above structure. That
>>> should simplify some code below.
>>
>> 	How is that? One structure is per cpu, the other is per pmu
>> type in the system, they are actually completely independent and
>> intertwining them will only server to obfuscate the code.
>
> Just to clarify, I am referring to "struct resources" you allocate for
> use with the pmu platform device in the next patch.

Ah yes, I understood that for the later comment but for this one I 
thought you were suggesting nesting these too. Thanks for clarifying.

>
>>
>>
>>>
>>>>
>>>>    static struct pmu_irq pmu_irqs[NR_CPUS] __initdata;
>>>> @@ -36,6 +49,124 @@ void __init arm_pmu_parse_acpi(int cpu, struct acpi_madt_generic_interrupt *gic)
>>>>    		pmu_irqs[cpu].trigger = ACPI_LEVEL_SENSITIVE;
>>>>    }
>>>>
>>>> +/* Count number and type of CPU cores in the system. */
>>>> +void __init arm_pmu_acpi_determine_cpu_types(struct list_head *pmus)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for_each_possible_cpu(i) {
>>>> +		struct cpuinfo_arm64 *cinfo = per_cpu_ptr(&cpu_data, i);
>>>> +		u32 partnum = MIDR_PARTNUM(cinfo->reg_midr);
>>>> +		struct pmu_types *pmu;
>>>> +
>>>> +		list_for_each_entry(pmu, pmus, list) {
>>>> +			if (pmu->cpu_type == partnum) {
>>>> +				pmu->cpu_count++;
>>>> +				break;
>>>> +			}
>>>> +		}
>>>> +
>>>> +		/* we didn't find the CPU type, add an entry to identify it */
>>>> +		if (&pmu->list == pmus) {
>>>> +			pmu = kcalloc(1, sizeof(struct pmu_types), GFP_KERNEL);
>>>
>>> Use kzalloc here.
>> Ok fair point.
>>
>>>
>>>> +			if (!pmu) {
>>>> +				pr_warn("Unable to allocate pmu_types\n");
>>>
>>> Bail out with error if the memory can't be allocated. Otherwise, we risk
>>> silently failing to register a PMU type.
>>
>> ? Its not silent, it fails to allocate the space complains about it,
>> and therefor this pmu type is not created.
>
> Sorry for the confusion, I didn't mean PMU type in the above comment. I
> was thinking of the missed cpu in cpu_count.
>
> If the allocation succeeds in the next iteration (as we don't break out
> of the loop), we'll end up undercounting cpus that have this type of
> pmu. In turn, this will lead to accessing beyond the allocated "struct
> resource" in arm_pmu_acpi_gsi_res.

Oh! Yah, that is a good point. I guess I missed that when i converted 
from the fixed buffer (which couldn't have this problem).

Actually I think i'm going to add a bad_alloc flag to stop further 
allocation attempts in this function. That way in theory the other side 
of the problem doesn't occur either (aka we get one allocation that 
succeeds, then one that fails, and the cpu's get under counted for the 
one that succeeded).




>
> Punit
>
>> In a system with a single
>> CPU this basically cancels the whole operation. If there is more than
>> one pmu, the remaining PMUs continue to have a chance of being
>> created, although if the memory allocation fails (this is pretty early
>> boot code) there is a high probability there is something seriously
>> wrong with the system.
>>
>>
>>>
>>>> +			} else {
>>>> +				pmu->cpu_type = partnum;
>>>> +				pmu->cpu_count++;
>>>> +				list_add_tail(&pmu->list, pmus);
>>>> +			}
>>>> +		}
>>>> +	}
>>>> +}
>>>> +
>>>> +/*
>>>> + * Registers the group of PMU interfaces which correspond to the 'last_cpu_id'.
>>>> + * This group utilizes 'count' resources in the 'res'.
>>>> + */
>>>> +int __init arm_pmu_acpi_register_pmu(int count, struct resource *res,
>>>> +					    int last_cpu_id)
>>>> +{
>>>
>>> With the addition of the irq resources to struct pmu_types, you can just pass
>>> the pmu structure here.
>>
>> 	Thats a point, but the lifetimes of the structures are
>> different and outside of their shared use in this single function
>> never really interact. I prefer not unnecessarily intertwine
>> independent data structures simply to reduce parameter counts for a
>> single function. Especially since it complicates cleanup because the
>> validity of the resource structure will have to be tracked relative to
>> its successful registration.
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
