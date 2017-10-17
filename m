From: james.morse@arm.com (James Morse)
Date: Tue, 17 Oct 2017 17:36:22 +0100
Subject: [PATCH v3 04/13] arm64: alternatives: use tpidr_el2 on VHE hosts
In-Reply-To: <20171016095845.htg2g4jkyw3nvzub@armageddon.cambridge.arm.com>
References: <20170922182614.27885-1-james.morse@arm.com>
 <20170922182614.27885-5-james.morse@arm.com>
 <20171013153148.dnejsvhxeui6opfw@armageddon.cambridge.arm.com>
 <59E0EEE5.2020208@arm.com>
 <20171016095845.htg2g4jkyw3nvzub@armageddon.cambridge.arm.com>
Message-ID: <59E63186.4010005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 16/10/17 10:58, Catalin Marinas wrote:
> On Fri, Oct 13, 2017 at 05:50:45PM +0100, James Morse wrote:
>> On 13/10/17 16:31, Catalin Marinas wrote:
>>> On Fri, Sep 22, 2017 at 07:26:05PM +0100, James Morse wrote:
>>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>>> index cd52d365d1f0..8e4c7da2b126 100644
>>>> --- a/arch/arm64/kernel/cpufeature.c
>>>> +++ b/arch/arm64/kernel/cpufeature.c
>>
>>>> @@ -1308,3 +1309,25 @@ static int __init enable_mrs_emulation(void)
>>>>  }
>>>>  
>>>>  late_initcall(enable_mrs_emulation);
>>>> +
>>>> +int cpu_copy_el2regs(void *__unused)
>>>> +{
>>>> +	int do_copyregs = 0;
>>>> +
>>>> +	/*
>>>> +	 * Copy register values that aren't redirected by hardware.
>>>> +	 *
>>>> +	 * Before code patching, we only set tpidr_el1, all CPUs need to copy
>>>> +	 * this value to tpidr_el2 before we patch the code. Once we've done
>>>> +	 * that, freshly-onlined CPUs will set tpidr_el2, so we don't need to
>>>> +	 * do anything here.
>>>> +	 */
>>>> +	asm volatile(ALTERNATIVE("mov %0, #1", "mov %0, #0",
>>>> +				 ARM64_HAS_VIRT_HOST_EXTN)
>>>> +		    : "=r" (do_copyregs) : : );
>>>
>>> Can you just do:
>>>
>>> 	if (cpu_have_const_cap(ARM64_HAS_VIRT_HOST_EXTN))
>>> 		write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);
>>>
>>> At this point the capability bits should be set and the jump labels
>>> enabled.
>>
>> These are enabled too early, we haven't done patching yet.
>>
>> We need to copy tpidr_el1 -> tpidr_el2 on all CPUs that are online before code
>> patching.
>>
>> After code patching new CPUs set tpidr_el2 when they come online, so we don't
>> need to do the copy... but this enable method is still called. There is nothing
>> for us to do, and tpidr_el1 now contains junk, so the copy

> Ah, I get it now (should've read the comment but I usually expect the
> code to be obvious; it wasn't, at least to me, in this case ;)).

> You could have added the sysreg copying directly in the asm volatile.

I was trying to stick to the sysreg C accessors, and thought there would be more
registers that needed copying. (I discovered this VHE doesn't remap all the _ELx
registers quite late.)


> Anyway, I think it's better if we keep it entirely in C with this hunk
> (untested):

[...]

Yes, that looks much better. I got tangled up in 'which alternative', but you're
right, they are all applied in one go so it doesn't matter.


>	if (!READ_ONCE(alternatives_applied))
> 		write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);

I don't think this READ_ONCE() is needed, that only matters within the
stop_machine()/alternatives-patching code that modifies the value on one CPU.


Thanks,

James
