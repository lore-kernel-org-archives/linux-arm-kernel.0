From: j.glisse@gmail.com (Jerome Glisse)
Date: Thu, 28 Apr 2011 15:37:00 -0400
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110428143440.GP17290@n2100.arm.linux.org.uk>
References: <201104212129.17013.arnd@arndb.de>
	<201104281428.56780.arnd@arndb.de>
	<20110428131531.GK17290@n2100.arm.linux.org.uk>
	<201104281629.52863.arnd@arndb.de>
	<20110428143440.GP17290@n2100.arm.linux.org.uk>
Message-ID: <BANLkTinhm7ar1mf1D-dSMiLtw5hRNY36RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 10:34 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Apr 28, 2011 at 04:29:52PM +0200, Arnd Bergmann wrote:
>> Given that people still want to have an interface that does what I
>> though this one did, I guess we have two options:
>>
>> * Kill off dma_cache_sync and replace it with calls to dma_sync_*
>> ? so we can start using dma_alloc_noncoherent on ARM
>
> I don't think this is an option as dma_sync_*() is part of the streaming
> DMA mapping API (dma_map_*) which participates in the idea of buffer
> ownership, which the noncoherent API doesn't appear to.

Sorry to jump in like that, but to me it seems that this whole
discussion is going toward having the decision of cache attribute
inside dma_* function and that a driver asking for uncached memory
might get cached memory if IOMMU or others component allows to have
cache coherency.

As Jesse pointed out already, for performance reasons it's lot better
if you let the driver decide even if you have an iommu capable of
handling coherency for you. My understanding is that each time
coherency is asked for it trigger bus activities of some kind (i think
snoop is the term used for pci) this traffic can slow down both the
cpu and the device. For graphic driver we have a lot of write once and
use (once or more) buffer and it makes a lot of sense to have those
buffer allocated using uncached memory so we can tell the device (in
case of drm driver) that there is no need to trigger snoop activities
for coherency. So i believe the decision should ultimately be in the
driver side.

Jesse also pointed out space exhaustion inside the iommu and i believe
this should also be considered. This is why i believe the dma_* api is
not well suited. In DRM/TTM we use  pci_dma_mapping* and we also play
with with page set_page*_uc|wc|wb.

So i believe a better API might look like :

- struct dma_alloc_unit {
bool contiguous;
uint dmamask;
}
struct dma_buffer {
dma_unit
}
CONTIGUOUS tell that this dma unit needs contiguous allocation or not,
if it needs contiguous allocation and there is an iommu then the
allocator might allocate non contiguous pages/memory and latter
properly program the iommu to make things look contiguous to the
device.
if contiguous==false then allocator might allocate one page at a time
but should rather to allocate a bunch of contiguous page to allow
optimization for minimizing  tlb miss if the device allow such things
(maybe adding a flag here might make sense)
-dma_buffer dma_alloc_(uc|wc|wb)(dma_alloc_unit, size) : alloc memory
according to constraint defined by dma_alloc_unit
-dma_buffer_update(dma_buffer, offset, size) allow dmabounce&swiotlb
to know what needs to be updated
-dma_bus_map(dma_buffer) map the buffer on to the bus in case of
dmabounce that would mean copy to the bounce buffer, for iommu that
would mean bind it, and in case of no iommu well do nothings
-dma_bus_unmap(dma_buffer) implementation might not necessarily unmap
the buffer if there is plenty of room in the iommu

So usage would look like :
mydma_buffer =  dma_alloc_uc(N);
cpuptr=dma_cpu_ptr(mydma_buffer)
//write to the buffer
// tell dma which data need to be updated depending on platform
iommu,dmabounce cache flushing ...
dma_buffer_update(mydma_buffer, offset, size)
dma_bus_map(mydma_buffer)
// let the device use the buffer
...
// the buffer isn't use anymore by the device
dma_bus_unmap(mydma_buffer)

It hides things like iommu or dmabounce from the device driver but
still allow the device driver to ask for the most optimal way. A
platform decide to not support dma_alloc_uc|wc (ie non coherent) if it
has an iommu that can handle coherency or some others way to handle it
like flushing. But if platform wants better performance it should try
to provide non coherent allocation (through highmem or changing kernel
mapping properties ...).

Maybe i am completely missing the point.

Cheers,
Jerome
