From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 8 Apr 2016 23:26:22 -0600
Subject: [PATCH 4/4] irqchip: bcm2836: Use a more generic memory barrier
 call
In-Reply-To: <87a8l40xox.fsf@eliezer.anholt.net>
References: <1459827858-3871-1-git-send-email-eric@anholt.net>
 <1459827858-3871-5-git-send-email-eric@anholt.net>
 <570497C7.10501@wwwdotorg.org> <87a8l40xox.fsf@eliezer.anholt.net>
Message-ID: <5708927E.9030406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2016 12:20 PM, Eric Anholt wrote:
> Stephen Warren <swarren@wwwdotorg.org> writes:
>
>> On 04/04/2016 09:44 PM, Eric Anholt wrote:
>>> dsb() requires an argument on arm64, so we needed to add "sy".
>>> Instead, take this opportunity to switch to the same smp_wmb() call
>>> that gic uses for its IPIs.  This is a less strong barrier than we
>>> were doing before (dmb(ishst) compared to dsb(sy)), but it seems to be
>>> the correct one.
>>
>> I assume all MMIO is part of the ish domain?
>>
>> If so, the series,
>> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
>
> I don't know if this barrier implies ordering all the way out to AXI on
> this HW, but I don't think that's a requirement of this function.

My understanding was that the barrier was explicitly to work around a 
bug in the bus fabric of the SoC, and hence the barrier very much does 
have to affect the transaction all the way out to AXI. Re-reading 
BCM2835-ARM-Peripherals.pdf section 1.3 "Peripheral access precautions 
for correct memory ordering" seems to confirm this.
