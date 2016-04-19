From: james.morse@arm.com (James Morse)
Date: Tue, 19 Apr 2016 16:05:02 +0100
Subject: [PATCH v7 04/16] arm64: kvm: Move the do_el2_call macro to a
 header file
In-Reply-To: <57164897.8090603@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-5-git-send-email-james.morse@arm.com>
 <57164897.8090603@arm.com>
Message-ID: <5716491E.4050607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 19/04/16 16:02, Marc Zyngier wrote:
> On 01/04/16 17:53, James Morse wrote:
>> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
>> index 9f22dd607958..b8fdddeca71b 100644
>> --- a/arch/arm64/include/asm/virt.h
>> +++ b/arch/arm64/include/asm/virt.h
>> @@ -21,7 +21,23 @@
>>  #define BOOT_CPU_MODE_EL1	(0xe11)
>>  #define BOOT_CPU_MODE_EL2	(0xe12)
>>  
>> -#ifndef __ASSEMBLY__
>> +#ifdef __ASSEMBLY__
>> +.macro do_el2_call
>> +	/*
>> +	 * Shuffle the parameters before calling the function
>> +	 * pointed to in x0. Assumes parameters in x[1,2,3].
>> +	 */
>> +	sub	sp, sp, #16
>> +	str	lr, [sp]
>> +	mov	lr, x0
>> +	mov	x0, x1
>> +	mov	x1, x2
>> +	mov	x2, x3
>> +	blr	lr
>> +	ldr	lr, [sp]
>> +	add	sp, sp, #16
>> +.endm
>> +#else
> 
> So while I'm not opposed to this macro being reused, the name is
> slightly misleading out of the original context. This macro doesn't take
> you to EL2, but implements a very peculiar calling convention that only
> the HYP code is expecting.

Ah, I hadn't thought of it like that!


> Could we have a disclaimer saying something along the lines of "Don't
> you dare using this macro!"?

Or rename it? Something like 'unpack_el2_call'.



Thanks,

James
