From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 6 Mar 2010 19:31:27 +0000
Subject: DMA using data buffer vmapped in kernel space
In-Reply-To: <201003061407.12698.thomas@koeller.dyndns.org>
References: <201003042211.28569.thomas@koeller.dyndns.org>
	<20100304213634.GH13417@n2100.arm.linux.org.uk>
	<201003061407.12698.thomas@koeller.dyndns.org>
Message-ID: <20100306193127.GA13262@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 06, 2010 at 02:07:12PM +0100, Thomas Koeller wrote:
> Am Donnerstag, 4. M?rz 2010 22:36:34 schrieb Russell King - ARM Linux:
> > Cache maintainence is done using virtual addresses for L1, and
> > physical addresses for L2.  There's the need for virtual addresses
> > to be translatable to physical addresses, which is only true for
> > the kernel direct mapped region (pages between PAGE_OFFSET and
> > high_memory).
> 
> Isn't the mapping created by vmap() sufficient for the virt/phys
> translation? In which way is this case different from a buffer
> passed in from user space, where the constituent pages are not
> in the directly mapped kernel region either?

No different.

The requirement is that dma_map_single() is passed a virtual address
in the kernel direct-mapped memory region, which is translatable using
virt_to_phys() and friends.

Anything which requires a page table lookup to obtain the physical
address is just not acceptable - that requires taking locks and other
messy things, plus is grossly inefficient.
