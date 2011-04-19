From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 19 Apr 2011 12:10:20 +0200
Subject: [RFC patch 00/20] Interrupt chip consolidation
In-Reply-To: <alpine.LFD.2.00.1104191130050.2744@localhost6.localdomain6>
References: <20110416211221.853079766@linutronix.de>
	<4DAD462D.5070008@metafoo.de>
	<alpine.LFD.2.00.1104191130050.2744@localhost6.localdomain6>
Message-ID: <4DAD5F8C.1060101@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2011 11:41 AM, Thomas Gleixner wrote:
> On Tue, 19 Apr 2011, Lars-Peter Clausen wrote:
>> On 04/16/2011 11:14 PM, Thomas Gleixner wrote:
>>> [...]
>  
>> I've also noticed that all my chained demuxer handlers follow a similar scheme
>> and a quick grep for generic_handle_irq revealed that quite a few other
>> implementations also follow a similar scheme as well.
>>
>> Something along the lines of ...
>>
>> void irq_gc_chained_demux_handler(unsigned int irq, struct irq_desc *desc)
>> {
>> 	struct irq_chip_generic *gc = irq_desc_get_handler_data(desc);
>> 	struct irq_chip_type *ct = gc = irq_chip_generic_current_chip_type(gc);
>> 	unsigned long pending = irq_reg_readl(ct->regs.pending);
>>
>> 	pending = irq_reg_readl(ct->regs.pending) & gc->mask_cache;
>>
>> 	for_each_set_bit (irq, &pending, gc->irq_cnt)
>> 		generic_handle_irq(gc->irq_base + irq);
>> }
>>
>> ... could be used to replace those custom handlers in an irq_chip_generic based
>> implementation.
>>
>> With this the diffstat for JZ4740 looks even better:
>>  4 files changed, 91 insertions(+), 232 deletions(-)
>>
>> Unfortunately it doesn't completely fit into the current irq_chip_generic
>> implementation. For one there is no irq_chip_generic_current_chip_type, but I
>> guess that could be implementing by adding a field to irq_chip_generic pointing
>> to the current chip type. On the other hand I'm not sure if it is necessary to
> 
> No, you can get the current chip from irq_data.chip which always has a
> pointer to the current active one. container_of will give you the
> generic chip.

Yes, but the chained demux handler is of course installed on the parent irq chip.
I guess we could do something like cur_regs(irq_get_irq_data(gc->irq_base))
though, but that is a lot of indirection.

> 
>> have different pending registers for different chip types of the same
>> irq_chip_generic.
>>
>> Another issue is that while the gpio unit on the JZ4740 supports different
>> trigger modes it only supports either rising or falling edge at one time. So
>> since it doesn't makes sense to implement switching between those two in a
>> driver triggering in both edges is emulated by the irq chip.
> 
> That's what about 5 dozen other irq chips do as well.

Yes, I've noticed as well. That is why I was asking if you see the possibility
to handle this in the core somehow.

- Lars
