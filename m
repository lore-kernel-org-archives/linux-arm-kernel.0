From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 24 Nov 2013 22:43:59 +0000
Subject: ARM: v3.13-rc1: USB regression
In-Reply-To: <20131124222247.GC24645@blackmetal.musicnaut.iki.fi>
References: <20131124222247.GC24645@blackmetal.musicnaut.iki.fi>
Message-ID: <20131124224359.GE25039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 12:22:47AM +0200, Aaro Koskinen wrote:
> Hi,
> 
> With 3.13-rc1, the USB OHCI probe fails on Amstrad E3 (ARM/OMAP1)
> as follows:
> 
> [   33.814705] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [   33.821482] ohci-omap: OHCI OMAP driver
> [   33.925153] ohci ohci: OMAP OHCI
> [   33.929087] ohci ohci: new USB bus registered, assigned bus number 1
> [   33.967324] ohci ohci: Coherent DMA mask 0xffffffff (pfn 0xe0000-0xe0000) covers a smaller range of system memory than the DMA zone pfn 0x0-0x100000
> [   33.982292] ohci ohci: can't setup: -12
> [   33.987898] ohci ohci: USB bus 1 deregistered
> [   33.992984] ohci: probe of ohci failed with error -12
> 
> I bisected this to 4dcfa60071b3d23f0181f27d8519f12e37cefbb9 (ARM: DMA-API:
> better handing of DMA masks for coherent allocations). Reverting that
> commit makes the USB work again fine.

This is because of this:

#define __arch_dma_to_pfn(dev, addr)	\
	({ dma_addr_t __dma = addr;				\
	   if (is_lbus_device(dev))				\
		__dma += PHYS_OFFSET - OMAP1510_LB_OFFSET;	\
	   __phys_to_pfn(__dma);				\
	})

dma_addr_t is 32-bit.  PHYS_OFFSET - OMAP1510_LB_OFFSET is 0xe0000000.
Consider what the result of passing 0xffffffff as addr into this is.

Better would be:

#define __arch_dma_to_pfn(dev, addr)	\
	({ unsigned long pfn = (addr) >> PAGE_SHIFT;		\
	   if (is_lbus_device(dev))				\
		pfn += PHYS_PFN_OFFSET - 			\
			(OMAP1510_LB_OFFSET >> PAGE_SHIFT);	\
	   pfn;							\
	})

Can you try that in arch/arm/mach-omap1/include/mach/memory.h please?
