From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 06 Jun 2014 10:23:01 +0100
Subject: [RFC v3 4/9] irqchip: gic: Introduce shadow irqs for FIQ
In-Reply-To: <20140606074614.GU5961@tbergstrom-lnx.Nvidia.com>
References: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-5-git-send-email-daniel.thompson@linaro.org>
 <20140606074614.GU5961@tbergstrom-lnx.Nvidia.com>
Message-ID: <53918875.8070205@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/14 08:46, Peter De Schrijver wrote:
>> @@ -1037,17 +1076,28 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>>  			irq_base = irq_start;
>>  		}
>>  
>> -		gic->domain = irq_domain_add_legacy(node, gic_irqs, irq_base,
>> -					hwirq_base, &gic_irq_domain_ops, gic);
>> +		gic->domain =
>> +		    irq_domain_add_legacy(node, 2 * gic_irqs, irq_base,
>> +					  hwirq_base, &gic_irq_domain_ops, gic);
>>  	} else {
>> -		gic->domain = irq_domain_add_linear(node, nr_routable_irqs,
>> -						    &gic_irq_domain_ops,
>> -						    gic);
>> +		gic->domain = irq_domain_add_linear(node, 2 * nr_routable_irqs,
>> +						    &gic_irq_domain_ops, gic);
>>  	}
>>  
>>  	if (WARN_ON(!gic->domain))
>>  		return;
>>  
>> +#ifdef CONFIG_FIQ
>> +	/* FIQ can only be supported on platforms without an extended irq_eoi
>> +	 * method (otherwise we take a lock during irq_eoi handling).
>> +	 */
>> +	if (!gic_arch_extn.irq_eoi)
>> +		fiq_add_mapping(
>> +		    irq_linear_revmap(gic->domain, hwirq_base),
>> +		    irq_linear_revmap(gic->domain, hwirq_base + gic_irqs),
>> +		    gic_irqs);
>> +#endif
> 
> This is rather unfortunate. On Tegra for example we don't need a lock for the
> irq_eoi because the eoi ack can be handled with a single write to the
> appropriate irq ack register.

I believe that Tegra is the only platform that uses this hook so should
be safe to remove the locks from gic_irq_eoi().

Certainly looking back at the code history and the mailing list
discussions around this code[1] I cannot see any reasoning about the
locks that I have missed.

Any objections to just nuking the locks?


Daniel.


[1]
http://thread.gmane.org/gmane.linux.ports.arm.kernel/107474
http://thread.gmane.org/gmane.linux.ports.arm.kernel/108361
http://thread.gmane.org/gmane.linux.ports.arm.kernel/109690
