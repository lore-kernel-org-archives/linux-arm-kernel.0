From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 8 May 2015 09:55:25 +0100
Subject: [PATCH 1/1] arm64:lib: Use Linaro's memset routine to avoid DC
 instruction
In-Reply-To: <1431062602-1894-1-git-send-email-jliang@xilinx.com>
References: <1431062602-1894-1-git-send-email-jliang@xilinx.com>
Message-ID: <20150508085525.GE11067@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 03:23:22PM +1000, Wendy Liang wrote:
> Currently the DC ZVA is used to zero out memory which is causing unaligned
> fault due to the follows:
> "If the memory region being zeroed is any type of Device memory, these
> instructions give an alignment fault which is prioritized in the same way
> as other alignment faults that are determined by the memory type."
> from arm reference menual.

Which is the right thing to do. You are not supposed to use memset() on
Device memory, we have memset_io() for this.

> We have carved out top memory from DDR as the memory for the device from DTS:
> ----
> reserved-memory {
>                 #address-cells = <2>;
>                 #size-cells = <1>;
>                 ranges;
>                 rproc_0_reserved: rproc at 3ed000000 {
>                         no-map;
>                         reg = <0x0 0x3ed00000 0x1000000>;
>                 };
>         };
> 
>  amba {
>                 example at 0 {
>                         reg = <0x0 0x3ed00000 0x800000>;
> 			...
> 		};
> };
> ----

Why not using CMA?

> We use dma_coherent_declare_memory() to declare the memory for DMA operations.
> We use memset() initialize the memory with 0.
> memset calls dc zva to zeroing the memory however it thinks the memory
> is not part of system (somehow even it is part of DDR) and causing
> unalignment fault.

So dma_init_coherent_memory() uses ioremap() to map such mapping with
the Device attributes. It then stores this cookie in
dma_coherent_mem.virt_base losing any __iomem annotation and declaring
it safe for direct access (without the started I/O accessors). This is
wrong. In addition, the assumption we have for coherent DMA buffers is
that they are mapped as Normal memory (cacheable or non-cacheable,
depending on what coherency the SoC supports).

I'm not taking this patch, the correct fix is a combination of
dma_init_coherent_memory() and dma_alloc_from_coherent(). A quick hack
could be to use ioremap_wc() but it still doesn't look right to me
(well, it's fine only if flags are DMA_MEMORY_IO and
dma_alloc_from_coherent() would use memset_io when this flag is
detected but accesses to such buffer should be done with readl/writel).

-- 
Catalin
