From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 26 Jun 2013 21:18:55 +0530
Subject: DMA channels (was Re: [PATCH 2/2] ARM: shmobile: sdhi: remove
 DMA hardware dependencies)
In-Reply-To: <201306261635.45579.arnd@arndb.de>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
 <201306192351.50804.arnd@arndb.de>
 <Pine.LNX.4.64.1306261024280.8856@axis700.grange>
 <201306261635.45579.arnd@arndb.de>
Message-ID: <20130626154855.GT23141@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 04:35:45PM +0200, Arnd Bergmann wrote:
> On Wednesday 26 June 2013, Guennadi Liakhovetski wrote:
> > > The problem with this is that on a lot of dma engines you have one channel
> > > per slave (in particular with virt-dma.c), so the slave-id has to be
> > > part of the filter data. Since the slave driver cannot know what kind
> > > of DMA engine it is connected to, it has to assume that the slave-id
> > > is inherent to the channel an cannot change.
> > > Also, the DT binding is built around the idea that you identify the
> > > channel or request line with the specifier in whichever form the
> > > dma engine requires, and there is no general way for the slave driver
> > > to find out a slave id. Setting it with dma_slave_config is inherently
> > > nonportable, and we should stop doing that.
> > 
> > Don't you think, that this situation, where without DT a filter function 
> > has to be used, which has to be provided by the platform and is just a 
> > kind of a platform callback; and with DT channels are selected and 
> > configured by a reference to suitable DMAC instances and a hardware- 
> > specific data set is suboptimal? Wouldn't it be better to unify it?
> > 
> > If yes, the unification would go in the direction of DT compatibility, 
> > i.e. dropping filter functions and just directly referencing required 
> > DMACs and using DMAC-specific configuration?
> 
> With the introduction of dma_request_slave_channel() we tried to
> only change the cases going forward with DT, SFI and ACPI but
> without changing the interface for the existing drivers, which
> are highly inconsistent at the moment (filter function being defined
> in the slave driver /or/ the platform /or/ the dmaengine driver).
> 
> > Wouldn't a channel requesting 
> > API, similar to that for requesting clocks, pinmux settings be a better 
> > option, than the current filtering procedure? Something like
> > 
> >         dma_request_slave_channel(dev, "tx", "dmac0", config);
> > 
> > in a simple case of just one suitable DMAC, or a NULL if DMACs should be 
> > able to figure out themselves, whether they can serve this slave, or 
> > something like "dmamux0" if there is a multiplexer, for which a driver has 
> > to be available, and in which case "config" would be that multiplexer 
> > driver's configuration?
> 
> I think what you suggest here is very similar to the existing
> dma_request_slave_channel_compat() function, except that you
> pass a string ("dmac0") instead of the filter function pointer,
> and that string presumably also has to come from the platform,
> since there is no other way for the driver to know it, right?
> 
> One idea that Vinod suggested was that the platform could register
> a table of DMA configurations with the dmaengine core to do the
> lookup by device and string. That would actually help unify the
> API to the current dma_request_slave_channel(dev, name) form
> for all the possible cases (DT, ACPI, SFI, platform_data).
> 
> In essence, the platform would have a table like clk_lookup
> but also containing the config:
> 
> struct dma_lookup {
> 	struct list_head node;
> 	const char *dev_id;	/* the slave device */
> 	const char *con_id;	/* request line of the slave, e.g. "rx" */
> 	const char *dmadev_id;	/* master device name */
> 	void *slave_id;		/* data passed to the master */
> };
Let me describes the scenarios we want to solve:
1. dma controllers with SW mux:
	In this case the dma controller has SW mux to connect to periphrals.
The mux is programmed to talk to a slave controller. SO we can grab any channel
from that controller, we just need to pass the mux value.
Ideally, in this scenario virtual channels should be described by driver (not
one per physical channel though) and driver uses mux values to transfer to
periphrals

2. dma controllers with hardwired channels:
	In this case you need a channel from a controller A and also channel X,
as it is hard wired to periphral. This is quite common in bunch of drivers.
In this case we just have to look for this channel.

3. MIX
	Yes, I believe we have controllers where they have SW mux as well as
hard wired.

In case of 1 and 3a(sw), we just need controller info
In 2 and3b we need both info

SO the idea was that DT, ACPI pdata etc just tells me that how the assignments
should be done and at runtime dmanegine just does that.

This is what I had in mind (more on same lines as above)
struct dmaengine_slave_map {
	char *dma;	/* dma controller */
	char *client;	/* client */
	int ch;		/* specfic channel id, NULL for SW muxes */
	int slave_id;	/* request line */
	struct dmaengine_slave_map_entries *entry;
};
https://lkml.org/lkml/2012/9/14/139

This way we just ask for a channel and dmaengine know what to do.

No filter functions, no multiple request methods etc.

--
~Vinod
