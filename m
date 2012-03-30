From: prylowski@metasoft.pl (Rafal Prylowski)
Date: Fri, 30 Mar 2012 10:29:48 +0200
Subject: [PATCH 2/3] ep93xx: IDE driver platform support code
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F00206970255B6@AUSP01VMBX24.collaborationhost.net>
References: <4F7418E7.4060500@metasoft.pl> <4F741B07.7040107@metasoft.pl>
 <ADE657CA350FB648AAC2C43247A983F00206970255B6@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4F756EFC.3080501@metasoft.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-03-29 18:26, H Hartley Sweeten wrote:
>> +/*************************************************************************
>> + * EP93xx IDE
>> + *************************************************************************/
>> +static struct resource ep93xx_ide_resources[] = {
>> +	[0] = {
>> +		.start	= EP93XX_IDE_PHYS_BASE,
>> +		.end	= EP93XX_IDE_PHYS_BASE + 0xffff,
>> +		.flags	= IORESOURCE_MEM,
>> +	},
>> +	[1] = {
>> +		.start	= IRQ_EP93XX_EXT3,
>> +		.end	= IRQ_EP93XX_EXT3,
>> +		.flags	= IORESOURCE_IRQ,
>> +	},
>> +};
> 
> Please use the DEFINE_RES_* macros.
> Also, the last register in the IDE interface is at offset 0x34, so something like this:
> 
> static struct resource ep93xx_ide_resources[] = {
> 	DEFINE_RES_MEM(EP93XX_IDE_PHYS_BASE, 0x38),
> 	DEFINE_RES_IRQ(IRQ_EP93XX_EXT3),
> };
> 

Ok. Will do.

>> +void __init ep93xx_register_ide(void)
>> +{
>> +	/* GPIO ports E, G and H used by IDE */
>> +	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_EONIDE |
>> +				 EP93XX_SYSCON_DEVCFG_GONIDE |
>> +				 EP93XX_SYSCON_DEVCFG_HONIDE);
>> +	platform_device_register(&ep93xx_ide_device);
>> +}
> 
> Please create ep93xx_ide_acquire_gpio and ep93xx_ide_acquire_gpio functions
> to set/clear the necessary SYSCON bits during the probe/remove of the ide driver.
> 
> This should also address your concern mentioned in PATCH 0/3 about making sure
> the pin muxing is correct when the driver is loaded.
> 
> The *_acquire_gpio function should also gpio_request  the pins before setting the
> SYSCON bits. That way if any of the pins are unavailable the driver will not load. Make
> sure to gpio_free the pins in the *_release_gpio function.  Look at how the keypad
> is handled for an example.

Yes, that makes sense. I will add necessary functions and modify the driver accordingly.

Thanks for comments.

Regards,
RP
