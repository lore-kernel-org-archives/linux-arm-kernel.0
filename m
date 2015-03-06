From: wuyun.wu@huawei.com (Yun Wu (Abel))
Date: Fri, 6 Mar 2015 09:34:53 +0800
Subject: [PATCH v3 5/5] irqchip: gicv3-its: support safe initialization
In-Reply-To: <54F8468D.7090902@arm.com>
References: <1425439098-10708-1-git-send-email-wuyun.wu@huawei.com>
 <1425439098-10708-6-git-send-email-wuyun.wu@huawei.com>
 <54F8468D.7090902@arm.com>
Message-ID: <54F9043D.2060706@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/5 20:05, Marc Zyngier wrote:

> On 04/03/15 03:18, Yun Wu wrote:
>> It's unsafe to change the configurations of an activated ITS directly
>> since this will lead to unpredictable results. This patch guarantees
>> the ITSes being initialized are quiescent.
>>
>> Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index d13c24e..9e09aa0 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1320,6 +1320,34 @@ static const struct irq_domain_ops its_domain_ops = {
>>  	.deactivate		= its_irq_domain_deactivate,
>>  };
>>
>> +static int its_check_quiesced(void __iomem *base)
> 
> Another nitpick: Rather than "its_check_quiesced", how about
> "its_force_quiescent" instead? Because this does a lot more than just
> checking.

Yes, indeed.

> 
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
>> +	while (1) {
>> +		val = readl_relaxed(base + GITS_CTLR);
>> +		if (val & GITS_CTLR_QUIESCENT)
>> +			return 0;
>> +
>> +		count--;
>> +		if (!count)
>> +			return -EBUSY;
>> +
>> +		cpu_relax();
>> +		udelay(1);
>> +	}
>> +}
>> +
> 
> I still dislike this repeated pattern, but I don't have a good solution
> so far.

Me too.

> 
>>  static int its_probe(struct device_node *node, struct irq_domain *parent)
>>  {
>>  	struct resource res;
>> @@ -1348,6 +1376,13 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
>>  		goto out_unmap;
>>  	}
>>
>> +	err = its_check_quiesced(its_base);
>> +	if (err) {
>> +		pr_warn("%s: failed to quiesce, giving up\n",
>> +			node->full_name);
>> +		goto out_unmap;
>> +	}
>> +
>>  	pr_info("ITS: %s\n", node->full_name);
>>
>>  	its = kzalloc(sizeof(*its), GFP_KERNEL);
>> --
>> 1.8.0
>>
>>
>>
> 
> Assuming you fix the above nitpick:
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 

Thanks,
	Abel
