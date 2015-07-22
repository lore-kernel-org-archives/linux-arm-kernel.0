From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 22 Jul 2015 12:08:00 +0100
Subject: [PATCH v2 1/5] arm64: alternative: Provide if/else/endif
 assembler macros
In-Reply-To: <20150720171242.GP9908@arm.com>
References: <1436536130-31438-1-git-send-email-daniel.thompson@linaro.org>
 <1437405004-1296-1-git-send-email-daniel.thompson@linaro.org>
 <1437405004-1296-2-git-send-email-daniel.thompson@linaro.org>
 <20150720171242.GP9908@arm.com>
Message-ID: <55AF7990.6070105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/07/15 18:12, Will Deacon wrote:
>> diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
>> index c385a0c4057f..31b19ad18f7e 100644
>> --- a/arch/arm64/include/asm/alternative.h
>> +++ b/arch/arm64/include/asm/alternative.h
>> @@ -77,6 +77,46 @@ void free_alternatives_memory(void);
>>   	.org	. - (662b-661b) + (664b-663b)
>>   .endm
>>
>> +/*
>> + * Begin an alternative code sequence.
>> + *
>> + * The code that follows this marco will be assembled and linked as
>> + * normal. There are no restrictions on this code.
>
> s/marco/macro/

Will fix this.


>
>> + */
>> +.macro alternative_if_not cap
>> +	.pushsection .altinstructions, "a"
>> +	altinstruction_entry 661f, 663f, \cap, 662f-661f, 664f-663f
>> +	.popsection
>> +661:
>> +.endm
>> +
>> +/*
>> + * Provide the alternative code sequence.
>> + *
>> + * The code that follows this macro is assembled into a special
>> + * section to be used for dynamic patching. Code that follows this
>> + * macro must:
>> + *
>> + * 1. Be exactly the same length (in bytes) as the default code
>> + *    sequence.
>> + *
>> + * 2. Not jump to local labels defined outside of the alternative
>> + *    sequence.
>
> Actually, we fix up the branch target during patching. What you can't do
> is jump into *another* alternative sequence.

Ok. I will update this.

I saw that there must be branch target patching (due to branches to 
__save_vgic_v3_state) but got it into my head that branches to local 
labels confused the assembler. I guess I must made an unrelated syntax 
error because I just done a few tests and can't reproduce anything like 
that.


Daniel.
