From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Wed, 20 May 2015 23:32:57 +0800
Subject: [RFC v1 15/25] genirq: Kill the first parameter 'irq' of
 irq_flow_handler_t
In-Reply-To: <alpine.DEB.2.11.1505201715380.4225@nanos>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
 <1432116013-25902-16-git-send-email-jiang.liu@linux.intel.com>
 <alpine.DEB.2.11.1505201715380.4225@nanos>
Message-ID: <555CA929.3080306@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/5/20 23:28, Thomas Gleixner wrote:
> On Wed, 20 May 2015, Jiang Liu wrote:
>> -static void locomo_handler(unsigned int irq, struct irq_desc *desc)
>> +static void locomo_handler(struct irq_desc *desc)
>>  {
>>  	struct locomo *lchip = irq_desc_get_chip_data(desc);
>> +	unsigned int irq;
>>  	int req, i;
> 
> That leaves irq unitialized ....
That should be OK, 'irq' here is just a local variable.
Actually it may be changed as:
        if (req) {
                /* generate the next interrupt(s) */
-                irq = lchip->irq_base;
+                unsigned int irq = lchip->irq_base;
                for (i = 0; i <= 3; i++, irq++) {
                        if (req & (0x0100 << i)) {
                                generic_handle_irq(irq);
                        }

                }
        }

> 
> Thanks,
> 
> 	tglx
> 
