From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Sep 2010 00:05:40 +0100
Subject: [RFC] mmaping with VIVT cache
In-Reply-To: <831453.93557.qm@web120220.mail.ne1.yahoo.com>
References: <831453.93557.qm@web120220.mail.ne1.yahoo.com>
Message-ID: <20100916230540.GA30916@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 15, 2010 at 05:25:38PM -0700, P F wrote:
> The mmap'd buffer is allocated by vmalloc_32(), and later mapped with
> vmalloc_to_page()/vm_insert_page().  The DMA'd buffer is allocated by
> usb_buffer_alloc().  At the appropriate time, the DMA'd buffer is
> memcpy()'d into the mmap'd buffer, and userspace is allowed to handle it,
> at which point it is corrupt.

Ah, that's slightly different as you're not talking about the DMA buffers
themselves.

However, anyone who is not familiar with VIVT or aliasing VIPT caches is
going to be caught out by this sort of thing (which basically means most
ARMs, and at least some PA-RISC.)

I don't think we have any APIs in the kernel to handle aliasing between
the vmalloc space and userspace...
