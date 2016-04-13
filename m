From: james.morse@arm.com (James Morse)
Date: Wed, 13 Apr 2016 13:37:46 +0100
Subject: [PATCH] arm64: mm: Add trace_irqflags annotations to
 do_debug_exception()
In-Reply-To: <20160329150650.GE6745@arm.com>
References: <1458580446-32474-1-git-send-email-james.morse@arm.com>
 <20160329150650.GE6745@arm.com>
Message-ID: <570E3D9A.4090402@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/03/16 16:06, Will Deacon wrote:
> On Mon, Mar 21, 2016 at 05:14:06PM +0000, James Morse wrote:
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 44e56de23f79..d8b9c1da2630 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -548,20 +548,33 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
>>  {
>>  	const struct fault_info *inf = debug_fault_info + DBG_ESR_EVT(esr);
>>  	struct siginfo info;
>> +	int rv;
>>  
>> -	if (!inf->fn(addr, esr, regs))
>> -		return 1;
>> +	/*
>> +	 * If we came in from el0_dbg, we disabled irqs. From el1_dbg,
>> +	 * we need to test pstate.
>> +	 */
>> +	if (user_mode(regs) || !(regs->pstate & PSR_I_BIT))
>> +		trace_hardirqs_off();
> 
> Can you use interrupts_enabled(regs) for this?

Yes! That would be better. I can also remove the user_mode() check which was due
to paranoia and miss-understanding.


Thanks,

James
