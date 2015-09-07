From: yangyingliang@huawei.com (Yang Yingliang)
Date: Mon, 7 Sep 2015 10:03:49 +0800
Subject: [RFC PATCH v1 2/4] irqchip: GICv3: set non-percpu irqs status
 with _IRQ_MOVE_PCNTXT
In-Reply-To: <55EBD59B.4030405@linux.intel.com>
References: <1441513421-8092-1-git-send-email-yangyingliang@huawei.com>
 <1441513421-8092-3-git-send-email-yangyingliang@huawei.com>
 <55EBD59B.4030405@linux.intel.com>
Message-ID: <55ECF085.7020708@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/9/6 13:56, Jiang Liu wrote:
> On 2015/9/6 12:23, Yang Yingliang wrote:
>> Use irq_settings_set_move_pcntxt() helper irqs status with
>> _IRQ_MOVE_PCNTXT. So that it can do set affinity when calling
>> irq_set_affinity_locked().
> Hi Yingliang,
> 	We could only set _IRQ_MOVE_PCNTCT flag to enable migrating
> IRQ in process context if your hardware platform supports atomically
> change IRQ configuration. Not sure whether that's true for GICv3.
> If GICv3 doesn't support atomically change irq configuration, this
> change may cause trouble.
> Thanks!
> Gerry

I am not certain sure if GICv3 supports it. But current code consider it 
as true default without CONFIG_GENERIC_PENDING_IRQ enable on arm.
Does Marc have any opinion ?

Thanks
Yang
>
>>
>> Cc: Jiang Liu <jiang.liu@linux.intel.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
>> Cc: Hanjun Guo <hanjun.guo@linaro.org>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/irqchip/irq-gic-v3.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index e406bc5..9108387 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -688,6 +688,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
>>   		irq_domain_set_info(d, irq, hw, &gic_chip, d->host_data,
>>   				    handle_fasteoi_irq, NULL, NULL);
>>   		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
>> +		irq_set_move_pcntxt(irq);
>>   	}
>>   	/* LPIs */
>>   	if (hw >= 8192 && hw < GIC_ID_NR) {
>> @@ -696,6 +697,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
>>   		irq_domain_set_info(d, irq, hw, &gic_chip, d->host_data,
>>   				    handle_fasteoi_irq, NULL, NULL);
>>   		set_irq_flags(irq, IRQF_VALID);
>> +		irq_set_move_pcntxt(irq);
>>   	}
>>
>>   	return 0;
>>
>
> .
>
