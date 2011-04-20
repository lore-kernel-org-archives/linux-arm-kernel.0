From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 20 Apr 2011 12:34:24 +0200
Subject: [RFC PATCH 02/23] at91: Make Ethernet device common
In-Reply-To: <20110420083636.GU31131@pengutronix.de>
References: <1303261827-27730-1-git-send-email-ryan@bluewatersys.com>
	<1303261827-27730-3-git-send-email-ryan@bluewatersys.com>
	<20110420083636.GU31131@pengutronix.de>
Message-ID: <20110420103424.GG4204@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > + * -------------------------------------------------------------------- */
> > +
> > +#if defined(CONFIG_MACB) || defined(CONFIG_MACB_MODULE)
> > +static u64 eth_dmamask = DMA_BIT_MASK(32);
> > +static struct at91_eth_data eth_data;
> > +
> > +static struct resource eth_resources[] = {
> > +	[0] = {
> > +		.end	= SZ_16K,
> > +		.flags	= IORESOURCE_MEM,
> > +	},
> > +	[1] = {
> > +		.flags	= IORESOURCE_IRQ,
> > +	},
> > +};
> > +
> > +static struct platform_device at91_eth_device = {
> > +	.name		= "macb",
> > +	.id		= -1,
> > +	.dev		= {
> > +				.dma_mask		= &eth_dmamask,
> > +				.coherent_dma_mask	= DMA_BIT_MASK(32),
> > +				.platform_data		= &eth_data,
> > +	},
> > +	.resource	= eth_resources,
> > +	.num_resources	= ARRAY_SIZE(eth_resources),
> > +};
> > +
> > +void __init at91_add_device_eth(struct at91_eth_data *data)
> > +{
> > +	struct at91_dev_table_ethernet *info = devices->ethernet;
> > +
> > +	BUG_ON(!info);
> > +	init_resource_mem(&eth_resources[0], info->mmio_base);
> > +	init_resource_irq(&eth_resources[1], info->irq);
> > +
> > +	if (!data)
> > +		return;
> > +
> > +	if (data->phy_irq_pin) {
> > +		at91_set_gpio_input(data->phy_irq_pin, 0);
> > +		at91_set_deglitch(data->phy_irq_pin, 1);
> > +	}
> > +
> > +	/* Pins used for MII and RMII */
> > +	at91_config_pins(info->rmii_pins, info->nr_rmii_pins);
> > +	if (!data->is_rmii && info->mii_pins)
> > +		at91_config_pins(info->mii_pins, info->nr_mii_pins);
> > +
> > +	eth_data = *data;
> > +	platform_device_register(&at91_eth_device);
> > +}
> > +#else
> > +void __init at91_add_device_eth(struct at91_eth_data *data) {}
> > +#endif
> > +
> >  void __init at91_init_devices(struct at91_device_table *device_table)
> >  {
> >  	devices = device_table;
> > diff --git a/arch/arm/mach-at91/devices.h b/arch/arm/mach-at91/devices.h
> > index 738f736..7bed3e7 100644
> > --- a/arch/arm/mach-at91/devices.h
> > +++ b/arch/arm/mach-at91/devices.h
> > @@ -28,7 +28,17 @@ struct at91_pin_config {
> >  	int value;
> >  };
> >  
> > +struct at91_dev_table_ethernet {
> > +	unsigned 		mmio_base;
> > +	int 			irq;
> > +	struct at91_pin_config	*rmii_pins;
> > +	int 			nr_rmii_pins;
> > +	struct at91_pin_config	*mii_pins;
> > +	int 			nr_mii_pins;
> > +};
> > +
> >  struct at91_device_table {
> > +	struct at91_dev_table_ethernet		*ethernet;
> >  };
> I wonder if it's a good idea to collect all data in a single cross-SoC
> table. Consider a new SoC that has a new type of device, then you need
> to expand this struct for only a single user. Moreover expanding this
> struct will result in merge conflicts when >1 patch touches it.
> If I understand your approach correctly you will have a single per-SoC
> function that initialises all devices, right? If so, how do you handle
> machines that don't have ethernet or that don't have handshake lines for
> an UART?
> 
> For mxc I used dedicated functions instead of a generic struct. (This
> isn't optimal also, because there is still a single header file, but
> when the functions are moved near the drivers I think that would be
> fine.) See arch/arm/plat-mxc/include/mach/devices-common.h,
> arch/arm/mach-imx/devices-imx27.h (et al) and
> arch/arm/plat-mxc/devices/* for the details.
> 
> Maybe this helps to consolidate cross-platform device registration.
I've start to work olso on the function level as you do Uwe I'll take a look
this week-end to make merge both of them

but in my mind I like the idea to have pull of available ressources and the
you register the one your are interested in

as I plan to add the multi soc the idea of a structure is good so you have
generic ressource registration function for all IP available on AT91 and then
each soc declare it

Maybe we could use early devices for this or a dedicated framework so the soc
declare his capabilitues

Best Regards,
J.
