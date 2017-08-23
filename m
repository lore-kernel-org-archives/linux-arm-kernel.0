From: slash.tmp@free.fr (Mason)
Date: Wed, 23 Aug 2017 17:45:49 +0200
Subject: [PATCH v6] irqchip: Add support for tango interrupt router
In-Reply-To: <29109a5f-3c0d-374a-97d5-f98b365d0e0e@arm.com>
References: <657580dd-0cfe-e377-e425-0deabf6d20c3@free.fr>
 <20170606175219.34ef62b9@free-electrons.com>
 <d8a4d8ad-a9f3-07eb-9e2a-a4bbec01961e@free.fr>
 <dfb86360-2247-65bb-602b-5c21029709fd@free.fr>
 <c0bd235a-9035-2002-31eb-e68710b076fd@free.fr>
 <24f34220-a017-f4e0-b72e-d1fdb014c0e1@free.fr>
 <9f384711-eef0-5117-b89c-9d2dc16e5ae5@free.fr>
 <afcc2b79-61ff-b54d-eac1-ea7f3ee6b6b2@free.fr>
 <e4a201b1-64e7-32a1-9cad-e632eeb156f6@free.fr>
 <473118cd-20dc-3534-d0d8-88799e3d2c3b@free.fr>
 <eea0ba7d-15d2-fb20-7c23-b2d3c4a7cfa7@free.fr>
 <ee9e4a52-9b21-d57f-1ae8-c7297d4386a6@arm.com>
 <21670cea-beaf-8a41-84fb-f3c892527b0e@free.fr>
 <29109a5f-3c0d-374a-97d5-f98b365d0e0e@arm.com>
Message-ID: <80cab52e-2d90-ace7-2587-742c4ef2b90b@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/08/2017 12:58, Marc Zyngier wrote:

> On 20/08/17 18:22, Mason wrote:
>
>> On 07/08/2017 14:47, Marc Zyngier wrote:
>>
>>> On 01/08/17 17:56, Mason wrote:
>>>
>>>> +static int tango_alloc(struct irq_domain *dom, uint virq, uint n, void *arg)
>>>> +{
>>>> +	int spi;
>>>> +	struct irq_fwspec *fwspec = arg;
>>>> +	struct tango_intc *intc = dom->host_data;
>>>> +	u32 hwirq = fwspec->param[0], trigger = fwspec->param[1];
>>>> +
>>>> +	if (trigger & IRQ_TYPE_EDGE_FALLING || trigger & IRQ_TYPE_LEVEL_LOW)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (trigger & IRQ_TYPE_LEVEL_HIGH)
>>>> +		intc->tango_irq_to_spi[hwirq] = LEVEL_SPI;
>>>> +
>>>> +	if (trigger & IRQ_TYPE_EDGE_RISING) {
>>>> +		for (spi = 1; spi < SPI_MAX; ++spi) {
>>>> +			if (intc->spi_to_tango_irq[spi] == 0) {
>>>> +				intc->tango_irq_to_spi[hwirq] = spi;
>>>> +				intc->spi_to_tango_irq[spi] = hwirq;
>>>> +				break;
>>>> +			}
>>>> +		}
>>>> +		if (spi == SPI_MAX)
>>>> +			return -ENOSPC;
>>>> +	}
>>>
>>> What's wrong with having a bitmap allocation, just like on other drivers?
>>
>> I don't understand what you are suggesting.
>>
>> The mapping is set up at run-time, I need to record it
>> somewhere.
> 
> Again. All the other drivers in the tree are using a bitmap to deal with
> their slot allocation. Why do you have to use a different data structure?

You appear to be objecting to the spi_to_tango_irq array.

The spi-to-tango-irq mapping has to be stored somewhere.

If I use a hierarchy for edge interrupts, as you have
demanded, then it becomes the core's responsibility to
store the mapping. Thus, I can drop the array, and just
use a bitmap to keep track of which output has already
been allocated.


>>> Calling panic? For a secondary interrupt controller? Don't. We call
>>> panic when we know for sure that the system is in such a state that
>>> we're better off killing it altogether than keeping it running (to avoid
>>> corruption, for example). panic is not a substitute for proper error
>>> handling.
>>
>> I handled the setup like irq-tango.c did.
> 
> Doesn't make it less crap.

Just want to clear something up.

If irq-tango.c were submitted today, would you demand this
issue be fixed, or are some submitters given more leeway
than others?


>>> Overall, this edge business feels wrong. If you want to mux a single
>>> output for all level interrupts, fine by me. But edge interrupts that
>>> have a 1:1 mapping with the underlying SPI must be represented as a
>>> hierarchy.
>>
>> I don't understand what you mean by "feels wrong".
>>
>> There are 128 inputs, and only 24 outputs.
>> Therefore, I must map some inputs to the same output.
>> Thomas explained that edge interrupts *cannot* be shared.
>> So edge interrupts must receive a dedicated output line.
>> Did I write anything wrong so far?
> 
> Let me repeat what Thomas already said:
> 
> - you dedicate one line to level interrupts using a multiplexer (chained
> interrupts).

OK.

> - you use the remaining 23 inputs in a hierarchical model, each input
> being mapped to one output, no chained handler.
> 
> That's what I want to see.

OK.

Can you confirm that this means two separate domains?


One last thing: about generic_handle_irq() and virq==0
I understand your point that irq_to_desc() is an expensive
operation, so it is better to check beforehand. But then,
would it not make sense to add the check in generic_handle_irq()
if all drivers are expected to do it? (Code factoring)

Regards.
