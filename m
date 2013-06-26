From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 26 Jun 2013 12:10:29 +0200 (CEST)
Subject: DMA channels (was Re: [PATCH 2/2] ARM: shmobile: sdhi: remove DMA
 hardware dependencies)
In-Reply-To: <201306192351.50804.arnd@arndb.de>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
 <201306071806.16031.arnd@arndb.de>
 <Pine.LNX.4.64.1306192132290.12502@axis700.grange>
 <201306192351.50804.arnd@arndb.de>
Message-ID: <Pine.LNX.4.64.1306261024280.8856@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

I think it would be good to come to a certain conclusion regarding the 
current dmaengine channel selection and configuration API and its possibly 
desired amendments.

On Wed, 19 Jun 2013, Arnd Bergmann wrote:

[snip]

> The problem with this is that on a lot of dma engines you have one channel
> per slave (in particular with virt-dma.c), so the slave-id has to be
> part of the filter data. Since the slave driver cannot know what kind
> of DMA engine it is connected to, it has to assume that the slave-id
> is inherent to the channel an cannot change.
> Also, the DT binding is built around the idea that you identify the
> channel or request line with the specifier in whichever form the
> dma engine requires, and there is no general way for the slave driver
> to find out a slave id. Setting it with dma_slave_config is inherently
> nonportable, and we should stop doing that.

Don't you think, that this situation, where without DT a filter function 
has to be used, which has to be provided by the platform and is just a 
kind of a platform callback; and with DT channels are selected and 
configured by a reference to suitable DMAC instances and a hardware- 
specific data set is suboptimal? Wouldn't it be better to unify it?

If yes, the unification would go in the direction of DT compatibility, 
i.e. dropping filter functions and just directly referencing required 
DMACs and using DMAC-specific configuration? Wouldn't a channel requesting 
API, similar to that for requesting clocks, pinmux settings be a better 
option, than the current filtering procedure? Something like

	dma_request_slave_channel(dev, "tx", "dmac0", config);

in a simple case of just one suitable DMAC, or a NULL if DMACs should be 
able to figure out themselves, whether they can serve this slave, or 
something like "dmamux0" if there is a multiplexer, for which a driver has 
to be available, and in which case "config" would be that multiplexer 
driver's configuration?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
