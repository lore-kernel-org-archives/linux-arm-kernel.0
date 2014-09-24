From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Wed, 24 Sep 2014 15:23:18 +0800
Subject: [RFC Part2 v1 01/21] irqdomain: Introduce new interfaces to
 support hierarchy irqdomains
In-Reply-To: <54226AE1.4000603@jp.fujitsu.com>
References: <1410444228-3134-1-git-send-email-jiang.liu@linux.intel.com>
 <1410444228-3134-2-git-send-email-jiang.liu@linux.intel.com>
 <54226AE1.4000603@jp.fujitsu.com>
Message-ID: <54227166.7010901@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2014/9/24 14:55, Yasuaki Ishimatsu wrote:
> (2014/09/11 23:03), Jiang Liu wrote:
>> +static void irq_domain_free_irq_data(unsigned int virq, unsigned int nr_irqs)
>> +{
>> +	int i;
>> +	struct irq_data *irq_data, *tmp;
>> +
>> +	for (i = 0; i < nr_irqs; i++) {
> 
>> +		irq_data = irq_get_irq_data(virq + i);
>> +		tmp = irq_data->parent_data;
> 
> Why don't you care NULL condition?
Yeah, there's an explicitly assumption that, irq_get_irq_data()
always return valid pointer once we have allocated the irq number
and associated irq_desc. If preferred, I will add a check here.

> 
>> +		irq_data->parent_data = NULL;
>> +		irq_data->domain = NULL;
>> +
>> +		while (tmp) {
>> +			irq_data = tmp;
>> +			tmp = tmp->parent_data;
>> +			kfree(irq_data);
>> +		}
>> +	}
>> +}
>> +
>> +static int irq_domain_alloc_irq_data(struct irq_domain *domain,
>> +				     unsigned int virq, unsigned int nr_irqs)
>> +{
>> +	int i;
>> +	struct irq_data *irq_data;
>> +	struct irq_domain *parent;
>> +
>> +	/* The outmost irq_data is embedded in struct irq_desc */
>> +	for (i = 0; i < nr_irqs; i++) {
> 
> 
>> +		irq_data = irq_get_irq_data(virq + i);
>> +		irq_data->domain = domain;
> 
> ditto.
Seems as above.
Regards!
Gerry

> 
> Thanks,
> Yasuaki Ishimatsu
> 
