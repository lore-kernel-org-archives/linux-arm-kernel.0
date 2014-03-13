From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Mar 2014 09:52:17 +0100
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <CACRpkdZrRYY0U5zDwoKRarAH=W6UmxGKX_gWR6nYPM64t6Dzpg@mail.gmail.com>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
 <1394463171.2270.54.camel@shinybook.infradead.org>
 <CACRpkdZrRYY0U5zDwoKRarAH=W6UmxGKX_gWR6nYPM64t6Dzpg@mail.gmail.com>
Message-ID: <4757683.7Ln0Vh5c4G@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 March 2014 09:17:04 Linus Walleij wrote:
> 
> Again as Russell stated that doesn't necessarily influence any memory
> coherency or the physical address pointer written into the DMAC
> hardware at all, does it? The transfers can still happen between the
> peripheral and DMAC, and the IOMMU can still be sitting in the middle
> of things, in front of the DMAC not the device, needing to be flushed etc.
> 
> Sorry if I don't get it... maybe this is one of these funny Intel things
> I cannot wrap my head around properly.

The device pointer we pass into dma_map_* can be used for anything that
the underlying dma_map_ops implementation requires. This includes
determining:

* coherency
* offsets between bus and cpu physical address
* presence of IOMMU
* limits in available bus address space (dma_mask)
* iommu context ID (normally the location on the PCI bus)

The difference is that on ARM we usually care about the first
four, which may be different for each device. The case that Dave is
interested in is when these four are known implicitly but the fifth
one is not know but depends on the slave device.

	Arnd
