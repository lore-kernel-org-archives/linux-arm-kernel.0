From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Thu, 31 Dec 2015 09:38:16 +0100
Subject: [Question about DMA] Consistent memory?
In-Reply-To: <CAK7LNASd1amcHinXzYy=8mtYbnHUY1G_v=fthpachAVSyjqPZA@mail.gmail.com>
References: <CAK7LNASd1amcHinXzYy=8mtYbnHUY1G_v=fthpachAVSyjqPZA@mail.gmail.com>
Message-ID: <5684E978.5050903@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31-12-15 08:50, Masahiro Yamada wrote:
> Hi.
>
> I am new to the Linux DMA APIs.
>
> First, I started by reading Documentation/DMA-API.txt,
> but I am confused with the term "consistent memory".
>
> Please help me understand the document correctly.
>
>
> The DMA-API.txt says as follows:
>
> ----------------------->8--------------------------------------------
> void *
> dma_alloc_coherent(struct device *dev, size_t size,
>      dma_addr_t *dma_handle, gfp_t flag)
>
> Consistent memory is memory for which a write by either the device or
> the processor can immediately be read by the processor or device
> without having to worry about caching effects.  (You may however need
> to make sure to flush the processor's write buffers before telling
> devices to read that memory.)
> ------------------------8<--------------------------------------------
>
>
> As far as I understand the the cited sentence, for the memory
> to be consistent, DMA controllers must be connected to
> DRAM through some special hardware that keeps the memory
> coherency, such as SCU.  I assume the system like Fig.1
>
>
> Fig.1
>
> |------|  |------| |-----|
> | CPU0 |  | CPU1 | | DMA |
> |------|  |------| |-----|
>     |         |        |
>     |         |        |
> |------|  |------| |-----|
> | L1-C |  | L1-C | | ACP |
> |------|  |------| |-----|
>     |         |        |
> |------------------------|
> |    Snoop Control Unit  |
> |------------------------|
>               |
> |------------------------|
> |         L2-cache       |
> |------------------------|
>               |
> |------------------------|
> |           DRAM         |
> |------------------------|
>
> (ACP = accelerator coherency port)
>
>
>
> But, I think such a system is rare.
>
> At least on my SoC (ARM SoC), DMA controllers
> for NAND, MMC, etc. are directly connected to the DRAM
> like Fig.2.
>
> So, cache operations must be explicitly done
> by software before/after DMAs are kicked.
> (I think this is very normal.)
>
> Fig.2
>
> |------|  |------| |-----|
> | CPU0 |  | CPU1 | | DMA |
> |------|  |------| |-----|
>     |         |        |
>     |         |        |
> |------|  |------|    |
> | L1-C |  | L1-C |    |
> |------|  |------|    |
>     |         |        |
> |------------------|  |
> |Snoop Control Unit|  |
> |------------------|  |
>           |            |
> |------------------|  |
> |   L2-cache       |  |
> |------------------|  |
>           |            |
> |--------------------------|
> |           DRAM           |
> |--------------------------|
>
>
> In a system like Fig.2, is the memory non-consistent?
>
> As long as I read DMA-API.txt, it is non-consistent.
> There is no consistent memory on my SoC.
>
> But, not only dma_alloc_noncoherent, but also dma_alloc_coherent()
> returns a memory region on my SoC.  I am confused...
>

On systems like this, dma_alloc_coherent() will simply return 
non-cacheable memory. Since the cache is not being used, the memory is 
coherent.

If you mmap the DMA buffer to user space, this will have performance 
implications for the userspace program. If you use the region as a 
"bounce" buffer, this is usually faster than using the streaming API.

-- 
Mike Looijmans
