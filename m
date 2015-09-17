From: james.morse@arm.com (James Morse)
Date: Thu, 17 Sep 2015 11:33:44 +0100
Subject: [PATCH v2] arm64: Introduce IRQ stack
In-Reply-To: <20150916112520.GH28771@arm.com>
References: <1442155337-7020-1-git-send-email-jungseoklee85@gmail.com>
 <20150916112520.GH28771@arm.com>
Message-ID: <55FA9708.5070200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 16/09/15 12:25, Will Deacon wrote:
> On Sun, Sep 13, 2015 at 03:42:17PM +0100, Jungseok Lee wrote:
>> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
>> index dcd06d1..44839c0 100644
>> --- a/arch/arm64/include/asm/thread_info.h
>> +++ b/arch/arm64/include/asm/thread_info.h
>> @@ -73,8 +73,11 @@ static inline struct thread_info *current_thread_info(void) __attribute_const__;
>>  
>>  static inline struct thread_info *current_thread_info(void)
>>  {
>> -	return (struct thread_info *)
>> -		(current_stack_pointer & ~(THREAD_SIZE - 1));
>> +	unsigned long sp_el0;
>> +
>> +	asm volatile("mrs %0, sp_el0" : "=r" (sp_el0));
>> +
>> +	return (struct thread_info *)(sp_el0 & ~(THREAD_SIZE - 1));
> 
> This looks like it will generate worse code than our current implementation,
> thanks to the asm volatile. Maybe just add something like a global
> current_stack_pointer_el0?

Like current_stack_pointer does?:
> register unsigned long current_stack_pointer_el0 asm ("sp_el0");

Unfortunately the compiler won't accept this, as it doesn't like the
register name, it also won't accept instructions in this asm string.

Dropping the 'volatile' has the desired affect[0]. This would only cause a
problem over a call to cpu_switch_to(), which writes to sp_el0, but also
save/restores the callee-saved registers, so they will always be consistent.


James




[0] A fictitious example printk:
> printk("%p%p%u%p", get_fs(), current_thread_info(),
>        smp_processor_id(), current);

With this patch compiles to:
 5f8:   d5384101        mrs     x1, sp_el0
 5fc:   d5384100        mrs     x0, sp_el0
 600:   d5384103        mrs     x3, sp_el0
 604:   d5384104        mrs     x4, sp_el0
 608:   9272c484        and     x4, x4, #0xffffffffffffc000
 60c:   9272c463        and     x3, x3, #0xffffffffffffc000
 610:   9272c421        and     x1, x1, #0xffffffffffffc000
 614:   aa0403e2        mov     x2, x4
 618:   90000000        adrp    x0, 0 <do_bad>
 61c:   f9400884        ldr     x4, [x4,#16]
 620:   91000000        add     x0, x0, #0x0
 624:   b9401c63        ldr     w3, [x3,#28]
 628:   f9400421        ldr     x1, [x1,#8]
 62c:   94000000        bl      0 <printk>

Removing the volatile:
 5e4:   d5384102        mrs     x2, sp_el0
 5e8:   f9400844        ldr     x4, [x2,#16]
 5ec:   91000000        add     x0, x0, #0x0
 5f0:   b9401c43        ldr     w3, [x2,#28]
 5f4:   f9400441        ldr     x1, [x2,#8]
 5f8:   94000000        bl      0 <printk>
