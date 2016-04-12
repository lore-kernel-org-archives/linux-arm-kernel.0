From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 12 Apr 2016 10:07:17 +0100
Subject: [RFC PATCH 1/2] ARM/ARM64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <1460440128.32510.106.camel@buserror.net>
References: <1460341353-15619-1-git-send-email-oss@buserror.net>
 <1460341353-15619-2-git-send-email-oss@buserror.net>
 <570B73CF.6070502@arm.com> <1460440128.32510.106.camel@buserror.net>
Message-ID: <570CBAC5.8070406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/16 06:48, Scott Wood wrote:
> On Mon, 2016-04-11 at 10:52 +0100, Marc Zyngier wrote:
>> Hi Scott,
>>
>> On 11/04/16 03:22, Scott Wood wrote:
>>> +static __always_inline
>>> +u32 arch_timer_reg_read_cp15(int access, enum arch_timer_reg reg)
>>> +{
>>> +	if (arm_arch_timer_reread && reg == ARCH_TIMER_REG_TVAL)
>>> +		return arch_timer_reg_tval_reread(access, reg);
>>
>> I'm really not keen on this. Please implement this workaround as a
>> static_key, and branch to the workaround in the slow path.
> 
> OK, I'll look into that.
> 
>>> -static inline u64 arch_counter_get_cntpct(void)
>>> +static __always_inline u64 arch_counter_get_cnt(int opcode, bool reread)
>>
>> Why the __always_inline? The compiler should already do the right thing.
> 
> The "i" asm constraint requires that it be inline.  Maybe GCC is likely to
> inline it anyway, but it's better to be explicit when it's required for
> correctness.

Probably. But the underlying issue is that you are reinventing your own
accessors instead of using the existing ones to implement your
workaround. What is wrong with looping around the existing accessors?

> 
>>> -	u64 cval;
>>> +	u64 val, val_new;
>>> +	int timeout = 200;
>>>  
>>>  	isb();
>>> -	asm volatile("mrrc p15, 0, %Q0, %R0, c14" : "=r" (cval));
>>> -	return cval;
>>> +
>>> +	if (reread) {
>>> +		do {
>>> +			asm volatile("mrrc p15, %2, %Q0, %R0, c14;"
>>> +				     "mrrc p15, %2, %Q1, %R1, c14"
>>> +				     : "=r" (val), "=r" (val_new)
>>> +				     : "i" (opcode));
>>> +			timeout--;
>>> +		} while (val != val_new && timeout);
>>> +
>>> +		BUG_ON(!timeout);
>>
>> BUG_ON()? Really? Is there any condition where you wouldn't be able to
>> converge to a single value?
> 
> This function is used from the vdso, and thus WARN causes a link error.

And surely BUG_ON() is suitable for userspace. /me rolls eyes...

>>> +	/*
>>> +	 * Erratum A-008585 requires back-to-back reads to be identical
>>> +	 * in order to avoid glitches.
>>> +	 */
>>> +	cmp	w17, #0
>>> +	b.eq	2f
>>> +1:	mrs	x15, cntvct_el0
>>> +	mrs	x16, cntvct_el0
>>> +	cmp	x16, x15
>>> +	b.ne	1b
>>> +2:
>>
>> Could userspace lock-up here? If it can, you need to be able to bail
>> out. If not, then your BUG_ON() sprinkling is bogus.
> 
> It *shouldn't* be possible for these loops to time out -- it would not be a
> viable workaround if it's not guaranteed to resolve quickly -- but if there
> are situations where the workaround fails (e.g. unusual clock speeds) it would
> be useful to get that diagnostic rather than have to hunt down a hang.  I can
> remove them if you want, though.

Warning once + tainting the kernel should be enough.

> 
> As for the VDSO, it seems quite unlikely that failures would be seen only in
> userspace and not in the kernel, so the utility of adding a timeout here was
> less, especially relative to the hassle.  Will Deacon asked that we leave the
> VDSO alone and set use_syscall instead, though, so adding a timeout here is
> moot.

Indeed.

>  
>>>  	/* Calculate cycle delta and convert to ns. */
>>>  	sub	x10, x15, x10
>>> diff --git a/drivers/clocksource/arm_arch_timer.c
>>> b/drivers/clocksource/arm_arch_timer.c
>>> index 5152b38..5ed7c7f 100644
>>> --- a/drivers/clocksource/arm_arch_timer.c
>>> +++ b/drivers/clocksource/arm_arch_timer.c
>>> @@ -79,6 +79,9 @@ static enum ppi_nr arch_timer_uses_ppi = VIRT_PPI;
>>>  static bool arch_timer_c3stop;
>>>  static bool arch_timer_mem_use_virtual;
>>>  
>>> +bool arm_arch_timer_reread; /* QorIQ erratum A-008585 */
>>> +EXPORT_SYMBOL(arm_arch_timer_reread);
>>> +
>>>  /*
>>>   * Architected system timer support.
>>>   */
>>> @@ -762,6 +765,8 @@ static void __init arch_timer_of_init(struct
>>> device_node *np)
>>>  	arch_timer_detect_rate(NULL, np);
>>>  
>>>  	arch_timer_c3stop = !of_property_read_bool(np, "always-on");
>>> +	arm_arch_timer_reread =
>>> +		of_property_read_bool(np, "fsl,erratum-a008585");
>>>  
>>>  	/*
>>>  	 * If we cannot rely on firmware initializing the timer registers
>>> then
>>>
>>
>> The elephant in the room is KVM. I'm pretty sure it suffers from the
>> same erratum, yet you did not handle it at all. I'd expect to see
>> something in an upcoming version of the patch.
> 
> cval isn't listed in the erratum description as being affected.  I looked
> around a bit and couldn't find the KVM code directly accessing tval or count. 
>  Am I missing something?

You are missing the fact that CVAL and TVAL are the two sides of the
same coin. From the ARMv8 ARM:

<quote>
This view of a timer depends on the following behavior of accesses to
TimerValue registers:

Reads: TimerValue = (CompareValue ? (Counter - Offset))[31:0]
Writes: CompareValue = ((Counter - Offset)[63:0] +
SignExtend(TimerValue))[63:0]
</quote>

So I'd be really surprised if TVAL was buggy and CVAL was not (why would
loop around programming TVAL if you could hit CVAL and be correct?).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
