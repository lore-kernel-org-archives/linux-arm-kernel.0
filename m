From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:35:02 +0100
Subject: [PATCH 048/222] ARM: l2c: implement L2C-310 erratum 752271 in core
 L2C code
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdePG-0007GN-6f@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than having SoCs work around L2C erratum themselves, move them
into core code.  This erratum affects the double linefill feature which
needs to be disabled for r3p0 to r3p1-50rel0.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index b13276c9971b..b1fa825c133f 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -476,6 +476,11 @@ static const struct l2c_init_data l2c220_data = {
  *	hit the line between the clean operation and invalidate operation,
  *	resulting in the store being lost.
  *
+ * 752271: PL310 R3P0->R3P1-50REL0, fixed R3P2.
+ *	Affects: 8x64-bit (double fill) line fetches
+ *	double fill line fetches can fail to cause dirty data to be evicted
+ *	from the cache before the new data overwrites the second line.
+ *
  * 753970: PL310 R3P0, fixed R3P1.
  *	Affects: sync
  *	prevents merging writes after the sync operation, until another L2C
@@ -619,7 +624,7 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 	struct outer_cache_fns *fns)
 {
 	unsigned revision = cache_id & L2X0_CACHE_ID_RTL_MASK;
-	const char *errata[4];
+	const char *errata[8];
 	unsigned n = 0;
 
 	if (IS_ENABLED(CONFIG_PL310_ERRATA_588369) &&
@@ -638,6 +643,17 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 		errata[n++] = "727915";
 	}
 
+	if (revision >= L310_CACHE_ID_RTL_R3P0 &&
+	    revision < L310_CACHE_ID_RTL_R3P2) {
+		u32 val = readl_relaxed(base + L2X0_PREFETCH_CTRL);
+		/* I don't think bit23 is required here... but iMX6 does so */
+		if (val & (BIT(30) | BIT(23))) {
+			val &= ~(BIT(30) | BIT(23));
+			l2c_write_sec(val, base, L2X0_PREFETCH_CTRL);
+			errata[n++] = "752271";
+		}
+	}
+
 	if (IS_ENABLED(CONFIG_PL310_ERRATA_753970) &&
 	    revision == L310_CACHE_ID_RTL_R3P0) {
 		sync_reg_offset = L2X0_DUMMY_REG;
-- 
1.8.3.1
