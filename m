From: David.Laight@ACULAB.COM (David Laight)
Date: Tue, 26 Aug 2014 08:54:53 +0000
Subject: [PATCH v2 2/9] mailbox: Add NVIDIA Tegra XUSB mailbox driver
In-Reply-To: <20140826065729.GC15573@ulmo>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
 <1408381705-3623-3-git-send-email-abrestic@chromium.org>
 <53FB8820.4010202@wwwdotorg.org> <20140826065729.GC15573@ulmo>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17481234@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding
...
> > Is _nocache required? I don't see other drivers using it. I assume there's
> > nothing special about the mbox registers.
> 
> Most drivers should be using devm_ioremap_resource() which will use the
> _nocache variant of devm_ioremap() when appropriate. Usually the region
> will not be marked cacheable (IORESOURCE_CACHEABLE) and therefore be
> remapped uncached.

A related question:
Is there any way for a driver to force that part of a PCIe BAR be mapped
through the data cache even when the BAR isn't actually marked cacheable?

Some hardware has address regions (which might not be an entire BAR)
that are actually memory and mapping through the data cache will
generate longer PCIe transfers [1].
Clearly the driver will have to be very careful about cache flushes
and invalidates to make this work.

[1] PCIe is high throughput and high latency, single word reads can
be much slower that PCI, much nearer x86 ISA bus speeds.

	David
