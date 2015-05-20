From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 May 2015 20:43:16 +0200 (CEST)
Subject: [RFC v1 25/25] genirq: Kill the first parameter 'irq' of
 irq_flow_handler_t
In-Reply-To: <555CAD21.7040907@linux.intel.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
 <1432116013-25902-26-git-send-email-jiang.liu@linux.intel.com>
 <alpine.DEB.2.11.1505201737510.4225@nanos> <555CAD21.7040907@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1505202041280.4225@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wed, 20 May 2015, Jiang Liu wrote:

> On 2015/5/20 23:40, Thomas Gleixner wrote:
> > On Wed, 20 May 2015, Jiang Liu wrote:
> >>  /* Chained IRQ handler for IPU error interrupt */
> >> -static void ipu_irq_err(unsigned int irq, struct irq_desc *desc)
> >> +static void ipu_irq_err(struct irq_desc *desc)
> >>  {
> >> +	unsigned int irq = irq_desc_to_irq(desc);
> > 
> > Why initializing? It's overwritten in the loop.
> Hi Thomas,
> 
> I'm not familiar with the hardware, but if src2map() returns 0
> on the first call, we need to initialize irq. Otherwise
> generic_handle_irq(irq) will use random value on the first call.
> ---------------------------------------------------------
>                         map = src2map(32 * i + line);
>                         if (map)
>                                 irq = map->irq;

You omitted the following code:

                        raw_spin_unlock(&bank_lock);

                        if (!map) {
                                pr_err("IPU: Interrupt on unmapped source %u bank %d\n",
                                       line, i);
                                continue;
			}

So you it does not use irq if map is 0.

Thanks,

	tglx
