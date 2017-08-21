From: slash.tmp@free.fr (Mason)
Date: Mon, 21 Aug 2017 18:13:07 +0200
Subject: [PATCH v6] irqchip: Add support for tango interrupt router
In-Reply-To: <21670cea-beaf-8a41-84fb-f3c892527b0e@free.fr>
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
Message-ID: <a6e1fe03-56a4-0db9-ca1c-36d09936a140@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/08/2017 19:22, Mason wrote:

> On 07/08/2017 14:47, Marc Zyngier wrote:
> 
>> On 01/08/17 17:56, Mason wrote:
>>
>>> +static int tango_set_type(struct irq_data *data, uint flow_type)
>>> +{
>>> +	return 0;
>>
>> What does this mean? Either you can do a set-type (and you do it), or
>> you cannot, and you fail. At least you check that what you're asked to
>> do matches the configuration.
> 
> IIRC, __irq_set_trigger() barfed when I did it differently.

The way the problem manifests is that /proc/interrupts cannot
determine the trigger types.

(I think the issue might be deeper than this cosmetic aspect.)

# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 40:       1832        333       2378        471     GIC-0  29 Edge      twd
 41:        487          0          0          0    mapper   1 Edge      serial
 44:         50          0          0          0    mapper  38 Edge      eth0
 51:          3          0          0          0    mapper  37 Edge      phy_interrupt

(1 and 38 are actually level interrupts.)

	ret = sprintf(buf, "%s\n",
		      irqd_is_level_type(&desc->irq_data) ? "level" : "edge");


__irq_set_trigger() is a no-op when irq_set_type is not implemented.

But if the callback returns 0, then __irq_set_trigger() eventually calls

		irqd_clear(&desc->irq_data, IRQD_TRIGGER_MASK);
		irqd_set(&desc->irq_data, flags);


Should I be calling irqd_get_trigger_type() myself earlier,
perhaps in the domain alloc function?

That's what drivers/irqchip/irq-pic32-evic.c seems to do.

The comment seems to state otherwise though:
/*
 * Must only be called inside irq_chip.irq_set_type() functions.
 */
static inline void irqd_set_trigger_type(struct irq_data *d, u32 type)


Regards.
