From: xiechao.mail@gmail.com (Chao Xie)
Date: Tue, 31 Jul 2012 14:13:12 +0800
Subject: [PATCH 5/7] ARM: cache: add extra feature enable for tauros2
In-Reply-To: <1343715194-25900-1-git-send-email-xiechao.mail@gmail.com>
References: <1343715194-25900-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <1343715194-25900-5-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

The extra feature may be used by SOCs are prefetch, burst8,
write buffer coalesce

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
---
 arch/arm/include/asm/hardware/cache-tauros2.h |    5 ++-
 arch/arm/mm/cache-tauros2.c                   |   44 +++++++++++++++---------
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-tauros2.h b/arch/arm/include/asm/hardware/cache-tauros2.h
index 538f17c..295e2e4 100644
--- a/arch/arm/include/asm/hardware/cache-tauros2.h
+++ b/arch/arm/include/asm/hardware/cache-tauros2.h
@@ -8,4 +8,7 @@
  * warranty of any kind, whether express or implied.
  */
 
-extern void __init tauros2_init(void);
+#define CACHE_TAUROS2_PREFETCH_ON	(1 << 0)
+#define CACHE_TAUROS2_LINEFILL_BURST8	(1 << 1)
+
+extern void __init tauros2_init(unsigned int features);
diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
index 4b787bb..e9f054f 100644
--- a/arch/arm/mm/cache-tauros2.c
+++ b/arch/arm/mm/cache-tauros2.c
@@ -145,21 +145,6 @@ static inline void __init write_extra_features(u32 u)
 	__asm__("mcr p15, 1, %0, c15, c1, 0" : : "r" (u));
 }
 
-static void __init disable_l2_prefetch(void)
-{
-	u32 u;
-
-	/*
-	 * Read the CPU Extra Features register and verify that the
-	 * Disable L2 Prefetch bit is set.
-	 */
-	u = read_extra_features();
-	if (!(u & 0x01000000)) {
-		printk(KERN_INFO "Tauros2: Disabling L2 prefetch.\n");
-		write_extra_features(u | 0x01000000);
-	}
-}
-
 static inline int __init cpuid_scheme(void)
 {
 	return !!((processor_id & 0x000f0000) == 0x000f0000);
@@ -188,11 +173,36 @@ static inline void __init write_actlr(u32 actlr)
 	__asm__("mcr p15, 0, %0, c1, c0, 1\n" : : "r" (actlr));
 }
 
-void __init tauros2_init(void)
+static void enable_extra_feature(unsigned int features)
+{
+	u32 u;
+
+	u = read_extra_features();
+
+	if (features & CACHE_TAUROS2_PREFETCH_ON)
+		u &= ~0x01000000;
+	else
+		u |= 0x01000000;
+	printk(KERN_INFO "Tauros2: %s L2 prefetch.\n",
+			(features & CACHE_TAUROS2_PREFETCH_ON)
+			? "Enabling" : "Disabling");
+
+	if (features & CACHE_TAUROS2_LINEFILL_BURST8)
+		u |= 0x00100000;
+	else
+		u &= ~0x00100000;
+	printk(KERN_INFO "Tauros2: %s line fill burt8.\n",
+			(features & CACHE_TAUROS2_LINEFILL_BURST8)
+			? "Enabling" : "Disabling");
+
+	write_extra_features(u);
+}
+
+void __init tauros2_init(unsigned int features)
 {
 	char *mode = NULL;
 
-	disable_l2_prefetch();
+	enable_extra_feature(features);
 
 #ifdef CONFIG_CPU_32v5
 	if ((processor_id & 0xff0f0000) == 0x56050000) {
-- 
1.7.0.4
