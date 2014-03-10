From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Mar 2014 15:11:57 +0100
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <1394459790.2270.39.camel@shinybook.infradead.org>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
 <20110101151545.GC25924@n2100.arm.linux.org.uk>
 <1394459790.2270.39.camel@shinybook.infradead.org>
Message-ID: <5345792.VhzckVI5HA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 March 2014 06:56:30 David Woodhouse wrote:
> It is not impossible for the DMA controller to "delegate" transactions
> so that (to the IOMMU) they appear to come from the individual slave
> device rather than from itself.
> 
> The Intel IOMMU has now gained support for DMA mapping for devices
> enumerated by ACPI ? essentially the ACPI "DMAR" table just has a lookup
> table of ACPI device paths, and tells us the PCI bus/devfn that their
> DMA transactions will *appear* to be from.

This makes a lot of sense for standalone DMA masters enumerated by ACPI,
but I fail to see what the purpose of that would be when the DMA
is delegated to a separate DMA engine devices. Do you have an idea?

It sounds to me that they are trying to isolate the DMA masters
because the slave driver is not trusted for some reason, yet the
DMA engine driver that does the DMA is trusted.

> Of course, it's also possible that all these BIOSes are broken and they
> *should* just list the DMA controller itself, instead of all the slave
> devices. But while I'm always quick to jump to the conclusion that it's
> the BIOS at fault, that doesn't necessarily seem likely here...

It would be good to verify this anyway. There are multiple reasons why
we have to pass the dmaengine device to the dma-mapping API at the moment
rather than the slave device, but in essence it comes down to the engine
being the one that is the master on its parent bus. A trivial example
where it goes wrong would be the slave living on a 32-bit noncoherent bus
and the master living on a 64-bit coherent bus.

	Arnd
