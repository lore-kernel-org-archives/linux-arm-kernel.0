From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 15 Jan 2013 11:56:42 -0500
Subject: [PATCH v2] mm: dmapool: use provided gfp flags for all
 dma_alloc_coherent() calls
In-Reply-To: <50F3F289.3090402@web.de>
References: <20121119144826.f59667b2.akpm@linux-foundation.org>
 <1353421905-3112-1-git-send-email-m.szyprowski@samsung.com>
 <50F3F289.3090402@web.de>
Message-ID: <20130115165642.GA25500@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

I've added you to the this thread hoping for a little insight into USB
drivers and their use of coherent and GFP_ATOMIC.  Am I barking up the
wrong tree by looking a the drivers?

On Mon, Jan 14, 2013 at 12:56:57PM +0100, Soeren Moch wrote:
> On 20.11.2012 15:31, Marek Szyprowski wrote:
> >dmapool always calls dma_alloc_coherent() with GFP_ATOMIC flag,
> >regardless the flags provided by the caller. This causes excessive
> >pruning of emergency memory pools without any good reason. Additionaly,
> >on ARM architecture any driver which is using dmapools will sooner or
> >later  trigger the following error:
> >"ERROR: 256 KiB atomic DMA coherent pool is too small!
> >Please increase it with coherent_pool= kernel parameter!".
> >Increasing the coherent pool size usually doesn't help much and only
> >delays such error, because all GFP_ATOMIC DMA allocations are always
> >served from the special, very limited memory pool.
> >
> >This patch changes the dmapool code to correctly use gfp flags provided
> >by the dmapool caller.
> >
> >Reported-by: Soeren Moch <smoch@web.de>
> >Reported-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> >Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >Tested-by: Andrew Lunn <andrew@lunn.ch>
> >Tested-by: Soeren Moch <smoch@web.de>
> 
> Now I tested linux-3.7.1 (this patch is included there) on my Marvell
> Kirkwood system. I still see
> 
>   ERROR: 1024 KiB atomic DMA coherent pool is too small!
>   Please increase it with coherent_pool= kernel parameter!
> 
> after several hours of runtime under heavy load with SATA and
> DVB-Sticks (em28xx / drxk and dib0700).

Could you try running the system w/o the em28xx stick and see how it
goes with v3.7.1?

thx,

Jason.

> As already reported earlier this patch improved the behavior
> compared to linux-3.6.x and 3.7.0 (error after several ten minutes
> runtime), but
> I still see a regression compared to linux-3.5.x. With this kernel the
> same system with same workload runs flawlessly.
> 
> Regards,
> Soeren
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
