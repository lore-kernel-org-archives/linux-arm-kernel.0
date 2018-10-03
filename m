From: leedom@chelsio.com (Casey Leedom)
Date: Wed, 3 Oct 2018 16:55:39 +0000
Subject: How is the Linux kernel API dma_alloc_coherent() typically
 implemented for the ARM Architecture?
Message-ID: <BYAPR12MB2791F73EC1033F998FF533BAC8E90@BYAPR12MB2791.namprd12.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  I have a question about ARM CPU versus PCIe DMA I/O Coherence that I'm
trying to understand. In general, I thought that ARM is I/O Incoherent and
that setting up Device DMA READs from Coherent Memory and Device DMA WRITEs
to Coherent Memory require that the Device Driver/OS coordinate to
FLUSH/INVALIDATE Caches, etc.  In Linux this is all handled automatically
via the dam_map*()/dma_unmap*() APIs.  But what does the Linux kernel API
dma_alloc_coherent() do on an architecture like ARM?  Return an UNCACHED
mapping? I've tried ferreting my way down through the layers and layers of
abstraction and implementation differences for various ARM platforms but
it's pretty opaque ...
 
  We use the Linux dma_alloc_coherent() API in order to allocate our TX and
RX "Rings".  All TX and RX "Buffers" are managed with the dma_map*(*READ*
and *WRITE*) APIs in order to Flush Caches to Memory / Invalidate Caches, etc.

  But these "Rings" serve as "message" rings between the Host and the Device
and we don't do Cache Flushes/Invalidates on them.  Messages sent from the
Host to the Device include Work Requests and lists of Free List Buffer
Pointers.  Messages sent from the Device to the Host include Ingress Packet
Delivery Notifications, Link Status, etc.  For the Ingress Queues which the
Device uses to send messages to the Host, we use a Generation Bit scheme
where the Generation Bit flips back and forth between 0 and 1 every time the
Device's Write Index in the Ingress Queue wraps back around to the start of
the Ingress Queue.  The Host software uses the Generation Bit value to
determine when there are new Device Messages available in the Ingress Queue.

  So, as I was grinding my way down through the layers of implementation on
the Linux dma_alloc_coherent() I was trying to see how the above
dma_alloc_coherent() semantic was being implemented on the ARM architecture
which [I thought] doesn't generally support I/O Coherency.  Setting up a
completely UNCACHED mapping would of course work but at a significant cost
in terms of access.  It's conceivable that the TX Rings could be mapped with
a WRITE-COMBINING UNCACHED mapping I suppose (though the Linux API doesn't
include any information on the DIRECTION of a dma_map_coherent() call).  So
I'm curious about how that all fits together.

Casey
