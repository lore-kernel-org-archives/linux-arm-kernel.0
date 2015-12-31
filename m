From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 31 Dec 2015 16:50:54 +0900
Subject: [Question about DMA] Consistent memory?
Message-ID: <CAK7LNASd1amcHinXzYy=8mtYbnHUY1G_v=fthpachAVSyjqPZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

I am new to the Linux DMA APIs.

First, I started by reading Documentation/DMA-API.txt,
but I am confused with the term "consistent memory".

Please help me understand the document correctly.


The DMA-API.txt says as follows:

----------------------->8--------------------------------------------
void *
dma_alloc_coherent(struct device *dev, size_t size,
    dma_addr_t *dma_handle, gfp_t flag)

Consistent memory is memory for which a write by either the device or
the processor can immediately be read by the processor or device
without having to worry about caching effects.  (You may however need
to make sure to flush the processor's write buffers before telling
devices to read that memory.)
------------------------8<--------------------------------------------


As far as I understand the the cited sentence, for the memory
to be consistent, DMA controllers must be connected to
DRAM through some special hardware that keeps the memory
coherency, such as SCU.  I assume the system like Fig.1


Fig.1

|------|  |------| |-----|
| CPU0 |  | CPU1 | | DMA |
|------|  |------| |-----|
   |         |        |
   |         |        |
|------|  |------| |-----|
| L1-C |  | L1-C | | ACP |
|------|  |------| |-----|
   |         |        |
|------------------------|
|    Snoop Control Unit  |
|------------------------|
             |
|------------------------|
|         L2-cache       |
|------------------------|
             |
|------------------------|
|           DRAM         |
|------------------------|

(ACP = accelerator coherency port)



But, I think such a system is rare.

At least on my SoC (ARM SoC), DMA controllers
for NAND, MMC, etc. are directly connected to the DRAM
like Fig.2.

So, cache operations must be explicitly done
by software before/after DMAs are kicked.
(I think this is very normal.)

Fig.2

|------|  |------| |-----|
| CPU0 |  | CPU1 | | DMA |
|------|  |------| |-----|
   |         |        |
   |         |        |
|------|  |------|    |
| L1-C |  | L1-C |    |
|------|  |------|    |
   |         |        |
|------------------|  |
|Snoop Control Unit|  |
|------------------|  |
         |            |
|------------------|  |
|   L2-cache       |  |
|------------------|  |
         |            |
|--------------------------|
|           DRAM           |
|--------------------------|


In a system like Fig.2, is the memory non-consistent?

As long as I read DMA-API.txt, it is non-consistent.
There is no consistent memory on my SoC.

But, not only dma_alloc_noncoherent, but also dma_alloc_coherent()
returns a memory region on my SoC.  I am confused...



-- 
Best Regards
Masahiro Yamada
