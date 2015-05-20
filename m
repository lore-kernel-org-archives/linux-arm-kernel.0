From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Wed, 20 May 2015 23:49:53 +0800
Subject: [RFC v1 25/25] genirq: Kill the first parameter 'irq' of
 irq_flow_handler_t
In-Reply-To: <alpine.DEB.2.11.1505201737510.4225@nanos>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
 <1432116013-25902-26-git-send-email-jiang.liu@linux.intel.com>
 <alpine.DEB.2.11.1505201737510.4225@nanos>
Message-ID: <555CAD21.7040907@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/5/20 23:40, Thomas Gleixner wrote:
> On Wed, 20 May 2015, Jiang Liu wrote:
>>  /* Chained IRQ handler for IPU error interrupt */
>> -static void ipu_irq_err(unsigned int irq, struct irq_desc *desc)
>> +static void ipu_irq_err(struct irq_desc *desc)
>>  {
>> +	unsigned int irq = irq_desc_to_irq(desc);
> 
> Why initializing? It's overwritten in the loop.
Hi Thomas,

I'm not familiar with the hardware, but if src2map() returns 0
on the first call, we need to initialize irq. Otherwise
generic_handle_irq(irq) will use random value on the first call.
---------------------------------------------------------
                        map = src2map(32 * i + line);
                        if (map)
                                irq = map->irq;
---------------------------------------------------------
Thanks!
Gerry

> 
>>  /* Chained IRQ handler for IPU function interrupt */
>> -static void ipu_irq_fn(unsigned int irq, struct irq_desc *desc)
>> +static void ipu_irq_fn(struct irq_desc *desc)
>>  {
>> +	unsigned int irq = irq_desc_to_irq(desc);
> 
> Ditto.
> 
> Thanks,
> 
> 	tglx
> 
