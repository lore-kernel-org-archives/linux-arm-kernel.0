From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 21 Nov 2011 00:12:42 +0100
Subject: [PATCH RFC] ARM: unwind: optimize to not convert each table value but
 the address
In-Reply-To: <20111120225207.GB30612@pengutronix.de>
References: <20111120225207.GB30612@pengutronix.de>
Message-ID: <1321830763-7227-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The offsets in the unwind index section are signed 31 bit numbers and
the structs are sorted by this offset. So it first has offsets between
0x40000000 and 0x7fffffff (i.e. the negative offsets) and then offsets
between 0x00000000 and 0x3fffffff. When seperating these two blocks the
numbers are sorted even when interpreting the offsets as unsigned longs.

So instead of converting each offset hit during bisection to an absolute
address, first determine which of the blocks needs to be searched and
then adapt the key to find for the offset while bisecting using a simple
unsigned long comparison.

In my tests this is faster than the original implementation modifying
the unwind index section by 4.5%.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/include/asm/unwind.h |    1 +
 arch/arm/kernel/unwind.c      |   89 ++++++++++++++++++++++++++++++++--------
 2 files changed, 72 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/unwind.h b/arch/arm/include/asm/unwind.h
index 2ae0e0a..d1c3f3a 100644
--- a/arch/arm/include/asm/unwind.h
+++ b/arch/arm/include/asm/unwind.h
@@ -37,6 +37,7 @@ struct unwind_idx {
 struct unwind_table {
 	struct list_head list;
 	const struct unwind_idx *start;
+	const struct unwind_idx *origin;
 	const struct unwind_idx *stop;
 	unsigned long begin_addr;
 	unsigned long end_addr;
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index ad3f06f..eaf5bbd 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -84,6 +84,7 @@ enum regs {
 };
 
 extern const struct unwind_idx __start_unwind_idx[];
+static const struct unwind_idx *__origin_unwind_idx;
 extern const struct unwind_idx __stop_unwind_idx[];
 
 static DEFINE_SPINLOCK(unwind_lock);
@@ -98,31 +99,76 @@ static LIST_HEAD(unwind_tables);
 })
 
 /*
- * Binary search in the unwind index. The entries entries are
+ * Binary search in the unwind index. The entries are
  * guaranteed to be sorted in ascending order by the linker.
+ *
+ * start = first entry
+ * origin = first entry with positive offset (or end if there is no such entry)
+ * stop - 1 = last entry
  */
 static const struct unwind_idx *search_index(unsigned long addr,
-				       const struct unwind_idx *first,
-				       const struct unwind_idx *last)
+				       const struct unwind_idx *start,
+				       const struct unwind_idx *origin,
+				       const struct unwind_idx *stop)
 {
-	pr_debug("%s(%08lx, %p, %p)\n", __func__, addr, first, last);
+	unsigned long addr_prel31;
+
+	pr_debug("%s(%08lx, %p, %p, %p)\n", __func__, addr, start, origin, stop);
+
+	/*
+	 * only search in the section with the matching sign. This way the
+	 * prel31 numbers can be compared as unsigned longs.
+	 */
+	if (addr < (unsigned long)start)
+		/* negative offsets: [start; origin) */
+		stop = origin;
+	else
+		/* positive offsets: [origin; stop) */
+		start = origin;
+
+	/* prel31 for address relavive to start */
+	addr_prel31 = (addr - (unsigned long)start) & 0x7fffffff;
+
+	while (start < stop - 1) {
+		const struct unwind_idx *mid = start + ((stop - start) >> 1);
+
+		/*
+		 * As addr_prel31 is relative to start an offset is needed to
+		 * make it relative to mid.
+		 */
+		if (addr_prel31 - ((unsigned long)mid - (unsigned long)start) < mid->addr_offset)
+			stop = mid;
+		else {
+			/* keep addr_prel31 relative to start */
+			addr_prel31 -= ((unsigned long)mid - (unsigned long)start);
+			start = mid;
+		}
+	}
 
-	if (addr < prel31_to_addr(&first->addr_offset)) {
+	if (likely(start->addr_offset <= addr_prel31))
+		return start;
+	else {
 		pr_warning("unwind: Unknown symbol address %08lx\n", addr);
 		return NULL;
-	} else if (addr >= prel31_to_addr(&last->addr_offset))
-		return last;
+	}
+}
 
-	while (first < last - 1) {
-		const struct unwind_idx *mid = first + ((last - first + 1) >> 1);
+static const struct unwind_idx *unwind_find_origin(const struct unwind_idx *start,
+		const struct unwind_idx *stop)
+{
+	pr_debug("%s(%p, %p)\n", __func__, start, stop);
+	while (start < stop - 1) {
+		const struct unwind_idx *mid = start + ((stop - start) >> 1);
 
-		if (addr < prel31_to_addr(&mid->addr_offset))
-			last = mid;
+		if (mid->addr_offset >= 0x40000000)
+			/* negative offset */
+			start = mid;
 		else
-			first = mid;
+			/* positive offset */
+			stop = mid;
 	}
-
-	return first;
+	pr_debug("%s -> %p\n", __func__, stop);
+	return stop;
 }
 
 static const struct unwind_idx *unwind_find_idx(unsigned long addr)
@@ -132,11 +178,16 @@ static const struct unwind_idx *unwind_find_idx(unsigned long addr)
 
 	pr_debug("%s(%08lx)\n", __func__, addr);
 
-	if (core_kernel_text(addr))
+	if (core_kernel_text(addr)) {
+		if (unlikely(!__origin_unwind_idx))
+			__origin_unwind_idx = unwind_find_origin(__start_unwind_idx,
+					__stop_unwind_idx);
+
 		/* main unwind table */
 		idx = search_index(addr, __start_unwind_idx,
-				   __stop_unwind_idx - 1);
-	else {
+				   __origin_unwind_idx,
+				   __stop_unwind_idx);
+	} else {
 		/* module unwind tables */
 		struct unwind_table *table;
 
@@ -145,7 +196,8 @@ static const struct unwind_idx *unwind_find_idx(unsigned long addr)
 			if (addr >= table->begin_addr &&
 			    addr < table->end_addr) {
 				idx = search_index(addr, table->start,
-						   table->stop - 1);
+						   table->origin,
+						   table->stop);
 				/* Move-to-front to exploit common traces */
 				list_move(&table->list, &unwind_tables);
 				break;
@@ -409,6 +461,7 @@ struct unwind_table *unwind_table_add(unsigned long start, unsigned long size,
 
 	tab->start = (const struct unwind_idx *)start;
 	tab->stop = (const struct unwind_idx *)(start + size);
+	tab->origin = unwind_find_origin(tab->start, tab->stop);
 	tab->begin_addr = text_addr;
 	tab->end_addr = text_addr + text_size;
 
-- 
1.7.7.2
