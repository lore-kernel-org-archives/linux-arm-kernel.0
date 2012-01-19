From: bill4carson@gmail.com (bill4carson)
Date: Thu, 19 Jan 2012 09:52:13 +0800
Subject: [PATCH] Skip unnecessary pte makeup when clearing it.
In-Reply-To: <20120118102055.GV14252@pengutronix.de>
References: <1326880345-17306-1-git-send-email-bill4carson@gmail.com>
 <20120118102055.GV14252@pengutronix.de>
Message-ID: <4F17774D.1040307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2012?01?18? 18:20, Uwe Kleine-K?nig wrote:
> On Wed, Jan 18, 2012 at 05:52:25PM +0800, bill4carson at gmail.com wrote:
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
>>   	bic	r3, r1, #0x000003fc
>>   	bic	r3, r3, #PTE_TYPE_MASK
>>   	orr	r3, r3, r2
> I guess you want
>
> 	beq	set_pte
>
> instead of
>
> 	moveq	set_pte
>
> here?!
>
> Additionally this doesn't seem to be able to be compiled to thumb. I
> don't know if it must be though.
>
Hi Uwe

Thanks for your reply :) I compile with following thumb configuration
build and run on hardware board show nothing wrong on my side.
I am not aware of any other THUMB configuration, so could you give
me more information about your concern ?

iamroot at iamroot-OptiPlex-780:~/workbench/vm_zone/linux/linux-2.6$ cat 
.config | grep THUMB
CONFIG_ARM_THUMB=y
CONFIG_ARM_THUMBEE=y
CONFIG_THUMB2_KERNEL=y
CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11=y
CONFIG_XZ_DEC_ARMTHUMB=y


00000028 <cpu_v7_set_pte_ext>:
28: 6001 str r1, [r0, #0]
2a: f011 0f02 tst.w r1, #2
2e: bf12 itee ne
30: f011 0f01 tstne.w r1, #1
34: 2300 moveq r3, #0
36: e01d beq.n 74 <cpu_v7_set_pte_ext+0x4c>
38: f421 737c bic.w r3, r1, #1008 ; 0x3f0
3c: f023 0303 bic.w r3, r3, #3
40: ea43 0302 orr.w r3, r3, r2
44: f043 0312 orr.w r3, r3, #18
48: f011 0f10 tst.w r1, #16
4c: bf18 it ne
4e: f043 0340 orrne.w r3, r3, #64 ; 0x40
52: f081 0140 eor.w r1, r1, #64 ; 0x40
56: f011 0fc0 tst.w r1, #192 ; 0xc0
5a: bf18 it ne
5c: f443 7300 orrne.w r3, r3, #512 ; 0x200
60: f411 7f80 tst.w r1, #256 ; 0x100
64: bf18 it ne
66: f043 0320 orrne.w r3, r3, #32
6a: f411 7f00 tst.w r1, #512 ; 0x200
6e: bf18 it ne
70: f043 0301 orrne.w r3, r3, #1
74: f500 6000 add.w r0, r0, #2048 ; 0x800
78: 6003 str r3, [r0, #0]
7a: ee07 0f3a mcr 15, 0, r0, cr7, cr10, {1}
7e: 46f7 mov pc, lr



>> @@ -163,11 +167,7 @@
>>   	orrne	r3, r3, #PTE_EXT_XN
>>
>>   	orr	r3, r3, r2
>> -
>> -	tst	r1, #L_PTE_YOUNG
>> -	tstne	r1, #L_PTE_PRESENT
>> -	moveq	r3, #0
>> -
>> +set_pte:
> Best regards
> Uwe
>

-- 
I am a slow learner
but I will keep trying to fight for my dreams!

--bill
