From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Jun 2013 16:35:45 +0200
Subject: DMA channels (was Re: [PATCH 2/2] ARM: shmobile: sdhi: remove DMA
 hardware dependencies)
In-Reply-To: <Pine.LNX.4.64.1306261024280.8856@axis700.grange>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
 <201306192351.50804.arnd@arndb.de>
 <Pine.LNX.4.64.1306261024280.8856@axis700.grange>
Message-ID: <201306261635.45579.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 June 2013, Guennadi Liakhovetski wrote:
> > The problem with this is that on a lot of dma engines you have one channel
> > per slave (in particular with virt-dma.c), so the slave-id has to be
> > part of the filter data. Since the slave driver cannot know what kind
> > of DMA engine it is connected to, it has to assume that the slave-id
> > is inherent to the channel an cannot change.
> > Also, the DT binding is built around the idea that you identify the
> > channel or request line with the specifier in whichever form the
> > dma engine requires, and there is no general way for the slave driver
> > to find out a slave id. Setting it with dma_slave_config is inherently
> > nonportable, and we should stop doing that.
> 
> Don't you think, that this situation, where without DT a filter function 
> has to be used, which has to be provided by the platform and is just a 
> kind of a platform callback; and with DT channels are selected and 
> configured by a reference to suitable DMAC instances and a hardware- 
> specific data set is suboptimal? Wouldn't it be better to unify it?
> 
> If yes, the unification would go in the direction of DT compatibility, 
> i.e. dropping filter functions and just directly referencing required 
> DMACs and using DMAC-specific configuration?

With the introduction of dma_request_slave_channel() we tried to
only change the cases going forward with DT, SFI and ACPI but
without changing the interface for the existing drivers, which
are highly inconsistent at the moment (filter function being defined
in the slave driver /or/ the platform /or/ the dmaengine driver).

> Wouldn't a channel requesting 
> API, similar to that for requesting clocks, pinmux settings be a better 
> option, than the current filtering procedure? Something like
> 
>         dma_request_slave_channel(dev, "tx", "dmac0", config);
> 
> in a simple case of just one suitable DMAC, or a NULL if DMACs should be 
> able to figure out themselves, whether they can serve this slave, or 
> something like "dmamux0" if there is a multiplexer, for which a driver has 
> to be available, and in which case "config" would be that multiplexer 
> driver's configuration?

I think what you suggest here is very similar to the existing
dma_request_slave_channel_compat() function, except that you
pass a string ("dmac0") instead of the filter function pointer,
and that string presumably also has to come from the platform,
since there is no other way for the driver to know it, right?

One idea that Vinod suggested was that the platform could register
a table of DMA configurations with the dmaengine core to do the
lookup by device and string. That would actually help unify the
API to the current dma_request_slave_channel(dev, name) form
for all the possible cases (DT, ACPI, SFI, platform_data).

In essence, the platform would have a table like clk_lookup
but also containing the config:

struct dma_lookup {
	struct list_head node;
	const char *dev_id;	/* the slave device */
	const char *con_id;	/* request line of the slave, e.g. "rx" */
	const char *dmadev_id;	/* master device name */
	void *slave_id;		/* data passed to the master */
};

	Arnd
