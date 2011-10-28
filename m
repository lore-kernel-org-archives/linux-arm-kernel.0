From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:58 +0100
Subject: [PATCH 30/51] ARM: mach-nuc93x: use arm_arch_reset instead of
	arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-31-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-nuc93x to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-nuc93x/cpu.c                 |   12 ++++++++++++
 arch/arm/mach-nuc93x/include/mach/system.h |    6 +-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-nuc93x/cpu.c b/arch/arm/mach-nuc93x/cpu.c
index f6ff5d8..ccd7818 100644
--- a/arch/arm/mach-nuc93x/cpu.c
+++ b/arch/arm/mach-nuc93x/cpu.c
@@ -28,6 +28,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 #include <asm/irq.h>
+#include <asm/proc-fns.h>
 
 #include <mach/hardware.h>
 #include <mach/regs-serial.h>
@@ -133,3 +134,14 @@ void __init nuc93x_init_clocks(void)
 	clks_register(nuc932_clkregs, ARRAY_SIZE(nuc932_clkregs));
 }
 
+static void nuc93x_arch_reset(char mode, const char *cmd)
+{
+	cpu_reset(0);
+}
+
+static int __init nuc93x_arch_reset_init(void)
+{
+	arm_arch_reset = nuc93x_arch_reset;
+	return 0;
+}
+arch_initcall(nuc93x_arch_reset_init);
diff --git a/arch/arm/mach-nuc93x/include/mach/system.h b/arch/arm/mach-nuc93x/include/mach/system.h
index d26bd9a..a4d39a3 100644
--- a/arch/arm/mach-nuc93x/include/mach/system.h
+++ b/arch/arm/mach-nuc93x/include/mach/system.h
@@ -15,14 +15,10 @@
  *
  */
 
-#include <asm/proc-fns.h>
-
 static void arch_idle(void)
 {
 }
 
-static void arch_reset(char mode, const char *cmd)
+static inline void arch_reset(char mode, const char *cmd)
 {
-	cpu_reset(0);
 }
-
-- 
1.7.4.1
