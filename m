From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 8 May 2015 10:00:17 +0100
Subject: [PATCH 1/1] arm64:lib: Use Linaro's memset routine to avoid DC
 instruction
In-Reply-To: <20150508085525.GE11067@e104818-lin.cambridge.arm.com>
References: <1431062602-1894-1-git-send-email-jliang@xilinx.com>
 <20150508085525.GE11067@e104818-lin.cambridge.arm.com>
Message-ID: <20150508090017.GF11067@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 09:55:25AM +0100, Catalin Marinas wrote:
> On Fri, May 08, 2015 at 03:23:22PM +1000, Wendy Liang wrote:
> > We use dma_coherent_declare_memory() to declare the memory for DMA operations.
> > We use memset() initialize the memory with 0.
> > memset calls dc zva to zeroing the memory however it thinks the memory
> > is not part of system (somehow even it is part of DDR) and causing
> > unalignment fault.
> 
> So dma_init_coherent_memory() uses ioremap() to map such mapping with
> the Device attributes. It then stores this cookie in
> dma_coherent_mem.virt_base losing any __iomem annotation and declaring
> it safe for direct access (without the started I/O accessors). This is
> wrong. In addition, the assumption we have for coherent DMA buffers is
> that they are mapped as Normal memory (cacheable or non-cacheable,
> depending on what coherency the SoC supports).
> 
> I'm not taking this patch, the correct fix is a combination of
> dma_init_coherent_memory() and dma_alloc_from_coherent(). A quick hack
> could be to use ioremap_wc() but it still doesn't look right to me
> (well, it's fine only if flags are DMA_MEMORY_IO and
> dma_alloc_from_coherent() would use memset_io when this flag is
> detected but accesses to such buffer should be done with readl/writel).

BTW, we used a similar workaround in commit 0ab163ad1ea0 (misc: sram:
switch to ioremap_wc from ioremap).

But CMA would be a better option.

-- 
Catalin
