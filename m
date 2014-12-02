From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 1 Dec 2014 16:13:00 -0800
Subject: [PATCH] mm: Remove the highmem zones' memmap in the highmem zone
In-Reply-To: <1417085194-17042-1-git-send-email-bocui107@gmail.com>
References: <1417085194-17042-1-git-send-email-bocui107@gmail.com>
Message-ID: <20141201161300.8d370b30b181e988065ec71d@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Nov 2014 18:46:34 +0800 Hongbo Zhong <bocui107@gmail.com> wrote:

> From: Zhong Hongbo <bocui107@gmail.com>
> 
> Since the commit 01cefaef40c4 ("mm: provide more accurate estimation
> of pages occupied by memmap") allocate the pages from lowmem for the
> highmem zones' memmap. So It is not need to reserver the memmap's for
> the highmem.

Looks right.

> A 2G DDR3 for the arm platform:
> On node 0 totalpages: 524288
> free_area_init_node: node 0, pgdat 80ccd380, node_mem_map 80d38000
>   DMA zone: 3568 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 456704 pages, LIFO batch:31
>   HighMem zone: 528 pages used for memmap
>   HighMem zone: 67584 pages, LIFO batch:15
> 
> On node 0 totalpages: 524288
> free_area_init_node: node 0, pgdat 80cd6f40, node_mem_map 80d42000
>   DMA zone: 3568 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 456704 pages, LIFO batch:31
>   HighMem zone: 67584 pages, LIFO batch:15

So nothing changed.  Maybe it would have if the machine had more
highmem.

I'm trying to work out what effect this patch actually has.  AFAICT it
provides more accurate values for zone->min_unmapped_pages and
zone->min_slab_pages on NUMA.  Anything else?
