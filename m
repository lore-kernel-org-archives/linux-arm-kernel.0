From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Feb 2013 16:26:38 +0000
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <201302011607.49205.arnd@arndb.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130201035115.GA23649@obsidianresearch.com> <20130201100329.4d57fa55@skate>
 <201302011607.49205.arnd@arndb.de>
Message-ID: <20130201162638.GT23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 04:07:49PM +0000, Arnd Bergmann wrote:
> On Friday 01 February 2013, Thomas Petazzoni wrote:
> > So there is really a range of I/O addresses associated to it, even
> > though the device will apparently not use it. Would it be possible to
> > detect that the I/O range is not used by the device, and therefore
> > avoid the allocation of an address decoding window for this I/O range?
> 
> I suspect it just gets disabled because the port number 0xc0010000 is
> larger than IO_PORT_LIMIT and we cannot access that offset inside
> of the virtual memory window we use for PIO.

You're running into that trap again which you fall into on other
architectures.

If you arrange for your PCI IO space to start at 0 rather than the
physical address that it appears on your CPU, then you shouldn't
end up with it extending up to something at 0xcXXXXXXX.

Remember that we should be ensuring that inb(0) hits the first address
of the cross-subarch PCI IO area - this alway requires that any sub-arch
taking part in a multiplatform kernel must start its IO space addresses
at 0 and not the physical address on the local CPU.
