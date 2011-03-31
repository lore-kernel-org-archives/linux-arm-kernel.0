From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 31 Mar 2011 19:52:01 +0530
Subject: [RFC PATCH] ARM: GIC: Convert GIC library to use the IO relaxed
	operations
In-Reply-To: <1301580231.10659.142.camel@e102109-lin.cambridge.arm.com>
References: <1301576121-10858-1-git-send-email-santosh.shilimkar@ti.com>
	<1301580231.10659.142.camel@e102109-lin.cambridge.arm.com>
Message-ID: <4D948E09.3050900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/31/2011 7:33 PM, Catalin Marinas wrote:
> On Thu, 2011-03-31 at 13:55 +0100, Santosh Shilimkar wrote:
>> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
>> index f70ec7d..e013f65 100644
>> --- a/arch/arm/common/gic.c
>> +++ b/arch/arm/common/gic.c
>> @@ -89,7 +89,9 @@ static void gic_ack_irq(struct irq_data *d)
>>          spin_lock(&irq_controller_lock);
>>          if (gic_arch_extn.irq_ack)
>>                  gic_arch_extn.irq_ack(d);
>> -       writel(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
>> +       writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
>> +       barrier();
>> +       readl_relaxed(gic_cpu_base(d) + GIC_CPU_EOI);
>
> We don't need the explicit barrier(), I don't think the compiler would
> reorder the writel/readl_relaxed calls. The same for all places where
> you added barrier().
>
Ok. I added it to just avoid any compiler re-ordering.

> Do we need the acknowledge to be confirmed via a readl?
I was not sure here. Though we should ensure that the write
has reached to CPU interface.

>
>>          spin_unlock(&irq_controller_lock);
>>   }
>>
>> @@ -98,7 +100,9 @@ static void gic_mask_irq(struct irq_data *d)
>>          u32 mask = 1<<  (d->irq % 32);
>>
>>          spin_lock(&irq_controller_lock);
>> -       writel(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
>> +       writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
>> +       barrier();
>> +       readl_relaxed(gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
>>          if (gic_arch_extn.irq_mask)
>>                  gic_arch_extn.irq_mask(d);
>>          spin_unlock(&irq_controller_lock);
>
> Here we need a readl back in case the calling code enables the
> interrupts at the CPU level (that's probably the only place where we
> need a read back?).
>
Ok.

>> @@ -111,7 +115,9 @@ static void gic_unmask_irq(struct irq_data *d)
>>          spin_lock(&irq_controller_lock);
>>          if (gic_arch_extn.irq_unmask)
>>                  gic_arch_extn.irq_unmask(d);
>> -       writel(mask, gic_dist_base(d) + GIC_DIST_ENABLE_SET + (gic_irq(d) / 32) * 4);
>> +       writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_SET + (gic_irq(d) / 32) * 4);
>> +       barrier();
>> +       readl_relaxed(gic_dist_base(d) + GIC_DIST_ENABLE_SET + (gic_irq(d) / 32) * 4);
>>          spin_unlock(&irq_controller_lock);
>>   }
>
> We don't need a read back, just let it unmask the interrupt at some
> point in the future.
>
Ok. Will drop this read back then.

>> @@ -392,6 +399,8 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>>          unsigned long map = *cpus_addr(*mask);
>>
>>          /* this always happens on GIC0 */
>> -       writel(map<<  16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
>> +       writel_relaxed(map<<  16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
>> +       barrier();
>> +       readl_relaxed(gic_data[0].dist_base + GIC_DIST_SOFTINT);
>>   }
>
> We don't need the readl.
>
And this one too.
