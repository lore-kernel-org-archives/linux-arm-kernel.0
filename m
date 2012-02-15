From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Feb 2012 00:57:22 +0000
Subject: [PATCH 13/15] ARM: make mach/io.h include optional
In-Reply-To: <20120214234313.GD29765@n2100.arm.linux.org.uk>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <4F3AE98D.7030104@gmail.com> <20120214234313.GD29765@n2100.arm.linux.org.uk>
Message-ID: <201202150057.23189.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 February 2012, Russell King - ARM Linux wrote:
> > orion5x maps 2 1MB regions for PCI and PCIE. How would you support 2 io
> > ranges?
> 
> That's not the only platform which effectively has two IO ranges.  The
> PCMCIA sockets on SA11x0 and probably PXA both have their own separate
> IO region.  Arnd's idea for this was to map 32k from one and 32k from
> the other into a single 64k space, and adapt soc_common to cope.

When going through the list today, I found that mv78xx0 in fact has eight
PCIe root complexes with their own I/O spaces.
This could still work with the method I suggested but it would limit
the I/O space per bus to 8kb, which is fairly small, so I'd still consider
using a 1MB space (allowing 16 separte 64 I/O windows) an equally
reasonable option.

> > BTW, I noticed some static mappings at 0xffxxxxxx. Are those even a
> > valid address?
> 
> Nothing invalid about them as such, but I have tried to discourage their
> use in case we decide that we want to go for a default 14MB DMA region.

We still have the option to either put the I/O spaces in the vmalloc area
where they typically are now, or (provided it's small enough) put them
into the fixmap area, which is a little under 1MB in total size and
almost entirely unused on ARM today.

	Arnd
