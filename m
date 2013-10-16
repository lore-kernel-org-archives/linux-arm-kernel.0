From: tushar.jagad@linaro.org (Tushar Jagad)
Date: Wed, 16 Oct 2013 12:34:48 +0530
Subject: [RFC PATCH 3/4] ARM64: Big Endian fixes for kernel booting
In-Reply-To: <525D8860.7080204@codeaurora.org>
References: <1381494135-15085-1-git-send-email-ankit.jindal@linaro.org>
 <1381494135-15085-4-git-send-email-ankit.jindal@linaro.org>
 <525D8860.7080204@codeaurora.org>
Message-ID: <525E3A90.4070809@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christopher,

On 10/15/2013 11:54 PM, Christopher Covington wrote:
>>   /*
>> + * Set el0-el1-el2 to Big endian
>> + */
>
> It might be helpful to say why this has to be done (each level needs to be set
> up before it's used?) and maybe list them in the order they're set up in.

Sure will cover more details in the comment.

>> +#if defined(CONFIG_CPU_BIG_ENDIAN)
>> +ENTRY(setend_be)
>> +	mrs     x21, CurrentEL
>> +        cmp     x21, #PSR_MODE_EL2t
>> +	b.ne  	setend_be_el1_el0
>
> Make sure to use tabs rather than spaces and run checkpatch.pl.

Somehow this got skipped. Thanks for pointing it out.

>
>> +
>> +setend_be_el2:
>> +	mrs     x21, sctlr_el2
>> +        mov     x22, #(1<<25)
>> +        orr     x21, x21, x22
>> +        msr     sctlr_el2, x21
>> +	isb
>> +
>> +setend_be_el1_el0:
>> +	mrs     x21, sctlr_el1
>> +        mov     x22, #(3<<24)
>> +        orr     x21, x21, x22
>> +        msr     sctlr_el1, x21
>> +	isb
>> +
>> +	ret
>> +ENDPROC(setend_be)
>> +#endif /* defined(CONFIG_CPU_BIG_ENDIAN) */
>> +
>> +/*
>>    * If we're fortunate enough to boot at EL2, ensure that the world is
>>    * sane before dropping to EL1.
>>    */
>> @@ -181,7 +210,11 @@ ENTRY(el2_setup)
>>
>>   	/* sctlr_el1 */
>>   	mov	x0, #0x0800			// Set/clear RES{1,0} bits
>> +#if defined(CONFIG_CPU_BIG_ENDIAN)
>> +	movk	x0, #0x33d0, lsl #16
>> +#else
>>   	movk	x0, #0x30d0, lsl #16
>> +#endif
>>   	msr	sctlr_el1, x0
>
> This may be easier to read if the magic number were ifdef'ed instead of the code.

Will change this as well.
-- 
Regards,
Tushar
