From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Thu, 18 Sep 2014 14:14:43 +0800
Subject: [RFC Part2 v1 02/21] genirq: Introduce helper functions to support
 stacked irq_chip
In-Reply-To: <alpine.DEB.2.10.1409171244090.21313@nanos>
References: <1410444228-3134-1-git-send-email-jiang.liu@linux.intel.com>
 <1410444228-3134-3-git-send-email-jiang.liu@linux.intel.com>
 <alpine.DEB.2.10.1409161044330.4247@nanos> <5418FAE1.4030008@linux.intel.com>
 <alpine.DEB.2.10.1409171244090.21313@nanos>
Message-ID: <541A7853.4020303@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2014/9/18 4:58, Thomas Gleixner wrote:
> On Wed, 17 Sep 2014, Jiang Liu wrote:
>> On 2014/9/17 1:45, Thomas Gleixner wrote:
>>> On Thu, 11 Sep 2014, Jiang Liu wrote:
>>>> +#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
>>>> +void irq_chip_ack_parent(struct irq_data *data)
>>>> +{
>>>> +	data = data->parent_data;
>>>> +	if (data && data->chip && data->chip->irq_ack)
>>>> +		data->chip->irq_ack(data);
>>>
>>> Why is this restricted to a single parent level and does not go down
>>> the whole stack?
>> Hi Thomas,
>> 	It happens to work on x86, and we want to achieve a bit
>> performance advantage by not walking down the whole stack.
>> If preferred, I will change it to walk the whole stack.
> 
> Happens to work on my machine is always a bad argument :)
> 
> Now, I can see why you want to do that, but if we do an optimization
> like that then we should really get rid of the conditional.
> 
> You surely need a conditional on data->chip and data->chip->callback
> for a full stackq walk, but for an explicit request to use the parents
> ack the parent better has a chip with an ack function, right?
> 
> void irq_chip_ack_parent(struct irq_data *data)
> {
> 	data = data->parent_data;
> 	data->chip->irq_ack(data);
> }
Sure, will optimize it further as above code.
Regards!
Gerry
> 
> Thanks,
> 
> 	tglx
> 
