From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Feb 2011 13:01:30 +0000
Subject: [PATCH v4 16/19] ARM: LPAE: Use generic dma_addr_t type definition
In-Reply-To: <20110212103413.GD15616@n2100.arm.linux.org.uk>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-17-git-send-email-catalin.marinas@arm.com>
	<20110212103413.GD15616@n2100.arm.linux.org.uk>
Message-ID: <1297688490.31111.38.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2011-02-12 at 10:34 +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 24, 2011 at 05:55:58PM +0000, Catalin Marinas wrote:
> > From: Will Deacon <will.deacon@arm.com>
> >
> > This patch uses the types.h implementation in asm-generic to define the
> > dma_addr_t type as the same width as phys_addr_t.
> >
> > NOTE: this is a temporary patch until the corresponding patches unifying
> > the dma_addr_t and removing the dma64_addr_t are merged into mainline.
> 
> I'm not too sure about this patch.  All of the DMA devices we have only
> take 32-bit addresses for their DMA, so making dma_addr_t 64-bit seems
> wrong as we'll implicitly truncate these addresses.

If we don't enable LPAE, the dma_addr_t is 32-bit, so existing platforms
are not affected. With Cortex-A15, new platforms may have PCIe and be
able to access memory beyond 32-bit (if they don't support >32-bit DMA
at least for some critical devices, I'm not sure why they would use
A15).

For things like hard drives for example, it becomes problematic as pages
are allocated by the VFS layer from highmem and passed to the driver for
DMA. If we keep dma_addr_t to 32-bit you would need to use DMA bounce
even if the PCIe device supports >32-bit physical addresses.

> As ARM platforms don't (sanely) support DMA, I think dropping this patch
> for the time being would be a good idea, and stick with 32-bit dma_addr_t,
> especially as we need to first do a sweep for dma_addr_t usage in device
> driver structures (such as dma engine scatter lists.)  These really should
> use __le32/__be32/u32 depending on whether they're little endian, big
> endian or native endian.

Maybe we could make the dma_addr_t size configurable (and disabled by
default) since I expect there'll be platforms capable of >32-bit DMA.

-- 
Catalin
