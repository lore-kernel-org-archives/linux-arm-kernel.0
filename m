From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 4 Jan 2016 16:35:28 -0800
Subject: Widespread boot failures on ARM due to
 "mm/page_alloc.c: calculate zone_start_pfn at zone_spanned_pages_in_node()"
In-Reply-To: <20160104235512.GW16023@sirena.org.uk>
References: <20160104224233.GU16023@sirena.org.uk>
 <20160104150946.373ed02b8e8b81221340b7c8@linux-foundation.org>
 <20160104235512.GW16023@sirena.org.uk>
Message-ID: <20160104163528.be56a4b1.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Jan 2016 23:55:12 +0000 Mark Brown <broonie@kernel.org> wrote:

> On Mon, Jan 04, 2016 at 03:09:46PM -0800, Andrew Morton wrote:
> > On Mon, 4 Jan 2016 22:42:33 +0000 Mark Brown <broonie@kernel.org> wrote:
> 
> > > platforms in the kernelci.org boot tests[1].  Doing bisections with
> > > Arndale and BeagleBone Black identifies 904769ac82ebf (mm/page_alloc.c:
> > > calculate zone_start_pfn at zone_spanned_pages_in_node()) from the akpm
> > > tree as the first broken commit[2,3].  An example bootlog from the
> > > failure is:
> 
> > Thanks.  That patch has rather a blooper if
> > CONFIG_HAVE_MEMBLOCK_NODE_MAP=n.  Is that the case in your testing?
> 
> Seems to be what's making a difference from a quick run through, yes.

OK, thanks.

Stephen, can we please retain

mm-calculate-zone_start_pfn-at-zone_spanned_pages_in_node.patch
mm-introduce-kernelcore=mirror-option.patch
mm-introduce-kernelcore=mirror-option-fix.patch
mm-introduce-kernelcore=mirror-option-fix-2.patch

and add the below?

Or don't bother - I'll do an mmotm tomorrow with these in it.

I'd still like reviewing and testing from Taku Izumi please.



From: Arnd Bergmann <arnd@arndb.de>
Subject: mm/page_alloc.c: set a zone_start_pfn value in zone_spanned_pages_in_node

We got a new build warning in linux-next:

mm/page_alloc.c: In function 'free_area_init_node':
mm/page_alloc.c:5278:25: warning: 'zone_start_pfn' may be used uninitialized in this function [-Wmaybe-uninitialized]
    zone->zone_start_pfn = zone_start_pfn;
mm/page_alloc.c:5265:17: note: 'zone_start_pfn' was declared here
   unsigned long zone_start_pfn, zone_end_pfn;

The code indeed looks wrong, but this is just a guess of what the
fix might be: I have not looked it in detail, so please treat this
as a bug report.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/page_alloc.c |    2 ++
 1 file changed, 2 insertions(+)

diff -puN mm/page_alloc.c~mm-calculate-zone_start_pfn-at-zone_spanned_pages_in_node-fix mm/page_alloc.c
--- a/mm/page_alloc.c~mm-calculate-zone_start_pfn-at-zone_spanned_pages_in_node-fix
+++ a/mm/page_alloc.c
@@ -5013,6 +5013,8 @@ static inline unsigned long __meminit zo
 					unsigned long *zone_end_pfn,
 					unsigned long *zones_size)
 {
+	*zone_start_pfn = node_start_pfn;
+	*zone_end_pfn = node_end_pfn;
 	return zones_size[zone_type];
 }
 
_
