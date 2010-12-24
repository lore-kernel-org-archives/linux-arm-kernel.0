From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Dec 2010 13:02:00 +0000
Subject: [PATCH] dma_declare_coherent_memory: push ioremap() up to caller
In-Reply-To: <201012240020.37208.jkrzyszt@tis.icnet.pl>
References: <201012240020.37208.jkrzyszt@tis.icnet.pl>
Message-ID: <20101224130200.GG20587@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 24, 2010 at 12:20:32AM +0100, Janusz Krzysztofik wrote:
> The patch tries to implement a solution suggested by Russell King, 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-December/035264.html. 
> It is expected to solve video buffer allocation issues for at least a 
> few soc_camera I/O memory less host interface drivers, designed around 
> the videobuf_dma_contig layer, which allocates video buffers using 
> dma_alloc_coherent().
> 
> Created against linux-2.6.37-rc5.
> 
> Tested on ARM OMAP1 based Amstrad Delta with a WIP OMAP1 camera patch, 
> patterned upon two mach-mx3 machine types which already try to use the 
> dma_declare_coherent_memory() method for reserving a region of system 
> RAM preallocated with another dma_alloc_coherent(). Compile tested for 
> all modified files except arch/sh/drivers/pci/fixups-dreamcast.c.

Another note: with the pair of patches I've sent to the linux-arm-kernel
list earlier today changing the DMA coherent allocator to steal memory
from the system at boot.

This means there's less need to pre-allocate DMA memory - if there's
sufficient contiguous space in the DMA region to satisfy the allocation,
then the allocation will succeed.  It's also independent of the maximum
page size from the kernel's memory allocators too.

So I suspect that mach-mx3 (and others) no longer need to do their own
pre-allocation anymore if both of these patches go in.
