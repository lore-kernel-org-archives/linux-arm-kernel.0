From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:14:27 +0000
Subject: [PATCH 11/44] ARM: l2c: use add L2C revision constants
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLCF-0002cZ-2e@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The revision namespace is specific to the L2 cache part, so don't name
these with generic identifiers, use a part specific identifier.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/hardware/cache-l2x0.h | 22 ++++++++++++++++------
 arch/arm/mm/cache-l2x0.c                   | 10 +++++-----
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 6795ff743b3d..94fbcec216ae 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -68,14 +68,24 @@
 /* Registers shifts and masks */
 #define L2X0_CACHE_ID_PART_MASK		(0xf << 6)
 #define L2X0_CACHE_ID_PART_L210		(1 << 6)
+#define L2X0_CACHE_ID_PART_L220		(2 << 6)
 #define L2X0_CACHE_ID_PART_L310		(3 << 6)
 #define L2X0_CACHE_ID_RTL_MASK          0x3f
-#define L2X0_CACHE_ID_RTL_R0P0          0x0
-#define L2X0_CACHE_ID_RTL_R1P0          0x2
-#define L2X0_CACHE_ID_RTL_R2P0          0x4
-#define L2X0_CACHE_ID_RTL_R3P0          0x5
-#define L2X0_CACHE_ID_RTL_R3P1          0x6
-#define L2X0_CACHE_ID_RTL_R3P2          0x8
+#define L210_CACHE_ID_RTL_R0P2_02	0x00
+#define L210_CACHE_ID_RTL_R0P1		0x01
+#define L210_CACHE_ID_RTL_R0P2_01	0x02
+#define L210_CACHE_ID_RTL_R0P3		0x03
+#define L210_CACHE_ID_RTL_R0P4		0x0b
+#define L210_CACHE_ID_RTL_R0P5		0x0f
+#define L220_CACHE_ID_RTL_R1P7_01REL0	0x06
+#define L310_CACHE_ID_RTL_R0P0          0x00
+#define L310_CACHE_ID_RTL_R1P0          0x02
+#define L310_CACHE_ID_RTL_R2P0          0x04
+#define L310_CACHE_ID_RTL_R3P0          0x05
+#define L310_CACHE_ID_RTL_R3P1          0x06
+#define L310_CACHE_ID_RTL_R3P1_50REL0	0x07
+#define L310_CACHE_ID_RTL_R3P2          0x08
+#define L310_CACHE_ID_RTL_R3P3		0x09
 
 #define L2X0_AUX_CTRL_MASK			0xc0000fff
 #define L2X0_AUX_CTRL_DATA_RD_LATENCY_SHIFT	0
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 29ee7f692801..c39602ef2cdd 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -374,7 +374,7 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 		/* Unmapped register. */
 		sync_reg_offset = L2X0_DUMMY_REG;
 #endif
-		if ((cache_id & L2X0_CACHE_ID_RTL_MASK) <= L2X0_CACHE_ID_RTL_R3P0)
+		if ((cache_id & L2X0_CACHE_ID_RTL_MASK) <= L310_CACHE_ID_RTL_R3P0)
 			outer_cache.set_debug = pl310_set_debug;
 		break;
 	case L2X0_CACHE_ID_PART_L210:
@@ -768,7 +768,7 @@ static void __init pl310_save(void)
 	l2x0_saved_regs.filter_start = readl_relaxed(l2x0_base +
 		L2X0_ADDR_FILTER_START);
 
-	if (l2x0_revision >= L2X0_CACHE_ID_RTL_R2P0) {
+	if (l2x0_revision >= L310_CACHE_ID_RTL_R2P0) {
 		/*
 		 * From r2p0, there is Prefetch offset/control register
 		 */
@@ -777,7 +777,7 @@ static void __init pl310_save(void)
 		/*
 		 * From r3p0, there is Power control register
 		 */
-		if (l2x0_revision >= L2X0_CACHE_ID_RTL_R3P0)
+		if (l2x0_revision >= L310_CACHE_ID_RTL_R3P0)
 			l2x0_saved_regs.pwr_ctrl = readl_relaxed(l2x0_base +
 				L2X0_POWER_CTRL);
 	}
@@ -830,10 +830,10 @@ static void pl310_resume(void)
 		l2x0_revision = readl_relaxed(l2x0_base + L2X0_CACHE_ID) &
 			L2X0_CACHE_ID_RTL_MASK;
 
-		if (l2x0_revision >= L2X0_CACHE_ID_RTL_R2P0) {
+		if (l2x0_revision >= L310_CACHE_ID_RTL_R2P0) {
 			writel_relaxed(l2x0_saved_regs.prefetch_ctrl,
 				l2x0_base + L2X0_PREFETCH_CTRL);
-			if (l2x0_revision >= L2X0_CACHE_ID_RTL_R3P0)
+			if (l2x0_revision >= L310_CACHE_ID_RTL_R3P0)
 				writel_relaxed(l2x0_saved_regs.pwr_ctrl,
 					l2x0_base + L2X0_POWER_CTRL);
 		}
-- 
1.8.3.1
