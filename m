From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Oct 2018 19:08:43 +0100
Subject: How is the Linux kernel API dma_alloc_coherent() typically
 implemented for the ARM Architecture?
In-Reply-To: <866a698a-aa61-6c48-0258-f2dd97973e87@arm.com>
References: <BYAPR12MB2791F73EC1033F998FF533BAC8E90@BYAPR12MB2791.namprd12.prod.outlook.com>
 <866a698a-aa61-6c48-0258-f2dd97973e87@arm.com>
Message-ID: <20181003180843.GY30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2018 at 06:44:56PM +0100, Robin Murphy wrote:
> Hi Casey,
> 
> On 03/10/18 17:55, Casey Leedom wrote:
> >   I have a question about ARM CPU versus PCIe DMA I/O Coherence that I'm
> >trying to understand. In general, I thought that ARM is I/O Incoherent and
> >that setting up Device DMA READs from Coherent Memory and Device DMA WRITEs
> >to Coherent Memory require that the Device Driver/OS coordinate to
> >FLUSH/INVALIDATE Caches, etc.  In Linux this is all handled automatically
> >via the dam_map*()/dma_unmap*() APIs.  But what does the Linux kernel API
> >dma_alloc_coherent() do on an architecture like ARM?  Return an UNCACHED
> >mapping? I've tried ferreting my way down through the layers and layers of
> >abstraction and implementation differences for various ARM platforms but
> >it's pretty opaque ...
> 
> The really old stuff is a bit murky, but certainly from Armv7 onwards (i.e.
> the kind of systems you'd be plugging a PCIe card into today), it's
> relatively straightforward.

The old stuff is _not_ murky - it operates the same way as modern
systems as far as Linux is concerned.  That's one of the reasons
for having the DMA API - to provide a consistent cross-platform
cross-architecture way to deal with the DMA coherency issues.

There are two major parts of the DMA API - the coherent API and the
streaming API.

The coherent API consists of dma_alloc_coherent() and friends.
dma_alloc_coherent() returns an allocation of memory to the driver
that is guaranteed to be coherent with the device that was passed
into the API.  How that happens depends on the implementation, but
the requirement is that the memory can be read and written by the
CPU _while_ the DMA device is also reading and writing that memory.
No cache flushing is required (if it were, then simultaneous access
would not be possible.)

The main purpose of this memory is for things like descriptor rings,
where (eg) the CPU places addresses for the device to process and
links the ring entry into the ring, or sets an ownership or go bit
in the descriptor.  Meanwhile the hardware polls the go bit and
processes the descriptor as soon as it notices that the go or ownership
bit has been set.

Barriers are required for weakly ordered architectures to ensure the
correct visibility semantics for CPU reads and writes.

Essentially, in *all* ARMs where the memory is noncoherent with the
device, allocating coherent memory means that the memory is remapped
with the caches disabled.

The streaming API consists of memory which is not inherently coherent,
and requires some form of cache maintanence to ensure that the data
transferred by DMA or the CPU is visible to the other.  These are the
dma_map_*(), dma_unmap_*() and dma_sync_*() functions.

> >   We use the Linux dma_alloc_coherent() API in order to allocate our TX and
> >RX "Rings".  All TX and RX "Buffers" are managed with the dma_map*(*READ*
> >and *WRITE*) APIs in order to Flush Caches to Memory / Invalidate Caches, etc.
> >
> >   But these "Rings" serve as "message" rings between the Host and the Device
> >and we don't do Cache Flushes/Invalidates on them.  Messages sent from the
> >Host to the Device include Work Requests and lists of Free List Buffer
> >Pointers.  Messages sent from the Device to the Host include Ingress Packet
> >Delivery Notifications, Link Status, etc.  For the Ingress Queues which the
> >Device uses to send messages to the Host, we use a Generation Bit scheme
> >where the Generation Bit flips back and forth between 0 and 1 every time the
> >Device's Write Index in the Ingress Queue wraps back around to the start of
> >the Ingress Queue.  The Host software uses the Generation Bit value to
> >determine when there are new Device Messages available in the Ingress Queue.
> >
> >   So, as I was grinding my way down through the layers of implementation on
> >the Linux dma_alloc_coherent() I was trying to see how the above
> >dma_alloc_coherent() semantic was being implemented on the ARM architecture
> >which [I thought] doesn't generally support I/O Coherency.  Setting up a
> >completely UNCACHED mapping would of course work but at a significant cost
> >in terms of access.  It's conceivable that the TX Rings could be mapped with
> >a WRITE-COMBINING UNCACHED mapping I suppose (though the Linux API doesn't
> >include any information on the DIRECTION of a dma_map_coherent() call).  So
> >I'm curious about how that all fits together.

To Casey:

If you are writing at the level where you need to know exactly how
coherent memory is implemented, then you're doing it wrong - and
your driver will never be reliable.  You will be writing it based
upon implementation semantics, rather than the API definition.

If you're thinking about avoiding "uncached" mappings by using a
streaming mapping and doing cache maintanence, please don't.  Writes
in that situation are written back using a full (or sometimes half
depending on the implementation) cache line which can be 16, 32, 64
or 128 bytes.

What this means is that if your descriptors are 16 bytes long, flushing
just that descriptor is impossible without also writing neighbouring
entries - and if the hardware has updated those entries while the
cache line is in the CPU cache, the hardware update will be lost upon
writeback.

Also note that there is no dma_map_coherent() API, and "direction" is
not relevant for memory which is inherently coherent.

Direction is necessary for the streaming API so it knows how to most
efficiently perform the cache maintanence if the memory is not coherent
with the device.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
