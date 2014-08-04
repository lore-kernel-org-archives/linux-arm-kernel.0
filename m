From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 04 Aug 2014 16:22:39 -0700
Subject: [PATCH] irqchip: gic: Allow gic_arch_extn hooks to call into
 scheduler
In-Reply-To: <alpine.LFD.2.11.1408041858570.6061@knanqh.ubzr>
References: <1407191616-31829-1-git-send-email-sboyd@codeaurora.org>
 <alpine.LFD.2.11.1408041858570.6061@knanqh.ubzr>
Message-ID: <53E015BF.4060701@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/14 16:20, Nicolas Pitre wrote:
> On Mon, 4 Aug 2014, Stephen Boyd wrote:
>
>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>> index 7c131cf7cc13..824c1e2ac403 100644
>> --- a/drivers/irqchip/irq-gic.c
>> +++ b/drivers/irqchip/irq-gic.c
>> @@ -72,6 +72,8 @@ struct gic_chip_data {
>>  };
>>  
>>  static DEFINE_RAW_SPINLOCK(irq_controller_lock);
>> +/* Synchronize switching CPU interface and sending SGIs */
>> +static DEFINE_RAW_SPINLOCK(gic_sgi_lock);
> I'd suggest moving this below gic_cpu_map[] definition for the comment 
> block right above it to also apply to this lock.

Ok.

>
>>  
>>  /*
>>   * The GIC mapping of CPU interfaces does not necessarily match
>> @@ -658,7 +660,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>>  	int cpu;
>>  	unsigned long flags, map = 0;
>>  
>> -	raw_spin_lock_irqsave(&irq_controller_lock, flags);
>> +	raw_spin_lock_irqsave(&gic_sgi_lock, flags);
>>  
>>  	/* Convert our logical CPU mask into a physical one. */
>>  	for_each_cpu(cpu, mask)
>> @@ -673,7 +675,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>>  	/* this always happens on GIC0 */
>>  	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
>>  
>> -	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
>> +	raw_spin_unlock_irqrestore(&gic_sgi_lock, flags);
>>  }
>>  #endif
>>  
>> @@ -742,6 +744,7 @@ void gic_migrate_target(unsigned int new_cpu_id)
>>  	cur_target_mask = 0x01010101 << cur_cpu_id;
>>  	ror_val = (cur_cpu_id - new_cpu_id) & 31;
>>  
>> +	raw_spin_lock(&gic_sgi_lock);
>>  	raw_spin_lock(&irq_controller_lock);
> According to your call trace, you would now take irq_controller_lock and 
> then gic_sgi_lock.  Here you're doing it in the opposite order with an 
> AB-BA deadlock potential.  I'd suggest reversing them here.
>

Ah thanks. I guess I didn't see it on lockdep because this code never
runs. Actually I don't think we need to hold it across this piece of
code at all. See v2.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
