From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 3 Feb 2011 10:26:51 +0100
Subject: ARM unaligned MMIO access with attribute((packed))
In-Reply-To: <yw1xei7qm3vy.fsf@unicorn.mansr.com>
References: <201102021700.20683.arnd@arndb.de>
	<20110202.133831.193702414.davem@davemloft.net>
	<yw1xei7qm3vy.fsf@unicorn.mansr.com>
Message-ID: <201102031026.52113.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 February 2011 00:08:01 M?ns Rullg?rd wrote:
> > But you really need that memory clobber there whether you like it or
> > not, see above.
> 
> I don't know of any device where the side-effects are not explicitly
> indicated by other means in the code triggering them, so it probably
> is safe without the clobber as Russel says.

On configurations that have CONFIG_ARM_DMA_MEM_BUFFERABLE set, this is
definitely true, since they use the rmb() and wmb() that include
both an IO memory barrier instruction where required and a compiler barrier
(i.e. __asm__ __volatile__ ("" : : : "memory")):

8<-------------- from arch/arm/include/asm/io.h

#ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
#define __iormb()               rmb()
#define __iowmb()               wmb()
#else
#define __iormb()               do { } while (0)
#define __iowmb()               do { } while (0)
#endif

#define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(); __v; })
#define readw(c)                ({ u16 __v = readw_relaxed(c); __iormb(); __v; })
#define readl(c)                ({ u32 __v = readl_relaxed(c); __iormb(); __v; })
        
#define writeb(v,c)             ({ __iowmb(); writeb_relaxed(v,c); })
#define writew(v,c)             ({ __iowmb(); writew_relaxed(v,c); })
#define writel(v,c)             ({ __iowmb(); writel_relaxed(v,c); })

8<---------------

Also, as Russell mentioned, anything using the streaming DMA mapping API
is fine because of the barriers included in the function calls there.

However, I would think that this fictional piece of code would be valid
for a possible PCI device driver (though inefficient) and not require
any additional synchronizing operations:

void foo_perform_operation(struct foo_dev *d, u32 in, u32 *out)
{
	dma_addr_t dma_addr;
	u32 *cpu_addr;

	/* 
	 * get memory from the consistent DMA mapping API, typically
	 * uncached memory on ARM, but could be anywhere if the DMA
	 * is coherent.
	 */
	cpu_addr = dma_alloc_coherent(&d->dev, sizeof (*cpu_addr),
					&dma_addr, GFP_KERNEL);

	/* lock the device, not required for the example, but normally
	 * needed in practice for SMP operation.
	 */
	spin_lock(&d->lock);

	/* initialize the DMA data */
	*cpu_addr = in;

	/*
	 * send a posted 32 bit write to the device, triggering the
	 * start of the DMA read from *cpu_addr, which is followed by
	 * a DMA write to *cpu_addr. writel includes a barrier that
	 * makes sure that the previous store to *cpu_addr is visible
	 * to the DMA, but does not block until the completion like
	 * outl() would.
	 */
	writel(dma_addr, d->mmio_addr);

	/*
	 * synchronize the outbound posted write, wait for the device
	 * to complete the DMA and synchronize the DMA data on its
	 * inbound path.
	 */
	(void)readl(d->mmio_addr);

	/*
	 * *cpu_addr contains data just written to by the device, and
	 * the readl includes all the necessary barriers to ensure
	 * it's really there when we access it.
	 */
	*out = *cpu_addr;

	/* unlock the device */
	spin_unlock(&d->lock);

	/* free the DMA memory */
	dma_free_coherent(&d->dev, sizeof (*cpu_addr), cpu_addr, dma_addr);
}

However, when readl contains no explicit or implicit synchronization, the
load from *cpu_addr might get pulled in front of the load from mmio_addr,
resulting in invalid output data. If this is the case, it is be a problem
on almost all architectures (not x86, powerpc or sparc64).

Am I missing something here?

	Arnd
