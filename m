From: slash.tmp@free.fr (Mason)
Date: Tue, 11 Jul 2017 17:56:56 +0200
Subject: [RFC PATCH v1] irqchip: Add support for tango interrupt router
In-Reply-To: <20170606175219.34ef62b9@free-electrons.com>
References: <657580dd-0cfe-e377-e425-0deabf6d20c3@free.fr>
 <20170606175219.34ef62b9@free-electrons.com>
Message-ID: <d8a4d8ad-a9f3-07eb-9e2a-a4bbec01961e@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2017 17:52, Thomas Petazzoni wrote:

> On Tue, 6 Jun 2017 15:42:36 +0200, Mason wrote:
> 
>> +	interrupt-controller at 6f800 {
>> +		compatible = "sigma,smp8759-intc";
>> +		reg = <0x6f800 0x430>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <2>;
>> +		interrupt-parent = <&gic>;
>> +		/*
>> +		 * There probably is a better way than explicitly listing
>> +		 * the 24 interrupts?
>> +		 */
> 
> What we do on Marvell platforms is:
> 
> 	marvell,spi-base = <128>, <136>, <144>, <152>;
> 
> see marvell,odmi-controller.txt.
> 
> In another driver I submitted, we're doing:
> 
> 	marvell,spi-ranges = <64 64>, <288 64>;
> 
> Retrospectively, I would have preferred to use marvell,spi-ranges for
> the first DT binding as well, since it allows to express both the base
> and number of interrupts available in the range.

Sorry for the delay, I got distracted by other drivers
(PCIe, clkgen, i2c, infrared).

Thanks for the suggestion.

So, if I remove the "interrupts" property from the controller's
DT node, I can no longer use irq_of_parse_and_map() followed by
irqd_set_trigger_type(), right?

I would have to "emulate" irq_of_parse_and_map() with
something along the lines of:

#include <dt-bindings/interrupt-controller/arm-gic.h>
static int __init map_irq(struct device_node *gic, int irq, int type)
{
	struct of_phandle_args data = { gic, 3, { GIC_SPI, irq, type }};
	return irq_create_of_mapping(&data);
}

Then map all 24 interrupts at init:

	virq = map_irq(gic, 0, IRQ_TYPE_LEVEL_HIGH);
	for (i = 1; i < 24; ++i)
		virq = map_irq(gic, i, IRQ_TYPE_EDGE_RISING);

Is that correct?

Does it make sense to use a separate ISR for the two kinds
of interrupts?

Regards.
