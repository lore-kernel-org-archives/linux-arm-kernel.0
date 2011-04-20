From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 20 Apr 2011 13:23:39 -0500
Subject: [RFC PATCH 02/23] at91: Make Ethernet device common
In-Reply-To: <4DAE45F5.70302@bluewatersys.com>
References: <1303261827-27730-1-git-send-email-ryan@bluewatersys.com>
	<1303261827-27730-3-git-send-email-ryan@bluewatersys.com>
	<0D753D10438DA54287A00B027084269764D2329FA6@AUSP01VMBX24.collaborationhost.net>
	<4DAE45F5.70302@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B027084269764D23ABA43@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 19, 2011 7:33 PM, Ryan Mallon wrote:
>>> -#if defined(CONFIG_MACB) || defined(CONFIG_MACB_MODULE)
>>> -static u64 eth_dmamask = DMA_BIT_MASK(32);
>>> -static struct at91_eth_data eth_data;
>>> -
>>> -static struct resource eth_resources[] = {
>>> -	[0] = {
>>> -		.start	= AT572D940HF_BASE_EMAC,
>>> -		.end	= AT572D940HF_BASE_EMAC + SZ_16K - 1,
>>> -		.flags	= IORESOURCE_MEM,
>>> -	},
>>> -	[1] = {
>>> -		.start	= AT572D940HF_ID_EMAC,
>>> -		.end	= AT572D940HF_ID_EMAC,
>>> -		.flags	= IORESOURCE_IRQ,
>>> -	},
>> 
>> [snip]
>> 
>>> +static struct __initdata at91_dev_table_ethernet device_eth = {
>>> +	.mmio_base	= AT91SAM9260_BASE_EMAC,
>>> +	.irq		= AT91SAM9260_ID_EMAC,
>> 
>> AT572D940HF_BASE_EMAC and AT572D940HF_ID_EMAC?
>
> Crap. It's somehow ended up in patch 4 instead. Will fix, thanks.

OK.

>>> +	.rmii_pins	= eth_rmii_pins,
>>> +	.nr_rmii_pins	= ARRAY_SIZE(eth_rmii_pins),
>>>  };
>>>
>>> -void __init at91_add_device_eth(struct at91_eth_data *data)
>>> -{
>>> -	if (!data)
>>> -		return;
>>> -
>>> -	if (data->phy_irq_pin) {
>>> -		at91_set_gpio_input(data->phy_irq_pin, 0);
>>> -		at91_set_deglitch(data->phy_irq_pin, 1);
>>> -	}
>>> -
>>> -	/* Only RMII is supported */
>>> -	data->is_rmii = 1;
>> 
>> How is this set for this platfrom?
>
> By having mii_pins set to NULL. The devices.c code now does:
>
>	if (!data->is_rmii && info->mii_pins)
>		...

Ah, see that now. OK.

>>> diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
>>> index 59fc483..3c0959f 100644
>>> --- a/arch/arm/mach-at91/at91sam9261_devices.c
>>> +++ b/arch/arm/mach-at91/at91sam9261_devices.c
>>> @@ -1044,7 +1044,6 @@ void __init at91_set_serial_console(unsigned portnr) {}
>>>  void __init at91_add_device_serial(void) {}
>>>  #endif
>>>  
>>> -
>>> 
>> Nit. Unrelated whitespace change.
>
> Thanks, will clean this up.

OK.

>>> +static struct platform_device at91_eth_device = {
>>> +	.name		= "macb",
>>> +	.id		= -1,
>>> +	.dev		= {
>>> +				.dma_mask		= &eth_dmamask,
>>> +				.coherent_dma_mask	= DMA_BIT_MASK(32),
>>> +				.platform_data		= &eth_data,
>> 
>> Nit.  Excessive whitespace.
>
> This is cut and pasted from one of the *_devices.c files so the change
> is minimal.

It's just a bit ugly... ;-)

>>> +#else
>>> +void __init at91_add_device_eth(struct at91_eth_data *data) {}
>> 
>> inline maybe?
>
> No. This is also cut and pasted from the *_devices.c files so the change
> is minimal. The compiler should out-right remove this anyway so it
> shouldn't need to be inline.

It appears the inline format is more widely used than the __init format.  Granted
this is a bit gross but:

$ git grep 'inline' | grep ') {}' | wc -l
577
$ git grep 'inline' | grep ') { }' | wc -l
451
$ git grep '__init' | grep ') {}' | wc -l
109
$ git grep '__init' | grep ') { }' | wc -l
20

For that matter mach-at91 has most of the __init formats:

$ git grep 'inline' arch/arm/mach-at91 | grep ') {}' | wc -l
0
$ git grep 'inline' arch/arm/mach-at91 | grep ') { }' | wc -l
0
$ git grep '__init' arch/arm/mach-at91 | grep ') {}' | wc -l
87
$ git grep '__init' arch/arm/mach-at91 | grep ') { }' | wc -l
0

But, as you wish... ;-)

Regards,
Hartley
