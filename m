From: public_filter@yahoo.com (P F)
Date: Fri, 17 Sep 2010 12:07:50 -0700 (PDT)
Subject: [RFC] mmaping with VIVT cache
Message-ID: <589851.42712.qm@web120206.mail.ne1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- On Thu, 9/16/10, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Wed, Sep 15, 2010 at 05:25:38PM-0700, P F wrote:
> > The mmap'd buffer is allocated by vmalloc_32(), and later mapped with
> > vmalloc_to_page()/vm_insert_page().? The DMA'dbuffer is allocated by
> > usb_buffer_alloc().? At the appropriate time, the DMA'd buffer is
> > memcpy()'d into the mmap'd buffer, and userspace is allowed to handle
> > it, at which point it is corrupt.
> 
> Ah, that's slightly different as you're not talking about
> the DMA buffers themselves.
> 
> However, anyone who is not familiar with VIVT or aliasing
> VIPT caches is going to be caught out by this sort of thing (which
> basically means most ARMs, and at least some PA-RISC.)

Again, thank you for the explanation, Russell.? For some reason I did not
quite grok the root cause of this issue before, but it is now clear to me.

> I don't think we have any APIs in the kernel to handle
> aliasing between the vmalloc space and userspace...

Perhaps I am revealing my ignorance of the driver ecosystem, but I find
this somewhat surprising.? I would think that this sort of construction
would not be uncommon.

For this issue, I can see two solutions:
1.) somehow make the vmalloc'd space non-cacheable so both the user- and
kernelspace mappings match, and there is no cache to alias
2.) invalidate the cache of the userspace mapping before handing the
buffer to userspace (after memcpy() above)

As Laurent noted earlier, (1) is a nonstarter as it has a negative
performance impact.? (2) I propose is a valid and correct solution.? This
is driver-specific, but each buffer corresponds to an image frame (e.g.,
from a webcam), so they are independent, and therefore it does not make
sense to share the cache between frames.? As long as userspace holds the
buffer, the cache is valid, but once it relinquishes the buffer, the cache
holds only stale data and should be purged.

>From your comment, I take it that there is no kernel API to invalidate the
cache of a range in a VMA.  Do you think linux-mm would be a more
appropriate forum to continue investigating?  Any input would be
appreciated.


      
