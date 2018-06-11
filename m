From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 11 Jun 2018 09:55:54 +0200
Subject: [PATCH] arm64: dma-mapping: clear buffers allocated with
 FORCE_CONTIGUOUS flag
In-Reply-To: <20180611051340.9024-1-m.szyprowski@samsung.com>
References: <CGME20180611051352eucas1p1f256a2a303da85a1e0923f012d709e39@eucas1p1.samsung.com>
 <20180611051340.9024-1-m.szyprowski@samsung.com>
Message-ID: <CAMuHMdV8PTBArnaoXMXsuTqxLcizAZe4YO59TkZ6Wj-F4M6Sbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Thanks for your patch!

On Mon, Jun 11, 2018 at 7:14 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> dma_alloc_*() buffers might be exposed to userspace via mmap() call, so
> they should be cleared on allocation. In case of IOMMU-based dma-mapping
> implementation such buffer clearing was missing in the code path for
> DMA_ATTR_FORCE_CONTIGUOUS flag handling. This patch fixes this issue. For

Is it? The memory is allocated using dma_alloc_from_contiguous(..., gfp),
and __iommu_alloc_attrs() has

        /*
         * Some drivers rely on this, and we probably don't want the
         * possibility of stale kernel data being read by devices anyway.
         */
        gfp |= __GFP_ZERO;

at the top, before the allocation.

If cma_alloc() (called from dma_alloc_from_contiguous()) doesn't honor
__GFP_ZERO, I think cma_alloc() should be fixed instead.

> more information on clearing buffers allocated by dma_alloc_* functions,
> see commit 44176bb38fa4 ("arm64: dma-mapping: always clear allocated

6829e274a623

> buffers").
>
> Fixes: 44176bb38fa4 ("arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to IOMMU")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
