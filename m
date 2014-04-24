From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Apr 2014 10:54:23 +0100
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with
 missing memory barrier
In-Reply-To: <20140423183742.GK24070@n2100.arm.linux.org.uk>
References: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
 <201404222153.41786.arnd@arndb.de> <5356C9D1.2060001@ti.com>
 <5895821.PvurJ8TWz2@wuerfel> <5356D163.1070304@ti.com>
 <20140423090251.GA5281@arm.com> <20140423160216.GC2208@arm.com>
 <20140423171727.GK5649@arm.com>
 <20140423183742.GK24070@n2100.arm.linux.org.uk>
Message-ID: <20140424095422.GC8521@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 07:37:42PM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 23, 2014 at 06:17:27PM +0100, Will Deacon wrote:
> > On Wed, Apr 23, 2014 at 05:02:16PM +0100, Catalin Marinas wrote:
> > > In the I/O coherency case, I would say it is the responsibility of the
> > > device/hardware to ensure that the data is visible to all observers
> > > (CPUs) prior to issuing a interrupt for DMA-ready. Looking at the mvebu
> > > code, I think it covers such scenario from-device or bidirectional
> > > scenarios.
> > > 
> > > Maybe Santosh still has a point ;) but I don't know what the right
> > > barrier would be here. And I really *hate* per-SoC/snoop unit barriers
> > > (I still hope a dsb would do the trick on newer/ARMv8 systems).
> > 
> > If you have device interrupts which are asynchronous to memory coherency,
> > then you're in a world of pain. I can't think of a generic (architected)
> > solution to this problem, unfortunately -- it's going to be both device
> > and interconnect specific. Adding dsbs doesn't necessarily help at all.
> 
> Think, network devices with NAPI handling.  There, we explicitly turn
> off the device's interrupt, and switch to software polling for received
> packets.
> 
> The memory for the packets has already been mapped, and we're unmapping
> the buffer, and then reading from it (to locate the ether type, and/or
> vlan headers) before passing it up the network stack.
> 
> So in this case, we need to ensure that the cache operations are ordered
> before the subsequent loads read from the DMA'd data.  It's purely an
> ordering thing, it's not a completion thing.

Well, ordering of completed cache operations ;).

> However, what must not happen is that the unmap must not be re-ordered
> before reading the descriptor and deciding whether there's a packet
> present to be unmapped.  That probabily imples that code _should_ be
> doing this:
> 
> 	status = desc->status;
> 	if (!(status & CPU_OWNS_THIS_DESCRIPTOR))
> 		no_packet;
> 
> 	rmb();
> 
> 	addr = desc->buf;
> 	len = desc->length;
> 
> 	dma_unmap_single(dev, addr, len, DMA_FROM_DEVICE);

Indeed.

> 	...receive skb...reading buffer...

The point Will and myself were trying to make is about ordering as
observed by the CPU (rather than ordering of CPU actions). Independently
of whether the DMA is coherent or not, the ordering between device write
to the buffer and status update (in-memory descriptor or IRQ) *must* be
ordered by the device and interconnects. The rmb() as per your example
above only solves the relative CPU loads and cache maintenance but they
don't have any effect on the transactions done by the device.

The mvebu SoC has exactly this problem. mvebu_hwcc_sync_io_barrier() is
something that should be handled by the hardware automatically,
especially in a system which claims cache coherency.

-- 
Catalin
