From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:15:33 +0000
Subject: [PATCH 24/44] ARM: l2c: move pl310_set_debug() into l2c-310 code
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLDJ-0002dU-SA@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the pl310_set_debug() into the l2c-310 code area, and don't hide
it with ifdefs.  Rename it to l2c310_set_debug().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 146865fa0dde..4e12fad497b2 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -142,18 +142,11 @@ static inline void debug_writel(unsigned long val)
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
@@ -410,6 +403,11 @@ static const struct l2c_init_data l2x0_init_fns __initconst = {
  *	Affects: store buffer
  *	store buffer is not automatically drained.
  */
+static void l2c310_set_debug(unsigned long val)
+{
+	writel_relaxed(val, l2x0_base + L2X0_DEBUG_CTRL);
+}
+
 static void l2c310_enable(void __iomem *base, u32 aux)
 {
 	/* PL310 has 8 lock registers */
@@ -482,7 +480,7 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 	unsigned n = 0;
 
 	if (revision <= L310_CACHE_ID_RTL_R3P0)
-		fns->set_debug = pl310_set_debug;
+		fns->set_debug = l2c310_set_debug;
 
 	if (IS_ENABLED(CONFIG_PL310_ERRATA_753970) &&
 	    revision == L310_CACHE_ID_RTL_R3P0) {
-- 
1.8.3.1
