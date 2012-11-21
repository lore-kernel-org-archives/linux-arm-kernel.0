From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 21 Nov 2012 11:17:11 -0800
Subject: [PATCH v2] mm: dmapool: use provided gfp flags for all
 dma_alloc_coherent() calls
In-Reply-To: <50AC9CC7.8010103@samsung.com>
References: <20121119144826.f59667b2.akpm@linux-foundation.org>
 <1353421905-3112-1-git-send-email-m.szyprowski@samsung.com>
 <20121120113325.dde266ed.akpm@linux-foundation.org>
 <50AC8C14.5050204@samsung.com>
 <20121121003643.97febbdb.akpm@linux-foundation.org>
 <50AC9CC7.8010103@samsung.com>
Message-ID: <20121121111711.fe915265.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Nov 2012 10:20:07 +0100
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> Hello,
> 
> On 11/21/2012 9:36 AM, Andrew Morton wrote:
> > On Wed, 21 Nov 2012 09:08:52 +0100 Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >
> > > Hello,
> > >
> > > On 11/20/2012 8:33 PM, Andrew Morton wrote:
> > > > On Tue, 20 Nov 2012 15:31:45 +0100
> > > > Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> > > >
> > > > > dmapool always calls dma_alloc_coherent() with GFP_ATOMIC flag,
> > > > > regardless the flags provided by the caller. This causes excessive
> > > > > pruning of emergency memory pools without any good reason. Additionaly,
> > > > > on ARM architecture any driver which is using dmapools will sooner or
> > > > > later  trigger the following error:
> > > > > "ERROR: 256 KiB atomic DMA coherent pool is too small!
> > > > > Please increase it with coherent_pool= kernel parameter!".
> > > > > Increasing the coherent pool size usually doesn't help much and only
> > > > > delays such error, because all GFP_ATOMIC DMA allocations are always
> > > > > served from the special, very limited memory pool.
> > > > >
> > > >
> > > > Is this problem serious enough to justify merging the patch into 3.7?
> > > > And into -stable kernels?
> > >
> > > I wonder if it is a good idea to merge such change at the end of current
> > > -rc period.
> >
> > I'm not sure what you mean by this.
> >
> > But what we do sometimes if we think a patch needs a bit more
> > real-world testing before backporting is to merge it into -rc1 in the
> > normal merge window, and tag it for -stable backporting.  That way it
> > gets a few weeks(?) testing in mainline before getting backported.
> 
> I just wondered that if it gets merged to v3.7-rc7 there won't be much time
> for real-world testing before final v3.7 release. This patch is in
> linux-next for over a week and I'm not aware of any issues, but -rc releases
> gets much more attention and testing than linux-next tree.
> 
> If You think it's fine to put such change to v3.7-rc7 I will send a pull
> request and tag it for stable asap.
> 

What I'm suggesting is that it be merged for 3.8-rc1 with a -stable
tag, then it will be backported into 3.7.x later on.
