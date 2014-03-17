From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:14:06 +0000
Subject: [PATCH 07/44] ARM: l2c: provide generic function for calling
 set_debug method
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLBu-0002cH-KM@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a generic function which always calls the set_debug method.
This will be used later in the series as some work-arounds require
that the debug register be written.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index d659c4ca46bb..595c50519e41 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -57,6 +57,16 @@ static inline void cache_wait_way(void __iomem *reg, unsigned long mask)
 		cpu_relax();
 }
 
+/*
+ * This should only be called when we have a requirement that the
+ * register be written due to a work-around, as platforms running
+ * in non-secure mode may not be able to access this register.
+ */
+static inline void l2c_set_debug(void __iomem *base, unsigned long val)
+{
+	outer_cache.set_debug(val);
+}
+
 #ifdef CONFIG_CACHE_PL310
 static inline void cache_wait(void __iomem *reg, unsigned long mask)
 {
@@ -92,7 +102,7 @@ static inline void l2x0_inv_line(unsigned long addr)
 static inline void debug_writel(unsigned long val)
 {
 	if (outer_cache.set_debug)
-		outer_cache.set_debug(val);
+		l2c_set_debug(l2x0_base, val);
 }
 
 static void pl310_set_debug(unsigned long val)
-- 
1.8.3.1
