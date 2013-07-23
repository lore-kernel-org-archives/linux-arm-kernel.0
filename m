From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Jul 2013 11:37:04 +0100
Subject: scatterlist: sg_set_buf() argument must be in linear mapping
 (sha1: ac4e97abce9b80c020e7113325f49e58b7b15e3f)
In-Reply-To: <87ppua9feh.fsf@rustcorp.com.au>
References: <51E64C6B.3080306@monstr.eu> <87siz7xt4z.fsf@rustcorp.com.au>
 <51ED2C74.7050502@monstr.eu> <87ppua9feh.fsf@rustcorp.com.au>
Message-ID: <20130723103704.GS24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 12:00:30PM +0930, Rusty Russell wrote:
> Michal Simek <monstr@monstr.eu> writes:
> > Let me take some code from virtio_rpmsg_bus.c to show that problematic part.
> >
> > bufs_va = dma_alloc_coherent(vdev->dev.parent->parent,
> > 				RPMSG_TOTAL_BUF_SPACE,
> > 				&vrp->bufs_dma, GFP_KERNEL);
> > vrp->rbufs = bufs_va;
> > for (i = 0; i < RPMSG_NUM_BUFS / 2; i++) {
> > 	struct scatterlist sg;
> > 	void *cpu_addr = vrp->rbufs + i * RPMSG_BUF_SIZE;
> >
> > 	sg_init_one(&sg, cpu_addr, RPMSG_BUF_SIZE);
> > }
> 
> Hmm.  Looking at arch/arm/include/asm/memory.h:
> 
> #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
> #define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory)
> 
> pfn_to_page in ARM seems to be the asm-generic one, which depends on
> CONFIG_SPARSEMEM/CONFIG_DISCONTIGMEM/CONFIG_FLATMEM etc.
> 
> Perhaps virt_addr_valid() is wrong for your config?  It's pretty clear
> that you shouldn't call virt_to_page() on something for which
> !virt_addr_valid().

The above code fragment is just wrong.  You can't make any assumptions about
the memory returned from dma_alloc_coherent(), because:

- On x86, it is kernel direct mapped memory, where things like
  virt_to_phys(cpuaddr) will work fine with it.

- On any architecture which needs to remap memory to make it coherent
  with the DMA device, the key word there is "remap" - it's not kernel
  direct mapped memory, and virt_to_phys(cpuaddr) on it is illegal.

The only valid operation with scatterlists and such memory returned from
dma_alloc_coherent() is:

	sg_dma_address(sg) = dma_address;
	sg_dma_len(sg) = dma_length;

and not to use the virtual address(es) at all in the scatterlist.  And
it is very very important to realise that you must not mix the streaming
and coherent DMA APIs - you must never pass coherent memory into the
dma_map_* functions.
