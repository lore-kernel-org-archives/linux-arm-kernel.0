From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue,  6 Sep 2011 13:48:26 +0800
Subject: [PATCH v2 1/2] ARM: cache-l2x0: remove __init annotation from
	initialization functions
In-Reply-To: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1315288107-14689-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If ARM core gets powered off during suspend, L2 cache controller
has to be reinitialized by resume procedure.

The patch removes __init annotation from a few initialization
functions to make the reinitialization possible.  For example,
platform resume function can call l2x0_of_init() to get L2 cache
back to work.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |    2 +-
 arch/arm/mm/cache-l2x0.c                   |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index d22765c..d270310 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -89,7 +89,7 @@
 #define L2X0_ADDR_FILTER_EN		1
 
 #ifndef __ASSEMBLY__
-extern void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
+extern void l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
 #if defined(CONFIG_CACHE_L2X0) && defined(CONFIG_OF)
 extern int l2x0_of_init(__u32 aux_val, __u32 aux_mask);
 #else
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index c035b9a..7835cb6 100644
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
@@ -356,7 +356,7 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
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
-- 
1.7.4.1
