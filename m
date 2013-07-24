From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 24 Jul 2013 16:24:34 +0100
Subject: [PATCH 03/14] ARM: fixup_pv_table bug when CPU_ENDIAN_BE8
In-Reply-To: <20130724143335.GL11072@mudshark.cambridge.arm.com>
References: <1374661682-9349-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374661682-9349-4-git-send-email-ben.dooks@codethink.co.uk>
 <20130724143335.GL11072@mudshark.cambridge.arm.com>
Message-ID: <51EFF1B2.4050609@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/13 15:33, Will Deacon wrote:
> On Wed, Jul 24, 2013 at 11:27:51AM +0100, Ben Dooks wrote:
>> The fixup_pv_table assumes that the instructions are in the same
>> endian configuration as the data, but when the CPU is running in
>> BE8 the instructions stay in little-endian format.
>>
>> Make sure if CONFIG_CPU_ENDIAN_BE8 is set that we do all the
>> alterations to the instructions taking in to account the LDR/STR
>> will be swapping the data endian-ness.
>>
>> Since the code is only modifying a byte, we avoid dual-swapping
>> the data, and just change the bits we clear and ORR in (in the
>> case where the code is not thumb2).
>>
>> For thumb2, we add the necessary rev16 instructions to ensure that
>> the instructions are processed in the correct format, as it was
>> easier than re-writing the code to contain a mask and shift.
>>
>> Signed-off-by: Ben Dooks<ben.dooks@codethink.co.uk>
>> ---
>>   arch/arm/kernel/head.S |    8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
>> index 8bac553..e40c0b3b 100644
>> --- a/arch/arm/kernel/head.S
>> +++ b/arch/arm/kernel/head.S
>> @@ -584,8 +584,10 @@ __fixup_a_pv_table:
>>   	b	2f
>>   1:	add     r7, r3
>>   	ldrh	ip, [r7, #2]
>> +ARM_BE8(rev16	ip, ip)
>>   	and	ip, 0x8f00
>>   	orr	ip, r6	@ mask in offset bits 31-24
>> +ARM_BE8(rev16	ip, ip)
>
> I'm not sure I follow you when you say this is easier than a mask and a
> shift? As far as I can tell, it's two extra instructions and makes the LE
> and BE cases look different.

I am not as familiar with THUMB2 as the ARM, so it was easier
to do this than see if there where any spare registers to hold the
mask and shift values, and use them.

>>   	strh	ip, [r7, #2]
>>   2:	cmp	r4, r5
>>   	ldrcc	r7, [r4], #4	@ use branch for delay slot
>> @@ -594,8 +596,14 @@ __fixup_a_pv_table:
>>   #else
>>   	b	2f
>>   1:	ldr	ip, [r7, r3]
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +	@ in BE8, we load data in BE, but instructions still in LE
>> +	bic	ip, ip, #0xff000000
>> +	orr	ip, ip, r6, lsl#24
>
> Pedantry: you could add a space between lsl and #24.
>
> Will


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
