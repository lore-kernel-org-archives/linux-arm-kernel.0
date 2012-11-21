From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 21 Nov 2012 09:08:52 +0100
Subject: [PATCH v2] mm: dmapool: use provided gfp flags for all
 dma_alloc_coherent() calls
In-Reply-To: <20121120113325.dde266ed.akpm@linux-foundation.org>
References: <20121119144826.f59667b2.akpm@linux-foundation.org>
 <1353421905-3112-1-git-send-email-m.szyprowski@samsung.com>
 <20121120113325.dde266ed.akpm@linux-foundation.org>
Message-ID: <50AC8C14.5050204@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 11/20/2012 8:33 PM, Andrew Morton wrote:
> On Tue, 20 Nov 2012 15:31:45 +0100
> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> > dmapool always calls dma_alloc_coherent() with GFP_ATOMIC flag,
> > regardless the flags provided by the caller. This causes excessive
> > pruning of emergency memory pools without any good reason. Additionaly,
> > on ARM architecture any driver which is using dmapools will sooner or
> > later  trigger the following error:
> > "ERROR: 256 KiB atomic DMA coherent pool is too small!
> > Please increase it with coherent_pool= kernel parameter!".
> > Increasing the coherent pool size usually doesn't help much and only
> > delays such error, because all GFP_ATOMIC DMA allocations are always
> > served from the special, very limited memory pool.
> >
>
> Is this problem serious enough to justify merging the patch into 3.7?
> And into -stable kernels?

I wonder if it is a good idea to merge such change at the end of current
-rc period. It changes the behavior of dma pool allocations and I bet there
might be some drivers which don't care much about passed gfp flags, as for
ages it simply worked for them, even if the allocations were done from
atomic context. What do You think? Technically it is also not a pure bugfix,
so imho it shouldn't be considered for -stable.

On the other hand at least for ARM users of sata_mv driver (which is just
an innocent client of dma pool, correctly passing GFP_KERNEL flag) it would
solve the issues related to shortage of atomic pool for dma allocations what
might justify pushing it to 3.7.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
