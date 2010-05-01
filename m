From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 May 2010 10:19:43 +0100
Subject: [RFC] Prohibit ioremap() on kernel managed RAM
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5217DFF@dbde02.ent.ti.com>
References: <20100423144058.GA11637@ZenIV.linux.org.uk>
	<20100430163356.GV2619@mvista.com>
	<1272645511.22683.1.camel@e102109-lin.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5217DFF@dbde02.ent.ti.com>
Message-ID: <20100501091943.GA12172@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 01, 2010 at 11:54:55AM +0530, Shilimkar, Santosh wrote:
> This seems to be good solution if it's doable. Reserving memory in the boot
> is not so flexible and might end up in waste of memory.

However, allocating large pages (larger than 4K) is unreliable due to
fragmentation.  There's two factors here - the larger the allocation,
and the longer the system has been running, the more likely such an
allocation is to fail.

Since we'd need to enforce a minimum allocation size of 1MB in order to
unmap the direct mapping, we're asking for an order-8 page - and I think
you'll find that'll be fairly unreliable if you want to keep allocating
and freeing it.

The DMA allocators can handle anything up to MAX_ORDER-order allocations
provided it has enough virtual memory space available to it - so if you
want to go down this route, you might as well switch to using that.
(However, eventually the DMA allocator also needs fixing to avoid the
dual-mappings that it creates.)
