From: dhillf@gmail.com (Hillf Danton)
Date: Sun, 5 Feb 2012 12:25:40 +0800
Subject: [PATCH 12/15] drivers: add Contiguous Memory Allocator
In-Reply-To: <1328271538-14502-13-git-send-email-m.szyprowski@samsung.com>
References: <1328271538-14502-1-git-send-email-m.szyprowski@samsung.com>
 <1328271538-14502-13-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAJd=RBBPOwftZJUfe3xc6y24=T8un5hPk0wEOT_5v6WMCbDSag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 3, 2012 at 8:18 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> The Contiguous Memory Allocator is a set of helper functions for DMA
> mapping framework that improves allocations of contiguous memory chunks.
>
> CMA grabs memory on system boot, marks it with CMA_MIGRATE_TYPE and
> gives back to the system. Kernel is allowed to allocate movable pages
> within CMA's managed memory so that it can be used for example for page
> cache when DMA mapping do not use it. On dma_alloc_from_contiguous()
> request such pages are migrated out of CMA area to free required
> contiguous block and fulfill the request. This allows to allocate large
> contiguous chunks of memory at any time assuming that there is enough
> free memory available in the system.
>
> This code is heavily based on earlier works by Michal Nazarewicz.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> CC: Michal Nazarewicz <mina86@mina86.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Tested-by: Rob Clark <rob.clark@linaro.org>
> Tested-by: Ohad Ben-Cohen <ohad@wizery.com>
> Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---

[...]

> +/*
> + * Contiguous Memory Allocator
> + *
> + * ? The Contiguous Memory Allocator (CMA) makes it possible to
> + * ? allocate big contiguous chunks of memory after the system has
> + * ? booted.
> + *
> + * Why is it needed?
> + *
> + * ? Various devices on embedded systems have no scatter-getter and/or
> + * ? IO map support and require contiguous blocks of memory to
> + * ? operate. ?They include devices such as cameras, hardware video
> + * ? coders, etc.
> + *
> + * ? Such devices often require big memory buffers (a full HD frame
> + * ? is, for instance, more then 2 mega pixels large, i.e. more than 6
> + * ? MB of memory), which makes mechanisms such as kmalloc() or
> + * ? alloc_page() ineffective.
> + *
> + * ? At the same time, a solution where a big memory region is
> + * ? reserved for a device is suboptimal since often more memory is
> + * ? reserved then strictly required and, moreover, the memory is
> + * ? inaccessible to page system even if device drivers don't use it.
> + *
> + * ? CMA tries to solve this issue by operating on memory regions
> + * ? where only movable pages can be allocated from. ?This way, kernel
> + * ? can use the memory for pagecache and when device driver requests
> + * ? it, allocated pages can be migrated.
> + *

Without boot mem reservation, what is the successful rate of CMA to
serve requests of 1MiB, 2MiB, 4MiB and 8MiB chunks?
