From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 12 Mar 2014 14:45:14 +0100
Subject: [PATCH] irqchip: sun4i: Fix irq 0 not working
In-Reply-To: <20140312100935.GY2815@lukather>
References: <1394553060-30298-1-git-send-email-hdegoede@redhat.com>
 <20140312100935.GY2815@lukather>
Message-ID: <532064EA.1070308@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/12/2014 11:09 AM, Maxime Ripard wrote:
> Hi,
> 
> On Tue, Mar 11, 2014 at 04:51:00PM +0100, Hans de Goede wrote:
>> SUN4I_IRQ_VECTOR_REG containing 0 can mean one of 2 things:
>> 1) irq 0 pending
>> 2) no more irqs pending
>>
>> So we must loop always atleast once to make irq 0 work, otherwise irq 0
>> will never get serviced and we end up with a hard hang because
>> sun4i_handle_irq gets re-entered constantly.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/irqchip/irq-sun4i.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
>> index a5438d8..3761bf1 100644
>> --- a/drivers/irqchip/irq-sun4i.c
>> +++ b/drivers/irqchip/irq-sun4i.c
>> @@ -140,10 +140,16 @@ static asmlinkage void __exception_irq_entry sun4i_handle_irq(struct pt_regs *re
>>  {
>>  	u32 irq, hwirq;
>>  
>> +	/*
>> +	 * hwirq == 0 can mean one of 2 things:
>> +	 * 1) irq 0 pending
>> +	 * 2) no more irqs pending
> 
> 3) spurious interrupt.
> 
>> +	 * So loop always atleast once to make irq 0 work.
>> +	 */
>>  	hwirq = readl(sun4i_irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
>> -	while (hwirq != 0) {
>> +	do {
> 
> I'd at least lookup in the pending register to see if the interrupt 0
> was actually triggered. Otherwise, you could end up with spurious
> handler calls on the interrupt 0.

Yes, I was already worrying about this myself after sending the patch,
and considered reading pending too.

> 
>>  		irq = irq_find_mapping(sun4i_irq_domain, hwirq);
>>  		handle_IRQ(irq, regs);
>>  		hwirq = readl(sun4i_irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
> 
> And you end up with the same issue if there's a first != 0 interrupt,
> and then the interrupt 0.

No, before my fix sun4i_handle_irq would be called continuously since we
were never handling irq 0, so if this happens we will simply drop out
of sun4i_handle_irq only to immediately get recalled, this does make this
scenario more expensive, but things will still work, while it saves an
also not cheap read from SUN4I_IRQ_PENDING_REG(0) for each regular
interrupt.

Note I agree the spurious irq case is an issue, as said that has me
worried too.

> What about something like:
> 
> while (1) {
> 	hwirq = readl(sun4i_irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
> 	if (!hwirq)
> 		if (!(readl(sun4i_irq_base + SUN4I_IRQ_PENDING_REG(0)) & BIT(0)))
> 			break;
>
> 	irq = irq_find_mapping(sun4i_irq_domain, hwirq);
> 	handle_IRQ(irq, regs);
> }

Yes that should work nicely, but for the straight path it means reading pending
once for each interrupt.

I agree we need to read pending before calling handle_IRQ for irq 0, but
we only need to do so if the first read from SUN4I_IRQ_VECTOR_REG == 0,
on any subsequent reads from SUN4I_IRQ_VECTOR_REG returning 0 we can exit
immediately, in the worst case we'll get called again, and then do the
right thing.

IE something like this:

	hwirq = readl(sun4i_irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
	/* Ensure hwirq == 0 is because of irq 0 pending */
	if (hwirq == 0 && !(readl(sun4i_irq_base + SUN4I_IRQ_PENDING_REG(0)) & BIT(0)))
		return;
	do {
		irq = irq_find_mapping(sun4i_irq_domain, hwirq);
		handle_IRQ(irq, regs);
		hwirq = readl(sun4i_irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
	} while (hwirq);

Note untested, and this might be unnecessary optimization. So let me know which
version you prefer and I'll give it a test run.

Regards,

Hans
