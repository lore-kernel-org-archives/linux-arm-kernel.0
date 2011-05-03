From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 03 May 2011 15:44:53 +0530
Subject: [PATCH V3] ARM: GIC: Convert GIC library to use the IO relaxed
	operations
In-Reply-To: <1304417481.19196.60.camel@e102109-lin.cambridge.arm.com>
References: <1304058131-8375-1-git-send-email-santosh.shilimkar@ti.com>
	<1304417481.19196.60.camel@e102109-lin.cambridge.arm.com>
Message-ID: <4DBFD59D.50008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/3/2011 3:41 PM, Catalin Marinas wrote:
[...]

>> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
>> index e9c2ff8..80b3d3c 100644
>> --- a/arch/arm/common/gic.c
>> +++ b/arch/arm/common/gic.c
>> @@ -89,7 +89,8 @@ static void gic_mask_irq(struct irq_data *d)
>>          u32 mask = 1<<  (d->irq % 32);
>>
>>          spin_lock(&irq_controller_lock);
>> -       writel(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
>> +       writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
>> +       readl_relaxed(gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
>
> As I commented on the version 2 of this patch, I don't think we should
> even bother with the additional readl_relaxed() here. It's not enough to
> prevent spurious interrupts anyway.
>
I forgot to drop this one.


>> @@ -392,6 +393,7 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>>          unsigned long map = *cpus_addr(*mask);
>>
>>          /* this always happens on GIC0 */
>> -       writel(map<<  16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
>> +       dsb();
>> +       writel_relaxed(map<<  16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
>
> I would add a comment before the dsb() on why it is needed. Maybe something like:
>
> /*
>   * Ensure that stores to Normal memory are visible to the other CPUs before
>   * issuing the IPI.
>   */
>
>
> Otherwise the patch looks fine (I'll add my ack after you fix the above).
>
Thanks. Will add above comment, drop the readl and repost with your ack.

Same will push it the patch system

Regards
Santosh
