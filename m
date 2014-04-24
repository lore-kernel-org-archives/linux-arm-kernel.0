From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Apr 2014 12:13:39 +0100
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with
 missing memory barrier
In-Reply-To: <20140424095422.GC8521@arm.com>
References: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
 <201404222153.41786.arnd@arndb.de> <5356C9D1.2060001@ti.com>
 <5895821.PvurJ8TWz2@wuerfel> <5356D163.1070304@ti.com>
 <20140423090251.GA5281@arm.com> <20140423160216.GC2208@arm.com>
 <20140423171727.GK5649@arm.com>
 <20140423183742.GK24070@n2100.arm.linux.org.uk>
 <20140424095422.GC8521@arm.com>
Message-ID: <20140424111339.GO26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 10:54:23AM +0100, Catalin Marinas wrote:
> On Wed, Apr 23, 2014 at 07:37:42PM +0100, Russell King - ARM Linux wrote:
> > However, what must not happen is that the unmap must not be re-ordered
> > before reading the descriptor and deciding whether there's a packet
> > present to be unmapped.  That probabily imples that code _should_ be
> > doing this:
> > 
> > 	status = desc->status;
> > 	if (!(status & CPU_OWNS_THIS_DESCRIPTOR))
> > 		no_packet;
> > 
> > 	rmb();
> > 
> > 	addr = desc->buf;
> > 	len = desc->length;
> > 
> > 	dma_unmap_single(dev, addr, len, DMA_FROM_DEVICE);
> 
> Indeed.
> 
> > 	...receive skb...reading buffer...
> 
> The point Will and myself were trying to make is about ordering as
> observed by the CPU (rather than ordering of CPU actions). Independently
> of whether the DMA is coherent or not, the ordering between device write
> to the buffer and status update (in-memory descriptor or IRQ) *must* be
> ordered by the device and interconnects. The rmb() as per your example
> above only solves the relative CPU loads and cache maintenance but they
> don't have any effect on the transactions done by the device.

If the hardware does not ensure proper ordering of the writes to the
buffer vs writes to the descriptor indicating that the packet has been
received, then the hardware is quite simply broken.

> The mvebu SoC has exactly this problem. mvebu_hwcc_sync_io_barrier() is
> something that should be handled by the hardware automatically,
> especially in a system which claims cache coherency.

So what if the descriptor also contains other data, such as a received
timestamp, or separate error bits that need checking before DMA unmap?
(There are implementations where this is true - for example the freescale
FEC driver, but that currently omits the rmb()...)

Stuffing this into the DMA API may not be the best place for it, but
the alternative is to stuff it into drivers, and that's just not
acceptable for any generic driver - plus we want to keep stuff as simple
as possible for driver authors who probably don't want to understand any
of these details.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
