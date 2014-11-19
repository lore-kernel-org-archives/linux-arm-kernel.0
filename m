From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Nov 2014 15:41:12 +0100
Subject: [PATCH 2/2] ARM: cache-l2x0: optimize aurora range operations
In-Reply-To: <1547660.4MUNEQsfAo@wuerfel>
References: <1547660.4MUNEQsfAo@wuerfel>
Message-ID: <2338525.sAePmDcrt9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aurora_inv_range(), aurora_clean_range() and aurora_flush_range()
functions are highly redundant, both in source and in object code, and
they are harder to understand than necessary.

By moving the range loop into the aurora_pa_range() function, they
become trivial wrappers, and the object code start looking like what
one would expect for an optimal implementation.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
 (on Armada 370 RD and Armada XP GP, boot tested, plus a little bit of
 DMA traffic by reading data from a SD card)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index c61f4151162f..737426b6bba6 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1164,7 +1164,7 @@ static const struct l2c_init_data of_l2c310_coherent_data __initconst = {
  * noninclusive, while the hardware cache range operations use
  * inclusive start and end addresses.
  */
-static unsigned long calc_range_end(unsigned long start, unsigned long end)
+static unsigned long aurora_range_end(unsigned long start, unsigned long end)
 {
 	/*
 	 * Limit the number of cache lines processed at once,
@@ -1183,25 +1183,13 @@ static unsigned long calc_range_end(unsigned long start, unsigned long end)
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
@@ -1209,15 +1197,24 @@ static void aurora_inv_range(unsigned long start, unsigned long end)
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
@@ -1225,36 +1222,16 @@ static void aurora_clean_range(unsigned long start, unsigned long end)
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
