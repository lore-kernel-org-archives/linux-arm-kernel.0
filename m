From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Fri, 1 Jun 2012 09:45:56 +0200
Subject: [PATCH v2] ARM: at91: aic can use fast eoi handler type
In-Reply-To: <20120601032442.GA11721@mudshark.cambridge.arm.com>
References: <1338474704-16665-1-git-send-email-ludovic.desroches@atmel.com>
 <20120601032442.GA11721@mudshark.cambridge.arm.com>
Message-ID: <4FC87334.90303@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Le 06/01/2012 05:24 AM, Will Deacon a ?crit :
> Hi Ludovic,
>
> Thanks for the update. Few comments inline.
>
> On Thu, May 31, 2012 at 03:31:44PM +0100, ludovic.desroches at atmel.com wrote:
>> diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
>> index 325837a..a8bd715 100644
>> --- a/arch/arm/mach-at91/gpio.c
>> +++ b/arch/arm/mach-at91/gpio.c
>> @@ -593,7 +593,7 @@ static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
>>   	int		n;
>>
>>   	/* temporarily mask (level sensitive) parent IRQ */
>> -	chip->irq_ack(idata);
>> +	chip->irq_mask(idata);
>
> You don't need to mask the IRQ for fasteoi. However, you shouldn't be coding
> the flow control like this -- use chained_irq_enter instead.
>
>>   	for (;;) {
>>   		/* Reading ISR acks pending (edge triggered) GPIO interrupts.
>>   		 * When there none are pending, we're finished unless we need
>> @@ -614,6 +614,7 @@ static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
>>   			n = find_next_bit(&isr, BITS_PER_LONG, n + 1);
>>   		}
>>   	}
>> +	chip->irq_eoi(idata);
>
> chained_irq_exit.

Thanks I was not aware about this two functions.

>
>> diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
>> index 601b4ee..3aa18a6 100644
>> --- a/arch/arm/mach-at91/irq.c
>> +++ b/arch/arm/mach-at91/irq.c
>> @@ -55,6 +55,15 @@ static void at91_aic_unmask_irq(struct irq_data *d)
>>   	at91_aic_write(AT91_AIC_IECR, 1<<  d->hwirq);
>>   }
>>
>> +static void at91_aic_eoi(struct irq_data *d)
>> +{
>> +	/*
>> +	 * Mark end-of-interrupt on AIC, the controller doesn't care about
>> +	 * the value written in this register.
>> +	 */
>> +	at91_aic_write(AT91_AIC_EOICR, 0);
>> +}
>
> Does the EOICR read as zero, or can you read back the value which you wrote?
> In the latter case, writing the interrupt number can be a useful debugging
> aid when you have to debug IRQ issues with JTAG. Your call.

It is a write only register so value read back is 0. Moreover there is a 
new version of AIC where writing '1 << d->hwirq' as no more sense since 
we have an interrupt select register.

Regards

Ludovic
