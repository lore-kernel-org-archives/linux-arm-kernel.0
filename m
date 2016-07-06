From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 6 Jul 2016 15:11:17 +0100
Subject: [PATCH] drivers/perf: arm-pmu: Handle per-interrupt affinity mask
In-Reply-To: <20160706103951.GC17925@arm.com>
References: <1467379291-18413-1-git-send-email-marc.zyngier@arm.com>
 <20160706103951.GC17925@arm.com>
Message-ID: <577D1185.4090801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/16 11:39, Will Deacon wrote:
> On Fri, Jul 01, 2016 at 02:21:31PM +0100, Marc Zyngier wrote:
>> On a big-little system, PMUs can be wired to CPUs using per CPU
>> interrups (PPI). In this case, it is important to make sure that
>> the enable/disable do happen on the right set of CPUs.
>>
>> So instead of relying on the interrupt-affinity property, we can
>> use the actual percpu affinity that DT exposes as part of the
>> interrupt specifier. The DT binding is also updated to reflect
>> the fact that the interrupt-affinity property shouldn't be used
>> in that case.
> 
> [...]
> 
>> -	/* If we didn't manage to parse anything, claim to support all CPUs */
>> -	if (cpumask_weight(&pmu->supported_cpus) == 0)
>> -		cpumask_setall(&pmu->supported_cpus);
>> +	/* If we didn't manage to parse anything, try the interrupt affinity */
>> +	if (cpumask_weight(&pmu->supported_cpus) == 0) {
>> +		if (!using_spi) {
>> +			/* If using PPIs, check the affinity of the partition */
>> +			int irq = platform_get_irq(pdev, 0);
>> +			irq_get_percpu_devid_partition(irq,
>> +						       &pmu->supported_cpus);
> 
> Should we not at least propagate the failure if this returns -EINVAL?

Good point. I'll fix that and resend it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
