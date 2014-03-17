From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Mar 2014 00:17:11 +0000
Subject: [PATCH 43/44] ARM: l2c: rename all L2C-310 constants with an L310_
 prefix
In-Reply-To: <20140317001302.GY21483@n2100.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
Message-ID: <E1WPLEt-0002en-19@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a mixture of different revisions with different register
layouts, but we group all the bits together in an opaque mess.
Split them out into those which are L2C-310 specific and ones
which refer to earlier devices.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/hardware/cache-l2x0.h | 41 +++++++++++----------
 arch/arm/mach-cns3xxx/core.c               |  8 ++---
 arch/arm/mach-imx/system.c                 |  8 ++---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c  |  2 +-
 arch/arm/mach-omap2/omap4-common.c         | 20 +++++------
 arch/arm/mach-prima2/l2x0.c                |  5 ++-
 arch/arm/mach-realview/realview_pbx.c      |  4 +--
 arch/arm/mach-spear/spear13xx.c            |  6 ++--
 arch/arm/mach-sti/board-dt.c               |  8 ++---
 arch/arm/mach-tegra/sleep.h                |  8 ++---
 arch/arm/mach-ux500/cache-l2x0.c           |  4 +--
 arch/arm/mach-vexpress/ct-ca9x4.c          |  4 +--
 arch/arm/mm/cache-l2x0.c                   | 57 +++++++++++++++---------------
 arch/arm/plat-samsung/s5p-sleep.S          |  8 ++---
 14 files changed, 93 insertions(+), 90 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 94fbcec216ae..048e817841ad 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -26,8 +26,8 @@
 #define L2X0_CACHE_TYPE			0x004
 #define L2X0_CTRL			0x100
 #define L2X0_AUX_CTRL			0x104
-#define L2X0_TAG_LATENCY_CTRL		0x108
-#define L2X0_DATA_LATENCY_CTRL		0x10C
+#define L310_TAG_LATENCY_CTRL		0x108
+#define L310_DATA_LATENCY_CTRL		0x10C
 #define L2X0_EVENT_CNT_CTRL		0x200
 #define L2X0_EVENT_CNT1_CFG		0x204
 #define L2X0_EVENT_CNT0_CFG		0x208
@@ -54,16 +54,16 @@
 #define L2X0_LOCKDOWN_WAY_D_BASE	0x900
 #define L2X0_LOCKDOWN_WAY_I_BASE	0x904
 #define L2X0_LOCKDOWN_STRIDE		0x08
-#define L2X0_ADDR_FILTER_START		0xC00
-#define L2X0_ADDR_FILTER_END		0xC04
+#define L310_ADDR_FILTER_START		0xC00
+#define L310_ADDR_FILTER_END		0xC04
 #define L2X0_TEST_OPERATION		0xF00
 #define L2X0_LINE_DATA			0xF10
 #define L2X0_LINE_TAG			0xF30
 #define L2X0_DEBUG_CTRL			0xF40
-#define L2X0_PREFETCH_CTRL		0xF60
-#define L2X0_POWER_CTRL			0xF80
-#define   L2X0_DYNAMIC_CLK_GATING_EN	(1 << 1)
-#define   L2X0_STNDBY_MODE_EN		(1 << 0)
+#define L310_PREFETCH_CTRL		0xF60
+#define L310_POWER_CTRL			0xF80
+#define   L310_DYNAMIC_CLK_GATING_EN	(1 << 1)
+#define   L310_STNDBY_MODE_EN		(1 << 0)
 
 /* Registers shifts and masks */
 #define L2X0_CACHE_ID_PART_MASK		(0xf << 6)
@@ -96,21 +96,24 @@
 #define L2X0_AUX_CTRL_TAG_LATENCY_MASK		(0x7 << 6)
 #define L2X0_AUX_CTRL_DIRTY_LATENCY_SHIFT	9
 #define L2X0_AUX_CTRL_DIRTY_LATENCY_MASK	(0x7 << 9)
-#define L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT	16
 #define L2X0_AUX_CTRL_WAY_SIZE_SHIFT		17
 #define L2X0_AUX_CTRL_WAY_SIZE_MASK		(0x7 << 17)
-#define L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT	22
-#define L2X0_AUX_CTRL_NS_LOCKDOWN_SHIFT		26
-#define L2X0_AUX_CTRL_NS_INT_CTRL_SHIFT		27
-#define L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT	28
-#define L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT	29
-#define L2X0_AUX_CTRL_EARLY_BRESP_SHIFT		30
 
-#define L2X0_LATENCY_CTRL_SETUP_SHIFT	0
-#define L2X0_LATENCY_CTRL_RD_SHIFT	4
-#define L2X0_LATENCY_CTRL_WR_SHIFT	8
+#define L310_AUX_CTRL_ASSOCIATIVITY_16		BIT(16)
+#define L310_AUX_CTRL_WAY_SIZE(n)		((n) << 17)
+#define L310_AUX_CTRL_SHARED_OVERRIDE		BIT(22)
+#define L310_AUX_CTRL_CACHE_REPLACE_RR		BIT(25)
+#define L310_AUX_CTRL_NS_LOCKDOWN		BIT(26)
+#define L310_AUX_CTRL_NS_INT_CTRL		BIT(27)
+#define L310_AUX_CTRL_DATA_PREFETCH		BIT(28)
+#define L310_AUX_CTRL_INSTR_PREFETCH		BIT(29)
+#define L310_AUX_CTRL_EARLY_BRESP		BIT(30)
 
-#define L2X0_ADDR_FILTER_EN		1
+#define L310_LATENCY_CTRL_SETUP(n)		((n) << 0)
+#define L310_LATENCY_CTRL_RD(n)			((n) << 4)
+#define L310_LATENCY_CTRL_WR(n)			((n) << 8)
+
+#define L310_ADDR_FILTER_EN		1
 
 #define L2X0_CTRL_EN			1
 
diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index 384dc859e6c6..1e8860e4c9e3 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -240,9 +240,9 @@ void __init cns3xxx_l2x0_init(void)
 	 *
 	 * 1 cycle of latency for setup, read and write accesses
 	 */
-	val = readl(base + L2X0_TAG_LATENCY_CTRL);
+	val = readl(base + L310_TAG_LATENCY_CTRL);
 	val &= 0xfffff888;
-	writel(val, base + L2X0_TAG_LATENCY_CTRL);
+	writel(val, base + L310_TAG_LATENCY_CTRL);
 
 	/*
 	 * Data RAM Control register
@@ -253,9 +253,9 @@ void __init cns3xxx_l2x0_init(void)
 	 *
 	 * 1 cycle of latency for setup, read and write accesses
 	 */
-	val = readl(base + L2X0_DATA_LATENCY_CTRL);
+	val = readl(base + L310_DATA_LATENCY_CTRL);
 	val &= 0xfffff888;
-	writel(val, base + L2X0_DATA_LATENCY_CTRL);
+	writel(val, base + L310_DATA_LATENCY_CTRL);
 
 	/* 32 KiB, 8-way, parity disable */
 	l2x0_init(base, 0x00540000, 0xfe000fff);
diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index 5e3027d3692f..3f270e5e25a1 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -124,7 +124,7 @@ void __init imx_init_l2cache(void)
 	}
 
 	/* Configure the L2 PREFETCH and POWER registers */
-	val = readl_relaxed(l2x0_base + L2X0_PREFETCH_CTRL);
+	val = readl_relaxed(l2x0_base + L310_PREFETCH_CTRL);
 	val |= 0x70800000;
 	/*
 	 * The L2 cache controller(PL310) version on the i.MX6D/Q is r3p1-50rel0
@@ -137,9 +137,9 @@ void __init imx_init_l2cache(void)
 	 */
 	if (cpu_is_imx6q())
 		val &= ~(1 << 30 | 1 << 23);
-	writel_relaxed(val, l2x0_base + L2X0_PREFETCH_CTRL);
-	val = L2X0_DYNAMIC_CLK_GATING_EN | L2X0_STNDBY_MODE_EN;
-	writel_relaxed(val, l2x0_base + L2X0_POWER_CTRL);
+	writel_relaxed(val, l2x0_base + L310_PREFETCH_CTRL);
+	val = L310_DYNAMIC_CLK_GATING_EN | L310_STNDBY_MODE_EN;
+	writel_relaxed(val, l2x0_base + L310_POWER_CTRL);
 
 	iounmap(l2x0_base);
 	of_node_put(np);
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 667915d236f3..ba43f49fbb59 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -194,7 +194,7 @@ static void save_l2x0_context(void)
 	if (l2x0_base) {
 		val = __raw_readl(l2x0_base + L2X0_AUX_CTRL);
 		__raw_writel(val, sar_base + L2X0_AUXCTRL_OFFSET);
-		val = __raw_readl(l2x0_base + L2X0_PREFETCH_CTRL);
+		val = __raw_readl(l2x0_base + L310_PREFETCH_CTRL);
 		__raw_writel(val, sar_base + L2X0_PREFETCH_CTRL_OFFSET);
 	}
 }
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 07b4efd23078..1d936f2747de 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -212,19 +212,19 @@ static int __init omap_l2_cache_init(void)
 	 * Way size - 32KB (es1.0)
 	 * Way size - 64KB (es2.0 +)
 	 */
-	aux_ctrl = ((1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT) |
-			(0x1 << 25) |
-			(0x1 << L2X0_AUX_CTRL_NS_LOCKDOWN_SHIFT) |
-			(0x1 << L2X0_AUX_CTRL_NS_INT_CTRL_SHIFT));
+	aux_ctrl = L310_AUX_CTRL_ASSOCIATIVITY_16 |
+		   L310_AUX_CTRL_CACHE_REPLACE_RR |
+		   L310_AUX_CTRL_NS_LOCKDOWN |
+		   L310_AUX_CTRL_NS_INT_CTRL;
 
 	if (omap_rev() == OMAP4430_REV_ES1_0) {
-		aux_ctrl |= 0x2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT;
+		aux_ctrl |= L310_AUX_CTRL_WAY_SIZE(2);
 	} else {
-		aux_ctrl |= ((0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
-			(1 << L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT) |
-			(1 << L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |
-			(1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT) |
-			(1 << L2X0_AUX_CTRL_EARLY_BRESP_SHIFT));
+		aux_ctrl |= L310_AUX_CTRL_WAY_SIZE(3) |
+			    L310_AUX_CTRL_SHARED_OVERRIDE |
+			    L310_AUX_CTRL_DATA_PREFETCH |
+			    L310_AUX_CTRL_INSTR_PREFETCH |
+			    L310_AUX_CTRL_EARLY_BRESP;
 	}
 	if (omap_rev() != OMAP4430_REV_ES1_0)
 		omap_smc1(0x109, aux_ctrl);
diff --git a/arch/arm/mach-prima2/l2x0.c b/arch/arm/mach-prima2/l2x0.c
index cbcbe9cb094c..3a9ddc3d6d0f 100644
--- a/arch/arm/mach-prima2/l2x0.c
+++ b/arch/arm/mach-prima2/l2x0.c
@@ -18,13 +18,12 @@ struct l2x0_aux
 };
 
 static struct l2x0_aux prima2_l2x0_aux __initconst = {
-	.val = 2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT,
+	.val = L310_AUX_CTRL_WAY_SIZE(2),
 	.mask =	0,
 };
 
 static struct l2x0_aux marco_l2x0_aux __initconst = {
-	.val = (2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
-		(1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT),
+	.val = L310_AUX_CTRL_WAY_SIZE(2) | L310_AUX_CTRL_ASSOCIATIVITY_16,
 	.mask = L2X0_AUX_CTRL_MASK,
 };
 
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index e880b8723d13..7757f1426fe1 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -371,8 +371,8 @@ static void __init realview_pbx_init(void)
 			__io_address(REALVIEW_PBX_TILE_L220_BASE);
 
 		/* set RAM latencies to 1 cycle for eASIC */
-		writel(0, l2x0_base + L2X0_TAG_LATENCY_CTRL);
-		writel(0, l2x0_base + L2X0_DATA_LATENCY_CTRL);
+		writel(0, l2x0_base + L310_TAG_LATENCY_CTRL);
+		writel(0, l2x0_base + L310_DATA_LATENCY_CTRL);
 
 		/* 16KB way size, 8-way associativity, parity disabled
 		 * Bits:  .. 0 0 0 0 1 00 1 0 1 001 0 000 0 .... .... .... */
diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
index 7aa6e8cf830f..92860fa01668 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -38,14 +38,14 @@ void __init spear13xx_l2x0_init(void)
 	if (!IS_ENABLED(CONFIG_CACHE_L2X0))
 		return;
 
-	writel_relaxed(0x06, VA_L2CC_BASE + L2X0_PREFETCH_CTRL);
+	writel_relaxed(0x06, VA_L2CC_BASE + L310_PREFETCH_CTRL);
 
 	/*
 	 * Program following latencies in order to make
 	 * SPEAr1340 work@600 MHz
 	 */
-	writel_relaxed(0x221, VA_L2CC_BASE + L2X0_TAG_LATENCY_CTRL);
-	writel_relaxed(0x441, VA_L2CC_BASE + L2X0_DATA_LATENCY_CTRL);
+	writel_relaxed(0x221, VA_L2CC_BASE + L310_TAG_LATENCY_CTRL);
+	writel_relaxed(0x441, VA_L2CC_BASE + L310_DATA_LATENCY_CTRL);
 	l2x0_init(VA_L2CC_BASE, 0x70A60001, 0xfe00ffff);
 }
 
diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
index 1217fb598cfd..fbe726c30f73 100644
--- a/arch/arm/mach-sti/board-dt.c
+++ b/arch/arm/mach-sti/board-dt.c
@@ -19,10 +19,10 @@ void __init stih41x_l2x0_init(void)
 	u32 way_size = 0x4;
 	u32 aux_ctrl;
 	/* may be this can be encoded in macros like BIT*() */
-	aux_ctrl = (0x1 << L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT) |
-		(0x1 << L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |
-		(0x1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT) |
-		(way_size << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);
+	aux_ctrl = L310_AUX_CTRL_SHARED_OVERRIDE |
+		   L310_AUX_CTRL_DATA_PREFETCH |
+		   L310_AUX_CTRL_INSTR_PREFETCH |
+		   L310_AUX_CTRL_WAY_SIZE(way_size);
 
 	l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
 }
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index a4edbb3abd3d..a032820d2fac 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -134,13 +134,13 @@
 	tst	\tmp3, #L2X0_CTRL_EN
 	bne	exit_l2_resume
 	ldr	\tmp3, [\tmp1, #L2X0_R_TAG_LATENCY]
-	str	\tmp3, [\tmp2, #L2X0_TAG_LATENCY_CTRL]
+	str	\tmp3, [\tmp2, #L310_TAG_LATENCY_CTRL]
 	ldr	\tmp3, [\tmp1, #L2X0_R_DATA_LATENCY]
-	str	\tmp3, [\tmp2, #L2X0_DATA_LATENCY_CTRL]
+	str	\tmp3, [\tmp2, #L310_DATA_LATENCY_CTRL]
 	ldr	\tmp3, [\tmp1, #L2X0_R_PREFETCH_CTRL]
-	str	\tmp3, [\tmp2, #L2X0_PREFETCH_CTRL]
+	str	\tmp3, [\tmp2, #L310_PREFETCH_CTRL]
 	ldr	\tmp3, [\tmp1, #L2X0_R_PWR_CTRL]
-	str	\tmp3, [\tmp2, #L2X0_POWER_CTRL]
+	str	\tmp3, [\tmp2, #L310_POWER_CTRL]
 	ldr	\tmp3, [\tmp1, #L2X0_R_AUX_CTRL]
 	str	\tmp3, [\tmp2, #L2X0_AUX_CTRL]
 	mov	\tmp3, #L2X0_CTRL_EN
diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 5cc7e3625d8c..9c1d083a3c8d 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -59,10 +59,10 @@ static int __init ux500_l2x0_init(void)
 	/* DBx540's L2 has 128KB way size */
 	if (cpu_is_ux540_family())
 		/* 128KB way size */
-		aux_val |= (0x4 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);
+		aux_val |= L310_AUX_CTRL_WAY_SIZE(4);
 	else
 		/* 64KB way size */
-		aux_val |= (0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);
+		aux_val |= L310_AUX_CTRL_WAY_SIZE(3);
 
 	outer_cache.write_sec = ux500_l2c310_write_sec;
 
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 6f34497a4245..6c4ffb6c5ad8 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -145,8 +145,8 @@ static void __init ct_ca9x4_init(void)
 	void __iomem *l2x0_base = ioremap(CT_CA9X4_L2CC, SZ_4K);
 
 	/* set RAM latencies to 1 cycle for this core tile. */
-	writel(0, l2x0_base + L2X0_TAG_LATENCY_CTRL);
-	writel(0, l2x0_base + L2X0_DATA_LATENCY_CTRL);
+	writel(0, l2x0_base + L310_TAG_LATENCY_CTRL);
+	writel(0, l2x0_base + L310_DATA_LATENCY_CTRL);
 
 	l2x0_init(l2x0_base, 0x00400000, 0xfe0fffff);
 #endif
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 34980c75bacd..831c65d55ab3 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -766,13 +766,13 @@ static void __init l2c310_save(void __iomem *base)
 	unsigned revision;
 
 	l2x0_saved_regs.tag_latency = readl_relaxed(base +
-		L2X0_TAG_LATENCY_CTRL);
+		L310_TAG_LATENCY_CTRL);
 	l2x0_saved_regs.data_latency = readl_relaxed(base +
-		L2X0_DATA_LATENCY_CTRL);
+		L310_DATA_LATENCY_CTRL);
 	l2x0_saved_regs.filter_end = readl_relaxed(base +
-		L2X0_ADDR_FILTER_END);
+		L310_ADDR_FILTER_END);
 	l2x0_saved_regs.filter_start = readl_relaxed(base +
-		L2X0_ADDR_FILTER_START);
+		L310_ADDR_FILTER_START);
 
 	revision = readl_relaxed(base + L2X0_CACHE_ID) &
 			L2X0_CACHE_ID_RTL_MASK;
@@ -780,12 +780,12 @@ static void __init l2c310_save(void __iomem *base)
 	/* From r2p0, there is Prefetch offset/control register */
 	if (revision >= L310_CACHE_ID_RTL_R2P0)
 		l2x0_saved_regs.prefetch_ctrl = readl_relaxed(base +
-							L2X0_PREFETCH_CTRL);
+							L310_PREFETCH_CTRL);
 
 	/* From r3p0, there is Power control register */
 	if (revision >= L310_CACHE_ID_RTL_R3P0)
 		l2x0_saved_regs.pwr_ctrl = readl_relaxed(base +
-							L2X0_POWER_CTRL);
+							L310_POWER_CTRL);
 }
 
 static void l2c310_resume(void)
@@ -797,23 +797,23 @@ static void l2c310_resume(void)
 
 		/* restore pl310 setup */
 		writel_relaxed(l2x0_saved_regs.tag_latency,
-			       base + L2X0_TAG_LATENCY_CTRL);
+			       base + L310_TAG_LATENCY_CTRL);
 		writel_relaxed(l2x0_saved_regs.data_latency,
-			       base + L2X0_DATA_LATENCY_CTRL);
+			       base + L310_DATA_LATENCY_CTRL);
 		writel_relaxed(l2x0_saved_regs.filter_end,
-			       base + L2X0_ADDR_FILTER_END);
+			       base + L310_ADDR_FILTER_END);
 		writel_relaxed(l2x0_saved_regs.filter_start,
-			       base + L2X0_ADDR_FILTER_START);
+			       base + L310_ADDR_FILTER_START);
 
 		revision = readl_relaxed(base + L2X0_CACHE_ID) &
 				L2X0_CACHE_ID_RTL_MASK;
 
 		if (revision >= L310_CACHE_ID_RTL_R2P0)
 			writel_relaxed(l2x0_saved_regs.prefetch_ctrl,
-				       base + L2X0_PREFETCH_CTRL);
+				       base + L310_PREFETCH_CTRL);
 		if (revision >= L310_CACHE_ID_RTL_R3P0)
 			writel_relaxed(l2x0_saved_regs.pwr_ctrl,
-				       base + L2X0_POWER_CTRL);
+				       base + L310_POWER_CTRL);
 
 		l2c310_enable(base, l2x0_saved_regs.aux_ctrl);
 	}
@@ -844,11 +844,11 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
 
 	if (revision >= L310_CACHE_ID_RTL_R3P0 &&
 	    revision < L310_CACHE_ID_RTL_R3P2) {
-		u32 val = readl_relaxed(base + L2X0_PREFETCH_CTRL);
+		u32 val = readl_relaxed(base + L310_PREFETCH_CTRL);
 		/* I don't think bit23 is required here... but iMX6 does so */
 		if (val & (BIT(30) | BIT(23))) {
 			val &= ~(BIT(30) | BIT(23));
-			l2c_write_sec(val, base, L2X0_PREFETCH_CTRL);
+			l2c_write_sec(val, base, L310_PREFETCH_CTRL);
 			errata[n++] = "752271";
 		}
 	}
@@ -943,7 +943,8 @@ static void __init __l2c_init(const struct l2c_init_data *data,
 	 *
 	 * L2 cache size = number of ways * way size.
 	 */
-	way_size_bits = (aux & L2X0_AUX_CTRL_WAY_SIZE_MASK) >> 17;
+	way_size_bits = (aux & L2X0_AUX_CTRL_WAY_SIZE_MASK) >>
+			L2X0_AUX_CTRL_WAY_SIZE_SHIFT;
 	l2x0_size = ways * (data->way_size_0 << way_size_bits);
 
 	fns = data->outer_cache;
@@ -1082,27 +1083,27 @@ static void __init l2c310_of_parse(const struct device_node *np,
 	of_property_read_u32_array(np, "arm,tag-latency", tag, ARRAY_SIZE(tag));
 	if (tag[0] && tag[1] && tag[2])
 		writel_relaxed(
-			((tag[0] - 1) << L2X0_LATENCY_CTRL_RD_SHIFT) |
-			((tag[1] - 1) << L2X0_LATENCY_CTRL_WR_SHIFT) |
-			((tag[2] - 1) << L2X0_LATENCY_CTRL_SETUP_SHIFT),
-			l2x0_base + L2X0_TAG_LATENCY_CTRL);
+			L310_LATENCY_CTRL_RD(tag[0] - 1) |
+			L310_LATENCY_CTRL_WR(tag[1] - 1) |
+			L310_LATENCY_CTRL_SETUP(tag[2] - 1),
+			l2x0_base + L310_TAG_LATENCY_CTRL);
 
 	of_property_read_u32_array(np, "arm,data-latency",
 				   data, ARRAY_SIZE(data));
 	if (data[0] && data[1] && data[2])
 		writel_relaxed(
-			((data[0] - 1) << L2X0_LATENCY_CTRL_RD_SHIFT) |
-			((data[1] - 1) << L2X0_LATENCY_CTRL_WR_SHIFT) |
-			((data[2] - 1) << L2X0_LATENCY_CTRL_SETUP_SHIFT),
-			l2x0_base + L2X0_DATA_LATENCY_CTRL);
+			L310_LATENCY_CTRL_RD(data[0] - 1) |
+			L310_LATENCY_CTRL_WR(data[1] - 1) |
+			L310_LATENCY_CTRL_SETUP(data[2] - 1),
+			l2x0_base + L310_DATA_LATENCY_CTRL);
 
 	of_property_read_u32_array(np, "arm,filter-ranges",
 				   filter, ARRAY_SIZE(filter));
 	if (filter[1]) {
 		writel_relaxed(ALIGN(filter[0] + filter[1], SZ_1M),
-			       l2x0_base + L2X0_ADDR_FILTER_END);
-		writel_relaxed((filter[0] & ~(SZ_1M - 1)) | L2X0_ADDR_FILTER_EN,
-			       l2x0_base + L2X0_ADDR_FILTER_START);
+			       l2x0_base + L310_ADDR_FILTER_END);
+		writel_relaxed((filter[0] & ~(SZ_1M - 1)) | L310_ADDR_FILTER_EN,
+			       l2x0_base + L310_ADDR_FILTER_START);
 	}
 }
 
@@ -1482,7 +1483,7 @@ static void __init tauros3_save(void __iomem *base)
 	l2x0_saved_regs.aux2_ctrl =
 		readl_relaxed(base + TAUROS3_AUX2_CTRL);
 	l2x0_saved_regs.prefetch_ctrl =
-		readl_relaxed(base + L2X0_PREFETCH_CTRL);
+		readl_relaxed(base + L310_PREFETCH_CTRL);
 }
 
 static void tauros3_resume(void)
@@ -1493,7 +1494,7 @@ static void tauros3_resume(void)
 		writel_relaxed(l2x0_saved_regs.aux2_ctrl,
 			       base + TAUROS3_AUX2_CTRL);
 		writel_relaxed(l2x0_saved_regs.prefetch_ctrl,
-			       base + L2X0_PREFETCH_CTRL);
+			       base + L310_PREFETCH_CTRL);
 	}
 
 	l2x0_resume();
diff --git a/arch/arm/plat-samsung/s5p-sleep.S b/arch/arm/plat-samsung/s5p-sleep.S
index a030e7301da8..497301944090 100644
--- a/arch/arm/plat-samsung/s5p-sleep.S
+++ b/arch/arm/plat-samsung/s5p-sleep.S
@@ -69,13 +69,13 @@ ENTRY(s3c_cpu_resume)
 	ldr	r2, [r0, #L2X0_R_AUX_CTRL]
 	str	r2, [r1, #L2X0_AUX_CTRL]
 	ldr	r2, [r0, #L2X0_R_TAG_LATENCY]
-	str	r2, [r1, #L2X0_TAG_LATENCY_CTRL]
+	str	r2, [r1, #L310_TAG_LATENCY_CTRL]
 	ldr	r2, [r0, #L2X0_R_DATA_LATENCY]
-	str	r2, [r1, #L2X0_DATA_LATENCY_CTRL]
+	str	r2, [r1, #L310_DATA_LATENCY_CTRL]
 	ldr	r2, [r0, #L2X0_R_PREFETCH_CTRL]
-	str	r2, [r1, #L2X0_PREFETCH_CTRL]
+	str	r2, [r1, #L310_PREFETCH_CTRL]
 	ldr	r2, [r0, #L2X0_R_PWR_CTRL]
-	str	r2, [r1, #L2X0_POWER_CTRL]
+	str	r2, [r1, #L310_POWER_CTRL]
 	mov	r2, #1
 	str	r2, [r1, #L2X0_CTRL]
 resume_l2on:
-- 
1.8.3.1
