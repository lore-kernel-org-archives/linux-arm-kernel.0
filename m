From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 13 Jun 2018 14:40:00 +0200
Subject: [PATCH] mm: cma: honor __GFP_ZERO flag in cma_alloc()
In-Reply-To: <20180613122359.GA8695@bombadil.infradead.org>
References: <CGME20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2@eucas1p2.samsung.com>
 <20180613085851eucas1p20337d050face8ff8ea87674e16a9ccd2~3rI_9nj8b0455904559eucas1p2C@eucas1p2.samsung.com>
 <20180613122359.GA8695@bombadil.infradead.org>
Message-ID: <20180613124001eucas1p2422f7916367ce19fecd40d6131990383~3uKFrT3ML1977219772eucas1p2G@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthew,

On 2018-06-13 14:24, Matthew Wilcox wrote:
> On Wed, Jun 13, 2018 at 10:58:37AM +0200, Marek Szyprowski wrote:
>> cma_alloc() function has gfp mask parameter, so users expect that it
>> honors typical memory allocation related flags. The most imporant from
>> the security point of view is handling of __GFP_ZERO flag, because memory
>> allocated by this function usually can be directly remapped to userspace
>> by device drivers as a part of multimedia processing and ignoring this
>> flag might lead to leaking some kernel structures to userspace.
>> Some callers of this function (for example arm64 dma-iommu glue code)
>> already assumed that the allocated buffers are cleared when this flag
>> is set. To avoid such issues, add simple code for clearing newly
>> allocated buffer when __GFP_ZERO flag is set. Callers will be then
>> updated to skip implicit clearing or adjust passed gfp flags.
> I think the documentation for this function needs improving.  For example,
> GFP_ATOMIC does not work (it takes a mutex lock, so it can sleep).
> At the very least, the kernel-doc needs:
>
>   * Context: Process context (may sleep even if GFP flags indicate otherwise).
>
> Unless someone wants to rework this allocator to use spinlocks instead
> of mutexes ...

It is not only the matter of the spinlocks. GFP_ATOMIC is not supported 
by the
memory compaction code, which is used in alloc_contig_range(). Right, this
should be also noted in the documentation.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
