From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 May 2016 09:56:38 +0100
Subject: [PATCH kexec-tools 12/32] kexec: add helper to exlude a region
 from a set of memory ranges
In-Reply-To: <CAHB_Guo_ozXhAnkGk_NrdBME2fSYDoKTHwu3kLBvsrmbwxOdww@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSv-0004i3-Gi@e0050434b2927.dyn.arm.linux.org.uk>
 <CAHB_Guo_ozXhAnkGk_NrdBME2fSYDoKTHwu3kLBvsrmbwxOdww@mail.gmail.com>
Message-ID: <20160526085638.GF19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 01:30:44PM +0530, Pratyush Anand wrote:
> On Tue, May 3, 2016 at 3:52 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> > +int mem_regions_exclude(struct memory_ranges *ranges,
> > +                       const struct memory_range *range)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < ranges->size; i++) {
> > +               struct memory_range *r = ranges->ranges + i;
> > +
> > +               /*
> > +                * We assume that crash area is fully contained in
> > +                * some larger memory area.
> > +                */
> > +               if (r->start <= range->start && r->end >= range->end) {
> > +                       if (r->start == range->start) {
> > +                               /* Shrink the start of this memory range */
> > +                               r->start = range->end + 1;
> > +                       } else if (r->end == range->end) {
> > +                               /* Shrink the end of this memory range */
> > +                               r->end = range->start - 1;
> 
> What if r->start == range->start) && (r->end == range->end)?

I suppose that could happen, so what about this patch on top (untested).
This isn't something I'd be able to test on real hardware, it needs a
separate test-suite to be written to do modular testing...

 kexec/mem_regions.c | 94 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 39 deletions(-)

diff --git a/kexec/mem_regions.c b/kexec/mem_regions.c
index c6ba942..4e7061b 100644
--- a/kexec/mem_regions.c
+++ b/kexec/mem_regions.c
@@ -29,6 +29,50 @@ void mem_regions_sort(struct memory_ranges *ranges)
 }
 
 /**
+ * mem_regions_add() - add a memory region to a set of ranges
+ * @ranges: ranges to add the memory region to
+ * @max: maximum number of entries in memory region
+ * @base: base address of memory region
+ * @length: length of memory region in bytes
+ * @type: type of memory region
+ *
+ * Add the memory region to the set of ranges, and return %0 if successful,
+ * or %-1 if we ran out of space.
+ */
+int mem_regions_add(struct memory_ranges *ranges, unsigned long long base,
+                    unsigned long long length, int type)
+{
+	struct memory_range *range;
+
+	if (ranges->size >= ranges->max_size)
+		return -1;
+
+	range = ranges->ranges + ranges->size++;
+	range->start = base;
+	range->end = base + length - 1;
+	range->type = type;
+
+	return 0;
+}
+
+static void mem_regions_remove(struct memory_ranges *ranges, int index)
+{
+	int tail_entries;
+
+	/* we are assured to have at least one entry */
+	ranges->size -= 1;
+
+	/* if we have following entries, shuffle them down one place */
+	tail_entries = ranges->size - index;
+	if (tail_entries)
+		memmove(ranges->ranges + index, ranges->ranges + index + 1,
+			tail_entries * sizeof(*ranges->ranges));
+
+	/* zero the new tail entry */
+	memset(ranges->ranges + ranges->size, 0, sizeof(*ranges->ranges));
+}
+
+/**
  * mem_regions_exclude() - excludes a memory region from a set of memory ranges
  * @ranges: memory ranges to exclude the region from
  * @range: memory range to exclude
@@ -40,7 +84,7 @@ void mem_regions_sort(struct memory_ranges *ranges)
 int mem_regions_exclude(struct memory_ranges *ranges,
 			const struct memory_range *range)
 {
-	int i;
+	int i, ret;
 
 	for (i = 0; i < ranges->size; i++) {
 		struct memory_range *r = ranges->ranges + i;
@@ -51,25 +95,25 @@ int mem_regions_exclude(struct memory_ranges *ranges,
 		 */
 		if (r->start <= range->start && r->end >= range->end) {
 			if (r->start == range->start) {
-				/* Shrink the start of this memory range */
-				r->start = range->end + 1;
+				if (r->end == range->end)
+					/* Remove this entry */
+					mem_regions_remove(ranges, i);
+				else
+					/* Shrink the start of this memory range */
+					r->start = range->end + 1;
 			} else if (r->end == range->end) {
 				/* Shrink the end of this memory range */
 				r->end = range->start - 1;
 			} else {
-				struct memory_range *new;
-
 				/*
 				 * Split this area into 2 smaller ones and
 				 * remove excluded range from between. First
 				 * create new entry for the remaining area.
 				 */
-				if (ranges->size >= ranges->max_size)
-					return -1;
-
-				new = ranges->ranges + ranges->size++;
-				new->start = range->end + 1;
-				new->end = r->end;
+				ret = mem_regions_add(ranges, range->end + 1,
+						      r->end, 0);
+				if (ret < 0)
+					return ret;
 
 				/*
 				 * Update this area to end before excluded
@@ -82,31 +126,3 @@ int mem_regions_exclude(struct memory_ranges *ranges,
 	}
 	return 0;
 }
-
-/**
- * mem_regions_add() - add a memory region to a set of ranges
- * @ranges: ranges to add the memory region to
- * @max: maximum number of entries in memory region
- * @base: base address of memory region
- * @length: length of memory region in bytes
- * @type: type of memory region
- *
- * Add the memory region to the set of ranges, and return %0 if successful,
- * or %-1 if we ran out of space.
- */
-int mem_regions_add(struct memory_ranges *ranges, unsigned long long base,
-                    unsigned long long length, int type)
-{
-	struct memory_range *range;
-
-	if (ranges->size >= ranges->max_size)
-		return -1;
-
-	range = ranges->ranges + ranges->size++;
-	range->start = base;
-	range->end = base + length - 1;
-	range->type = type;
-
-	return 0;
-}
-


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
