From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 26 Apr 2011 08:15:19 +1200
Subject: [PATCH v2 02/23] at91: Make Ethernet device common
In-Reply-To: <0D753D10438DA54287A00B027084269764D24302CC@AUSP01VMBX24.collaborationhost.net>
References: <1303364535-11557-1-git-send-email-ryan@bluewatersys.com>
	<1303364535-11557-3-git-send-email-ryan@bluewatersys.com>
	<0D753D10438DA54287A00B027084269764D24302CC@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4DB5D657.2040103@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2011 11:19 AM, H Hartley Sweeten wrote:
> On Wednesday, April 20, 2011 10:42 PM, Ryan Mallon wrote:
>>
>> Replace the individual Ethernet device code for each at91 variant with
>> a single implementation in devices.
>>
>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> 
> [snip]
> 
>> diff --git a/arch/arm/mach-at91/devices.c b/arch/arm/mach-at91/devices.c
>> index 6f6e0d5..4ecbd38 100644
>> --- a/arch/arm/mach-at91/devices.c
>> +++ b/arch/arm/mach-at91/devices.c
>> @@ -14,8 +14,11 @@
>>   */
>>  
>>  #include <linux/platform_device.h>
>> +#include <linux/dma-mapping.h>
>>  #include <linux/gpio.h>
>>  
>> +#include <mach/board.h>
>> +
>>  #include "devices.h"
>>  
>>  static struct at91_device_table *devices __initdata;
>> @@ -64,6 +67,64 @@ static inline void __init init_resource_irq(struct resource *res, int irq)
>>  	}
>>  }
>>  
>> +/* --------------------------------------------------------------------
>> + *  Ethernet
>> + * -------------------------------------------------------------------- */
>> +
>> +#if defined(CONFIG_MACB) || defined(CONFIG_MACB_MODULE)
>> +static u64 eth_dmamask = DMA_BIT_MASK(32);
>> +static struct at91_eth_data eth_data;
>> +
>> +static struct resource eth_resources[] = {
>> +	[0] = {
>> +		.end	= SZ_16K,
>> +		.flags	= IORESOURCE_MEM,
>> +	},
>> +	[1] = {
>> +		.flags	= IORESOURCE_IRQ,
>> +	},
>> +};
>> +
>> +static struct platform_device at91_eth_device = {
>> +	.name		= "macb",
>> +	.id		= -1,
>> +	.dev		= {
>> +				.dma_mask		= &eth_dmamask,
>> +				.coherent_dma_mask	= DMA_BIT_MASK(32),
> 
> Doesn't this work also?
> 
> +static struct platform_device at91_eth_device = {
> +	.name		= "macb",
> +	.id		= -1,
> +	.dev		= {
> +		.dma_mask		= &at91_eth_device.dev.coherent_dma_mask,
> +		.coherent_dma_mask	= DMA_BIT_MASK(32),
> 
> That will get rid of the static u64 variable used for every dma capable device.

Possibly. I think it should be done as a separate patch though. I've
tried to introduce as little code change as possible with this patch set
to avoid introducing additional bugs.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
