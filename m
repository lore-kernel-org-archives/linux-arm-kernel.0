From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Jun 2013 16:53:21 +0200
Subject: [PATCH 2/2] ARM: shmobile: sdhi: remove DMA hardware dependencies
In-Reply-To: <Pine.LNX.4.64.1306071507060.11277@axis700.grange>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
 <2024464.67s93nOUnz@wuerfel>
 <Pine.LNX.4.64.1306071507060.11277@axis700.grange>
Message-ID: <201306071653.21668.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013, Guennadi Liakhovetski wrote:
> > I think that is a flaw in the dmaengine driver. I don't actually know how
> > any dma-engine driver could use dmaengine_slave_config to pick the request
> > line, since that is something the driver should not know at the time
> > it calls dmaengine_slave_config().
> > 
> > It's probably best to change the shdma driver to just ignore the slave_id
> > value in slave_config, like most other drivers to.
> 
> This is how shdma driver used to work. We used to pass the slave ID (DMA 
> request line ID) to shdma from clients from the filter. This was 
> considered bad and we were asked to switch to using 
> dmaengine_slave_config(), which is the current preferred API, IIUC.

I think you misunderstood the requirement. All other configuration,
i.e. slave port address, burst size, bus width, really should be
configured using dmaengine_slave_config, since this is data that
is known by the /driver/, independent of the DMA engine in use and
unknown to the platform. The request line number is something that
the driver cannot know, since it is a property of the DMA engine.

> > I don't see how that
> > could possibly work when used from a portable slave driver.
> 
> A DMA slave ID (DMA request line) is considered to be a portable 
> parameter. I.e. on every platform your DMA slave has to request a DMA 
> request line to the DMAC and that line can be coded with an int. That's 
> the current assumption, I think.

In a lot of cases you actually need more than one number here, e.g.
to configure which master port of the DMA engine is being used.
That's why the dmaengine DT binding needs a variable #dma-cells
property that is specific to the dma engine being used.

	Arnd
