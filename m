From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 05 Jan 2012 15:50:09 +0100
Subject: [PATCH v2] ARM: at91: pit add DT support
In-Reply-To: <20120105120049.GB4641@page>
References: <1318799895-5121-4-git-send-email-plagnioj@jcrosoft.com>
 <1325771308-19770-1-git-send-email-nicolas.ferre@atmel.com>
 <20120105120049.GB4641@page>
Message-ID: <4F05B8A1.2010003@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2012 01:00 PM, Jamie Iles :
> Hi Nicolas, Jean-Christophe,
> 
> On Thu, Jan 05, 2012 at 02:48:28PM +0100, Nicolas Ferre wrote:
>> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>
>> Retreive registers address and IRQ from device tree entry. Fall back
>> to built-in values if an error occurs.
>>
>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> [nicolas.ferre at atmel.com: change error path and interrupts property handling]
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
> [...]
>> diff --git a/arch/arm/mach-at91/at91sam926x_time.c 
>> b/arch/arm/mach-at91/at91sam926x_time.c
>> index d89ead7..5d4c308 100644
>> --- a/arch/arm/mach-at91/at91sam926x_time.c
>> +++ b/arch/arm/mach-at91/at91sam926x_time.c
>> @@ -14,6 +14,8 @@
> [...]
>> +static int __init of_at91sam926x_pit_init(void)
>> +{
>> +	struct device_node *np;
>> +
>> +	np = of_find_matching_node(NULL, timer_ids);
>> +	if (!np)
>> +		goto err;
>> +
>> +	pit_base_addr = of_iomap(np, 0);
>> +	if (!pit_base_addr)
>> +		goto node_err;
>> +
>> +	/* Get the interrupts property */
>> +	if (of_property_read_u32(np, "interrupts", &at91sam926x_pit_irq.irq))
>> +		goto ioremap_err;
> 
> I think you want:
> 
> 	at91sam926x_pit_irq.irq = irq_of_parse_and_map(np, 0);
> 
> to make sure the IRQ is converted to a Linux IRQ and not a hwirq.

Yes, that definitively makes sense. BTW, without a DT entry, how should
I map a hwirq, with the irq_domain_to_irq() helper? But I will need
access to the interrupt controller "struct irq_domain"...

> Other than that looks fine to me.

Thanks a lot for your review, Jamie.

Best regards,
-- 
Nicolas Ferre
