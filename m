From: wuyun.wu@huawei.com (Yun Wu (Abel))
Date: Tue, 17 Feb 2015 18:15:15 +0800
Subject: [PATCH v2 5/6] irqchip: gicv3-its: add support for power down
In-Reply-To: <20150217092935.1fefcb24@arm.com>
References: <1423992723-5028-1-git-send-email-wuyun.wu@huawei.com>
 <1423992723-5028-6-git-send-email-wuyun.wu@huawei.com>
 <20150217092935.1fefcb24@arm.com>
Message-ID: <54E314B3.40803@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/2/17 17:29, Marc Zyngier wrote:

> On Sun, 15 Feb 2015 09:32:02 +0000
> Yun Wu <wuyun.wu@huawei.com> wrote:
> 
>> It's unsafe to change the configurations of an activated ITS directly
>> since this will lead to unpredictable results. This patch guarantees
>> a safe quiescent status before initializing an ITS.
> 
> Please change the title of this patch to reflect what it actually
> does. Nothing here is about powering down anything.

My miss, I will fix this in next version.

> 
>> Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 32
>> ++++++++++++++++++++++++++++++++ 1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c
>> b/drivers/irqchip/irq-gic-v3-its.c index 42c03b2..29eb665 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1321,6 +1321,31 @@ static const struct irq_domain_ops
>> its_domain_ops = { .deactivate		=
>> its_irq_domain_deactivate, };
>>
>> +static int its_check_quiesced(void __iomem *base)
>> +{
>> +	u32 count = 1000000;	/* 1s */
>> +	u32 val;
>> +
>> +	val = readl_relaxed(base + GITS_CTLR);
>> +	if (val & GITS_CTLR_QUIESCENT)
>> +		return 0;
>> +
>> +	/* Disable the generation of all interrupts to this ITS */
>> +	val &= ~GITS_CTLR_ENABLE;
>> +	writel_relaxed(val, base + GITS_CTLR);
>> +
>> +	/* Poll GITS_CTLR and wait until ITS becomes quiescent */
>> +	while (count--) {
>> +		val = readl_relaxed(base + GITS_CTLR);
>> +		if (val & GITS_CTLR_QUIESCENT)
>> +			return 0;
>> +		cpu_relax();
>> +		udelay(1);
>> +	}
> 
> You're now introducing a third variant of a 1s timeout loop. Notice a
> pattern?
> 

I am not sure I know exactly what you suggest. Do you mean I should code
like below to keep the coding style same as the other 2 loops?

	while (1) {
		val = readl_relaxed(base + GITS_CTLR);
		if (val & GITS_CTLR_QUIESCENT)
			return 0;

		count--;
		if (!count)
			return -EBUSY;

		cpu_relax();
		udelay(1);
	}

Thanks,
	Abel
