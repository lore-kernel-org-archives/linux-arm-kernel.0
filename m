From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Aug 2014 12:04:18 +0200
Subject: [PATCH v2 2/9] mailbox: Add NVIDIA Tegra XUSB mailbox driver
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D17481234@AcuExch.aculab.com>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
 <20140826065729.GC15573@ulmo>
 <063D6719AE5E284EB5DD2968C1650D6D17481234@AcuExch.aculab.com>
Message-ID: <4609609.i9jPXymFJZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 August 2014 08:54:53 David Laight wrote:
> From: Thierry Reding
> ...
> > > Is _nocache required? I don't see other drivers using it. I assume there's
> > > nothing special about the mbox registers.
> > 
> > Most drivers should be using devm_ioremap_resource() which will use the
> > _nocache variant of devm_ioremap() when appropriate. Usually the region
> > will not be marked cacheable (IORESOURCE_CACHEABLE) and therefore be
> > remapped uncached.
> 
> A related question:
> Is there any way for a driver to force that part of a PCIe BAR be mapped
> through the data cache even when the BAR isn't actually marked cacheable?

No. BARs are not actually marked cacheable anyway, except for the ROM
BAR, which we tend to not use.

Some architectures don't even allow any caching of PCI memory ranges,
so we have no architecture independent API for that.

It's possible that ioremap_cache() works on x86 and/or ARM if you call
it manually on the physical address (rather than using a resource
API).

> Some hardware has address regions (which might not be an entire BAR)
> that are actually memory and mapping through the data cache will
> generate longer PCIe transfers [1].
> Clearly the driver will have to be very careful about cache flushes
> and invalidates to make this work.

Some framebuffer drivers use writethrough mappings, but those again
are only available on few architectures. vesafb uses ioremap_cache,
but this works because the memory is in system RAM and not on PCI.

	Arnd
