From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 4 Jan 2016 21:49:44 -0800
Subject: Widespread boot failures on ARM due to
 "mm/page_alloc.c: calculate zone_start_pfn at zone_spanned_pages_in_node()"
In-Reply-To: <20160105164716.44b9db6d@canb.auug.org.au>
References: <20160104224233.GU16023@sirena.org.uk>
 <20160104150946.373ed02b8e8b81221340b7c8@linux-foundation.org>
 <20160104235512.GW16023@sirena.org.uk>
 <20160104163528.be56a4b1.akpm@linux-foundation.org>
 <20160105114918.2641f95d@canb.auug.org.au>
 <20160105164716.44b9db6d@canb.auug.org.au>
Message-ID: <20160104214944.8cafbcef.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Jan 2016 16:47:16 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Andrew,
> 
> On Tue, 5 Jan 2016 11:49:18 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Mon, 4 Jan 2016 16:35:28 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > Stephen, can we please retain
> > > 
> > > mm-calculate-zone_start_pfn-at-zone_spanned_pages_in_node.patch
> > > mm-introduce-kernelcore=mirror-option.patch
> > > mm-introduce-kernelcore=mirror-option-fix.patch
> > > mm-introduce-kernelcore=mirror-option-fix-2.patch
> > > 
> > > and add the below?  
> > 
> > Sure, that is easier than dropping the above patches, anyway.
> 
> I have done that *except* that
> mm-introduce-kernelcore=mirror-option-fix-2.patch is not in mmotm and I
> cannot find it anywhere.

oops sorry, I took it out so it isn't in today's
http://ozlabs.org/~akpm/mmots/broken-out/.  Here:


From: Arnd Bergmann <arnd@arndb.de>
Subject: mm: avoid unused variables in memmap_init_zone

A quick fix on mm/page_alloc.c introduced a harmless warning:

mm/page_alloc.c: In function 'memmap_init_zone':
mm/page_alloc.c:4617:44: warning: unused variable 'tmp' [-Wunused-variable]
mm/page_alloc.c:4617:26: warning: unused variable 'r' [-Wunused-variable]

This uses another #ifdef to avoid declaring the two variables when the
code is not built.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/page_alloc.c |    2 ++
 1 file changed, 2 insertions(+)

diff -puN mm/page_alloc.c~mm-introduce-kernelcore=mirror-option-fix-2 mm/page_alloc.c
--- a/mm/page_alloc.c~mm-introduce-kernelcore=mirror-option-fix-2
+++ a/mm/page_alloc.c
@@ -4465,7 +4465,9 @@ void __meminit memmap_init_zone(unsigned
 	unsigned long pfn;
 	struct zone *z;
 	unsigned long nr_initialised = 0;
+#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 	struct memblock_region *r = NULL, *tmp;
+#endif
 
 	if (highest_memmap_pfn < end_pfn - 1)
 		highest_memmap_pfn = end_pfn - 1;
_
