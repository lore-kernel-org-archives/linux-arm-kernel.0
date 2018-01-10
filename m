From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Wed, 10 Jan 2018 01:33:42 +0000
Subject: [PATCH v2 4/6] arm: Add icache invalidation on switch_mm for
 Cortex-A15
In-Reply-To: <a11193e5-0f0b-3280-e2b2-c0665676d230@gmail.com>
References: <20180108185533.9698-1-marc.zyngier@arm.com>
 <20180108185533.9698-5-marc.zyngier@arm.com>
 <a11193e5-0f0b-3280-e2b2-c0665676d230@gmail.com>
Message-ID: <3ab22cbc-76a2-01c6-d016-61bc874cd003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/18 01:28, Florian Fainelli wrote:
> On 01/08/2018 10:55 AM, Marc Zyngier wrote:
>> In order to avoid aliasing attacks against the branch predictor,
>> Cortex-A15 require to invalidate the BTB when switching
>> from one user context to another. The only way to do so on this
>> CPU is to perform an ICIALLU, having set ACTLR[0] to 1 from secure
>> mode.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
> 
> [snip]
> 
>> diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
>> index f6adfe88ead2..0a2245b309e5 100644
>> --- a/arch/arm/mm/proc-v7-3level.S
>> +++ b/arch/arm/mm/proc-v7-3level.S
>> @@ -71,6 +71,22 @@ ENTRY(cpu_v7_switch_mm)
>>  ENDPROC(cpu_v7_switch_mm)
>>  ENDPROC(cpu_v7_btbinv_switch_mm)
>>  
>> +/*
>> + *	Cortex-A15 requires ACTLR[0] to be set from secure in order
>> + *	for the icache invalidation to also invalidate the BTB.
> 
> Considering that writes are ignored when we don't have the correct
> permission level, how about set try to set this bit from the
> __v7_ca15mp_setup and __v7_b15mp_setup labels just like we are setting
> the SMP_EN bit for the poor bastards out there stuck with possibly
> frozen bootloaders/ATF?

Even when writes to ACTLR are allowed by secure world, this only
actually applies to the SMP bit:
ARM DDI0438H ARM Cortex-A15 TRM, 4.3.28 Auxiliary Control Register:
"-- Read/write in Non-secure PL1 and PL2 modes if NSACR.NS_SMP is 1. In
this case, all bits are write-ignored except for the SMP bit."

So: good idea, but no luck here :-(

Cheers,
Andre.
