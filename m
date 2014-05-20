From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 20 May 2014 13:42:24 +0300
Subject: [RFC PATCH] of/irq: do irq resolution in platform_get_irq_byname()
In-Reply-To: <20140519125738.GB9466@ulmo>
References: <1400506259-18397-1-git-send-email-grygorii.strashko@ti.com>
 <20140519125738.GB9466@ulmo>
Message-ID: <537B3190.9030706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On 05/19/2014 03:57 PM, Thierry Reding wrote:
> On Mon, May 19, 2014 at 04:30:59PM +0300, Grygorii Strashko wrote:
> [...]
>> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> [...]
>>   /**
>> + * of_irq_get_byname - Decode a node's IRQ and return it as a Linux irq number
>> + * @dev: pointer to device tree node
>> + * @name: zero-based index of the irq
> 
> This is a name, not an index.
> 
>> + *
>> + * Returns Linux irq number on success, or -EPROBE_DEFER if the irq domain
>> + * is not yet created, or errorno in case of failure.
> 
> s/errorno/error code/? Also EPROBE_DEFER is also an error code, so I'm
> not sure if it's worth a special case in the description here.

>From my experience, It's very useful to know that function can return 
EPROBE_DEFER, otherwise, the code need to be traced till place where
EPROBE_DEFER is returned.

> 
>> + *
>> + */
>> +int of_irq_get_byname(struct device_node *dev, const char *name)
>> +{
>> +	const char *name_irq = NULL;
>> +	int index = 0;
>> +
>> +	if (unlikely(!name))
>> +		return -EINVAL;
>> +
>> +	while (!of_property_read_string_index(dev, "interrupt-names",
>> +					      index, &name_irq))
>> +		if (!strcmp(name, name_irq))
>> +			return of_irq_get(dev, index);
> 
> Isn't this missing an index++ somewhere? Otherwise it seems like this
> would loop infinitely if there was no match on the first entry.

Omg. You're right. It was bad day (

Thanks for your review. Patch re-sent.

Regards,
-grygorii
