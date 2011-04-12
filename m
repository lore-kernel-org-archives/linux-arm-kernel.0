From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Apr 2011 22:40:11 +0100
Subject: [PATCH 2.6.39 v2] V4L: videobuf-dma-contig: fix mmap_mapper
	broken on ARM
In-Reply-To: <201104122306.34909.jkrzyszt@tis.icnet.pl>
References: <201104122306.34909.jkrzyszt@tis.icnet.pl>
Message-ID: <20110412214011.GG7806@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2011 at 11:06:34PM +0200, Janusz Krzysztofik wrote:
> The patch tries to solve this regression by using 
> virt_to_phys(bus_to_virt(mem->dma_handle)) instead of problematic 
> virt_to_phys(mem->vaddr).

Who says that DMA handles are bus addresses in the strictest sense?

DMA handles on ARM are the bus address to program 'dev' with in order
for it to access the memory mapped by dma_alloc_coherent().  On some
ARM platforms, this bus address is dependent on 'dev' - such as platforms
with more than one root PCI bus, and so bus_to_virt() just doesn't
hack it.

What is really needed is for this problem - the mapping of DMA coherent
memory into userspace - to be solved with a proper arch API rather than
all these horrible hacks which subsystems instead invent.  That's
something I tried to do with the dma_mmap_coherent() stuff but it was
shot down by linux-arch as (iirc) PA-RISC objected to it.

Hence why ARM only implements it.

Maybe the video drivers should try to resurect the idea, maybe only
allowing this support for architectures which provide dma_mmap_coherent().
