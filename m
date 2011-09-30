From: Barry.Song@csr.com (Barry Song)
Date: Fri, 30 Sep 2011 02:42:53 -0700
Subject: [PATCH v4] ARM: cache-l2x0: add resume entry for l2 in secure mode
Message-ID: <1317375773-7229-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

we save the l2x0 registers at the first initialization, and platform codes
can get them to restore l2x0 status after wakeup.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---
 -v4:
 add a declaration of l2x0_saved_regs in cache-l2x0.h, so that
 platform code does not need to declare it individually.

 arch/arm/include/asm/hardware/cache-l2x0.h |   25 ++++++
 arch/arm/include/asm/outercache.h          |    7 ++
 arch/arm/kernel/asm-offsets.c              |   12 +++
 arch/arm/mm/cache-l2x0.c                   |  129 +++++++++++++++++++++++++--
 4 files changed, 163 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index c48cb1e..434edcc 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -67,6 +67,13 @@
 #define L2X0_CACHE_ID_PART_MASK		(0xf << 6)
 #define L2X0_CACHE_ID_PART_L210		(1 << 6)
 #define L2X0_CACHE_ID_PART_L310		(3 << 6)
+#define L2X0_CACHE_ID_RTL_MASK          0x3f
+#define L2X0_CACHE_ID_RTL_R0P0          0x0
+#define L2X0_CACHE_ID_RTL_R1P0          0x2
+#define L2X0_CACHE_ID_RTL_R2P0          0x4
+#define L2X0_CACHE_ID_RTL_R3P0          0x5
+#define L2X0_CACHE_ID_RTL_R3P1          0x6
+#define L2X0_CACHE_ID_RTL_R3P2          0x8
 
 #define L2X0_AUX_CTRL_MASK			0xc0000fff
 #define L2X0_AUX_CTRL_DATA_RD_LATENCY_SHIFT	0
@@ -96,6 +103,24 @@
 #ifndef __ASSEMBLY__
 extern void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
 extern int l2x0_of_init(__u32 aux_val, __u32 aux_mask);
+
+struct l2x0_regs {
+	unsigned long phy_base;
+	unsigned long aux_ctrl;
+	/*
+	 * Whether the following registers need to be saved/restored
+	 * depends on platform
+	 */
+	unsigned long tag_latency;
+	unsigned long data_latency;
+	unsigned long filter_start;
+	unsigned long filter_end;
+	unsigned long prefetch_ctrl;
+	unsigned long pwr_ctrl;
+};
+
+extern struct l2x0_regs l2x0_saved_regs;
+
 #endif
 
 #endif
diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index d838743..53426c6 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -34,6 +34,7 @@ struct outer_cache_fns {
 	void (*sync)(void);
 #endif
 	void (*set_debug)(unsigned long);
+	void (*resume)(void);
 };
 
 #ifdef CONFIG_OUTER_CACHE
@@ -74,6 +75,12 @@ static inline void outer_disable(void)
 		outer_cache.disable();
 }
 
+static inline void outer_resume(void)
+{
+	if (outer_cache.resume)
+		outer_cache.resume();
+}
+
 #else
 
 static inline void outer_inv_range(phys_addr_t start, phys_addr_t end)
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 16baba2..1429d89 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -20,6 +20,7 @@
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/procinfo.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <linux/kbuild.h>
 
 /*
@@ -92,6 +93,17 @@ int main(void)
   DEFINE(S_OLD_R0,		offsetof(struct pt_regs, ARM_ORIG_r0));
   DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
   BLANK();
+#ifdef CONFIG_CACHE_L2X0
+  DEFINE(L2X0_R_PHY_BASE,	offsetof(struct l2x0_regs, phy_base));
+  DEFINE(L2X0_R_AUX_CTRL,	offsetof(struct l2x0_regs, aux_ctrl));
+  DEFINE(L2X0_R_TAG_LATENCY,	offsetof(struct l2x0_regs, tag_latency));
+  DEFINE(L2X0_R_DATA_LATENCY,	offsetof(struct l2x0_regs, data_latency));
+  DEFINE(L2X0_R_FILTER_START,	offsetof(struct l2x0_regs, filter_start));
+  DEFINE(L2X0_R_FILTER_END,	offsetof(struct l2x0_regs, filter_end));
+  DEFINE(L2X0_R_PREFETCH_CTRL,	offsetof(struct l2x0_regs, prefetch_ctrl));
+  DEFINE(L2X0_R_PWR_CTRL,	offsetof(struct l2x0_regs, pwr_ctrl));
+  BLANK();
+#endif
 #ifdef CONFIG_CPU_HAS_ASID
   DEFINE(MM_CONTEXT_ID,		offsetof(struct mm_struct, context.id));
   BLANK();
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 0d85d22..3f9b998 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -33,6 +33,14 @@ static DEFINE_SPINLOCK(l2x0_lock);
 static uint32_t l2x0_way_mask;	/* Bitmask of active ways */
 static uint32_t l2x0_size;
 
+struct l2x0_regs l2x0_saved_regs;
+
+struct l2x0_of_data {
+	void (*setup)(const struct device_node *, __u32 *, __u32 *);
+	void (*save)(void);
+	void (*resume)(void);
+};
+
 static inline void cache_wait_way(void __iomem *reg, unsigned long mask)
 {
 	/* wait for cache operation by line or way to complete */
@@ -280,7 +288,7 @@ static void l2x0_disable(void)
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
-static void __init l2x0_unlock(__u32 cache_id)
+static void l2x0_unlock(__u32 cache_id)
 {
 	int lockregs;
 	int i;
@@ -356,6 +364,8 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 		/* l2x0 controller is disabled */
 		writel_relaxed(aux, l2x0_base + L2X0_AUX_CTRL);
 
+		l2x0_saved_regs.aux_ctrl = aux;
+
 		l2x0_inv_all();
 
 		/* enable L2X0 */
@@ -445,33 +455,132 @@ static void __init pl310_of_setup(const struct device_node *np,
 	}
 }
 
+static void __init pl310_save(void)
+{
+	u32 l2x0_revision = readl_relaxed(l2x0_base + L2X0_CACHE_ID) &
+		L2X0_CACHE_ID_RTL_MASK;
+
+	l2x0_saved_regs.tag_latency = readl_relaxed(l2x0_base +
+		L2X0_TAG_LATENCY_CTRL);
+	l2x0_saved_regs.data_latency = readl_relaxed(l2x0_base +
+		L2X0_DATA_LATENCY_CTRL);
+	l2x0_saved_regs.filter_end = readl_relaxed(l2x0_base +
+		L2X0_ADDR_FILTER_END);
+	l2x0_saved_regs.filter_start = readl_relaxed(l2x0_base +
+		L2X0_ADDR_FILTER_START);
+
+	if (l2x0_revision >= L2X0_CACHE_ID_RTL_R2P0) {
+		/*
+		 * From r2p0, there is Prefetch offset/control register
+		 */
+		l2x0_saved_regs.prefetch_ctrl = readl_relaxed(l2x0_base +
+			L2X0_PREFETCH_CTRL);
+		/*
+		 * From r3p0, there is Power control register
+		 */
+		if (l2x0_revision >= L2X0_CACHE_ID_RTL_R3P0)
+			l2x0_saved_regs.pwr_ctrl = readl_relaxed(l2x0_base +
+				L2X0_POWER_CTRL);
+	}
+}
+
+static void l2x0_resume(void)
+{
+	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & 1)) {
+		/* restore aux ctrl and enable l2 */
+		l2x0_unlock(readl_relaxed(l2x0_base + L2X0_CACHE_ID));
+
+		writel_relaxed(l2x0_saved_regs.aux_ctrl, l2x0_base +
+			L2X0_AUX_CTRL);
+
+		l2x0_inv_all();
+
+		writel_relaxed(1, l2x0_base + L2X0_CTRL);
+	}
+}
+
+static void pl310_resume(void)
+{
+	u32 l2x0_revision;
+
+	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & 1)) {
+		/* restore pl310 setup */
+		writel_relaxed(l2x0_saved_regs.tag_latency,
+			l2x0_base + L2X0_TAG_LATENCY_CTRL);
+		writel_relaxed(l2x0_saved_regs.data_latency,
+			l2x0_base + L2X0_DATA_LATENCY_CTRL);
+		writel_relaxed(l2x0_saved_regs.filter_end,
+			l2x0_base + L2X0_ADDR_FILTER_END);
+		writel_relaxed(l2x0_saved_regs.filter_start,
+			l2x0_base + L2X0_ADDR_FILTER_START);
+
+		l2x0_revision = readl_relaxed(l2x0_base + L2X0_CACHE_ID) &
+			L2X0_CACHE_ID_RTL_MASK;
+
+		if (l2x0_revision >= L2X0_CACHE_ID_RTL_R2P0) {
+			writel_relaxed(l2x0_saved_regs.prefetch_ctrl,
+				l2x0_base + L2X0_PREFETCH_CTRL);
+			if (l2x0_revision >= L2X0_CACHE_ID_RTL_R3P0)
+				writel_relaxed(l2x0_saved_regs.pwr_ctrl,
+					l2x0_base + L2X0_POWER_CTRL);
+		}
+	}
+
+	l2x0_resume();
+}
+
+static const struct l2x0_of_data pl310_data = {
+	pl310_of_setup,
+	pl310_save,
+	pl310_resume,
+};
+
+static const struct l2x0_of_data l2x0_data = {
+	l2x0_of_setup,
+	NULL,
+	l2x0_resume,
+};
+
 static const struct of_device_id l2x0_ids[] __initconst = {
-	{ .compatible = "arm,pl310-cache", .data = pl310_of_setup },
-	{ .compatible = "arm,l220-cache", .data = l2x0_of_setup },
-	{ .compatible = "arm,l210-cache", .data = l2x0_of_setup },
+	{ .compatible = "arm,pl310-cache", .data = (void *)&pl310_data },
+	{ .compatible = "arm,l220-cache", .data = (void *)&l2x0_data },
+	{ .compatible = "arm,l210-cache", .data = (void *)&l2x0_data },
 	{}
 };
 
 int __init l2x0_of_init(__u32 aux_val, __u32 aux_mask)
 {
 	struct device_node *np;
-	void (*l2_setup)(const struct device_node *np,
-		__u32 *aux_val, __u32 *aux_mask);
+	struct l2x0_of_data *data;
+	struct resource res;
 
 	np = of_find_matching_node(NULL, l2x0_ids);
 	if (!np)
 		return -ENODEV;
-	l2x0_base = of_iomap(np, 0);
+
+	if (of_address_to_resource(np, 0, &res))
+		return -ENODEV;
+
+	l2x0_base = ioremap(res.start, resource_size(&res));
 	if (!l2x0_base)
 		return -ENOMEM;
 
+	l2x0_saved_regs.phy_base = res.start;
+
+	data = of_match_node(l2x0_ids, np)->data;
+
 	/* L2 configuration can only be changed if the cache is disabled */
 	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & 1)) {
-		l2_setup = of_match_node(l2x0_ids, np)->data;
-		if (l2_setup)
-			l2_setup(np, &aux_val, &aux_mask);
+		if (data->setup)
+			data->setup(np, &aux_val, &aux_mask);
 	}
+
+	if (data->save)
+		data->save();
+
 	l2x0_init(l2x0_base, aux_val, aux_mask);
+
+	outer_cache.resume = data->resume;
 	return 0;
 }
 #endif
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
