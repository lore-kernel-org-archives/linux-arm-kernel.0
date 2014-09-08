From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Sep 2014 22:43:32 +0200
Subject: [PATCH] ARM: cache-l2x0: optimize aurora range operations
In-Reply-To: <2958731.nsOomQFma0@wuerfel>
References: <2852268.nkG1OoBDfE@wuerfel>
 <20140908153946.GB12361@n2100.arm.linux.org.uk> <2958731.nsOomQFma0@wuerfel>
Message-ID: <2885617.4rXk1QzsZ5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aurora_inv_range(), aurora_clean_range() and aurora_flush_range()
functions are highly redundant, both in source and in object code, and
they are harder to understand than necessary.

By moving the range loop into the aurora_pa_range() function, they
become trivial wrappers, and the object code start looking like what
one would expect for an optimal implementation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/cache-l2x0.c | 67 +++++++++++++++++-----------------------------------------
 1 file changed, 22 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 0964e83e0238..82d724af294e 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1033,7 +1033,7 @@ static const struct l2c_init_data of_l2c310_coherent_data __initconst = {
  * noninclusive, while the hardware cache range operations use
  * inclusive start and end addresses.
  */
-static unsigned long calc_range_end(unsigned long start, unsigned long end)
+static unsigned long aurora_range_end(unsigned long start, unsigned long end)
 {
 	/*
 	 * Limit the number of cache lines processed at once,
@@ -1052,25 +1052,13 @@ static unsigned long calc_range_end(unsigned long start, unsigned long end)
 	return end;
 }
 
-/*
- * Make sure 'start' and 'end' reference the same page, as L2 is PIPT
- * and range operations only do a TLB lookup on the start address.
- */
 static void aurora_pa_range(unsigned long start, unsigned long end,
-			unsigned long offset)
+			    unsigned long offset)
 {
 	void __iomem *base = l2x0_base;
+	unsigned long range_end;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&l2x0_lock, flags);
-	writel_relaxed(start, base + AURORA_RANGE_BASE_ADDR_REG);
-	writel_relaxed(end, base + offset);
-	writel_relaxed(0, base + AURORA_SYNC_REG);
-	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
-}
-
-static void aurora_inv_range(unsigned long start, unsigned long end)
-{
 	/*
 	 * round start and end adresses up to cache line size
 	 */
@@ -1078,15 +1066,24 @@ static void aurora_inv_range(unsigned long start, unsigned long end)
 	end = ALIGN(end, CACHE_LINE_SIZE);
 
 	/*
-	 * Invalidate all full cache lines between 'start' and 'end'.
+	 * perform operation on all full cache lines between 'start' and 'end'
 	 */
 	while (start < end) {
-		unsigned long range_end = calc_range_end(start, end);
-		aurora_pa_range(start, range_end - CACHE_LINE_SIZE,
-				AURORA_INVAL_RANGE_REG);
+		range_end = aurora_range_end(start, end);
+
+		raw_spin_lock_irqsave(&l2x0_lock, flags);
+		writel_relaxed(start, base + AURORA_RANGE_BASE_ADDR_REG);
+		writel_relaxed(range_end - CACHE_LINE_SIZE, base + offset);
+		writel_relaxed(0, base + AURORA_SYNC_REG);
+		raw_spin_unlock_irqrestore(&l2x0_lock, flags);
+
 		start = range_end;
 	}
 }
+static void aurora_inv_range(unsigned long start, unsigned long end)
+{
+	aurora_pa_range(start, end, AURORA_INVAL_RANGE_REG);
+}
 
 static void aurora_clean_range(unsigned long start, unsigned long end)
 {
@@ -1094,36 +1091,16 @@ static void aurora_clean_range(unsigned long start, unsigned long end)
 	 * If L2 is forced to WT, the L2 will always be clean and we
 	 * don't need to do anything here.
 	 */
-	if (!l2_wt_override) {
-		start &= ~(CACHE_LINE_SIZE - 1);
-		end = ALIGN(end, CACHE_LINE_SIZE);
-		while (start != end) {
-			unsigned long range_end = calc_range_end(start, end);
-			aurora_pa_range(start, range_end - CACHE_LINE_SIZE,
-					AURORA_CLEAN_RANGE_REG);
-			start = range_end;
-		}
-	}
+	if (!l2_wt_override)
+		aurora_pa_range(start, end, AURORA_CLEAN_RANGE_REG);
 }
 
 static void aurora_flush_range(unsigned long start, unsigned long end)
 {
-	start &= ~(CACHE_LINE_SIZE - 1);
-	end = ALIGN(end, CACHE_LINE_SIZE);
-	while (start != end) {
-		unsigned long range_end = calc_range_end(start, end);
-		/*
-		 * If L2 is forced to WT, the L2 will always be clean and we
-		 * just need to invalidate.
-		 */
-		if (l2_wt_override)
-			aurora_pa_range(start, range_end - CACHE_LINE_SIZE,
-							AURORA_INVAL_RANGE_REG);
-		else
-			aurora_pa_range(start, range_end - CACHE_LINE_SIZE,
-							AURORA_FLUSH_RANGE_REG);
-		start = range_end;
-	}
+	if (l2_wt_override)
+		aurora_pa_range(start, end, AURORA_INVAL_RANGE_REG);
+	else
+		aurora_pa_range(start, end, AURORA_FLUSH_RANGE_REG);
 }
 
 static void aurora_flush_all(void)
