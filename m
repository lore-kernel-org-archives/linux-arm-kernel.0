From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Aug 2011 19:16:52 +0200
Subject: How to handle named resources with DT?
In-Reply-To: <alpine.DEB.2.00.1108271306500.23968@utopia.booyaka.com>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<5595208.OB5dBohxQP@wuerfel>
	<alpine.DEB.2.00.1108271306500.23968@utopia.booyaka.com>
Message-ID: <201108291916.52571.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 27 August 2011, Paul Walmsley wrote:
> On Sat, 27 Aug 2011, Arnd Bergmann wrote:
> 
> > Right, and I guess we can simply ignore DMA and ioport resources because 
> > they are extremely rare, right?
> 
> DMA resources are quite widely used.
> 
> For example, looking at the SoCs with some publicly-available 
> documentation, the Motorola i.MX51 reference manual lists 47 SDMA request 
> lines across about 17 different IP block types[1], and to pick a 
> representative OMAP, the OMAP3430 technical reference manual lists 77 SDMA 
> request lines, used by at least 9 different IP block types[2].
> 
> Also, many IP blocks have multiple DMA resources.  For example, the above 
> references list UART, MCSPI, PATA, I2C, FIRI, MCBSP, SSI, CTI, CSPI, 
> eCSPI, EMI, eSDHC, SPI, and DSS.

I don't doubt that many devices have a DMA controllers with multiple
channels, but I think the last time we discussed those, the conclusion
was that they should not actually be represented as DMA resources.

The problem with DMA resources is that they assume the presence of
a global number space for DMA channel numbers, while in reality a
lot of devices have multiple DMA controllers that have independent
channel numbers.

We should have a proper device tree binding for dma-controllers that
enables us to find both the channel and the controller in a simple
dma-controller API call without having to resort to global numbers.

In a way that is the same with IRQ numbers, however the concept of
a global number space for interrupt lines is used in so many places
in the kernel that we can't reasonably move away from that. For
dma-engine drivers, the concept does not exist in a driver-independent
way and we should not introduce it.

	Arnd
