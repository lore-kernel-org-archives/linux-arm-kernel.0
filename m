From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Jul 2018 13:20:54 +0100
Subject: Does the driver need check the GICD_ACTIVE or GICD_PENDING state
 before SPI affinity changing
In-Reply-To: <5B45CA9B.8020602@huawei.com>
References: <5B45CA9B.8020602@huawei.com>
Message-ID: <2d67e9d3-26af-4565-09af-1649ef9e46af@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yang,

On 11/07/18 10:15, Yang Yingliang wrote:
> Hi Marc,
> 
> The following case :
> 
>             cpu0           cpu1                          cpu2
>            read iar
>                            set affinity to cpu2
>             dsb(sy)                                       read iar
> 
> cpu0 is interrupted by a edge-SPI. After cpu0 getting INTID,
> cpu1 set SPI's affinity to another cpu(like cpu2), if the effects
> of reading ICC_IAR1_EL1 on the state of a returned INTID are
> not seeing by GIC, the SPI's state is still pending and the state
> will be migrated to cpu2, so cpu2 can also read the INTID from
> ICC_IAR1_EL1. It makes the SPI be handled twice.
> 
> Does the driver need check the GICD_ACTIVE or GICD_PENDING
> state before SPI affinity changing or should hardware guarantee
> this case can't happen ?

Checking GICD_ACTIVE is racy (you may not see it active at the
distributor level if you check between cpu0 read and dsb), and so is
GICD_PENDING (you could receive an interrupt right after checking).

The GICv3 spec has the following note for GICR_IROUTERn updates:

<quote>
Implementations must ensure that an interrupt that is pending at the
time of the write uses either the old value or the new value and must
ensure that the interrupt is neither lost nor handled more than once.
The effect of the change must be visible in finite time.
</quote>

The "nor handled more than once" covers the above, and clearly states
that an interrupt cannot be delivered twice like in your example.

> Does GIC SPEC have describe the affinity chaning flow ?

Not really. The GICD_IROUTERn registers have no particular restriction
in that respect, and are free to be used at any time.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
