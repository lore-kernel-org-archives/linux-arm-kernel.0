From: yangyingliang@huawei.com (Yang Yingliang)
Date: Tue, 15 Sep 2015 11:07:33 +0800
Subject: [RFC PATCH v2 1/3] irqchip: GICv3: set non-percpu irqs status
 with IRQ_MOVE_PCNTXT
In-Reply-To: <55F6C2B2.2060808@arm.com>
References: <1442222945-10628-1-git-send-email-yangyingliang@huawei.com>
 <1442222945-10628-2-git-send-email-yangyingliang@huawei.com>
 <55F6C2B2.2060808@arm.com>
Message-ID: <55F78B75.1020105@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/9/14 20:50, Marc Zyngier wrote:
> On 14/09/15 10:29, Yang Yingliang wrote:
>> Use irq_set_status_flags() helper set irqs status with
>> IRQ_MOVE_PCNTXT. So that it can do set affinity when
>> calling irq_set_affinity_locked().
>>
>> Cc: Jiang Liu <jiang.liu@linux.intel.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/irqchip/irq-gic-v3.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 7deed6e..3d8f400 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -761,6 +761,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
>>   		irq_domain_set_info(d, irq, hw, chip, d->host_data,
>>   				    handle_fasteoi_irq, NULL, NULL);
>>   		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
>> +		irq_set_status_flags(irq, IRQ_MOVE_PCNTXT);
>>   	}
>>   	/* LPIs */
>>   	if (hw >= 8192 && hw < GIC_ID_NR) {
>> @@ -769,6 +770,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
>>   		irq_domain_set_info(d, irq, hw, chip, d->host_data,
>>   				    handle_fasteoi_irq, NULL, NULL);
>>   		set_irq_flags(irq, IRQF_VALID);
>> +		irq_set_status_flags(irq, IRQ_MOVE_PCNTXT);
>>   	}
>>
>>   	return 0;
>>
>
> I'm still not keen on this approach. As far as I can tell, the only
> reason you are setting this flag is to be able to use
> GENERIC_PENDING_IRQ. irq_set_affinity_locked would work even if you
> don't select this config option, because irq_can_move_pcntxt() will
> always return true if this is not selected.
>
> So instead of adding flags that are not required on ARM, why don't you
> just make migration.c to compile even when GENERIC_PENDING_IRQ is not
> selected? I think this would make a lot more sense.

OK, I will try this way.

Thanks,
Yang
>
> Thanks,
>
> 	M.
>
