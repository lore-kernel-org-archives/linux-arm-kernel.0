From: nerv@dawncrow.de (=?UTF-8?B?QW5kcsOpIEhlbnRzY2hlbA==?=)
Date: Tue, 16 Jul 2013 21:27:11 +0200
Subject: arm: Only load TLS values when needed
In-Reply-To: <51E5836B.1010904@arm.com>
References: <51E42E11.1010903@dawncrow.de> <51E5836B.1010904@arm.com>
Message-ID: <51E59E8F.1060501@dawncrow.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,
First, thank you for your review.

Am 16.07.2013 19:31, schrieb Jonathan Austin:
> Hi Andr?,
> 
> On 15/07/13 18:14, Andr? Hentschel wrote:
>> From: Andr? Hentschel <nerv@dawncrow.de>
>>
>> This patch intents to reduce loading instructions when the resulting value is not used.
>> It's a follow up on a4780adeefd042482f624f5e0d577bf9cdcbb760
>>
> 
> Have you done any benchmarking to see that this has any real impact? Or tested on a !Vv6k system? It looks possible that the only case where this will perform better is where we're using switch_tls_none or switch_tls_software (both rare cases, I think) and there's some change it will make things worse in other cases?

I have to admit that i only tested it on v6k and did no benchmark.

> One of the reasons for Russell's suggestion of placing the ldrd (which became the two ldr instructions you've removed from __switch_to, in order to maintain building for older cores) where it is was in order to reduce the chance of pipeline stalls.
> 
> As I've pointed out below, there is some risk that changing that has implications for the v6 only case below (and the v6k case is now more prone to stalls with !CONFIG_CPU_USE_DOMAINS, but newer cores should have more advanced scheduling to avoid such issues anyway...)

I'm not sure how this could make things worse on v6k, could you elaborate please?
Besides of the ldr and str being too close to each other i thought this patch is a good idea, because it removes two ldr which are always executed.
(Continuing below...)

>> Signed-off-by: Andr? Hentschel <nerv@dawncrow.de>
>>
>> ---
>> This patch is against Linux 3.11-rc1 (ad81f0545ef01ea651886dddac4bef6cec930092)
>>
>> Thanks to everyone who helped me with a4780adeefd042482f624f5e0d577bf9cdcbb760
>>
>> diff --git a/arch/arm/include/asm/tls.h b/arch/arm/include/asm/tls.h
>> index 83259b8..3742722 100644
>> --- a/arch/arm/include/asm/tls.h
>> +++ b/arch/arm/include/asm/tls.h
>> @@ -3,29 +3,32 @@
>>
>>   #ifdef __ASSEMBLY__
>>   #include <asm/asm-offsets.h>
>> -    .macro switch_tls_none, base, tp, tpuser, tmp1, tmp2
>> +    .macro switch_tls_none, prev, next, tp, tpuser, tmp1, tmp2
>>       .endm
>>
>> -    .macro switch_tls_v6k, base, tp, tpuser, tmp1, tmp2
>> +    .macro switch_tls_v6k, prev, next, tp, tpuser, tmp1, tmp2
>> +    ldrd    \tp, \tpuser, [\next, #TI_TP_VALUE]    @ get the next TLS and user r/w register
>>       mrc    p15, 0, \tmp2, c13, c0, 2    @ get the user r/w register
>>       mcr    p15, 0, \tp, c13, c0, 3        @ set TLS register
>>       mcr    p15, 0, \tpuser, c13, c0, 2    @ and the user r/w register
>> -    str    \tmp2, [\base, #TI_TP_VALUE + 4] @ save it
>> +    str    \tmp2, [\prev, #TI_TP_VALUE + 4] @ save it
>>       .endm
>>
>> -    .macro switch_tls_v6, base, tp, tpuser, tmp1, tmp2
>> +    .macro switch_tls_v6, prev, next, tp, tpuser, tmp1, tmp2
>>       ldr    \tmp1, =elf_hwcap
>>       ldr    \tmp1, [\tmp1, #0]
>>       mov    \tmp2, #0xffff0fff
>> +    ldr    \tp, [\next, #TI_TP_VALUE]    @ get the next TLS register
>>       tst    \tmp1, #HWCAP_TLS        @ hardware TLS available?
>>       streq    \tp, [\tmp2, #-15]        @ set TLS value at 0xffff0ff0
>> -    mrcne    p15, 0, \tmp2, c13, c0, 2    @ get the user r/w register
>> +    mrcne    p15, 0, \tmp2, c13, c0, 2    @ get the previous user r/w register
>> +    ldrne    \tpuser, [\next, #TI_TP_VALUE + 4]    @ get the next user r/w register
>>       mcrne    p15, 0, \tp, c13, c0, 3        @ yes, set TLS register
>>       mcrne    p15, 0, \tpuser, c13, c0, 2    @ set user r/w register
> 
> Now we've only got one instruction between the store and the load and risk stalling the pipeline...
> 
> Dave M cautiously says "The ancient advice was that one instruction was enough" but this is very core dependent... I wonder if anyone has a good idea about whether this is an issue here...?

We could use a ldrd at the top, that'd be nearly what we have right now, don't we?
