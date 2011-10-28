From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:49 +0100
Subject: [PATCH 21/51] ARM: mach-kirkwood: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-22-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-kirkwood to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-kirkwood/common.c              |   17 +++++++++++++++++
 arch/arm/mach-kirkwood/include/mach/system.h |   14 --------------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index f3248cf..5fcfbde 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -448,6 +448,22 @@ static void __init kirkwood_l2_init(void)
 #endif
 }
 
+static void kirkwood_arch_reset(char mode, const char *cmd)
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
 void __init kirkwood_init(void)
 {
 	printk(KERN_INFO "Kirkwood: %s, TCLK=%d.\n",
@@ -478,6 +494,7 @@ void __init kirkwood_init(void)
 #ifdef CONFIG_KEXEC 
 	kexec_reinit = kirkwood_enable_pcie;
 #endif
+	arm_arch_reset = kirkwood_arch_reset;
 }
 
 static int __init kirkwood_clock_gate(void)
diff --git a/arch/arm/mach-kirkwood/include/mach/system.h b/arch/arm/mach-kirkwood/include/mach/system.h
index 7568e95..f094431 100644
--- a/arch/arm/mach-kirkwood/include/mach/system.h
+++ b/arch/arm/mach-kirkwood/include/mach/system.h
@@ -9,8 +9,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-#include <mach/bridge-regs.h>
-
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
@@ -18,18 +16,6 @@ static inline void arch_idle(void)
 
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
