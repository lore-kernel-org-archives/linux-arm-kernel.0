From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 7 Jun 2013 17:32:35 +0200 (CEST)
Subject: [PATCH 2/2] ARM: shmobile: sdhi: remove DMA hardware dependencies
In-Reply-To: <201306071653.21668.arnd@arndb.de>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
 <2024464.67s93nOUnz@wuerfel>
 <Pine.LNX.4.64.1306071507060.11277@axis700.grange>
 <201306071653.21668.arnd@arndb.de>
Message-ID: <Pine.LNX.4.64.1306071659290.11277@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Jun 2013, Arnd Bergmann wrote:

> On Friday 07 June 2013, Guennadi Liakhovetski wrote:
> > > I think that is a flaw in the dmaengine driver. I don't actually know how
> > > any dma-engine driver could use dmaengine_slave_config to pick the request
> > > line, since that is something the driver should not know at the time
> > > it calls dmaengine_slave_config().
> > > 
> > > It's probably best to change the shdma driver to just ignore the slave_id
> > > value in slave_config, like most other drivers to.
> > 
> > This is how shdma driver used to work. We used to pass the slave ID (DMA 
> > request line ID) to shdma from clients from the filter. This was 
> > considered bad and we were asked to switch to using 
> > dmaengine_slave_config(), which is the current preferred API, IIUC.
> 
> I think you misunderstood the requirement. All other configuration,
> i.e. slave port address, burst size, bus width, really should be
> configured using dmaengine_slave_config, since this is data that
> is known by the /driver/, independent of the DMA engine in use and
> unknown to the platform. The request line number is something that
> the driver cannot know, since it is a property of the DMA engine.

Isn't it a board property? In case of external devices, or an SoC property 
in case of integrated DMA slave and controller? Let me try to explain. The 
DMAC has to configure the controller to "link" a specific DMA channel to a 
slave request line. E.g. to link an internal channel #0 to SDHI0 tx. To do 
this it has to write specific "magic" values in certain DMAC registers. 
Those values aren't known to the DMAC driver, they are a property of the 
SoC. Let's say, the SoC has 3 DMAC instances, each of them can serve any 
of compatible DMA slaves, including SDHI0, on each of their 6 channels. To 
configure a channel on a DMAC instance for SDHI0 tx you have to write to 
that channel's config register a certain value, that cannot be calculated. 

Those values are only known to the SoC code, so, they are passed as 
platform parameters to the DMAC driver. Now, when SDHI0 asks DMAC to set 
up a DMA channel for its tx, the DMAC driver has to find that value in its 
platform data. In most cases you could use the client address (e.g. FIFO 
register) and direction to find that value. But, I think, that might not 
always be enough. So, we use unique enum values to find those values in 
DMAC platform data. The SDHI driver gets that enum value in its platform 
data, passes it to the DMAC driver as a slave ID, and the DMAC driver uses 
it to find the value(s), it needs to set up its DMA channel. Do you see a 
better way to do the same?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
