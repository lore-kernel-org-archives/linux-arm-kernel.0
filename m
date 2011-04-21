From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 21 Apr 2011 19:13:08 +1200
Subject: [PATCH v2 16/23] at91: Make LCD controller device common
In-Reply-To: <20110421070227.GF31131@pengutronix.de>
References: <1303364535-11557-1-git-send-email-ryan@bluewatersys.com>
	<1303364535-11557-17-git-send-email-ryan@bluewatersys.com>
	<20110421070227.GF31131@pengutronix.de>
Message-ID: <4DAFD904.409@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/04/11 19:02, Uwe Kleine-K?nig wrote:
> Hello Ryan,
> 
> On Thu, Apr 21, 2011 at 05:42:08PM +1200, Ryan Mallon wrote:
>> Replace the individual LCD controller device code for each at91 variant with a
>> single implementation in devices.c
>>
>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>

<snip>

>> +static struct platform_device at91_lcdc_device = {
>> +	.name		= "atmel_lcdfb",
>> +	.id		= 0,
>> +	.dev		= {
>> +				.dma_mask		= &lcdc_dmamask,
>> +				.coherent_dma_mask	= DMA_BIT_MASK(32),
>> +				.platform_data		= &lcdc_data,
>> +	},
>> +	.resource	= lcdc_resources,
>> +	.num_resources	= ARRAY_SIZE(lcdc_resources),
>> +};
> One difference to my approach (which you can like or not) is that mxc
> uses dynamic allocation of the platform_devices. A struct
> platform_device has a size of 320 bytes. So instead of using
> at91_lcdc_device you could add to at91_add_device_lcdc:
> 
> 	struct platform_device *pdev = platform_device_register_resndata(
> 		NULL, "atmel_lcdfb", 0, &lcdc_resources,
> 		ARRAY_SIZE(lcdc_resources), *data, sizeof(*data));
> 
> with the added benefit that lcdc_resources and *data can be __initdata
> (or __initconst) to save a few more bytes.
> 
> The obvious downside is that dynamic allocation probably takes more time
> than using static data and so increases the boottime. I didn't measure
> it, but I think the difference is small enough to see over it.

Having the resources and *data also be __initdata would be good. One
reason I have taken the approach I have, rather than what you suggest,
is that my patches introduce minimal change. To create the common
devices.c I have cut and pasted one of the implementations and only made
necessary changes to make it generic to all of the variants rather than
do a complete rewrite. I think that this approach makes the patch series
easier to review and more likely to be correct (less new bugs introduced).

~Ryan
