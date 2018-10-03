From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 3 Oct 2018 18:44:56 +0100
Subject: How is the Linux kernel API dma_alloc_coherent() typically
 implemented for the ARM Architecture?
In-Reply-To: <BYAPR12MB2791F73EC1033F998FF533BAC8E90@BYAPR12MB2791.namprd12.prod.outlook.com>
References: <BYAPR12MB2791F73EC1033F998FF533BAC8E90@BYAPR12MB2791.namprd12.prod.outlook.com>
Message-ID: <866a698a-aa61-6c48-0258-f2dd97973e87@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Casey,

On 03/10/18 17:55, Casey Leedom wrote:
>    I have a question about ARM CPU versus PCIe DMA I/O Coherence that I'm
> trying to understand. In general, I thought that ARM is I/O Incoherent and
> that setting up Device DMA READs from Coherent Memory and Device DMA WRITEs
> to Coherent Memory require that the Device Driver/OS coordinate to
> FLUSH/INVALIDATE Caches, etc.  In Linux this is all handled automatically
> via the dam_map*()/dma_unmap*() APIs.  But what does the Linux kernel API
> dma_alloc_coherent() do on an architecture like ARM?  Return an UNCACHED
> mapping? I've tried ferreting my way down through the layers and layers of
> abstraction and implementation differences for various ARM platforms but
> it's pretty opaque ...

The really old stuff is a bit murky, but certainly from Armv7 onwards 
(i.e. the kind of systems you'd be plugging a PCIe card into today), 
it's relatively straightforward. In short, if the PCIe root complex is 
non-coherent, the allocation (usually from CMA) gets remapped with the 
Normal Non-Cacheable memory type, and that's the address given back to 
the caller (side note: we don't unmap the Cacheable linear map alias, so 
have to be very careful to *not* touch that while both mappings exist, 
because there be dragons). If on the other hand it is coherent, then the 
caller just gets the regular Normal Cacheable linear map address back 
and nothing special happens (the IOMMU stuff is a little more involved, 
but the same principle applies).

Note that those Non-Cacheable mappings are still of the Normal memory 
type, which is not as strict as the Device memory type used for MMIO, 
and are also write-bufferable (again, on modern CPUs at least). Given 
the Architectural memory model, that's about as good as it can get.

FWIW coherent I/O is actually becoming increasingly common, at least on 
larger systems, since once you have a coherent interconnect to allow two 
or more clusters of CPUs to work together properly, it's not *that* much 
work to also make other DMA masters spit out enough of the right signals 
to snoop caches when targeting memory addresses.

>    We use the Linux dma_alloc_coherent() API in order to allocate our TX and
> RX "Rings".  All TX and RX "Buffers" are managed with the dma_map*(*READ*
> and *WRITE*) APIs in order to Flush Caches to Memory / Invalidate Caches, etc.
> 
>    But these "Rings" serve as "message" rings between the Host and the Device
> and we don't do Cache Flushes/Invalidates on them.  Messages sent from the
> Host to the Device include Work Requests and lists of Free List Buffer
> Pointers.  Messages sent from the Device to the Host include Ingress Packet
> Delivery Notifications, Link Status, etc.  For the Ingress Queues which the
> Device uses to send messages to the Host, we use a Generation Bit scheme
> where the Generation Bit flips back and forth between 0 and 1 every time the
> Device's Write Index in the Ingress Queue wraps back around to the start of
> the Ingress Queue.  The Host software uses the Generation Bit value to
> determine when there are new Device Messages available in the Ingress Queue.
> 
>    So, as I was grinding my way down through the layers of implementation on
> the Linux dma_alloc_coherent() I was trying to see how the above
> dma_alloc_coherent() semantic was being implemented on the ARM architecture
> which [I thought] doesn't generally support I/O Coherency.  Setting up a
> completely UNCACHED mapping would of course work but at a significant cost
> in terms of access.  It's conceivable that the TX Rings could be mapped with
> a WRITE-COMBINING UNCACHED mapping I suppose (though the Linux API doesn't
> include any information on the DIRECTION of a dma_map_coherent() call).  So
> I'm curious about how that all fits together.

Arm has no specific write-combining memory type, so in actual fact 
DMA_ATTR_WRITE_COMBINE will just give you the same Normal Non-cacheable 
mapping as for the non-coherent case (and thus you really wouldn't want 
it for coherent devices!)

Robin.
