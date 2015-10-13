From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 13 Oct 2015 18:22:26 +0100
Subject: [PATCH v3 18/24] arm64/debug: Make use of the system wide safe value
In-Reply-To: <1444756952-31145-1-git-send-email-suzuki.poulose@arm.com>
References: <1444756952-31145-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1444756952-31145-19-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the system wide value of ID_AA64DFR0 to make safer decisions

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/hw_breakpoint.h |    9 +++++++--
 arch/arm64/kernel/debug-monitors.c     |    6 ++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index 4c47cb2..e54415e 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -17,6 +17,7 @@
 #define __ASM_HW_BREAKPOINT_H
 
 #include <asm/cputype.h>
+#include <asm/cpufeature.h>
 
 #ifdef __KERNEL__
 
@@ -137,13 +138,17 @@ extern struct pmu perf_ops_bp;
 /* Determine number of BRP registers available. */
 static inline int get_num_brps(void)
 {
-	return ((read_cpuid(ID_AA64DFR0_EL1) >> 12) & 0xf) + 1;
+	return 1 +
+		cpuid_feature_extract_field(read_system_reg(SYS_ID_AA64DFR0_EL1),
+						ID_AA64DFR0_BRPS_SHIFT);
 }
 
 /* Determine number of WRP registers available. */
 static inline int get_num_wrps(void)
 {
-	return ((read_cpuid(ID_AA64DFR0_EL1) >> 20) & 0xf) + 1;
+	return 1 +
+		cpuid_feature_extract_field(read_system_reg(SYS_ID_AA64DFR0_EL1),
+						ID_AA64DFR0_WRPS_SHIFT);
 }
 
 #endif	/* __KERNEL__ */
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index cebf786..c0a2327 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -26,14 +26,16 @@
 #include <linux/stat.h>
 #include <linux/uaccess.h>
 
-#include <asm/debug-monitors.h>
+#include <asm/cpufeature.h>
 #include <asm/cputype.h>
+#include <asm/debug-monitors.h>
 #include <asm/system_misc.h>
 
 /* Determine debug architecture. */
 u8 debug_monitors_arch(void)
 {
-	return read_cpuid(ID_AA64DFR0_EL1) & 0xf;
+	return cpuid_feature_extract_field(read_system_reg(SYS_ID_AA64DFR0_EL1),
+						ID_AA64DFR0_DEBUGVER_SHIFT);
 }
 
 /*
-- 
1.7.9.5
