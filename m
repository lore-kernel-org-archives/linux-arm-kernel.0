From: bill4carson@gmail.com (bill4carson)
Date: Thu, 19 Jan 2012 09:57:19 +0800
Subject: [PATCH] Skip unnecessary pte makeup when clearing it.
In-Reply-To: <20120118103315.GB20028@arm.com>
References: <1326880345-17306-1-git-send-email-bill4carson@gmail.com>
 <20120118103315.GB20028@arm.com>
Message-ID: <4F17787F.2030003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2012?01?18? 18:33, Catalin Marinas wrote:
> On Wed, Jan 18, 2012 at 09:52:25AM +0000, bill4carson at gmail.com wrote:
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
>> index 2d8ff3a..11288b3 100644
>> --- a/arch/arm/mm/proc-macros.S
>> +++ b/arch/arm/mm/proc-macros.S
>> @@ -138,6 +138,10 @@
>>   	.macro	armv6_set_pte_ext pfx
>>   	str	r1, [r0], #2048			@ linux version
>>
>> +	tst	r1, #L_PTE_YOUNG
>> +	tstne	r1, #L_PTE_PRESENT
>> +	moveq	r3, #0
>> +	moveq	set_pte
> As Uwe said, "beq" here and you could use numerical labels like "1f".
>
Yes, I made a terrible mistake about "beq" :-[
I will send v2 after Uwe compile thumb successfully with this patch.

-- 
I am a slow learner
but I will keep trying to fight for my dreams!

--bill
