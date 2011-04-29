From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 29 Apr 2011 21:38:36 +1200
Subject: [PATCH v3 02/23] at91: Make Ethernet device common
In-Reply-To: <20110429090809.GY17290@n2100.arm.linux.org.uk>
References: <1304045972-19319-1-git-send-email-ryan@bluewatersys.com>
	<1304045972-19319-3-git-send-email-ryan@bluewatersys.com>
	<20110429090809.GY17290@n2100.arm.linux.org.uk>
Message-ID: <4DBA871C.1030007@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/04/11 21:08, Russell King - ARM Linux wrote:
> On Fri, Apr 29, 2011 at 02:59:11PM +1200, Ryan Mallon wrote:
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
>> +				.platform_data		= &eth_data,
> 
> These three lines have twice as many tabs as is needed.

Hartley pointed this out also. The reason it is this way is because I
cut and pasted the code from one of the existing implementations (to
make the changeset minimal). I can fix this if preferred.

> 
>> +	},
>> +	.resource	= eth_resources,
>> +	.num_resources	= ARRAY_SIZE(eth_resources),
>> +};
>> +
>> +void __init at91_add_device_eth(struct at91_eth_data *data)
>> +{
>> +	struct at91_dev_table_ethernet *info = devices->ethernet;
>> +
>> +	BUG_ON(!info);
>> +	init_resource_mem(&eth_resources[0], info->mmio_base);
>> +	init_resource_irq(&eth_resources[1], info->irq);
> 
> Hmm.  How about something like this instead:
> 
> 	struct resource eth_res[2];
> 	int err;
> 
> 	BUG_ON(!info);
> 
> 	init_resource_mem(&eth_res[0], info->mmio_base, SZ_16K);
> 	init_resource_irq(&eth_res[1], info->irq);
> 
> 	...
> 
> 	err = platform_device_add_resources(&at91_eth_device, eth_res, 2);
> 	if (err) {
> 		pr_err("eth: unable to add resources: %d\n", err);
> 		return;
> 	}
> 
> 	err = platform_device_add_data(&at91_eth_device, data, sizeof(*data));
> 	if (err) {
> 		pr_err("eth: unable to add platform data: %d\n", err);
> 		/* res leaked */
> 		return;
> 	}
> 
> 	err = platform_device_register(&at91_eth_device);
> 	if (err) {
> 		pr_err("eth: unable to register device: %d\n", err);
> 		/* res and data leaked */
> 	}
> 
> With Uwe's patches, we can plug those leaks.  Note that we can't use
> platform_device_register_resndata() because it doesn't set the DMA
> masks etc (which is one of the problems I've always had with interfaces
> which try to wrap too much stuff up - they always lack something.)
> 
> This would get rid of the need to have the resources and platform
> data storage declared for each and every device.  I'd suggest wrapping
> the last bit adding the platform data and resources up in its own
> function common to each device as its going to be the same for
> everything.  Remember to pass the size of the platform data though.

That seems sensible. It should be possible to make the whole lot
generic. i.e.

static void __init add_device(struct device *dev, struct resource *res,
				int nr_res, void *data,
				size_t data_size)
{
	if (res) {
 		err = platform_device_add_resources(dev, res, nr_res);
 		if (err) {
 			pr_err("eth: unable to add resources: %d\n", err);
 			return;
 		}
	}

	if (data) {
 		err = platform_device_add_data(dev, data, data_size);
 		if (err) {
 			pr_err("eth: unable to add platform data: %d\n", err);
 			/* res leaked */
 			return;
 		}
	}

 	err = platform_device_register(dev);
 	if (err) {
 		pr_err("eth: unable to register device: %d\n", err);
 		/* res and data leaked */
 	}	
}

void __init at91_add_device_eth(struct at91_eth_data *data)
{
	struct at91_dev_table_ethernet *info = devices->ethernet;
	struct resource res[2];

	BUG_ON(!info);
	init_resource_mem(&res[0], info->mmio_base, SZ_16K);
	init_resource_irq(&res[1], info->irq);
	add_device(&at91_eth_device, res, ARRAY_SIZE(res),
			 data, sizeof(*data));
}

Is this what you mean?

~Ryan
