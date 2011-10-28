From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:35 +0100
Subject: [PATCH 07/51] ARM: mach-dove: use arm_arch_reset instead of arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-dove to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-dove/common.c              |   18 ++++++++++++++++++
 arch/arm/mach-dove/include/mach/system.h |   13 -------------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index a9e0dae..975f6f1 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -273,6 +273,22 @@ void __init dove_sdio1_init(void)
 	platform_device_register(&dove_sdio1);
 }
 
+static void dove_arch_reset(char mode, const char *cmd)
+{
+	/*
+	 * Enable soft reset to assert RSTOUTn.
+	 */
+	writel(SOFT_RESET_OUT_EN, RSTOUTn_MASK);
+
+	/*
+	 * Assert soft reset.
+	 */
+	writel(SOFT_RESET, SYSTEM_SOFT_RESET);
+
+	while (1)
+		;
+}
+
 void __init dove_init(void)
 {
 	int tclk;
@@ -282,6 +298,8 @@ void __init dove_init(void)
 	printk(KERN_INFO "Dove 88AP510 SoC, ");
 	printk(KERN_INFO "TCLK = %dMHz\n", (tclk + 499999) / 1000000);
 
+	arm_arch_reset = dove_arch_reset;
+
 #ifdef CONFIG_CACHE_TAUROS2
 	tauros2_init();
 #endif
diff --git a/arch/arm/mach-dove/include/mach/system.h b/arch/arm/mach-dove/include/mach/system.h
index 356afda..ce3e749 100644
--- a/arch/arm/mach-dove/include/mach/system.h
+++ b/arch/arm/mach-dove/include/mach/system.h
@@ -18,19 +18,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	/*
-	 * Enable soft reset to assert RSTOUTn.
-	 */
-	writel(SOFT_RESET_OUT_EN, RSTOUTn_MASK);
-
-	/*
-	 * Assert soft reset.
-	 */
-	writel(SOFT_RESET, SYSTEM_SOFT_RESET);
-
-	while (1)
-		;
 }
 
-
 #endif
-- 
1.7.4.1
