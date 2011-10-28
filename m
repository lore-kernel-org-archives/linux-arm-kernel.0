From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:29 +0100
Subject: [PATCH 01/51] ARM: reset: introduce arm_arch_reset function pointer
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch_reset is a static inline function defined in mach/system.h and, as
such, is a blocker for the single zImage work.

This patch introduces an arm_arch_reset function pointer to which
platforms can assign their reset function rather than define it in the
header file.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/system.h |    1 +
 arch/arm/kernel/process.c     |   11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 832888d..6838bd4 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -108,6 +108,7 @@ extern int cpu_architecture(void);
 extern void cpu_init(void);
 
 void arm_machine_restart(char mode, const char *cmd);
+extern void (*arm_arch_reset)(char mode, const char *cmd);
 extern void (*arm_pm_restart)(char str, const char *cmd);
 
 #define UDBG_UNDEFINED	(1 << 0)
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 1a347f4..13e68c5 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -117,7 +117,8 @@ void arm_machine_restart(char mode, const char *cmd)
 	/*
 	 * Now call the architecture specific reboot code.
 	 */
-	arch_reset(mode, cmd);
+	if (arm_arch_reset)
+		arm_arch_reset(mode, cmd);
 
 	/*
 	 * Whoops - the architecture was unable to reboot.
@@ -128,6 +129,11 @@ void arm_machine_restart(char mode, const char *cmd)
 	while (1);
 }
 
+static void temporary_arm_arch_reset(char mode, const char *cmd)
+{
+	arch_reset(mode, cmd);
+}
+
 /*
  * Function pointers to optional machine specific functions
  */
@@ -137,6 +143,9 @@ EXPORT_SYMBOL(pm_power_off);
 void (*arm_pm_restart)(char str, const char *cmd) = arm_machine_restart;
 EXPORT_SYMBOL_GPL(arm_pm_restart);
 
+void (*arm_arch_reset)(char mode, const char *cmd) = temporary_arm_arch_reset;
+EXPORT_SYMBOL_GPL(arm_arch_reset);
+
 static void do_nothing(void *unused)
 {
 }
-- 
1.7.4.1
