From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Thu, 31 Dec 2015 10:25:48 +0000
Subject: [Question about DMA] Consistent memory?
In-Reply-To: <CAK7LNASd1amcHinXzYy=8mtYbnHUY1G_v=fthpachAVSyjqPZA@mail.gmail.com>
References: <CAK7LNASd1amcHinXzYy=8mtYbnHUY1G_v=fthpachAVSyjqPZA@mail.gmail.com>
Message-ID: <20151231102548.3ed389fb@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 31 Dec 2015 16:50:54 +0900
> But, I think such a system is rare.

Actually its quite normal for some vendors processors but not others.

> At least on my SoC (ARM SoC), DMA controllers
> for NAND, MMC, etc. are directly connected to the DRAM
> like Fig.2.
> 
> So, cache operations must be explicitly done
> by software before/after DMAs are kicked.
> (I think this is very normal.)

For ARM certainly.

> 
> Fig.2
> 
> |------|  |------| |-----|
> | CPU0 |  | CPU1 | | DMA |
> |------|  |------| |-----|
>    |         |        |
>    |         |        |
> |------|  |------|    |
> | L1-C |  | L1-C |    |
> |------|  |------|    |
>    |         |        |
> |------------------|  |
> |Snoop Control Unit|  |
> |------------------|  |
>          |            |
> |------------------|  |
> |   L2-cache       |  |
> |------------------|  |
>          |            |
> |--------------------------|
> |           DRAM           |
> |--------------------------|
> 
> 
> In a system like Fig.2, is the memory non-consistent?

dma_alloc_coherent will always provide you with coherent memory. On a
machine with good cache interfaces it will provide you with normal
memory. On some systems it may be memory from a special window, in other
cases it will fall back to providing uncached memory for this.

If the platform genuinely cannot support this (even by marking those areas
uncacheable) then it will fail the allocation.

What it does mean is that you need to use non-coherent mappings when
accessing a lot of data. On hardware without proper cache coherency it
may be quite expensive to access coherent memory.

Alan
