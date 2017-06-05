From: hoeun.ryu@gmail.com (Hoeun Ryu)
Date: Mon, 5 Jun 2017 20:06:47 +0900
Subject: [PATCHv2] arm: LPAE: kexec: clear TTBCR.T1SZ explicitly when
 PHYS_OFFSET > PAGE_OFFSET
In-Reply-To: <bb00a038-b6b8-2da9-7b16-0c2ea96a44b5@arm.com>
References: <1496657199-29589-1-git-send-email-hoeun.ryu@gmail.com>
 <bb00a038-b6b8-2da9-7b16-0c2ea96a44b5@arm.com>
Message-ID: <E0350890-B097-4816-9B8A-CD07A7F11B6D@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> On Jun 5, 2017, at 7:30 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> 
>> On 05/06/17 11:06, Hoeun Ryu wrote:
>> Clearing TTBCR.T1SZ explicitly when kernel runs on a configuration of
>> PHYS_OFFSET > PAGE_OFFSET.
>> Reading TTBCR in early boot stage might returns the value of the
>> previous kernel's configuration, especially in case of kexec. For
>> example, if normal kernel (first kernel) had run on a configuration
>> of PHYS_OFFSET <= PAGE_OFFSET and crash kernel (second kernel) is
>> running on a configuration PHYS_OFFSET > PAGE_OFFSET, which can happen
>> because it depends on the reserved area for crash kernel, reading
>> TTBCR and using the value without clearing TTBCR.T1SZ might risky
>> because the value doesn't have a reset value for TTBCR.T1SZ.
> 
> Hmm, but isn't that also strictly true of all the other fields we're
> ORing TTB_FLAGS_* into? Given that this is initial setup, I wonder
> whether we need to care about the previous TTBCR value at all - is there
> any reason for not simply building up the value we want from scratch?

Your idea seems better.
I'll send a new patch to build TTBCR from scratch without reading it for the initial value.

Russell, do you have any opinion ?

Thank toy for the review.

> 
> Robin.
> 
>> Signed-off-by: Hoeun Ryu <hoeun.ryu@gmail.com>
>> ---
>> arch/arm/mm/proc-v7-3level.S | 1 +
>> 1 file changed, 1 insertion(+)
>> 
>> diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
>> index 5e5720e..81404b8 100644
>> --- a/arch/arm/mm/proc-v7-3level.S
>> +++ b/arch/arm/mm/proc-v7-3level.S
>> @@ -140,6 +140,7 @@ ENDPROC(cpu_v7_set_pte_ext)
>>    * otherwise booting secondary CPUs would end up using TTBR1 for the
>>    * identity mapping set up in TTBR0.
>>    */
>> +    bichi    \tmp, \tmp, #(7 << 16)                @ clear TTBCR.T1SZ
>>   orrls    \tmp, \tmp, #TTBR1_SIZE                @ TTBCR.T1SZ
>>   mcr    p15, 0, \tmp, c2, c0, 2                @ TTBCR
>>   mov    \tmp, \ttbr1, lsr #20
> 
