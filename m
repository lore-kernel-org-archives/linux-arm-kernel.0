From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:53 +0100
Subject: [PATCH 25/51] ARM: mach-mv78xx0: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-26-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-mv78xx0 to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-mv78xx0/common.c              |   17 +++++++++++++++++
 arch/arm/mach-mv78xx0/include/mach/system.h |   12 ------------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index 23d3980..c3d5dd4 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -375,6 +375,22 @@ static int __init is_l2_writethrough(void)
 	return !!(readl(CPU_CONTROL) & L2_WRITETHROUGH);
 }
 
+static void mv78xx0_arch_reset(char mode, const char *cmd)
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
 void __init mv78xx0_init(void)
 {
 	int core_index;
@@ -400,4 +416,5 @@ void __init mv78xx0_init(void)
 #ifdef CONFIG_CACHE_FEROCEON_L2
 	feroceon_l2_init(is_l2_writethrough());
 #endif
+	arm_arch_reset = mv78xx0_arch_reset;
 }
diff --git a/arch/arm/mach-mv78xx0/include/mach/system.h b/arch/arm/mach-mv78xx0/include/mach/system.h
index 66e7ce4..1a41dc5 100644
--- a/arch/arm/mach-mv78xx0/include/mach/system.h
+++ b/arch/arm/mach-mv78xx0/include/mach/system.h
@@ -18,18 +18,6 @@ static inline void arch_idle(void)
 
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
 
 
-- 
1.7.4.1
