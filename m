From: opendmb@gmail.com (Doug Berger)
Date: Mon, 24 Jul 2017 10:54:33 -0700
Subject: [PATCH v2 2/6] irqchip/tango: Use irq_gc_mask_disable_and_ack_set
In-Reply-To: <7a51555f-8191-9ebd-1f30-7c20f6db9d3f@sigmadesigns.com>
References: <20170719190734.18566-1-opendmb@gmail.com>
 <20170719190734.18566-3-opendmb@gmail.com>
 <7a51555f-8191-9ebd-1f30-7c20f6db9d3f@sigmadesigns.com>
Message-ID: <8d29fec9-35b8-c33b-3091-3e9a51c99ed7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2017 09:40 AM, Marc Gonzalez wrote:
> [ Trimming CC list ]
> 
> On 19/07/2017 21:07, Doug Berger wrote:
> 
>> From: Florian Fainelli <f.fainelli@gmail.com>
>>
>> The only usage of the irq_gc_mask_disable_reg_and_ack() function
>> is by the Tango irqchip driver. This usage is replaced by the
>> irq_gc_mask_disable_and_ack_set() function since it provides the
>> intended functionality.
>>
>> Fixes: 4bba66899ac6 ("irqchip/tango: Add support for Sigma Designs SMP86xx/SMP87xx interrupt controller")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> Acked-by: Mans Rullgard <mans@mansr.com>
>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>> ---
>>  drivers/irqchip/irq-tango.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
>> index bdbb5c0ff7fe..0c085303a583 100644
>> --- a/drivers/irqchip/irq-tango.c
>> +++ b/drivers/irqchip/irq-tango.c
>> @@ -141,7 +141,7 @@ static void __init tangox_irq_init_chip(struct irq_chip_generic *gc,
>>  	for (i = 0; i < 2; i++) {
>>  		ct[i].chip.irq_ack = irq_gc_ack_set_bit;
>>  		ct[i].chip.irq_mask = irq_gc_mask_disable_reg;
>> -		ct[i].chip.irq_mask_ack = irq_gc_mask_disable_reg_and_ack;
>> +		ct[i].chip.irq_mask_ack = irq_gc_mask_disable_and_ack_set;
>>  		ct[i].chip.irq_unmask = irq_gc_unmask_enable_reg;
>>  		ct[i].chip.irq_set_type = tangox_irq_set_type;
>>  		ct[i].chip.name = gc->domain->name;
>>
> 
> (I had a look only at patches 1 and 2)
> 
> irq_gc_mask_disable_reg() =
> 	irq_reg_writel(gc, mask, ct->regs.disable);
> 	*ct->mask_cache &= ~mask;
> 
> irq_gc_ack_set_bit() =
> 	irq_reg_writel(gc, mask, ct->regs.ack);
> 
> 
> irq_gc_mask_disable_reg_and_ack() =
> 	irq_reg_writel(gc, mask, ct->regs.mask);  // regs.mask not defined for tango driver
> 	irq_reg_writel(gc, mask, ct->regs.ack);
> 
> It will try to write at offset 0, which is a read-only register
> so no disaster, but interrupt is not disabled. I wonder why
> everything doesn't blow up...
> 
> irq_gc_mask_disable_and_ack_set() =
> 	irq_reg_writel(gc, mask, ct->regs.disable);
> 	*ct->mask_cache &= ~mask;
> 	irq_reg_writel(gc, mask, ct->regs.ack);
> 
> 
> Your change makes sense.
> 
> But note that mask_ack_irq() is defined as:
> 
> static inline void mask_ack_irq(struct irq_desc *desc)
> {
> 	if (desc->irq_data.chip->irq_mask_ack) {
> 		desc->irq_data.chip->irq_mask_ack(&desc->irq_data);
> 		irq_state_set_masked(desc);
> 	} else {
> 		mask_irq(desc);
> 		if (desc->irq_data.chip->irq_ack)
> 			desc->irq_data.chip->irq_ack(&desc->irq_data);
> 	}
> }
> 
> So IIUC, if we don't define a irq_mask_ack() callback,
> it will just call irq_mask() and irq_ack() which will
> do the right thing.
> 
> So an alternative is simply to delete the assignment
> of ct[i].chip.irq_mask_ack. What do you think?
> 

Yes, you understand correctly.  The irq_mask_ack method is entirely
optional and I assume that is why this issue went undetected for so
long; however, it is slightly more efficient to combine the functions
(even if the ack is unnecessary) which is why I chose to do so for my
changes to the irqchip-brcmstb-l2 driver where I first discovered this
issue.  How much value the improved efficiency has is certainly
debatable, but interrupt handling is one area where people might care
about such a small difference.  As the irqchip-tango driver maintainer
you are welcome to decide whether or not the irq_mask_ack method makes
sense to you.

I wanted to use the method for the irqchip-brcmstb-l2 driver which is
based on the irq generic chip implementation.  I discovered that the
irq_gc_mask_disable_reg_and_ack() function was not the function I needed
despite the name and that it appeared not to be the function the
irqchip-tango driver needed as well.  My desire here was to correct that
error and provide a standard set of generic implementations of
irq_mask_ack so that other drivers could avoid a similar mistake in an
attempt to provide a service to the community.  That was pared down at
Thomas Gleixner's request to correcting just the one implementation that
I wanted to use.

> diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
> index bdbb5c0ff7fe..825085cdab99 100644
> --- a/drivers/irqchip/irq-tango.c
> +++ b/drivers/irqchip/irq-tango.c
> @@ -141,7 +141,6 @@ static void __init tangox_irq_init_chip(struct irq_chip_generic *gc,
>         for (i = 0; i < 2; i++) {
>                 ct[i].chip.irq_ack = irq_gc_ack_set_bit;
>                 ct[i].chip.irq_mask = irq_gc_mask_disable_reg;
> -               ct[i].chip.irq_mask_ack = irq_gc_mask_disable_reg_and_ack;
>                 ct[i].chip.irq_unmask = irq_gc_unmask_enable_reg;
>                 ct[i].chip.irq_set_type = tangox_irq_set_type;
>                 ct[i].chip.name = gc->domain->name;
> 
> 
> One thing I'm not sure about is why we need to ack for level
> interrupts... We should be able to get away with defining ack()
> only for edge interrupts... I'm confused. If I try to do that,
> I get:
> 
> [    1.430547] irq 20: nobody cared (try booting with the "irqpoll" option)
> [    1.437283] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.13.0-rc1 #148
> [    1.443754] Hardware name: Sigma Tango DT
> [    1.447812] [<c010e890>] (unwind_backtrace) from [<c010b01c>] (show_stack+0x10/0x14)
> [    1.455598] [<c010b01c>] (show_stack) from [<c04a3fc4>] (dump_stack+0x84/0x98)
> [    1.462864] [<c04a3fc4>] (dump_stack) from [<c0159d80>] (__report_bad_irq+0x28/0xcc)
> [    1.470650] [<c0159d80>] (__report_bad_irq) from [<c015a188>] (note_interrupt+0x28c/0x2dc)
> [    1.478959] [<c015a188>] (note_interrupt) from [<c0157688>] (handle_irq_event_percpu+0x4c/0x58)
> [    1.487702] [<c0157688>] (handle_irq_event_percpu) from [<c01576cc>] (handle_irq_event+0x38/0x5c)
> [    1.496621] [<c01576cc>] (handle_irq_event) from [<c015aa84>] (handle_level_irq+0xa8/0x124)
> [    1.505017] [<c015aa84>] (handle_level_irq) from [<c01568bc>] (generic_handle_irq+0x24/0x34)
> [    1.513501] [<c01568bc>] (generic_handle_irq) from [<c02f9dc0>] (tangox_dispatch_irqs+0x4c/0x58)
> [    1.522333] [<c02f9dc0>] (tangox_dispatch_irqs) from [<c02f9e18>] (tangox_irq_handler+0x4c/0xb0)
> [    1.531163] [<c02f9e18>] (tangox_irq_handler) from [<c01568bc>] (generic_handle_irq+0x24/0x34)
> [    1.539819] [<c01568bc>] (generic_handle_irq) from [<c0156df4>] (__handle_domain_irq+0x5c/0xb4)
> [    1.548562] [<c0156df4>] (__handle_domain_irq) from [<c0101450>] (gic_handle_irq+0x48/0x8c)
> [    1.556956] [<c0101450>] (gic_handle_irq) from [<c010bb4c>] (__irq_svc+0x6c/0xa8)
> 

Whether an interrupt requires acknowledgement is a function of the
design of the interrupt controller hardware.  As you say, in principle
it should not be necessary to acknowledge a level sensitive interrupt.
In fact, that is the fundamental difference between the new hardware
implementation of the brcmstb-l2 interrupt controller in the BCM7271
device and previous versions (i.e. it only supports level interrupts and
therefore does not require acknowledgement).  However, it is not unusual
for the interrupt controller designers to latch the state of triggered
interrupts especially on controllers that can be configured for
different types of interrupt triggers (e.g. rising edge, falling edge,
active low, ...) and so it becomes necessary to acknowledge level
interrupts on such controllers to clear that latched state.

I don't know the requirements of the tango interrupt controller hardware.

> 
> Regards.
> 

Thanks,
    Doug
