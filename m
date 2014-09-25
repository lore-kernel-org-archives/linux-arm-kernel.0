From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Thu, 25 Sep 2014 11:04:37 +0800
Subject: [PATCH] [RFC] Using hierarchy irqdomian to implement MTK intpol.
In-Reply-To: <1411611417.21763.56.camel@mtksdaap41>
References: <1411574696-1881-1-git-send-email-srv_yingjoe.chen@mediatek.com>
 <1411611417.21763.56.camel@mtksdaap41>
Message-ID: <54238645.8090502@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,
	Thanks, I will merge them into my next version.
Regards!
Gerry

On 2014/9/25 10:16, Joe.C wrote:
> 
> Jiang,
> 
> Please consider merge the following 2 changes into your next round.
> 
> On Thu, 2014-09-25 at 00:04 +0800, Joe.C wrote:
>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>> index e285f3a..01e852b 100644
>> --- a/kernel/irq/irqdomain.c
>> +++ b/kernel/irq/irqdomain.c
>> @@ -467,7 +467,7 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
>>  	struct irq_domain *domain;
>>  	irq_hw_number_t hwirq;
>>  	unsigned int type = IRQ_TYPE_NONE;
>> -	unsigned int virq;
>> +	int virq;
>>  
>>  	domain = irq_data->np ? irq_find_host(irq_data->np) : irq_default_domain;
>>  	if (!domain) {
>> @@ -493,8 +493,8 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
>>  	else
>>  #endif
>>  		virq = irq_create_mapping(domain, hwirq);
>> -	if (!virq)
>> -		return virq;
>> +	if (virq <= 0)
>> +		return 0;
>>  
>>  	/* Set type if specified and different than the current one */
>>  	if (type != IRQ_TYPE_NONE &&
> 
> irq_of_parse_and_map()/of_irq_to_resource() expect
> irq_create_of_mapping() to return 0 when fail. Return error code will
> cause of_irq_to_resource crash.
> 
> 
>> @@ -716,20 +716,20 @@ const struct irq_domain_ops irq_domain_simple_ops = {
>>  };
>>  EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
>>  
>> -static int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
>> +static int irq_domain_alloc_descs(int virq, unsigned int cnt,
>>  				  irq_hw_number_t hwirq, int node)
>>  {
>>  	unsigned int hint;
>>  
>>  	if (virq >= 0) {
>> -		virq = irq_alloc_descs(virq, virq, nr_irqs, node);
>> +		virq = irq_alloc_descs(virq, virq, cnt, node);
>>  	} else {
>>  		hint = hwirq % nr_irqs;
>>  		if (hint == 0)
>>  			hint++;
>> -		virq = irq_alloc_descs_from(hint, nr_irqs, node);
>> +		virq = irq_alloc_descs_from(hint, cnt, node);
>>  		if (virq <= 0 && hint > 1)
>> -			virq = irq_alloc_descs_from(1, nr_irqs, node);
>> +			virq = irq_alloc_descs_from(1, cnt, node);
>>  	}
>>  
>>  	return virq;
> 
> This come from irq_create_mapping(), the original code is using global
> nr_irqs. Change to match original behavior.
> 
> Joe.C
> 
> 
