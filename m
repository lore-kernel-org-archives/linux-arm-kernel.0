From: willy@infradead.org (Matthew Wilcox)
Date: Wed, 13 Jun 2018 05:24:01 -0700
Subject: [PATCH] mm: cma: honor __GFP_ZERO flag in cma_alloc()
In-Reply-To: <20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2~3rI_9nj8b0455904559eucas1p2C@eucas1p2.samsung.com>
References: <CGME20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2@eucas1p2.samsung.com>
 <20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2~3rI_9nj8b0455904559eucas1p2C@eucas1p2.samsung.com>
Message-ID: <20180613122359.GA8695@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 10:58:37AM +0200, Marek Szyprowski wrote:
> cma_alloc() function has gfp mask parameter, so users expect that it
> honors typical memory allocation related flags. The most imporant from
> the security point of view is handling of __GFP_ZERO flag, because memory
> allocated by this function usually can be directly remapped to userspace
> by device drivers as a part of multimedia processing and ignoring this
> flag might lead to leaking some kernel structures to userspace.
> Some callers of this function (for example arm64 dma-iommu glue code)
> already assumed that the allocated buffers are cleared when this flag
> is set. To avoid such issues, add simple code for clearing newly
> allocated buffer when __GFP_ZERO flag is set. Callers will be then
> updated to skip implicit clearing or adjust passed gfp flags.

I think the documentation for this function needs improving.  For example,
GFP_ATOMIC does not work (it takes a mutex lock, so it can sleep).
At the very least, the kernel-doc needs:

 * Context: Process context (may sleep even if GFP flags indicate otherwise).

Unless someone wants to rework this allocator to use spinlocks instead
of mutexes ...
