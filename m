From: behanw@converseincode.com (Behan Webster)
Date: Fri, 06 Sep 2013 18:56:07 -0400
Subject: [PATCH 2/5] arm: LLVMLinux: use current_stack_pointer for percpu
In-Reply-To: <20130906222243.GS6617@n2100.arm.linux.org.uk>
References: <1378502899-1241-1-git-send-email-behanw@converseincode.com>
 <1378502899-1241-3-git-send-email-behanw@converseincode.com>
 <20130906222243.GS6617@n2100.arm.linux.org.uk>
Message-ID: <522A5D87.30704@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/13 18:22, Russell King - ARM Linux wrote:
> On Fri, Sep 06, 2013 at 05:28:08PM -0400, behanw at converseincode.com wrote:
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
> This looks like it's breaking what's going on here.  With the original
> code, we're passing the contents of the word at the stack pointer into
> the assembly via a "Q" constraint.  After this change, we're passing
> the _value_ of the stack pointer.
>
> Also, if you read the comment, it's certainly wrong.
This code was rewritten a few times trying to remove the extra copy. I 
think this bug crept in.

Of course you're right. I will fix it.

Thanks,

Behan

-- 
Behan Webster
behanw at converseincode.com
