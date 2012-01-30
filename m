From: bill4carson@gmail.com (bill4carson)
Date: Mon, 30 Jan 2012 16:29:47 +0800
Subject: [PATCH] Skip unnecessary pte makeup when clearing it.
In-Reply-To: <20120130075806.GJ6305@pengutronix.de>
References: <1327888071-3162-1-git-send-email-bill4carson@gmail.com>
 <1327888071-3162-2-git-send-email-bill4carson@gmail.com>
 <20120130075806.GJ6305@pengutronix.de>
Message-ID: <4F2654FB.60403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2012?01?30? 15:58, Uwe Kleine-K?nig wrote:
> On Mon, Jan 30, 2012 at 09:47:51AM +0800, bill4carson at gmail.com wrote:
>> From: Bill Carson<bill4carson@gmail.com>
>>
>> If we are only about to clear a hardware pte entry, then pte makeup code is
>> unnecessary for cpu_v7_set_pte_ext and armv6_set_pte_ext, so just skip it.
>>
>> Signed-off-by: Bill Carson<bill4carson@gmail.com>
>> ---
>>   arch/arm/mm/proc-macros.S    |   10 +++++-----
>>   arch/arm/mm/proc-v7-2level.S |   10 +++++-----
>>   2 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
>> index 2d8ff3a..907b524 100644
>> --- a/arch/arm/mm/proc-macros.S
>> +++ b/arch/arm/mm/proc-macros.S
>> @@ -138,6 +138,10 @@
>>   	.macro	armv6_set_pte_ext pfx
>>   	str	r1, [r0], #2048			@ linux version
>>
>> +	tst	r1, #L_PTE_YOUNG
>> +	tstne	r1, #L_PTE_PRESENT
>> +	moveq	r3, #0
>> +	beq	1f
>>   	bic	r3, r1, #0x000003fc
>>   	bic	r3, r3, #PTE_TYPE_MASK
>>   	orr	r3, r3, r2
>> @@ -163,11 +167,7 @@
>>   	orrne	r3, r3, #PTE_EXT_XN
>>
>>   	orr	r3, r3, r2
>> -
>> -	tst	r1, #L_PTE_YOUNG
>> -	tstne	r1, #L_PTE_PRESENT
>> -	moveq	r3, #0
>> -
>> +1:
>>   	str	r3, [r0]
>>   	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
>>   	.endm
>> diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
>> index 3a4b3e7..869bebc 100644
>> --- a/arch/arm/mm/proc-v7-2level.S
>> +++ b/arch/arm/mm/proc-v7-2level.S
>> @@ -76,6 +76,10 @@ ENTRY(cpu_v7_set_pte_ext)
>>   #ifdef CONFIG_MMU
>>   	str	r1, [r0]			@ linux version
>>
>> +	tst	r1, #L_PTE_YOUNG
>> +	tstne	r1, #L_PTE_PRESENT
>> +	moveq	r3, #0
>> +	beq		1f
> This double tab looks wrong. Other than that I think the patch is OK.
> Note I don't have a clue about ptes but your changes are a logical nop.
>
Thanks for your feedback :)

I will fix that double tab soon, as for "your changes are a logical nop"
it does not change any code substantially, changing the sequence does
not help when setup an page mapping, but it take a short path when clearing
an existing pte, thus gives better performance.

> Best regards
> Uwe
>
>>   	bic	r3, r1, #0x000003f0
>>   	bic	r3, r3, #PTE_TYPE_MASK
>>   	orr	r3, r3, r2
>> @@ -98,11 +102,7 @@ ENTRY(cpu_v7_set_pte_ext)
>>
>>   	tst	r1, #L_PTE_XN
>>   	orrne	r3, r3, #PTE_EXT_XN
>> -
>> -	tst	r1, #L_PTE_YOUNG
>> -	tstne	r1, #L_PTE_PRESENT
>> -	moveq	r3, #0
>> -
>> +1:
>>    ARM(	str	r3, [r0, #2048]! )
>>    THUMB(	add	r0, r0, #2048 )
>>    THUMB(	str	r3, [r0] )

-- 
I am a slow learner
but I will keep trying to fight for my dreams!

--bill
