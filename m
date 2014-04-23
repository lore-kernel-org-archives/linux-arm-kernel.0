From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Apr 2014 20:04:48 +0100
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with
 missing memory barrier
In-Reply-To: <6414220.SShvCHLvZQ@wuerfel>
References: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
 <20140423171727.GK5649@arm.com>
 <20140423183742.GK24070@n2100.arm.linux.org.uk> <6414220.SShvCHLvZQ@wuerfel>
Message-ID: <20140423190448.GB26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 08:58:05PM +0200, Arnd Bergmann wrote:
> On Wednesday 23 April 2014 19:37:42 Russell King - ARM Linux wrote:
> > On Wed, Apr 23, 2014 at 06:17:27PM +0100, Will Deacon wrote:
> > > On Wed, Apr 23, 2014 at 05:02:16PM +0100, Catalin Marinas wrote:
> > > > In the I/O coherency case, I would say it is the responsibility of the
> > > > device/hardware to ensure that the data is visible to all observers
> > > > (CPUs) prior to issuing a interrupt for DMA-ready. Looking at the mvebu
> > > > code, I think it covers such scenario from-device or bidirectional
> > > > scenarios.
> > > > 
> > > > Maybe Santosh still has a point  but I don't know what the right
> > > > barrier would be here. And I really *hate* per-SoC/snoop unit barriers
> > > > (I still hope a dsb would do the trick on newer/ARMv8 systems).
> > > 
> > > If you have device interrupts which are asynchronous to memory coherency,
> > > then you're in a world of pain. I can't think of a generic (architected)
> > > solution to this problem, unfortunately -- it's going to be both device
> > > and interconnect specific. Adding dsbs doesn't necessarily help at all.
> > 
> > Think, network devices with NAPI handling.  There, we explicitly turn
> > off the device's interrupt, and switch to software polling for received
> > packets.
> >
> > The memory for the packets has already been mapped, and we're unmapping
> > the buffer, and then reading from it (to locate the ether type, and/or
> > vlan headers) before passing it up the network stack.
> > 
> > So in this case, we need to ensure that the cache operations are ordered
> > before the subsequent loads read from the DMA'd data.  It's purely an
> > ordering thing, it's not a completion thing.
> 
> PCI guarantees this, but I have seen systems in the past (on PowerPC) that
> would violate them on the internal interconnect: You could sometimes see the
> completion DMA data in the descriptor ring before the actual user data
> is there. We only ever observed it in combination with an IOMMU, when the
> descriptor address had a valid IOTLB but the data address did not.

What is done on down-stream buses is of no concern to the behaviour of
the CPU, which is what's being discussed here (in terms of barriers.)
and the correct CPU ordering of various read/writes to memory and
devices vs the streaming cache operations.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
