From: sramana@codeaurora.org (Srinivas Ramana)
Date: Tue, 27 Sep 2016 17:46:44 +0530
Subject: [PATCH] ARM: decompressor: reset ttbcr fields to use TTBR0 on
 ARMv7
In-Reply-To: <57D812A7.6040905@codeaurora.org>
References: <57D3C06D.4030908@codeaurora.org>
 <1473663420-18629-1-git-send-email-sramana@codeaurora.org>
 <7608c508-0537-267c-0cdf-6995445b811e@arm.com>
 <57D812A7.6040905@codeaurora.org>
Message-ID: <57EA632C.3000208@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 09/13/2016 08:22 PM, Srinivas Ramana wrote:
> On 09/12/2016 11:21 PM, Robin Murphy wrote:
>> On 12/09/16 07:57, Srinivas Ramana wrote:
>>> If the bootloader uses the long descriptor format and jumps to
>>> kernel decompressor code, TTBCR may not be in a right state.
>>> Before enabling the MMU, it is required to clear the TTBCR.PD0
>>> field to use TTBR0 for translation table walks.
>>>
>>> The 'commit dbece45894d3a ("ARM: 7501/1: decompressor:
>>> reset ttbcr for VMSA ARMv7 cores")' does the reset of TTBCR.N, but
>>> doesn't consider all the bits for the size of TTBCR.N.
>>>
>>> Clear TTBCR.PD0 field and reset all the three bits of TTBCR.N to
>>> indicate the use of TTBR0 and the correct base address width.
>>>
>>> Signed-off-by: Srinivas Ramana <sramana@codeaurora.org>
>>> ---
>>>   arch/arm/boot/compressed/head.S | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/compressed/head.S
>>> b/arch/arm/boot/compressed/head.S
>>> index af11c2f8f3b7..fc6d541549a2 100644
>>> --- a/arch/arm/boot/compressed/head.S
>>> +++ b/arch/arm/boot/compressed/head.S
>>> @@ -779,7 +779,7 @@ __armv7_mmu_cache_on:
>>>           orrne    r0, r0, #1        @ MMU enabled
>>>           movne    r1, #0xfffffffd        @ domain 0 = client
>>>           bic     r6, r6, #1 << 31        @ 32-bit translation system
>>
>> Hmm, if TTBCR.EAE _was_ actually set...
>>
>>> -        bic     r6, r6, #3 << 0         @ use only ttbr0
>>> +        bic     r6, r6, #(7 << 0) | (1 << 4)    @ use only ttbr0
>>>           mcrne    p15, 0, r3, c2, c0, 0    @ load page table pointer
>>>           mcrne    p15, 0, r1, c3, c0, 0    @ load domain access control
>>>           mcrne   p15, 0, r6, c2, c0, 2   @ load ttb control
>>
>> ...then strictly the TLBIALL needs to happen after the ISB following
>> this update. Otherwise per B3.10.2 of DDI406C.c I think we might be into
>> unpredictable territory - i.e. if the TLB happens to treat long- and
>> short-descriptor entries differently then the TLBI beforehand (with EAE
>> set) may be at liberty to only discard long-descriptor entries and leave
>> bogus short-descriptor entries sitting around.
> Yes, it seems this has to be taken care of, along with resetting
> TTBCR.PD0 and TTBCR.N. Do you say that this needs to be done in the same
> patch or a different one?
>>
>> In other words, something like (completely untested):
>>
>> ---8<---
>> diff --git a/arch/arm/boot/compressed/head.S
>> b/arch/arm/boot/compressed/head.S
>> index af11c2f8f3b7..536b7781024a 100644
>> --- a/arch/arm/boot/compressed/head.S
>> +++ b/arch/arm/boot/compressed/head.S
>> @@ -764,7 +764,6 @@ __armv7_mmu_cache_on:
>>                  mov     r0, #0
>>                  mcr     p15, 0, r0, c7, c10, 4  @ drain write buffer
>>                  tst     r11, #0xf               @ VMSA
>> -               mcrne   p15, 0, r0, c8, c7, 0   @ flush I,D TLBs
>
> Shouldn't this be still there for the same reason you explained above? I
> mean to discard the long descriptor entries when EAE was 1 (before we
> reset it).
>>   #endif
>>                  mrc     p15, 0, r0, c1, c0, 0   @ read control reg
>>                  bic     r0, r0, #1 << 28        @ clear SCTLR.TRE
>> @@ -783,8 +782,11 @@ __armv7_mmu_cache_on:
>>                  mcrne   p15, 0, r3, c2, c0, 0   @ load page table
>> pointer
>>                  mcrne   p15, 0, r1, c3, c0, 0   @ load domain access
>> control
>>                  mcrne   p15, 0, r6, c2, c0, 2   @ load ttb control
>> -#endif
>>                  mcr     p15, 0, r0, c7, c5, 4   @ ISB
>> +               mcrne   p15, 0, r0, c8, c7, 0   @ flush I,D TLBs
>> +#else
>> +               mcr     p15, 0, r0, c7, c5, 4   @ ISB
>> +#endif
>>                  mcr     p15, 0, r0, c1, c0, 0   @ load control register
>>                  mrc     p15, 0, r0, c1, c0, 0   @ and read it back
>> ---8<---
>>
>> Robin.
>>
> i have tested this change (flush I, D, TLBs after TTB control is
> written) and don't see any issue. But on my setup decompression is
> successful even without this (probably not hitting the case in discussion).
>
>
> Thanks,
> -- Srinivas R
>

Would like your feedback on the above. Can we get the TTBCR fix merged 
first?(will send final patch with Russell Kings comments fixed)

For testing the TLB flush change we may have to check if we can create a 
failure case.

Thanks,
-- Srinivas R

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative 
Project.
