From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:16:51 +0000
Subject: [PATCH 29/75] ARM: l2c: move pl310_set_debug() into l2c-310 code
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYWZ-000704-4F@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the pl310_set_debug() into the l2c-310 code area, and don't hide
it with ifdefs.  Rename it to l2c310_set_debug().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 157fd7ae331a..9586be73ca4f 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -154,18 +154,11 @@ static inline void debug_writel(unsigned long val)
 	if (outer_cache.set_debug)
 		l2c_set_debug(l2x0_base, val);
 }
-
-static void pl310_set_debug(unsigned long val)
-{
-	writel_relaxed(val, l2x0_base + L2X0_DEBUG_CTRL);
-}
 #else
 /* Optimised out for non-errata case */
 static inline void debug_writel(unsigned long val)
 {
 }
-
-#define pl310_set_debug	NULL
 #endif
 
 #ifdef CONFIG_PL310_ERRATA_588369
@@ -422,6 +415,11 @@ static const struct l2c_init_data l2x0_init_fns __initconst = {
  *	Affects: store buffer
  *	store buffer is not automatically drained.
  */
+static void l2c310_set_debug(unsigned long val)
+{
+	writel_relaxed(val, l2x0_base + L2X0_DEBUG_CTRL);
+}
+
 static void __init l2c310_save(void __iomem *base)
 {
 	unsigned revision;
@@ -488,7 +486,7 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 	unsigned n = 0;
 
 	if (revision <= L310_CACHE_ID_RTL_R3P0)
-		fns->set_debug = pl310_set_debug;
+		fns->set_debug = l2c310_set_debug;
 
 	if (IS_ENABLED(CONFIG_PL310_ERRATA_753970) &&
 	    revision == L310_CACHE_ID_RTL_R3P0) {
-- 
1.8.3.1
