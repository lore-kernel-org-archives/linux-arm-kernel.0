From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 22 Oct 2018 13:43:56 +0300
Subject: [PATCH v2 09/10] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
In-Reply-To: <6b112f34-cae3-fcd4-0d36-80b39c575fe4@ti.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-10-lokeshvutla@ti.com>
 <6b112f34-cae3-fcd4-0d36-80b39c575fe4@ti.com>
Message-ID: <85ec72c9-1b5b-6621-a704-c12efe6d72a7@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018-10-22 13:42, Peter Ujfalusi wrote:
> Lokesh,
> 
> On 2018-10-18 18:40, Lokesh Vutla wrote:
>> Texas Instruments' K3 generation SoCs has an IP Interrupt Aggregator
>> which is an interrupt controller that does the following:
>> - Converts events to interrupts that can be understood by
>>   an interrupt router.
>> - Allows for multiplexing of events to interrupts.
>> - Allows for grouping of multiple events to a single interrupt.
>>
>> Configuration of the interrupt aggregator registers can only be done by
>> a system co-processor and the driver needs to send a message to this
>> co processor over TISCI protocol.
>>
>> Add support for Interrupt Aggregator driver over TISCI protocol.
> 
> Have you compiled this?
> 
> ...
> 
>> diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
>> new file mode 100644
>> index 000000000000..ef0a2e8b782c
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-ti-sci-inta.c
> 
> ...
> 
>> +/**
>> + * ti_sci_inta_register_event() - Register a event to an interrupt aggregator
>> + * @dev:	Device pointer to source generating the event
>> + * @src_id:	TISCI device ID of the event source
>> + * @src_index:	Event source index within the device.
>> + * @virq:	Linux Virtual IRQ number
>> + * @flags:	Corresponding IRQ flags
>> + * @ack_needed:	If explicit clearing of event is required.
>> + *
>> + * Creates a new irq and attaches to IA domain if virq is not specified
>> + * else attaches the event to vint corresponding to virq.
>> + * When using TISCI within the client drivers, source indexes are always
>> + * generated dynamically and cannot be represented in DT. So client
>> + * drivers should call this API instead of platform_get_irq().
>> + *
>> + * Return virq if all went well else appropriate error value.
>> + */
>> +int ti_sci_inta_register_event(struct device *dev, u16 src_id, u16 src_index,
>> +			       unsigned int virq, u32 flags, bool ack_needed)

And can you swap the flags and ack_needed?

>> +{
> 
> ...
> 
>> diff --git a/include/linux/irqchip/irq-ti-sci-inta.h b/include/linux/irqchip/irq-ti-sci-inta.h
>> new file mode 100644
>> index 000000000000..c078234fda3f
>> --- /dev/null
>> +++ b/include/linux/irqchip/irq-ti-sci-inta.h
>> @@ -0,0 +1,35 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Texas Instruments' System Control Interface (TI-SCI) irqchip
>> + *
>> + * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
>> + *	Lokesh Vutla <lokeshvutla@ti.com>
>> + */
>> +
>> +#ifndef __INCLUDE_LINUX_IRQCHIP_TI_SCI_INTA_H
>> +#define __INCLUDE_LINUX_IRQCHIP_TI_SCI_INTA_H
>> +
>> +#if IS_ENABLED(CONFIG_TI_SCI_INTA_IRQCHIP)
>> +int ti_sci_inta_register_event(struct device *dev, u16 src_id, u16 src_index,
>> +			       unsigned int virq, u32 flags);
> 
> You are missing the ack_needed
> 
>> +int ti_sci_inta_unregister_event(struct device *dev, u16 src_id, u16 src_index,
>> +				 unsigned int virq);
>> +
>> +#else /* CONFIG_TI_SCI_INTA_IRQCHIP */
>> +
>> +static inline int ti_sci_inta_register_event(struct device *dev, u16 src_id,
>> +					     u16 src_index, unsigned int virq,
>> +					     u32 flags)
> 
> Here as well.
> 
>> +{
>> +	return -EINVAL;
>> +}
>> +
>> +static inline int ti_sci_inta_unregister_event(struct device *dev, u16 src_id,
>> +					       u16 src_index, unsigned int virq)
>> +{
>> +	return -EINVAL;
>> +}
>> +
>> +#endif /* CONFIG_TI_SCI_INTA_IRQCHIP */
>> +
>> +#endif /* __INCLUDE_LINUX_IRQCHIP_TI_SCI_INTA_H */
>>
> 
> - P?ter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

- P?ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
