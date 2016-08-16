From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 16 Aug 2016 15:51:05 +0100
Subject: [PATCH] kvm: arm: Enforce some NS-SVC initialisation
In-Reply-To: <57B31643.1000600@arm.com>
References: <5322cdb9cb397741d15b60c6693ad39dbf74b6d5.1469101945.git.robin.murphy@arm.com>
 <57B31643.1000600@arm.com>
Message-ID: <46b4e0f6-eb62-1748-6fed-04340331efa1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 16/08/16 14:33, Marc Zyngier wrote:
> On 21/07/16 13:01, Robin Murphy wrote:
>> Since the non-secure copies of banked registers lack architecturally
>> defined reset values, there is no actual guarantee when entering in Hyp
>> from secure-only firmware that the non-secure PL1 state will look the
>> way that kernel entry (in particular the decompressor stub) expects.
>> So far, we've been getting away with it thanks to implementation details
>> of ARMv7 cores and/or bootloader behaviour, but for the sake of forwards
>> compatibility let's try to ensure that we have a minimally sane state
>> before dropping down into it.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>  arch/arm/kernel/hyp-stub.S | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
>> index 0b1e4a93d67e..7de3fe15ab21 100644
>> --- a/arch/arm/kernel/hyp-stub.S
>> +++ b/arch/arm/kernel/hyp-stub.S
>> @@ -142,6 +142,18 @@ ARM_BE8(orr	r7, r7, #(1 << 25))     @ HSCTLR.EE
>>  	and	r7, #0x1f		@ Preserve HPMN
>>  	mcr	p15, 4, r7, c1, c1, 1	@ HDCR
>>  
>> +	@ Make sure NS-SVC is initialised appropriately
>> +	mrc	p15, 0, r7, c1, c0, 0	@ SCTLR
>> +	orr	r7, #(1 << 5)		@ CP15 barriers enabled
>> +	bic	r7, #(3 << 19)		@ WXN and UWXN disabled
> 
> I think that while you're doing this, you also may want to clear SED and
> ITD so that a BE kernel has a chance to survive its first instruction
> (assuming it it uses the decompressor...).

Good point; I wrote this from the v7 perspective and neglected those,
and I think I was actually trying to achieve something useful at the
time which precluded cracking out the big-endian Thumb-2 kernel ;)

>From a quick correlation between ARM ARMs, those bits should be reliably
safe to unconditionally clear on v7VE, so let's do it. I'll respin shortly.

>> +	mcr	p15, 0, r7, c1, c0, 0	@ SCTLR
>> +
>> +	mrc	p15, 0, r7, c0, c0, 0	@ MIDR
>> +	mcr	p15, 4, r7, c0, c0, 0	@ VPIDR
>> +
>> +	mrc	p15, 0, r7, c0, c0, 5	@ MPIDR
>> +	mcr	p15, 4, r7, c0, c0, 5	@ VMPIDR
>> +
>>  #if !defined(ZIMAGE) && defined(CONFIG_ARM_ARCH_TIMER)
>>  	@ make CNTP_* and CNTPCT accessible from PL1
>>  	mrc	p15, 0, r7, c0, c1, 1	@ ID_PFR1
>>
> 
> Otherwise looks good.

Cheers,
Robin.

> 
> Thanks,
> 
> 	M.
> 
