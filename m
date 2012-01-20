From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 09:53:35 +0000
Subject: [PATCH] ARM: cache-l2x0.c: consistently use u32
Message-ID: <E1RoBA7-0005Jg-OU@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__u32 exists to avoid namespace clashes with userspace programs.  It
should not be used outside header files, so convert to use u32 instead.
Also, don't mix uint32_t and __u32 - use the same type throughout the
file for consistency.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |    6 +++---
 arch/arm/mm/cache-l2x0.c                   |   22 +++++++++++-----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 7df239b..c4c87bc 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -103,11 +103,11 @@
 #define L2X0_ADDR_FILTER_EN		1
 
 #ifndef __ASSEMBLY__
-extern void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
+extern void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask);
 #if defined(CONFIG_CACHE_L2X0) && defined(CONFIG_OF)
-extern int l2x0_of_init(__u32 aux_val, __u32 aux_mask);
+extern int l2x0_of_init(u32 aux_val, u32 aux_mask);
 #else
-static inline int l2x0_of_init(__u32 aux_val, __u32 aux_mask)
+static inline int l2x0_of_init(u32 aux_val, u32 aux_mask)
 {
 	return -ENODEV;
 }
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index b1e192b..a53fd2a 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -30,13 +30,13 @@
 
 static void __iomem *l2x0_base;
 static DEFINE_RAW_SPINLOCK(l2x0_lock);
-static uint32_t l2x0_way_mask;	/* Bitmask of active ways */
-static uint32_t l2x0_size;
+static u32 l2x0_way_mask;	/* Bitmask of active ways */
+static u32 l2x0_size;
 
 struct l2x0_regs l2x0_saved_regs;
 
 struct l2x0_of_data {
-	void (*setup)(const struct device_node *, __u32 *, __u32 *);
+	void (*setup)(const struct device_node *, u32 *, u32 *);
 	void (*save)(void);
 	void (*resume)(void);
 };
@@ -288,7 +288,7 @@ static void l2x0_disable(void)
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
-static void l2x0_unlock(__u32 cache_id)
+static void l2x0_unlock(u32 cache_id)
 {
 	int lockregs;
 	int i;
@@ -307,11 +307,11 @@ static void l2x0_unlock(__u32 cache_id)
 	}
 }
 
-void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
+void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 {
-	__u32 aux;
-	__u32 cache_id;
-	__u32 way_size = 0;
+	u32 aux;
+	u32 cache_id;
+	u32 way_size = 0;
 	int ways;
 	const char *type;
 
@@ -388,7 +388,7 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 
 #ifdef CONFIG_OF
 static void __init l2x0_of_setup(const struct device_node *np,
-				 __u32 *aux_val, __u32 *aux_mask)
+				 u32 *aux_val, u32 *aux_mask)
 {
 	u32 data[2] = { 0, 0 };
 	u32 tag = 0;
@@ -422,7 +422,7 @@ static void __init l2x0_of_setup(const struct device_node *np,
 }
 
 static void __init pl310_of_setup(const struct device_node *np,
-				  __u32 *aux_val, __u32 *aux_mask)
+				  u32 *aux_val, u32 *aux_mask)
 {
 	u32 data[3] = { 0, 0, 0 };
 	u32 tag[3] = { 0, 0, 0 };
@@ -548,7 +548,7 @@ static const struct of_device_id l2x0_ids[] __initconst = {
 	{}
 };
 
-int __init l2x0_of_init(__u32 aux_val, __u32 aux_mask)
+int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 {
 	struct device_node *np;
 	struct l2x0_of_data *data;
-- 
1.7.4.4
