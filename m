From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 30 Aug 2011 15:40:15 +0800
Subject: [PATCH 1/3] ARM: cache-l2x0: make the reinitialization possible
In-Reply-To: <1314690017-17590-1-git-send-email-shawn.guo@linaro.org>
References: <1314690017-17590-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1314690017-17590-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If ARM core gets powered off during suspend, L2 cache controller
has to be reinitialized by resume procedure.

The patch removes __init annotation from a few initialization
functions to make the reinitialization possible.  For example,
platform resume function can call l2x0_of_init() to get L2 cache
back to work.

It also adds the empty function for l2x0_init() and l2x0_of_init(),
so that we can keep '#ifdef CONFIG_CACHE_L2X0' check in header.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |   10 +++++++++-
 arch/arm/mm/cache-l2x0.c                   |   23 +++++++++++++----------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 4a6004a..ed946c5 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -89,8 +89,16 @@
 #define L2X0_ADDR_FILTER_EN		1
 
 #ifndef __ASSEMBLY__
-extern void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
+#ifdef CONFIG_CACHE_L2X0
+extern void l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
 extern int l2x0_of_init(__u32 aux_val, __u32 aux_mask);
+#else
+static void l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask) {}
+static inline int l2x0_of_init(__u32 aux_val, __u32 aux_mask)
+{
+	return -ENOSYS;
+}
+#endif
 #endif
 
 #endif
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index c035b9a..3eeb025 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -280,7 +280,7 @@ static void l2x0_disable(void)
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
-void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
+void l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 {
 	__u32 aux;
 	__u32 cache_id;
@@ -350,13 +350,13 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 	outer_cache.disable = l2x0_disable;
 	outer_cache.set_debug = l2x0_set_debug;
 
-	printk(KERN_INFO "%s cache controller enabled\n", type);
-	printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d B\n",
+	pr_info_once("%s cache controller enabled\n", type);
+	pr_info_once("l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d B\n",
 			ways, cache_id, aux, l2x0_size);
 }
 
 #ifdef CONFIG_OF
-static void __init l2x0_of_setup(const struct device_node *np,
+static void l2x0_of_setup(const struct device_node *np,
 				 __u32 *aux_val, __u32 *aux_mask)
 {
 	u32 data[2] = { 0, 0 };
@@ -390,7 +390,7 @@ static void __init l2x0_of_setup(const struct device_node *np,
 	*aux_mask &= ~mask;
 }
 
-static void __init pl310_of_setup(const struct device_node *np,
+static void pl310_of_setup(const struct device_node *np,
 				  __u32 *aux_val, __u32 *aux_mask)
 {
 	u32 data[3] = { 0, 0, 0 };
@@ -424,14 +424,14 @@ static void __init pl310_of_setup(const struct device_node *np,
 	}
 }
 
-static const struct of_device_id l2x0_ids[] __initconst = {
+static const struct of_device_id l2x0_ids[] = {
 	{ .compatible = "arm,pl310-cache", .data = pl310_of_setup },
 	{ .compatible = "arm,l220-cache", .data = l2x0_of_setup },
 	{ .compatible = "arm,l210-cache", .data = l2x0_of_setup },
 	{}
 };
 
-int __init l2x0_of_init(__u32 aux_val, __u32 aux_mask)
+int l2x0_of_init(__u32 aux_val, __u32 aux_mask)
 {
 	struct device_node *np;
 	void (*l2_setup)(const struct device_node *np,
@@ -440,9 +440,12 @@ int __init l2x0_of_init(__u32 aux_val, __u32 aux_mask)
 	np = of_find_matching_node(NULL, l2x0_ids);
 	if (!np)
 		return -ENODEV;
-	l2x0_base = of_iomap(np, 0);
-	if (!l2x0_base)
-		return -ENOMEM;
+
+	if (!l2x0_base) {
+		l2x0_base = of_iomap(np, 0);
+		if (!l2x0_base)
+			return -ENOMEM;
+	}
 
 	/* L2 configuration can only be changed if the cache is disabled */
 	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & 1)) {
-- 
1.7.4.1
