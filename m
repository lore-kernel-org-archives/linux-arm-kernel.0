From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 9 May 2018 17:55:51 +0100
Subject: [PATCH v7 02/16] arm64: Use update{,_tsk}_thread_flag()
In-Reply-To: <20180509162753.GP7753@e103592.cambridge.arm.com>
References: <1525882385-29181-1-git-send-email-Dave.Martin@arm.com>
 <1525882385-29181-3-git-send-email-Dave.Martin@arm.com>
 <20180509161728.GC26671@arm.com>
 <20180509162753.GP7753@e103592.cambridge.arm.com>
Message-ID: <f444acee-b558-7dbb-97bd-bbf716b20ebd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/18 17:27, Dave Martin wrote:
> On Wed, May 09, 2018 at 05:17:28PM +0100, Will Deacon wrote:
>> Hi Dave,
>>
>> On Wed, May 09, 2018 at 05:12:51PM +0100, Dave Martin wrote:
>>> This patch uses the new update_thread_flag() helpers to simplify a
>>> couple of if () set; else clear; constructs.
>>>
>>> No functional change.
>>>
>>> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> ---
>>>  arch/arm64/kernel/fpsimd.c | 19 +++++++------------
>>>  1 file changed, 7 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>>> index 87a3536..0c4e7e0 100644
>>> --- a/arch/arm64/kernel/fpsimd.c
>>> +++ b/arch/arm64/kernel/fpsimd.c
> 
> [...]
> 
>>> @@ -902,7 +900,7 @@ void fpsimd_thread_switch(struct task_struct *next)
>>>  	if (current->mm)
>>>  		task_fpsimd_save();
>>>  
>>> -	if (next->mm) {
>>> +	if (next->mm)
>>>  		/*
>>>  		 * If we are switching to a task whose most recent userland
>>>  		 * FPSIMD state is already in the registers of *this* cpu,
>>> @@ -910,13 +908,10 @@ void fpsimd_thread_switch(struct task_struct *next)
>>>  		 * the TIF_FOREIGN_FPSTATE flag so the state will be loaded
>>>  		 * upon the next return to userland.
>>>  		 */
>>> -		if (__this_cpu_read(fpsimd_last_state.st) ==
>>> -			&next->thread.uw.fpsimd_state
>>> -		    && next->thread.fpsimd_cpu == smp_processor_id())
>>> -			clear_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE);
>>> -		else
>>> -			set_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE);
>>> -	}
>>> +		update_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE,
>>> +			__this_cpu_read(fpsimd_last_state.st) !=
>>> +				&next->thread.uw.fpsimd_state ||
>>> +			next->thread.fpsimd_cpu != smp_processor_id());
>>
>> Given the multi-line comment and this multi-line call, I'd be inclined to
>> leave the curlies in place and then use a local bool for the complex
>> condition.
> 
> Hey, curlies cost money, you know.
> 
>> With that:
>>
>> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Are you content to see this merged without the change?  It doesn't seem
> worth a respin of the whole series just for this.  I agree the code
> would be clearer, but this patch doesn't actually make it worse IMHO.
> 
> If I respin for some reason though, I can address this and add your Ack.

I'm happy to perform the change myself when applying the series if there
is no additional comment that would lead to a respin.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
