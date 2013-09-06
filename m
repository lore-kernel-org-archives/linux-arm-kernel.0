From: behanw@converseincode.com (Behan Webster)
Date: Fri, 06 Sep 2013 18:59:35 -0400
Subject: [PATCH 2/5] arm: LLVMLinux: use current_stack_pointer for percpu
In-Reply-To: <yw1xioyd1t1d.fsf@unicorn.mansr.com>
References: <1378502899-1241-1-git-send-email-behanw@converseincode.com>
 <1378502899-1241-3-git-send-email-behanw@converseincode.com>
 <yw1xioyd1t1d.fsf@unicorn.mansr.com>
Message-ID: <522A5E57.2050505@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/13 18:31, M?ns Rullg?rd wrote:
> behanw at converseincode.com writes:
>
>> From: Behan Webster <behanw@converseincode.com>
>>
>> The existing code uses named registers to get the value of the stack pointer.
>> The new current_stack_pointer macro is more readable and allows for a central
>> portable implementation of how to get the stack pointer with ASM.  This change
>> supports being able to compile the kernel with both gcc and Clang.
>>
>> Signed-off-by: Mark Charlebois <charlebm@gmail.com>
>> Signed-off-by: Behan Webster <behanw@converseincode.com>
>> Reviewed-by: Jan-Simon M?ller <dl9pf@gmx.de>
>> ---
>>   arch/arm/include/asm/percpu.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
>> index 209e650..629a975 100644
>> --- a/arch/arm/include/asm/percpu.h
>> +++ b/arch/arm/include/asm/percpu.h
>> @@ -30,14 +30,14 @@ static inline void set_my_cpu_offset(unsigned long off)
>>   static inline unsigned long __my_cpu_offset(void)
>>   {
>>   	unsigned long off;
>> -	register unsigned long *sp asm ("sp");
>> +	unsigned long sp = current_stack_pointer;
>>
>>   	/*
>>   	 * Read TPIDRPRW.
>>   	 * We want to allow caching the value, so avoid using volatile and
>>   	 * instead use a fake stack read to hazard against barrier().
>>   	 */
>> -	asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off) : "Q" (*sp));
>> +	asm("mrc p15, 0, %0, c13, c0, 4" : "=r" (off) : "Q" (sp));
> This doesn't do quite the same thing.  The existing code pretends to
> read something from the stack in order to create a barrier of some
> sort.  Your new code stores the value of the stack pointer to a location
> on the stack for consumption by the "Q" memory constraint.
Agreed. My bug. Will fix.

>    This store is not necessary and should preferably be avoided.
I agree that the extra store should be avoided. I wasn't unable to 
remove it. Can you suggest how?

Thanks,

Behan

-- 
Behan Webster
behanw at converseincode.com
