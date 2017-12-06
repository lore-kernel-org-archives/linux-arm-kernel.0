From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 6 Dec 2017 10:17:12 +0000
Subject: [PATCH] arm64/mm: Do not write ASID generation to ttbr0
In-Reply-To: <5A26F485.10402@arm.com>
References: <1512495507-23259-1-git-send-email-julien.thierry@arm.com>
 <5A26F485.10402@arm.com>
Message-ID: <4f4572cf-9ae1-24b9-ec46-d8bbc6179426@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 05/12/17 19:33, James Morse wrote:
> Hi Julien,
> 
> On 05/12/17 17:38, Julien Thierry wrote:
>> When writing the user ASID to ttbr0, 16bit get copied to ttbr0, potentially
>> including part of the ASID generation in the ttbr0.ASID. If the kernel is
>> using less than 16bits ASIDs and the other ttbr0 bits aren't RES0, two
>> tasks using the same mm context might end up running with different
>> ttbr0.ASID values.
>> This would be triggered by one of the threads being scheduled before a
>> roll-over and the second one scheduled after a roll-over.
>>
>> Pad the generation out of the 16bits of the mm id that are written to
>> ttbr0. Thus, what the hardware sees is what the kernel considers ASID.
> 
> Is this to fix a system with a mix of 8/16 asid bits? Or someone being clever
> and reducing asid_bits to stress rollover?
> 

So it was motivated by the later. But hopefully the fix, pushing the 
generation always over 16bits is also suitable for hardware that mixes 
8/16bits asids. If it is not, do call it out.

> (I think we should do something like this so we can test rollover.)
> 
> 
>> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
>> index 6f40170..a7c72d4 100644
>> --- a/arch/arm64/mm/context.c
>> +++ b/arch/arm64/mm/context.c
>> @@ -180,6 +190,13 @@ static u64 new_context(struct mm_struct *mm, unsigned int cpu)
>>   	/* We're out of ASIDs, so increment the global generation count */
>>   	generation = atomic64_add_return_relaxed(ASID_FIRST_VERSION,
>>   						 &asid_generation);
>> +
>> +	/*
>> +	 * It is unlikely the generation will ever overflow, but if this
>> +	 * happens, let it be known strange things can occur.
>> +	 */
>> +	WARN_ON(generation == ASID_FIRST_VERSION);
> 
> Won't generation wrap to zero, not '1<<16'?

Yes it will! Silly me...

> 
> asid_generation-is-never-zero is one of the nasty things in this code.
> 
> In check_and_switch_context() we switch to the 'fast path' where the current
> asid is usable if: the generation matches and the active_asid isn't 0 (which
> indicates a rollover has occurred).
> 
> from mm/context.c::check_and_switch_context():
>> 	if (!((asid ^ atomic64_read(&asid_generation)) >> asid_bits)
>> 	    && atomic64_xchg_relaxed(&per_cpu(active_asids, cpu), asid))
>> 		goto switch_mm_fastpath;
> 
> 
> If asid_generation is ever zero, (even briefly) multiple new tasks with
> different pages-tables will pass the generation test, and run with asid=0.
> 
> Short of xchg(ASID_MAX_VERSION, ASID_FIRST_VERSION), every time, just in case, I
> don't think this is something we can handle.
> 
> But, this thing is layers on layers of subtle behaviour, so I may have missed
> something...
> 
> 

I had not thought of that. However I believe we checked with 48bits and 
the case of the generation overflowing would take a human life span (or 
something on that scale) of a system running and spawning continuous 
processes before reaching this. Which is why we decided on having a 
WARN_ON for now. So I don't know if we want to change things for this 
corner case which really means "things are going bad" more than anything 
else.

> Instead, do you think we can duplicate just the asid bits (asid & ASID_MASK)
> into a new 16bit field in mm_context_t, which we then use instead of the ASID()
> and mmid macros? (We only set a new asid in one place as returned by new_context()).
> 

I'm not sure I understand why this prevents running with asid = 0 when 
generation is 0.

> This would let context.c's asid_bits be arbitrary, as the hardware only uses the
> masked value it exposes in the new field.
> 
> This doesn't solve the mixed 8/16 bit case. I think we should force those
> systems to use 8bit asids via cpufeature to preserve as much of the generation
> counter as possible.
> 

Hmmm right, I see that today we just panic the kernel when we have a 
smaller asid size than the boot cpu...
So if we boot on a 8bit asid cpu it should work but not the other way 
around... I agree we probably should find a way to reduce the size of 
software asids system wide when we find a cpu has less bits available.

Thanks,

-- 
Julien Thierry
