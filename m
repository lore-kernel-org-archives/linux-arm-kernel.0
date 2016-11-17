From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 17 Nov 2016 14:34:24 +0900
Subject: [PATCH v27 1/9] memblock: add memblock_cap_memory_range()
In-Reply-To: <20161116163015.GM7928@arm.com>
References: <20161102044959.11954-1-takahiro.akashi@linaro.org>
 <20161102045153.12008-1-takahiro.akashi@linaro.org>
 <20161110172720.GB17134@arm.com> <20161111025049.GG381@linaro.org>
 <20161111031903.GB15997@arm.com> <20161114055515.GH381@linaro.org>
 <20161116163015.GM7928@arm.com>
Message-ID: <20161117022023.GA5704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On Wed, Nov 16, 2016 at 04:30:15PM +0000, Will Deacon wrote:
> Hi Akashi,
> 
> On Mon, Nov 14, 2016 at 02:55:16PM +0900, AKASHI Takahiro wrote:
> > On Fri, Nov 11, 2016 at 11:19:04AM +0800, Dennis Chen wrote:
> > > On Fri, Nov 11, 2016 at 11:50:50AM +0900, AKASHI Takahiro wrote:
> > > > On Thu, Nov 10, 2016 at 05:27:20PM +0000, Will Deacon wrote:
> > > > > On Wed, Nov 02, 2016 at 01:51:53PM +0900, AKASHI Takahiro wrote:
> > > > > > +void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
> > > > > > +{
> > > > > > +	int start_rgn, end_rgn;
> > > > > > +	int i, ret;
> > > > > > +
> > > > > > +	if (!size)
> > > > > > +		return;
> > > > > > +
> > > > > > +	ret = memblock_isolate_range(&memblock.memory, base, size,
> > > > > > +						&start_rgn, &end_rgn);
> > > > > > +	if (ret)
> > > > > > +		return;
> > > > > > +
> > > > > > +	/* remove all the MAP regions */
> > > > > > +	for (i = memblock.memory.cnt - 1; i >= end_rgn; i--)
> > > > > > +		if (!memblock_is_nomap(&memblock.memory.regions[i]))
> > > > > > +			memblock_remove_region(&memblock.memory, i);
> > > > > > +
> > > > > > +	for (i = start_rgn - 1; i >= 0; i--)
> > > > > > +		if (!memblock_is_nomap(&memblock.memory.regions[i]))
> > > > > > +			memblock_remove_region(&memblock.memory, i);
> > > > > > +
> > > > > > +	/* truncate the reserved regions */
> > > > > > +	memblock_remove_range(&memblock.reserved, 0, base);
> > > > > > +	memblock_remove_range(&memblock.reserved,
> > > > > > +			base + size, (phys_addr_t)ULLONG_MAX);
> > > > > > +}
> > > > > 
> > > > > This duplicates a bunch of the logic in memblock_mem_limit_remove_map. Can
> > > > > you not implement that in terms of your new, more general, function? e.g.
> > > > > by passing base == 0, and size == limit?
> > > > 
> > > > Obviously it's possible.
> > > > I actually talked to Dennis before about merging them,
> > > > but he was against my idea.
> > > >
> > > Oops! I thought we have reached agreement in the thread:http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/442817.html
> > > So feel free to do that as Will'll do
> > 
> > OK, but I found that the two functions have a bit different semantics
> > in clipping memory range, in particular, when the range [base,base+size)
> > goes across several regions with a gap.
> > (This does not happen in my arm64 kdump, though.)
> > That is, 'limit' in memblock_mem_limit_remove_map() means total size of
> > available memory, while 'size' in memblock_cap_memory_range() indicates
> > the size of _continuous_ memory range.
> 
> I thought limit was just a physical address, and then

No, it's not.

> memblock_mem_limit_remove_map operated on the end of the nearest memblock?

No, but "max_addr" returned by __find_max_addr() is a physical address
and the end address of memory of "limit" size in total.

> You could leave the __find_max_addr call in memblock_mem_limit_remove_map,
> given that I don't think you need/want it for memblock_cap_memory_range.
> 
> > So I added an extra argument, exact, to a common function to specify
> > distinct behaviors. Confusing? Please see the patch below.
> 
> Oh yikes, this certainly wasn't what I had in mind! My observation was
> just that memblock_mem_limit_remove_map(limit) does:
> 
> 
>   1. memblock_isolate_range(limit - limit+ULLONG_MAX)
>   2. memblock_remove_region(all non-nomap regions in the isolated region)
>   3. truncate reserved regions to limit
> 
> and your memblock_cap_memory_range(base, size) does:
> 
>   1. memblock_isolate_range(base - base+size)
>   2, memblock_remove_region(all non-nomap regions above and below the
>      isolated region)
>   3. truncate reserved regions around the isolated region
> 
> so, assuming we can invert the isolation in one of the cases, then they
> could share the same underlying implementation.

Please see my simplified patch below which would explain what I meant.
(Note that the size is calculated by 'max_addr - 0'.)

> I'm probably just missing something here, because the patch you've ended
> up with is far more involved than I anticipated...

I hope that it will meet almost your anticipation.

Thanks,
-Takahiro AKASHI

> 
> Will
===8<===
diff --git a/mm/memblock.c b/mm/memblock.c
index 7608bc3..fea1688 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1514,11 +1514,37 @@ void __init memblock_enforce_memory_limit(phys_addr_t limit)
 			      (phys_addr_t)ULLONG_MAX);
 }
 
+void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
+{
+	int start_rgn, end_rgn;
+	int i, ret;
+
+	if (!size)
+		return;
+
+	ret = memblock_isolate_range(&memblock.memory, base, size,
+						&start_rgn, &end_rgn);
+	if (ret)
+		return;
+
+	/* remove all the MAP regions */
+	for (i = memblock.memory.cnt - 1; i >= end_rgn; i--)
+		if (!memblock_is_nomap(&memblock.memory.regions[i]))
+			memblock_remove_region(&memblock.memory, i);
+
+	for (i = start_rgn - 1; i >= 0; i--)
+		if (!memblock_is_nomap(&memblock.memory.regions[i]))
+			memblock_remove_region(&memblock.memory, i);
+
+	/* truncate the reserved regions */
+	memblock_remove_range(&memblock.reserved, 0, base);
+	memblock_remove_range(&memblock.reserved,
+			base + size, (phys_addr_t)ULLONG_MAX);
+}
+
 void __init memblock_mem_limit_remove_map(phys_addr_t limit)
 {
-	struct memblock_type *type = &memblock.memory;
 	phys_addr_t max_addr;
-	int i, ret, start_rgn, end_rgn;
 
 	if (!limit)
 		return;
@@ -1529,19 +1555,7 @@ void __init memblock_mem_limit_remove_map(phys_addr_t limit)
 	if (max_addr == (phys_addr_t)ULLONG_MAX)
 		return;
 
-	ret = memblock_isolate_range(type, max_addr, (phys_addr_t)ULLONG_MAX,
-				&start_rgn, &end_rgn);
-	if (ret)
-		return;
-
-	/* remove all the MAP regions above the limit */
-	for (i = end_rgn - 1; i >= start_rgn; i--) {
-		if (!memblock_is_nomap(&type->regions[i]))
-			memblock_remove_region(type, i);
-	}
-	/* truncate the reserved regions */
-	memblock_remove_range(&memblock.reserved, max_addr,
-			      (phys_addr_t)ULLONG_MAX);
+	memblock_cap_memory_range(0, max_addr);
 }
 
 static int __init_memblock memblock_search(struct memblock_type *type, phys_addr_t addr)
