From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 26 Jan 2018 12:10:11 +0000
Subject: [PATCH 06/16] arm64: capabilities: Unify the verification
In-Reply-To: <20180126110759.GN5862@e103592.cambridge.arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-7-suzuki.poulose@arm.com>
 <20180126110759.GN5862@e103592.cambridge.arm.com>
Message-ID: <c46997bb-8b56-4e93-d603-4fc0abd2f4b4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/01/18 11:08, Dave Martin wrote:
> On Tue, Jan 23, 2018 at 12:27:59PM +0000, Suzuki K Poulose wrote:
>> Now that each capability describes how to treat the conflicts
>> of CPU cap state vs System wide cap state, we can unify the
>> verification logic to a single place.
>>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/kernel/cpufeature.c | 87 ++++++++++++++++++++++++++----------------
>>   1 file changed, 54 insertions(+), 33 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 43c7e992d784..79737034a628 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -1228,6 +1228,54 @@ static void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *
>>   }
> 
>>   
>>   /*
>> + * Run through the list of capabilities to check for conflicts.
>> + * Returns "false" on conflicts.
>> + */
>> +static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_list)
>> +{
>> +	bool cpu_has_cap, system_has_cap;
>> +	const struct arm64_cpu_capabilities *caps = caps_list;
>> +
>> +	for (; caps->matches; caps++) {
>> +		cpu_has_cap = __this_cpu_has_cap(caps_list, caps->capability);
> 
> What's the point of scanning the whole of caps_list?  Don't we already
> have the pointer to the right cap struct?
> 
> We already know caps->matches is true.  Can't we just call
> caps->matches(caps)?  That seemed pretty intuitive to me in the old
> code.
> 

This was supposed to be fixed by [1] in the "old code". Given we have multiple
entries for a "capability", we could be dealing with the one which doesn't
apply to this CPU and could eventually trigger a wrong conflict below. To
avoid this, we need to make sure use the right values.

>> +		system_has_cap =  cpus_have_cap(caps->capability);
>> +
>> +		if (system_has_cap) {
>> +			/*
>> +			 * Check if the new CPU misses an advertised feature, which is not
>> +			 * safe to miss.
>> +			 */
>> +			if (!cpu_has_cap && !cpucap_late_cpu_missing_cap_safe(caps))
>> +				break;
>> +			/*
>> +			 * We have to issue enable() irrespective of whether the CPU
>> +			 * has it or not, as it is enabeld system wide. It is upto
> 
> enabled
> 
>> +			 * the call back to take appropriate action on this CPU.
>> +			 */
>> +			if (caps->enable)
>> +				caps->enable(caps);
>> +		} else {
>> +			/*
>> +			 * Check if the CPU has this capability if it isn't safe to
>> +			 * have when the system doesn't.
>> +			 */
> 
> Possibly most of the commenting here is not needed.  The code is pretty
> self-explanatory, so the comments may just be adding clutter.

Sure.

> 
> The role of the ->enable() call is the only real subtlety here.
> 
>> +			if (cpu_has_cap && !cpucap_late_cpu_have_cap_safe(caps))
>> +				break;
>> +		}
>> +	}
>> +
>> +	if (caps->matches) {
>> +		pr_crit("CPU%d: Detected conflict for capability %d (%s), System: %d, CPU: %d\n",
>> +			smp_processor_id(), caps->capability,
>> +			caps->desc ? : "no description",
> 
> Wouldn't it be a bug for a conflict to occur on a cap with no .desc?
> 
> Why can't we just let printk print its default "(null)" for %s
> in this case?

We could.

> 
> Alternatively, is there a reason for any cap not to have a description?

Some of them do. e.g, some of them could be "negative" capabilities. e.g,
ARM64_NO_FPSIMD.

>> +			system_has_cap, cpu_has_cap);
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
> 
> Perhaps the capability verification procedure could be made a little
> clearer by splitting this into two functions:
> 

As explained above, the code below is not sufficient.


> static bool __verify_local_cpu_cap(const struct arm64_cpu_capabilities *cap)
> {
> 	bool cpu_has_cap = cap->matches(cap, SCOPE_LOCAL_CPU);
> 	bool system_has_cap =  cpus_have_cap(cap->capability);
> 
> 	if (system_has_cap) {
> 		if (!cpu_has_cap && !cpucap_late_cpu_missing_cap_safe(cap))
> 			goto bad;
> 
> 		if (cap->enable)
> 			/* Enable for this cpu if appropriate: */
> 			cap->enable(cap);
> 	} else {
> 		if (cpu_has_cap && !cpucap_late_cpu_have_cap_safe(cap))
> 			goto bad;
> 	}
> 
> 	return true;
> 
> bad:
> 	pr_crit([...]);
> 	return false;
> }
> 
> static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps)
> {
> 	while (caps->matches) {
> 		if (!__verify_local_cpu_cap(caps))
> 			return false;
> 
> 		++caps;
> 	}
> 
> 	return true;
> }


[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-January/552877.html

Cheers
Suzuki
