From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Jun 2013 23:51:50 +0200
Subject: [PATCH 2/2] ARM: shmobile: sdhi: remove DMA hardware dependencies
In-Reply-To: <Pine.LNX.4.64.1306192132290.12502@axis700.grange>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
 <201306071806.16031.arnd@arndb.de>
 <Pine.LNX.4.64.1306192132290.12502@axis700.grange>
Message-ID: <201306192351.50804.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 June 2013, Guennadi Liakhovetski wrote:
> > Ah, so you have multiple values, too, and you just abstract them by using
> > an enum to index an array of platform_data in the dma engine.
> > 
> > This obviously works as well, and lets you get away with a single 32-bit
> > enum to use as the slave-id. However, I think slave drivers should not
> > be written with the assumption that all dma-engine drivers do this.
> > In particular, you seem to assume that the argument to the filter function
> > is not a pointer but this enum.
> > 
> > It also gets more complicated with the DT binding, since that should
> > reflect the hardware settings, i.e. not an arbitrarily defined enum
> > but the data that you have in your array. To keep the DT and platform_data
> > cases similar, I would suggest you actually remove the array listing
> > the per-slave data, and move that data instead as an opaque pointer into
> > the platform data. You can take a look at drivers/mmc/host/mmci.c for
> > an example of a driver that does this and that is portable across
> > multiple DMA engine drivers.
> > 
> > Essentially we pass the dma_filter function and dma_param struct pointers
> > to dma_request_channel directly from the platform_data, without trying
> > to interpret them. In case of stedma40, the dma_param contains a complex
> > data structure, while for others it may contain a single integer.
> 
> And what happens then? How do those parameters get used by the stedma40 
> driver to configure the hardware? I see, in its filter function the 
> stedma40 driver is storing the configuration in the driver private channel 
> struct for later use. SHDMA used to do the same (ok, we used the .private 
> pointer for that, but essentially it was the same), but we were told to 
> stop doing that. The filter function should only verify, whether a channel 
> is suitable, and not set any configuration. That's what the 
> dmaengine_slave_config() function is for, including the .slave_id 
> parameter in struct dma_slave_config.

The problem with this is that on a lot of dma engines you have one channel
per slave (in particular with virt-dma.c), so the slave-id has to be
part of the filter data. Since the slave driver cannot know what kind
of DMA engine it is connected to, it has to assume that the slave-id
is inherent to the channel an cannot change.
Also, the DT binding is built around the idea that you identify the
channel or request line with the specifier in whichever form the
dma engine requires, and there is no general way for the slave driver
to find out a slave id. Setting it with dma_slave_config is inherently
nonportable, and we should stop doing that.

	Arnd
