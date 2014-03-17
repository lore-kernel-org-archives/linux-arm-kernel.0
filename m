From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:15:44 +0000
Subject: [PATCH 26/44] ARM: l2c: implement L2C-310 erratum 727915 as a method
 override
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLDU-0002dc-3R@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement L2C-310 erratum 727915 by overriding the flush_all method
in the outer_cache operations structure.  This allows us to sensibly
contain the erratum code in one place without affecting other
locations or implementations.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 4930f63d5f4a..3371617a1c8b 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -524,6 +524,19 @@ static void l2c310_set_debug(unsigned long val)
 	writel_relaxed(val, l2x0_base + L2X0_DEBUG_CTRL);
 }
 
+static void l2c310_flush_all_erratum(void)
+{
+	void __iomem *base = l2x0_base;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&l2x0_lock, flags);
+	l2c_set_debug(base, 0x03);
+	__l2c_op_way(base + L2X0_CLEAN_INV_WAY);
+	l2c_set_debug(base, 0x00);
+	__l2c210_cache_sync(base);
+	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
+}
+
 static void l2c310_enable(void __iomem *base, u32 aux)
 {
 	/* PL310 has 8 lock registers */
@@ -598,6 +611,13 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 	if (revision <= L310_CACHE_ID_RTL_R3P0)
 		fns->set_debug = l2c310_set_debug;
 
+	if (IS_ENABLED(CONFIG_PL310_ERRATA_727915) &&
+	    revision >= L310_CACHE_ID_RTL_R2P0 &&
+	    revision < L310_CACHE_ID_RTL_R3P1) {
+		fns->flush_all = l2c310_flush_all_erratum;
+		errata[n++] = "727915";
+	}
+
 	if (IS_ENABLED(CONFIG_PL310_ERRATA_753970) &&
 	    revision == L310_CACHE_ID_RTL_R3P0) {
 		sync_reg_offset = L2X0_DUMMY_REG;
-- 
1.8.3.1
