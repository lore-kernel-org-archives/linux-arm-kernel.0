From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 27 Sep 2012 11:35:23 +0200
Subject: [PATCH V6 3/6] arm: cache-l2x0: add support for Aurora L2 cache ctrl
In-Reply-To: <1348738523-28609-1-git-send-email-gregory.clement@free-electrons.com>
References: <CAHkRjk7YdzB_RMCjY7SkzPVwEvuk17akJxaNeNmAuqZpwX_kfQ@mail.gmail.com>
 <1348738523-28609-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1348738523-28609-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aurora Cache Controller was designed to be compatible with the ARM L2
Cache Controller. It comes with some difference or improvement such
as:
- no cache id part number available through hardware (need to get it
  by the DT).
- always write through mode available.
- two flavors of the controller outer cache and system cache (meaning
  maintenance operations on L1 are broadcasted to the L2 and L2
  performs the same operation).
- in outer cache mode, the cache maintenance operations are improved and
  can be done on a range inside a page and are not limited to a cache
  line.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
Tested-and-reviewed-by: Lior Amsalem <alior@marvell.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>

Cc: Barry Song <21cnbao@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |    4 +
 arch/arm/mm/cache-aurora-l2.h              |   55 +++++++
 arch/arm/mm/cache-l2x0.c                   |  222 ++++++++++++++++++++++++++--
 3 files changed, 268 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/mm/cache-aurora-l2.h

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 5f2c7b4..3b2c40b 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -102,6 +102,10 @@
 
 #define L2X0_ADDR_FILTER_EN		1
 
+#define L2X0_CTRL_EN			1
+
+#define L2X0_WAY_SIZE_SHIFT		3
+
 #ifndef __ASSEMBLY__
 extern void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask);
 #if defined(CONFIG_CACHE_L2X0) && defined(CONFIG_OF)
diff --git a/arch/arm/mm/cache-aurora-l2.h b/arch/arm/mm/cache-aurora-l2.h
new file mode 100644
index 0000000..c861247
--- /dev/null
+++ b/arch/arm/mm/cache-aurora-l2.h
@@ -0,0 +1,55 @@
+/*
+ * AURORA shared L2 cache controller support
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Yehuda Yitschak <yehuday@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARM_HARDWARE_AURORA_L2_H
+#define __ASM_ARM_HARDWARE_AURORA_L2_H
+
+#define AURORA_SYNC_REG		    0x700
+#define AURORA_RANGE_BASE_ADDR_REG  0x720
+#define AURORA_FLUSH_PHY_ADDR_REG   0x7f0
+#define AURORA_INVAL_RANGE_REG	    0x774
+#define AURORA_CLEAN_RANGE_REG	    0x7b4
+#define AURORA_FLUSH_RANGE_REG	    0x7f4
+
+#define AURORA_ACR_REPLACEMENT_OFFSET	    27
+#define AURORA_ACR_REPLACEMENT_MASK	     \
+	(0x3 << AURORA_ACR_REPLACEMENT_OFFSET)
+#define AURORA_ACR_REPLACEMENT_TYPE_WAYRR    \
+	(0 << AURORA_ACR_REPLACEMENT_OFFSET)
+#define AURORA_ACR_REPLACEMENT_TYPE_LFSR     \
+	(1 << AURORA_ACR_REPLACEMENT_OFFSET)
+#define AURORA_ACR_REPLACEMENT_TYPE_SEMIPLRU \
+	(3 << AURORA_ACR_REPLACEMENT_OFFSET)
+
+#define AURORA_ACR_FORCE_WRITE_POLICY_OFFSET	0
+#define AURORA_ACR_FORCE_WRITE_POLICY_MASK	\
+	(0x3 << AURORA_ACR_FORCE_WRITE_POLICY_OFFSET)
+#define AURORA_ACR_FORCE_WRITE_POLICY_DIS	\
+	(0 << AURORA_ACR_FORCE_WRITE_POLICY_OFFSET)
+#define AURORA_ACR_FORCE_WRITE_BACK_POLICY	\
+	(1 << AURORA_ACR_FORCE_WRITE_POLICY_OFFSET)
+#define AURORA_ACR_FORCE_WRITE_THRO_POLICY	\
+	(2 << AURORA_ACR_FORCE_WRITE_POLICY_OFFSET)
+
+#define MAX_RANGE_SIZE		1024
+
+#define AURORA_WAY_SIZE_SHIFT	2
+
+#define AURORA_CTRL_FW		0x100
+
+/* chose a number outside L2X0_CACHE_ID_PART_MASK to be sure to make
+ * the distinction between a number coming from hardware and a number
+ * coming from the device tree */
+#define AURORA_CACHE_ID	       0x100
+
+#endif /* __ASM_ARM_HARDWARE_AURORA_L2_H */
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 1f7aad6..6d5e5e7 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -25,6 +25,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
+#include "cache-aurora-l2.h"
 
 #define CACHE_LINE_SIZE		32
 
@@ -33,6 +34,11 @@ static DEFINE_RAW_SPINLOCK(l2x0_lock);
 static u32 l2x0_way_mask;	/* Bitmask of active ways */
 static u32 l2x0_size;
 static unsigned long sync_reg_offset = L2X0_CACHE_SYNC;
+static int l2_wt_override;
+
+/* Aurora don't have the cache ID register available, so we have to
+ * pass it though the device tree */
+static u32  cache_id_part_number_from_dt;
 
 struct l2x0_regs l2x0_saved_regs;
 
@@ -169,7 +175,7 @@ static void l2x0_inv_all(void)
 	/* invalidate all ways */
 	raw_spin_lock_irqsave(&l2x0_lock, flags);
 	/* Invalidating when L2 is enabled is a nono */
-	BUG_ON(readl(l2x0_base + L2X0_CTRL) & 1);
+	BUG_ON(readl(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN);
 	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_INV_WAY);
 	cache_wait_way(l2x0_base + L2X0_INV_WAY, l2x0_way_mask);
 	cache_sync();
@@ -277,6 +283,98 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
+/*
+ * Note that the end addresses passed to Linux primitives are
+ * noninclusive, while the hardware cache range operations use
+ * inclusive start and end addresses.
+ */
+static unsigned long calc_range_end(unsigned long start, unsigned long end)
+{
+	/*
+	 * Limit the number of cache lines processed at once,
+	 * since cache range operations stall the CPU pipeline
+	 * until completion.
+	 */
+	if (end > start + MAX_RANGE_SIZE)
+		end = start + MAX_RANGE_SIZE;
+
+	/*
+	 * Cache range operations can't straddle a page boundary.
+	 */
+	if (end > PAGE_ALIGN(start+1))
+		end = PAGE_ALIGN(start+1);
+
+	return end;
+}
+
+/*
+ * Make sure 'start' and 'end' reference the same page, as L2 is PIPT
+ * and range operations only do a TLB lookup on the start address.
+ */
+static void aurora_pa_range(unsigned long start, unsigned long end,
+			unsigned long offset)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&l2x0_lock, flags);
+	writel_relaxed(start, l2x0_base + AURORA_RANGE_BASE_ADDR_REG);
+	writel_relaxed(end, l2x0_base + offset);
+	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
+
+	cache_sync();
+}
+
+static void aurora_inv_range(unsigned long start, unsigned long end)
+{
+	/*
+	 * round start and end adresses up to cache line size
+	 */
+	start &= ~(CACHE_LINE_SIZE - 1);
+	end = ALIGN(end, CACHE_LINE_SIZE);
+
+	/*
+	 * Invalidate all full cache lines between 'start' and 'end'.
+	 */
+	while (start < end) {
+		unsigned long range_end = calc_range_end(start, end);
+		aurora_pa_range(start, range_end - CACHE_LINE_SIZE,
+				AURORA_INVAL_RANGE_REG);
+		start = range_end;
+	}
+}
+
+static void aurora_clean_range(unsigned long start, unsigned long end)
+{
+	/*
+	 * If L2 is forced to WT, the L2 will always be clean and we
+	 * don't need to do anything here.
+	 */
+	if (!l2_wt_override) {
+		start &= ~(CACHE_LINE_SIZE - 1);
+		end = ALIGN(end, CACHE_LINE_SIZE);
+		while (start != end) {
+			unsigned long range_end = calc_range_end(start, end);
+			aurora_pa_range(start, range_end - CACHE_LINE_SIZE,
+					AURORA_CLEAN_RANGE_REG);
+			start = range_end;
+		}
+	}
+}
+
+static void aurora_flush_range(unsigned long start, unsigned long end)
+{
+	if (!l2_wt_override) {
+		start &= ~(CACHE_LINE_SIZE - 1);
+		end = ALIGN(end, CACHE_LINE_SIZE);
+		while (start != end) {
+			unsigned long range_end = calc_range_end(start, end);
+			aurora_pa_range(start, range_end - CACHE_LINE_SIZE,
+					AURORA_FLUSH_RANGE_REG);
+			start = range_end;
+		}
+	}
+}
+
 static void l2x0_disable(void)
 {
 	unsigned long flags;
@@ -293,11 +391,18 @@ static void l2x0_unlock(u32 cache_id)
 	int lockregs;
 	int i;
 
-	if (cache_id == L2X0_CACHE_ID_PART_L310)
+	switch (cache_id) {
+	case L2X0_CACHE_ID_PART_L310:
 		lockregs = 8;
-	else
+		break;
+	case AURORA_CACHE_ID:
+		lockregs = 4;
+		break;
+	default:
 		/* L210 and unknown types */
 		lockregs = 1;
+		break;
+	}
 
 	for (i = 0; i < lockregs; i++) {
 		writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_D_BASE +
@@ -313,18 +418,22 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 	u32 cache_id;
 	u32 way_size = 0;
 	int ways;
+	int way_size_shift = L2X0_WAY_SIZE_SHIFT;
 	const char *type;
 
 	l2x0_base = base;
-
-	cache_id = readl_relaxed(l2x0_base + L2X0_CACHE_ID);
+	if (cache_id_part_number_from_dt)
+		cache_id = cache_id_part_number_from_dt;
+	else
+		cache_id = readl_relaxed(l2x0_base + L2X0_CACHE_ID)
+			& L2X0_CACHE_ID_PART_MASK;
 	aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
 
 	aux &= aux_mask;
 	aux |= aux_val;
 
 	/* Determine the number of ways */
-	switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
+	switch (cache_id) {
 	case L2X0_CACHE_ID_PART_L310:
 		if (aux & (1 << 16))
 			ways = 16;
@@ -341,6 +450,14 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 		ways = (aux >> 13) & 0xf;
 		type = "L210";
 		break;
+
+	case AURORA_CACHE_ID:
+		sync_reg_offset = AURORA_SYNC_REG;
+		ways = (aux >> 13) & 0xf;
+		ways = 2 << ((ways + 1) >> 2);
+		way_size_shift = AURORA_WAY_SIZE_SHIFT;
+		type = "Aurora";
+		break;
 	default:
 		/* Assume unknown chips have 8 ways */
 		ways = 8;
@@ -354,7 +471,8 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 	 * L2 cache Size =  Way size * Number of ways
 	 */
 	way_size = (aux & L2X0_AUX_CTRL_WAY_SIZE_MASK) >> 17;
-	way_size = 1 << (way_size + 3);
+	way_size = 1 << (way_size + way_size_shift);
+
 	l2x0_size = ways * way_size * SZ_1K;
 
 	/*
@@ -362,7 +480,7 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 	 * If you are booting from non-secure mode
 	 * accessing the below registers will fault.
 	 */
-	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & 1)) {
+	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
 		/* Make sure that I&D is not locked down when starting */
 		l2x0_unlock(cache_id);
 
@@ -374,7 +492,7 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 		l2x0_inv_all();
 
 		/* enable L2X0 */
-		writel_relaxed(1, l2x0_base + L2X0_CTRL);
+		writel_relaxed(L2X0_CTRL_EN, l2x0_base + L2X0_CTRL);
 	}
 
 	if (!of_init) {
@@ -490,9 +608,15 @@ static void __init pl310_save(void)
 	}
 }
 
+static void aurora_save(void)
+{
+	l2x0_saved_regs.ctrl = readl_relaxed(l2x0_base + L2X0_CTRL);
+	l2x0_saved_regs.aux_ctrl = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
+}
+
 static void l2x0_resume(void)
 {
-	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & 1)) {
+	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
 		/* restore aux ctrl and enable l2 */
 		l2x0_unlock(readl_relaxed(l2x0_base + L2X0_CACHE_ID));
 
@@ -501,7 +625,7 @@ static void l2x0_resume(void)
 
 		l2x0_inv_all();
 
-		writel_relaxed(1, l2x0_base + L2X0_CTRL);
+		writel_relaxed(L2X0_CTRL_EN, l2x0_base + L2X0_CTRL);
 	}
 }
 
@@ -509,7 +633,7 @@ static void pl310_resume(void)
 {
 	u32 l2x0_revision;
 
-	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & 1)) {
+	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
 		/* restore pl310 setup */
 		writel_relaxed(l2x0_saved_regs.tag_latency,
 			l2x0_base + L2X0_TAG_LATENCY_CTRL);
@@ -535,6 +659,46 @@ static void pl310_resume(void)
 	l2x0_resume();
 }
 
+static void aurora_resume(void)
+{
+	if (!(readl(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
+		writel(l2x0_saved_regs.aux_ctrl, l2x0_base + L2X0_AUX_CTRL);
+		writel(l2x0_saved_regs.ctrl, l2x0_base + L2X0_CTRL);
+	}
+}
+
+static void __init aurora_broadcast_l2_commands(void)
+{
+	__u32 u;
+	/* Enable Broadcasting of cache commands to L2*/
+	__asm__ __volatile__("mrc p15, 1, %0, c15, c2, 0" : "=r"(u));
+	u |= AURORA_CTRL_FW;		/* Set the FW bit */
+	__asm__ __volatile__("mcr p15, 1, %0, c15, c2, 0\n" : : "r"(u));
+	isb();
+}
+
+static void __init aurora_of_setup(const struct device_node *np,
+				u32 *aux_val, u32 *aux_mask)
+{
+	u32 val = AURORA_ACR_REPLACEMENT_TYPE_SEMIPLRU;
+	u32 mask =  AURORA_ACR_REPLACEMENT_MASK;
+
+	of_property_read_u32(np, "cache-id-part",
+			&cache_id_part_number_from_dt);
+
+	/* Determine and save the write policy */
+	l2_wt_override = of_property_read_bool(np, "wt-override");
+
+	if (l2_wt_override) {
+		val |= AURORA_ACR_FORCE_WRITE_THRO_POLICY;
+		mask |= AURORA_ACR_FORCE_WRITE_POLICY_MASK;
+	}
+
+	*aux_val &= ~mask;
+	*aux_val |= val;
+	*aux_mask &= ~mask;
+}
+
 static const struct l2x0_of_data pl310_data = {
 	.setup = pl310_of_setup,
 	.save  = pl310_save,
@@ -566,10 +730,37 @@ static const struct l2x0_of_data l2x0_data = {
 	},
 };
 
+static const struct l2x0_of_data aurora_with_outer_data = {
+	.setup = aurora_of_setup,
+	.save  = aurora_save,
+	.outer_cache = {
+		.resume      = aurora_resume,
+		.inv_range   = aurora_inv_range,
+		.clean_range = aurora_clean_range,
+		.flush_range = aurora_flush_range,
+		.sync        = l2x0_cache_sync,
+		.flush_all   = l2x0_flush_all,
+		.inv_all     = l2x0_inv_all,
+		.disable     = l2x0_disable,
+	},
+};
+
+static const struct l2x0_of_data aurora_no_outer_data = {
+	.setup = aurora_of_setup,
+	.save  = aurora_save,
+	.outer_cache = {
+		.resume      = aurora_resume,
+	},
+};
+
 static const struct of_device_id l2x0_ids[] __initconst = {
 	{ .compatible = "arm,pl310-cache", .data = (void *)&pl310_data },
 	{ .compatible = "arm,l220-cache", .data = (void *)&l2x0_data },
 	{ .compatible = "arm,l210-cache", .data = (void *)&l2x0_data },
+	{ .compatible = "marvell,aurora-system-cache",
+	  .data = (void *)&aurora_no_outer_data},
+	{ .compatible = "marvell,aurora-outer-cache",
+	  .data = (void *)&aurora_with_outer_data},
 	{}
 };
 
@@ -595,9 +786,14 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	data = of_match_node(l2x0_ids, np)->data;
 
 	/* L2 configuration can only be changed if the cache is disabled */
-	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & 1)) {
+	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
 		if (data->setup)
 			data->setup(np, &aux_val, &aux_mask);
+
+		/* For aurora cache in no outer mode select the
+		 * correct mode using the coprocessor*/
+		if (data == &aurora_no_outer_data)
+			aurora_broadcast_l2_commands();
 	}
 
 	if (data->save)
-- 
1.7.9.5
