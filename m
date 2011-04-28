From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 28 Apr 2011 12:57:45 -0500
Subject: [PATCH v2 02/23] at91: Make Ethernet device common
In-Reply-To: <20110428091517.GP17290@n2100.arm.linux.org.uk>
References: <1303364535-11557-1-git-send-email-ryan@bluewatersys.com>
	<1303364535-11557-3-git-send-email-ryan@bluewatersys.com>
	<0D753D10438DA54287A00B027084269764D24302CC@AUSP01VMBX24.collaborationhost.net>
	<20110428091517.GP17290@n2100.arm.linux.org.uk>
Message-ID: <0D753D10438DA54287A00B027084269764D26C44B4@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 28, 2011 2:15 AM, Russell King wrote:
> On Thu, Apr 21, 2011 at 06:19:37PM -0500, H Hartley Sweeten wrote:
>> +static struct platform_device at91_eth_device = {
>> +	.name		= "macb",
>> +	.id		= -1,
>> +	.dev		= {
>> +		.dma_mask		= &at91_eth_device.dev.coherent_dma_mask,
>> +		.coherent_dma_mask	= DMA_BIT_MASK(32),
>> 
>> That will get rid of the static u64 variable used for every dma
>> capable device.
>
> I've never really liked that, because coherent_dma_mask is never changed,
> but the value pointed to be dma_mask can be by drivers.  See dma_set_mask().
>
> So, calling dma_set_mask() on any device which does the above will also
> (unexpectedly?) change the coherent mask too.
>
> It's a minor point as we don't have many platform drivers using
> dma_set_mask().

So, if I understand this correctly...

1) dev.coherent_dma_mask is a constant that defines the default dma mask of
the device.

2) dev.dma_mask is a pointer to the dma mask that is being used by the device.

3) The static variable pointed to by dev.dma_mask holds the dma mask being
used by the device.  The value can be modified by the driver.

Why couldn't a new field be added to struct device to replace the static
variable?  The code that sets up the device could do something like:

	dev.used_dma_mask = dev.coherent_dma_mask;
	dev.dma_mask = &dev.used_dma_mask;

Then all that needs to be set in the init code is:

	.dev	= {
		.coherent_dma_mask	= DMA_BIT_MASK(32),
	},

Drivers can then change the value pointer to be dma_mask as needed.

Regards,
Hartley
