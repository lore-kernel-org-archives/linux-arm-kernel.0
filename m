From: junxiao.bi@windriver.com (Bi Junxiao)
Date: Tue, 22 Nov 2011 09:47:24 +0800
Subject: [PATCH 2/6] ARM: gic: fix big endian support
In-Reply-To: <alpine.LFD.2.02.1111211334320.17904@xanadu.home>
References: <1321322785-2981-1-git-send-email-junxiao.bi@windriver.com>
 <1321322785-2981-2-git-send-email-junxiao.bi@windriver.com>
 <alpine.LFD.2.02.1111211334320.17904@xanadu.home>
Message-ID: <4ECAFF2C.1010604@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

on 11/22/2011 03:11 AM Nicolas Pitre wrote:
> On Tue, 15 Nov 2011, Junxiao Bi wrote:
>
>    
>> The irq state from gic is in little-endian mode. We need do endian
>> conversion for it in big-endian machine. Usually byte swapping of
>> 32-bits word needs 4 assembler instructions for arm machine which
>> arch<  6. But since the high order half word of the irq state is
>> zero, there is a way that can use lesser instrunctions to improve
>> the performance since we only need a bytes swaping of half word.
>> That's what swab16_low_half and swab16_high_half do.
>>
>> Signed-off-by: Junxiao Bi<junxiao.bi@windriver.com>
>>      
> Comments below.
>
>    
>> ---
>>   arch/arm/include/asm/assembler.h                |   27 +++++++++++++++++++++++
>>   arch/arm/include/asm/hardware/entry-macro-gic.S |    7 ++++++
>>   2 files changed, 34 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
>> index 29035e8..3ddee22 100644
>> --- a/arch/arm/include/asm/assembler.h
>> +++ b/arch/arm/include/asm/assembler.h
>> @@ -302,4 +302,31 @@
>>   	.size \name , . - \name
>>   	.endm
>>
>> +/*
>> + * swab16_low_half is used to swap the bytes order of the low order
>> + * half word, it assumes that the high order half word is zero.
>> + * swab16_high_half is used to swap the bytes order of the high order
>> + * half word, it assumes that the low order half word is zero.
>> + */
>> +#if __LINUX_ARM_ARCH__>= 6
>> +	.macro swab16_low_half, reg
>> +	rev \reg, \reg
>> +	.endm
>> +
>> +	.macro swab16_high_half, reg
>> +	rev \reg, \reg
>> +	.endm
>> +#else
>> +	.macro swab16_low_half, reg
>> +	mov \reg, \reg, ror #8
>> +	orr \reg, \reg, \reg, lsr #16
>> +	bic \reg, \reg, \reg, lsl #16
>> +	.endm
>>      
> I fail to see how this macro would be generally useful.  Presuming that
> the top or bottom half has to be zero is not particularly practical.
>    
We can use it to swap bytes order of a 16-bits number in 32-bits 
register in which case the top or bottom half will be zero. For the 
\irqstat register, as the original implementation assumes its top half 
is zero, so I make the same assumption.
>    
>> +	.macro swab16_high_half, reg
>> +	swab16_low_half \reg
>> +	mov \reg, \reg, lsl #16
>> +	.endm
>>      
> And this doesn't end up cheaper than a plain swab32.
>    
This macro has an advantage that it only needs one register. For swab32, 
it will need another temporary register besides the target register.
> Furthermore, you're using those macros 1) in the gic code, and 2) onli
> in the BE8 case.  Both of those conditions are only possible on ARMv6
> and above anyway, so I'd simply open code a rev instruction inline.
>    
This is not be8 specific. It will be needed for both be8 and be32. So 
the machine with arch < 6 also needs to be supported.
>
> Nicolas
>
>    
