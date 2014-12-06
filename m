From: rjui@broadcom.com (Ray Jui)
Date: Fri, 5 Dec 2014 19:41:59 -0800
Subject: [PATCH 2/5] gpio: Cygnus: add GPIO driver
In-Reply-To: <1417833291.31745.5.camel@perches.com>
References: <Ray Jui <rjui@broadcom.com>	
 <1417826408-1600-1-git-send-email-rjui@broadcom.com>	
 <1417826408-1600-3-git-send-email-rjui@broadcom.com>	
 <1417829282.31745.3.camel@perches.com> <5482668F.1040907@broadcom.com>
 <1417833291.31745.5.camel@perches.com>
Message-ID: <54827B07.3000707@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/5/2014 6:34 PM, Joe Perches wrote:
> On Fri, 2014-12-05 at 18:14 -0800, Ray Jui wrote:
>> On 12/5/2014 5:28 PM, Joe Perches wrote:
>>> On Fri, 2014-12-05 at 16:40 -0800, Ray Jui wrote:
>>>> +static void bcm_cygnus_gpio_irq_handler(unsigned int irq,
>>>> +		struct irq_desc *desc)
>>>> +{
>>>> +	struct bcm_cygnus_gpio *cygnus_gpio;
>>>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>>>> +	int i, bit;
>>>> +
>>>> +	chained_irq_enter(chip, desc);
>>>> +
>>>> +	cygnus_gpio = irq_get_handler_data(irq);
>>>> +
>>>> +	/* go through the entire GPIO banks and handle all interrupts */
>>>> +	for (i = 0; i < cygnus_gpio->num_banks; i++) {
>>>> +		unsigned long val = readl(cygnus_gpio->base +
>>>> +				(i * GPIO_BANK_SIZE) +
>>>> +				CYGNUS_GPIO_INT_MSTAT_OFFSET);
>>>> +		if (val) {
>>>
>>> This if (val) and indentation isn't really necessary
>>>
>>
>> Note for_each_set_bit in this case iterates 32 times searching for bits
>> that are set.
>
> No it doesn't.
>
> #define for_each_set_bit(bit, addr, size) \
> 	for ((bit) = find_first_bit((addr), (size));		\
> 	     (bit) < (size);					\
> 	     (bit) = find_next_bit((addr), (size), (bit) + 1))
>
> find_first_bit:
>
>   * Returns the bit number of the first set bit.
>   * If no bits are set, returns @size.
>

You are right. I reviewed for_each_set_bit but didn't notice 
find_next_bit may simply return 32 in our case without doing any 
iterative processing. I will get rid of the redundant if (val) check below.

>>   By having the if (val) check here, it can potentially save
>> some of such processing in the ISR. I agree with you that it introduces
>> one extra indent here but I think it's required.
>>
>>>> +			for_each_set_bit(bit, &val, 32) {
>>>
>>> for_each_set_bit will effectively do the if above.
>>>
>>> 32 bit only code?
>>> otherwise isn't this endian unsafe?
>>>
>>
>> Will change 'unsigned long val' to 'u32 val'.
>
> All the bit operations only work on long *
>
>

Actually, by reviewing the code more deeply, I'm not sure why using 
for_each_set_bit here is 'endian unsafe'. Isn't that already taken care 
of by macros in bitops.h? Sorry if I'm still missing something here...
