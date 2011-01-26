From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 26 Jan 2011 17:59:43 -0600
Subject: [PATCH] ep93xx: implement gpiolib set_debounce for built-in GPIOs
In-Reply-To: <4D40B2A2.2070403@bluewatersys.com>
References: <201101261622.48750.hartleys@visionengravers.com>
	<4D40B2A2.2070403@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B027084269764CEC45F7A@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 26, 2011 4:48 PM, Ryan Mallon wrote:
> On 01/27/2011 12:22 PM, H Hartley Sweeten wrote:
>> GPIO Ports A, B, and F on the ep93xx provide interrupt capability.  It is
>> possible to debounce the input signal on these ports when interrupts are
>> enabled.
>> 
>> Support for this debounce capability was provided with an ep93xx internal
>> function.  Now that gpiolib knows about gpio debounce, use the gpiolib
>> method and do not export the internal function.
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Ryan Mallon <ryan@bluewatersys.com>
>> 
>> ---
>> 
>> diff --git a/arch/arm/mach-ep93xx/gpio.c b/arch/arm/mach-ep93xx/gpio.c
>> index bec34b8..a889fa7 100644
>> --- a/arch/arm/mach-ep93xx/gpio.c
>> +++ b/arch/arm/mach-ep93xx/gpio.c
>> @@ -61,7 +61,7 @@ static inline void ep93xx_gpio_int_mask(unsigned line)
>>  	gpio_int_unmasked[line >> 3] &= ~(1 << (line & 7));
>>  }
>>  
>> -void ep93xx_gpio_int_debounce(unsigned int irq, int enable)
>> +static void ep93xx_gpio_int_debounce(unsigned int irq, bool enable)
>>  {
>>  	int line = irq_to_gpio(irq);
>>  	int port = line >> 3;
>> @@ -75,7 +75,6 @@ void ep93xx_gpio_int_debounce(unsigned int irq, int enable)
>>  	__raw_writeb(gpio_int_debounce[port],
>>  		EP93XX_GPIO_REG(int_debounce_register_offset[port]));
>>  }
>> -EXPORT_SYMBOL(ep93xx_gpio_int_debounce);
>>  
>>  static void ep93xx_gpio_ab_irq_handler(unsigned int irq, struct irq_desc *desc)
>>  {
>> @@ -335,6 +334,20 @@ static void ep93xx_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
>>  	local_irq_restore(flags);
>>  }
>>  
>> +static int ep93xx_gpio_set_debounce(struct gpio_chip *chip,
>> +				    unsigned offset, unsigned debounce)
>> +{
>> +	int gpio = chip->base + offset;
>> +	int irq = gpio_to_irq(gpio);
>> +
>> +	if (irq < 0)
>> +		return -EINVAL;
>> +
>> +	ep93xx_gpio_int_debounce(irq, debounce ? true : false);
>
> We should just move the code from ep93xx_gpio_int_debounce here. Why
> have two functions to do one thing?

The reason I left the original function it that it messes with the cached gpio_int_debounce
values.  Also, the 'debounce' feature is interrupt specific.  If the gpio pin is no enabled
as an interrupt the debounce has no effect.  As such I figured it was cleaner to leave it
in place.

Would you still like me to combine the functions?

Regards,
Hartley
