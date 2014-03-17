From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:17:00 +0000
Subject: [PATCH 41/44] ARM: l2c: remove old .set_debug method
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLEi-0002ee-QY@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We no longer need or require the .set_debug method; we handle everything
it used to do via the .write_sec method instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/outercache.h |  1 -
 arch/arm/mm/cache-l2x0.c          | 21 ++-------------------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index 69f57a5c0dd3..2e0de485a210 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -36,7 +36,6 @@ struct outer_cache_fns {
 	void (*resume)(void);
 
 	/* This is an ARM L2C thing */
-	void (*set_debug)(unsigned long);
 	void (*write_sec)(unsigned long, unsigned);
 };
 
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index f9fe70792bc9..ae838bb97cc2 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -77,10 +77,7 @@ static void l2c_write_sec(unsigned long val, void __iomem *base, unsigned reg)
  */
 static inline void l2c_set_debug(void __iomem *base, unsigned long val)
 {
-	if (outer_cache.set_debug)
-		outer_cache.set_debug(val);
-	else
-		l2c_write_sec(val, base, L2X0_DEBUG_CTRL);
+	l2c_write_sec(val, base, L2X0_DEBUG_CTRL);
 }
 
 static void __l2c_op_way(void __iomem *reg)
@@ -156,8 +153,7 @@ static inline void l2x0_inv_line(unsigned long addr)
 #if defined(CONFIG_PL310_ERRATA_588369) || defined(CONFIG_PL310_ERRATA_727915)
 static inline void debug_writel(unsigned long val)
 {
-	if (outer_cache.set_debug || outer_cache.write_sec)
-		l2c_set_debug(l2x0_base, val);
+	l2c_set_debug(l2x0_base, val);
 }
 #else
 /* Optimised out for non-errata case */
@@ -682,11 +678,6 @@ static const struct l2c_init_data l2c220_data = {
  *	Affects: store buffer
  *	store buffer is not automatically drained.
  */
-static void l2c310_set_debug(unsigned long val)
-{
-	writel_relaxed(val, l2x0_base + L2X0_DEBUG_CTRL);
-}
-
 static void l2c310_inv_range_erratum(unsigned long start, unsigned long end)
 {
 	void __iomem *base = l2x0_base;
@@ -830,10 +821,6 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 	const char *errata[4];
 	unsigned n = 0;
 
-	/* For compatibility */
-	if (revision <= L310_CACHE_ID_RTL_R3P0)
-		fns->set_debug = l2c310_set_debug;
-
 	if (IS_ENABLED(CONFIG_PL310_ERRATA_588369) &&
 	    revision < L310_CACHE_ID_RTL_R2P0 &&
 	    /* For compatibility */
@@ -882,7 +869,6 @@ static const struct l2c_init_data l2c310_init_fns __initconst = {
 		.flush_all = l2c210_flush_all,
 		.disable = l2c210_disable,
 		.sync = l2c210_sync,
-		.set_debug = l2c310_set_debug,
 		.resume = l2c310_resume,
 	},
 };
@@ -948,8 +934,6 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 	fns.write_sec = outer_cache.write_sec;
 	if (data->fixup)
 		data->fixup(l2x0_base, cache_id, &fns);
-	if (fns.write_sec)
-		fns.set_debug = NULL;
 
 	/*
 	 * Check if l2x0 controller is already enabled.  If we are booting
@@ -1120,7 +1104,6 @@ static const struct l2c_init_data of_l2c310_data __initconst = {
 		.flush_all   = l2c210_flush_all,
 		.disable     = l2c210_disable,
 		.sync        = l2c210_sync,
-		.set_debug   = l2c310_set_debug,
 		.resume      = l2c310_resume,
 	},
 };
-- 
1.8.3.1
