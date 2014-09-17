From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Wed, 17 Sep 2014 13:16:23 +0800
Subject: [RFC Part2 v1 14/21] x86,
 hpet: Enhance HPET IRQ to support hierarchy irqdomain
In-Reply-To: <alpine.DEB.2.10.1409161104120.4247@nanos>
References: <1410444228-3134-1-git-send-email-jiang.liu@linux.intel.com>
 <1410444228-3134-15-git-send-email-jiang.liu@linux.intel.com>
 <alpine.DEB.2.10.1409161104120.4247@nanos>
Message-ID: <54191927.2040102@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2014/9/17 2:31, Thomas Gleixner wrote:
> On Thu, 11 Sep 2014, Jiang Liu wrote:
>>  #ifdef CONFIG_HPET_TIMER
>> +#define	HPET_DOMAIN_REMAPPED		0x80000000
>> +
>> +static inline int hpet_dev_id(struct irq_domain *domain)
>> +{
>> +	return (int)((long)domain->host_data & ~HPET_DOMAIN_REMAPPED);
>> +}
>> +
>> +static inline bool hpet_remapped(struct irq_domain *domain)
>> +{
>> +	return (bool)((long)domain->host_data & HPET_DOMAIN_REMAPPED);
>> +}
> 
> It's kinda odd to have this encoded in domain->host_data.
Hi Thomas,
	I have thought about add a "domain_flags" field to struct
irq_domain to host the remapping flag. But remapping flag is not a
common flag for all architectures, so I adopted the dirty solution
to hide the remapped flag in x86 arch specific code.
How about adding domain_flags field and define IRQ_DOMAIN_FLAG_ARCH1?

> 
>>  static int hpet_msi_set_affinity(struct irq_data *data,
>>  				 const struct cpumask *mask, bool force)
>>  {
>> +	struct irq_data *parent = data->parent_data;
>>  	struct irq_cfg *cfg = irqd_cfg(data);
>>  	struct msi_msg msg;
>> -	unsigned int dest;
>>  	int ret;
>>  
>> -	ret = apic_set_affinity(data, mask, &dest);
>> -	if (ret)
>> -		return ret;
>> -
>> -	hpet_msi_read(data->handler_data, &msg);
>> -
>> -	msg.data &= ~MSI_DATA_VECTOR_MASK;
>> -	msg.data |= MSI_DATA_VECTOR(cfg->vector);
>> -	msg.address_lo &= ~MSI_ADDR_DEST_ID_MASK;
>> -	msg.address_lo |= MSI_ADDR_DEST_ID(dest);
>> -
>> -	hpet_msi_write(data->handler_data, &msg);
>> +	ret = parent->chip->irq_set_affinity(parent, mask, force);
>> +	/* No need to rewrite HPET registers if interrupt is remapped */
>> +	if (ret >= 0 && !hpet_remapped(data->domain)) {
> 
> So we really should use irq_data->chip_data for this, i.e. storing
> 
> struct hpet_msi {
>        struct msi_msg msg;
>        bool remapped;
>        /* whatever you need here */
> };
OK, we add this flag for HPET, MSI and IOAPIC.

> 
>> +		hpet_msi_read(data->handler_data, &msg);
>> +		msg.data &= ~MSI_DATA_VECTOR_MASK;
>> +		msg.data |= MSI_DATA_VECTOR(cfg->vector);
>> +		msg.address_lo &= ~MSI_ADDR_DEST_ID_MASK;
>> +		msg.address_lo |= MSI_ADDR_DEST_ID(cfg->dest_apicid);
> 
> We need the same thing for MSI so this should be a helper function
> 
>    msi_update_msg(struct msi_msg *msg, struct irq_cfg *cfg)
Good suggestion, will do it in next version
Regards!
Gerry

> 
>> +		hpet_msi_write(data->handler_data, &msg);
>> +	}
>>  
>> -	return IRQ_SET_MASK_OK_NOCOPY;
>> +	return ret;
>>  }
>  
> Thanks,
> 
> 	tglx
> 
