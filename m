From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Apr 2013 11:34:54 +0200
Subject: [PATCH 6/9] crypto: ux500/cryp - Set DMA configuration though
 dma_slave_config()
In-Reply-To: <CACRpkdaBf++gy3sghC-t33uio2+eHp1MrQ2FM0XXBazZTtm3kA@mail.gmail.com>
References: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
 <201304251611.39667.arnd@arndb.de>
 <CACRpkdaBf++gy3sghC-t33uio2+eHp1MrQ2FM0XXBazZTtm3kA@mail.gmail.com>
Message-ID: <1412321.eb7x7S18CK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 April 2013 10:28:39 Linus Walleij wrote:
> 
> However this rings a bell that there may be a possible relation to
> DMA-API, since that API syncs memory buffers to the DMA
> address space if there is some MMU inbetween the DMA and the
> (ordinary, non-device) memory.
> 
> So if we think one step ahead, assuming the DMAC is actually behind
> an MMU making it see the device in some other address than the
> physical (bus) space, where would the address be resolved?

We don't currently have the infrastructure for that I think.
The dma-mapping API has some of the required parts but not all,
in particular it's only designed for mapping pages from the linear
kernel memory into the bus address space, not for devices.

The iommu API could do it for devices that have an IOMMU, but
it's not the best fit, because it does not abstract away the
presence of an IOMMU.

Another missing part is parsing the "dma-ranges" properties in
device tree, which you need to do if the address space translation
is not 1:1, and to find out which side of the IOMMU the DMA master
is connected to: if it's on the bus side, you need 1:1 mapping
and if it's on the host side, you need an IO page table entry.

	Arnd
