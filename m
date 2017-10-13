From: james.morse@arm.com (James Morse)
Date: Fri, 13 Oct 2017 17:50:45 +0100
Subject: [PATCH v3 04/13] arm64: alternatives: use tpidr_el2 on VHE hosts
In-Reply-To: <20171013153148.dnejsvhxeui6opfw@armageddon.cambridge.arm.com>
References: <20170922182614.27885-1-james.morse@arm.com>
 <20170922182614.27885-5-james.morse@arm.com>
 <20171013153148.dnejsvhxeui6opfw@armageddon.cambridge.arm.com>
Message-ID: <59E0EEE5.2020208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 13/10/17 16:31, Catalin Marinas wrote:
> On Fri, Sep 22, 2017 at 07:26:05PM +0100, James Morse wrote:
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index cd52d365d1f0..8e4c7da2b126 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c

>> @@ -1308,3 +1309,25 @@ static int __init enable_mrs_emulation(void)
>>  }
>>  
>>  late_initcall(enable_mrs_emulation);
>> +
>> +int cpu_copy_el2regs(void *__unused)
>> +{
>> +	int do_copyregs = 0;
>> +
>> +	/*
>> +	 * Copy register values that aren't redirected by hardware.
>> +	 *
>> +	 * Before code patching, we only set tpidr_el1, all CPUs need to copy
>> +	 * this value to tpidr_el2 before we patch the code. Once we've done
>> +	 * that, freshly-onlined CPUs will set tpidr_el2, so we don't need to
>> +	 * do anything here.
>> +	 */
>> +	asm volatile(ALTERNATIVE("mov %0, #1", "mov %0, #0",
>> +				 ARM64_HAS_VIRT_HOST_EXTN)
>> +		    : "=r" (do_copyregs) : : );
> 
> Can you just do:
> 
> 	if (cpu_have_const_cap(ARM64_HAS_VIRT_HOST_EXTN))
> 		write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);
> 
> At this point the capability bits should be set and the jump labels
> enabled.

These are enabled too early, we haven't done patching yet.

We need to copy tpidr_el1 -> tpidr_el2 on all CPUs that are online before code
patching.

After code patching new CPUs set tpidr_el2 when they come online, so we don't
need to do the copy... but this enable method is still called. There is nothing
for us to do, and tpidr_el1 now contains junk, so the copy


cpu_have_const_cap() is great for knowing if we have a feature, here we want to
know if we've done the patching for this feature.

I can wrap the ALTERNATIVE() into a helper, something like:
> arm64_alternatives_applied(ARM64_HAS_VIRT_HOST_EXTN)

which should make it clearer.

Christoffer had the same question at connect, so I evidently haven't found the
right way of describing this yet.


> Otherwise:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks for taking a look, I'll leave this RB until your happy with the
ALTERNATIVE() hackery above.


James
