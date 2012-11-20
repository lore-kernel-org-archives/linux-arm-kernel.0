From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 20 Nov 2012 15:27:27 -0500
Subject: [PATCH v2] mm: dmapool: use provided gfp flags for all
 dma_alloc_coherent() calls
In-Reply-To: <20121120113325.dde266ed.akpm@linux-foundation.org>
References: <20121119144826.f59667b2.akpm@linux-foundation.org>
 <1353421905-3112-1-git-send-email-m.szyprowski@samsung.com>
 <20121120113325.dde266ed.akpm@linux-foundation.org>
Message-ID: <20121120202727.GE22106@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 11:33:25AM -0800, Andrew Morton wrote:
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

kirkwood and orion5x currently have the following code in their early
init:

/*
 * Some Kirkwood devices allocate their coherent buffers from atomic
 * context. Increase size of atomic coherent pool to make sure such the
 * allocations won't fail.
 */
init_dma_coherent_pool_size(SZ_1M);

We have a pending patch to do the same for mvebu (new armv7 Marvell
SoCs).  There is at least one reported real world case where even the
above isn't sufficient [1].

thx,

Jason.

[1] http://www.spinics.net/lists/arm-kernel/msg205495.html
