From: Baohua.Song@csr.com (Barry Song)
Date: Tue, 20 Sep 2011 18:57:45 -0700
Subject: [PATCH] ARM: cache-l2x0: add resume entry for l2 in secure mode
Message-ID: <1316570265-13709-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we save the l2x0 registers at the first initialization, and restore
them after resuming every time.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/include/asm/outercache.h |    7 +++
 arch/arm/mm/cache-l2x0.c          |   81 ++++++++++++++++++++++++++++++++----
 2 files changed, 79 insertions(+), 9 deletions(-)

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
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 0d85d22..4722707 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -32,6 +32,14 @@ static void __iomem *l2x0_base;
 static DEFINE_SPINLOCK(l2x0_lock);
 static uint32_t l2x0_way_mask;	/* Bitmask of active ways */
 static uint32_t l2x0_size;
+static u32 l2x0_aux_ctrl;
+static u32 l2x0_tag_latency, l2x0_data_latency, l2x0_filter_start, l2x0_filter_end;
+
+struct l2x0_of_data {
+	void (*setup)(const struct device_node *,__u32 *, __u32 *);
+	void (*save)(void);
+	void (*resume)(void);
+};
 
 static inline void cache_wait_way(void __iomem *reg, unsigned long mask)
 {
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
 
+		l2x0_aux_ctrl = aux;
+
 		l2x0_inv_all();
 
 		/* enable L2X0 */
@@ -445,18 +455,64 @@ static void __init pl310_of_setup(const struct device_node *np,
 	}
 }
 
+static void __init pl310_save(void)
+{
+	l2x0_tag_latency = readl_relaxed(l2x0_base + L2X0_TAG_LATENCY_CTRL);
+	l2x0_data_latency = readl_relaxed(l2x0_base + L2X0_DATA_LATENCY_CTRL);
+	l2x0_filter_end = readl_relaxed(l2x0_base + L2X0_ADDR_FILTER_END);
+	l2x0_filter_start = readl_relaxed(l2x0_base + L2X0_ADDR_FILTER_START);
+}
+
+static void l2x0_resume(void)
+{
+	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & 1)) {
+		/* restore aux ctrl and enable l2 */
+		l2x0_unlock(readl_relaxed(l2x0_base + L2X0_CACHE_ID));
+
+		writel_relaxed(l2x0_aux_ctrl, l2x0_base + L2X0_AUX_CTRL);
+
+		l2x0_inv_all();
+
+		writel_relaxed(1, l2x0_base + L2X0_CTRL);
+	}
+}
+
+static void pl310_resume(void)
+{
+	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & 1)) {
+		/* restore pl310 setup */
+		writel_relaxed(l2x0_tag_latency, l2x0_base + L2X0_TAG_LATENCY_CTRL);
+		writel_relaxed(l2x0_data_latency, l2x0_base + L2X0_DATA_LATENCY_CTRL);
+		writel_relaxed(l2x0_filter_end, l2x0_base + L2X0_ADDR_FILTER_END);
+		writel_relaxed(l2x0_filter_start, l2x0_base + L2X0_ADDR_FILTER_START);
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
 
 	np = of_find_matching_node(NULL, l2x0_ids);
 	if (!np)
@@ -465,13 +521,20 @@ int __init l2x0_of_init(__u32 aux_val, __u32 aux_mask)
 	if (!l2x0_base)
 		return -ENOMEM;
 
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
