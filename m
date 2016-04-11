From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Apr 2016 09:52:27 -0600
Subject: [PATCH 4/4] irqchip: bcm2836: Use a more generic memory barrier
 call
In-Reply-To: <878u0l1fj0.fsf@eliezer.anholt.net>
References: <1459827858-3871-1-git-send-email-eric@anholt.net>
 <1459827858-3871-5-git-send-email-eric@anholt.net>
 <570497C7.10501@wwwdotorg.org> <87a8l40xox.fsf@eliezer.anholt.net>
 <5708927E.9030406@wwwdotorg.org> <878u0l1fj0.fsf@eliezer.anholt.net>
Message-ID: <570BC83B.4020106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2016 12:32 PM, Eric Anholt wrote:
> Stephen Warren <swarren@wwwdotorg.org> writes:
>
>> On 04/08/2016 12:20 PM, Eric Anholt wrote:
>>> Stephen Warren <swarren@wwwdotorg.org> writes:
>>>
>>>> On 04/04/2016 09:44 PM, Eric Anholt wrote:
>>>>> dsb() requires an argument on arm64, so we needed to add "sy".
>>>>> Instead, take this opportunity to switch to the same smp_wmb() call
>>>>> that gic uses for its IPIs.  This is a less strong barrier than we
>>>>> were doing before (dmb(ishst) compared to dsb(sy)), but it seems to be
>>>>> the correct one.
>>>>
>>>> I assume all MMIO is part of the ish domain?
>>>>
>>>> If so, the series,
>>>> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
>>>
>>> I don't know if this barrier implies ordering all the way out to AXI on
>>> this HW, but I don't think that's a requirement of this function.
>>
>> My understanding was that the barrier was explicitly to work around a
>> bug in the bus fabric of the SoC, and hence the barrier very much does
>> have to affect the transaction all the way out to AXI. Re-reading
>> BCM2835-ARM-Peripherals.pdf section 1.3 "Peripheral access precautions
>> for correct memory ordering" seems to confirm this.
>
> My understanding of the explicit barrier here, which was copied from
> other irqchips, is "Make sure that normal memory writes before our IPI
> on this CPU appear on the other CPUs before they get the IPI" (like the
> comment says).  This barrier was not put in to deal with the
> 283x-specific weird AXI behavior.
>
> Note that we had previously decided that the weird AXI ordering
> behavior, which is about repeated reads or repeated writes from the same
> CPU across different peripherals, is already covered by the barriers
> present in readl() and writel().  The writel() barrier happens to be a
> dsb() as well, so this explicit barrier is actually redundant.

Ah OK. In that case, the change seems fine.
