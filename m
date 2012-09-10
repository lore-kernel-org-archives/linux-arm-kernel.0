From: robherring2@gmail.com (Rob Herring)
Date: Mon, 10 Sep 2012 14:45:34 -0500
Subject: [RFC PATCH] ARM: l2x0: avoid spinlock for sync op on pl310
Message-ID: <1347306334-781-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The sync op is atomic on the pl310, so a spinlock is not needed. It can
be a bottleneck for code paths with register accesses, so remove it.
Removing it gives a 30% improvement to pktgen throughput on highbank.

A similar spinlock removal was originally done by Catalin Marinas[1], but
the spinlock part was dropped in the merged version. It is unclear why
other than it was not a runtime selection. As every readl/writel causes a
outer_sync, the sync function is likely the most critical.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2010-August/024514.html

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/cache-l2x0.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 2a8e380..6778238 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -130,6 +130,11 @@ static void l2x0_cache_sync(void)
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
+static void pl310_cache_sync(void)
+{
+	cache_sync();
+}
+
 static void __l2x0_flush_all(void)
 {
 	debug_writel(0x03);
@@ -335,6 +340,7 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 		sync_reg_offset = L2X0_DUMMY_REG;
 #endif
 		outer_cache.set_debug = pl310_set_debug;
+		outer_cache.sync = pl310_cache_sync;
 		break;
 	case L2X0_CACHE_ID_PART_L210:
 		ways = (aux >> 13) & 0xf;
-- 
1.7.9.5
