From: vichy.kuo@gmail.com (vichy)
Date: Sat, 4 Jul 2015 23:08:52 +0800
Subject: some question about __dma_alloc in arch/arm/mm/dma-mapping.c
In-Reply-To: <CAOVJa8F6v1wA=Z1FKH01hrtb4N29v-hzYysOC6=JWkHFYMQQQA@mail.gmail.com>
References: <CAOVJa8F6v1wA=Z1FKH01hrtb4N29v-hzYysOC6=JWkHFYMQQQA@mail.gmail.com>
Message-ID: <CAOVJa8F4fZZxWLyEYDSSVT5QTEmRx_psJGZdoHhWi6Zg6hjp8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all:
in __dma_alloc of arch/arm/mm/dma-mapping.c, if the size of allocation
is PAGE_SIZE, we will use __alloc_remap_buffer instead of
__alloc_from_contiguous like below excerpted from __dma_alloc.

Is any special reason for PAGE_SIZE allocation NOT getting from continuous pool?
Appreciate your kind help in advance,

         ..............
         if (is_coherent || nommu())
                 addr = __alloc_simple_buffer(dev, size, gfp, &page);
         else if (!(gfp & __GFP_WAIT))
                 addr = __alloc_from_pool(size, &page);
         else if (size == PAGE_SIZE || !CMA_DEFAULT_REGION)
                 addr = __alloc_remap_buffer(dev, size, gfp, prot,
&page, caller);
         else
                 addr = __alloc_from_contiguous(dev, size, prot, &page, caller);
