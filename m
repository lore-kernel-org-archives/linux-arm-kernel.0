From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 Mar 2015 10:08:18 +0100
Subject: [PATCH] arm64: errata: add workaround for cortex-a53 erratum #845719
Message-ID: <1427792898-22297-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When running a compat (AArch32) userspace on Cortex-A53, a load at EL0
from a virtual address that matches the bottom 32 bits of the virtual
address used by a recent load at (AArch64) EL1 might return incorrect
data.

This patch works around the issue by writing to the contextidr_el1
register on the exception return path when returning to a 32-bit task.
This workaround is patched in at runtime based on the MIDR value of the
processor.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                  | 21 +++++++++++++++++++++
 arch/arm64/include/asm/cpufeature.h |  3 ++-
 arch/arm64/kernel/cpu_errata.c      |  8 ++++++++
 arch/arm64/kernel/entry.S           | 20 ++++++++++++++++++++
 4 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b8e97331ffb..11103853d5f4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -361,6 +361,27 @@ config ARM64_ERRATUM_832075
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_845719
+	bool "Cortex-A53: 845719: a load might read incorrect data"
+	depends on COMPAT
+	default y
+	help
+	  This option adds an alternative code sequence to work around ARM
+	  erratum 845719 on Cortex-A53 parts up to r0p4.
+
+	  When running a compat (AArch32) userspace on an affected Cortex-A53
+	  part, a load at EL0 from a virtual address that matches the bottom 32
+	  bits of the virtual address used by a recent load at (AArch64) EL1
+	  might return incorrect data.
+
+	  The workaround is to write the contextidr_el1 register on exception
+	  return to a 32-bit task.
+	  Please note that this does not necessarily enable the workaround,
+	  as it depends on the alternative framework, which will only patch
+	  the kernel if an affected CPU is detected.
+
+	  If unsure, say Y.
+
 endmenu
 
 
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index b6c16d5f622f..3f0c53c45771 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -23,8 +23,9 @@
 
 #define ARM64_WORKAROUND_CLEAN_CACHE		0
 #define ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE	1
+#define ARM64_WORKAROUND_845719			2
 
-#define ARM64_NCAPS				2
+#define ARM64_NCAPS				3
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index fa62637e63a8..ac5d965f1300 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -91,6 +91,14 @@ struct arm64_cpu_capabilities arm64_errata[] = {
 		MIDR_RANGE(MIDR_CORTEX_A57, 0x00, 0x12),
 	},
 #endif
+#ifdef CONFIG_ARM64_ERRATUM_845719
+	{
+	/* Cortex-A53 r0p[01234] */
+		.desc = "ARM erratum 845719",
+		.capability = ARM64_WORKAROUND_845719,
+		MIDR_RANGE(MIDR_CORTEX_A53, 0x00, 0x04),
+	},
+#endif
 	{
 	}
 };
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index cf21bb3bf752..959fe8733560 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -21,8 +21,10 @@
 #include <linux/init.h>
 #include <linux/linkage.h>
 
+#include <asm/alternative-asm.h>
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
+#include <asm/cpufeature.h>
 #include <asm/errno.h>
 #include <asm/esr.h>
 #include <asm/thread_info.h>
@@ -120,6 +122,24 @@
 	ct_user_enter
 	ldr	x23, [sp, #S_SP]		// load return stack pointer
 	msr	sp_el0, x23
+
+#ifdef CONFIG_ARM64_ERRATUM_845719
+	alternative_insn						\
+	"nop",								\
+	"tbz x22, #4, 1f",						\
+	ARM64_WORKAROUND_845719
+#ifdef CONFIG_PID_IN_CONTEXTIDR
+	alternative_insn						\
+	"nop; nop",							\
+	"mrs x29, contextidr_el1; msr contextidr_el1, x29; 1:",		\
+	ARM64_WORKAROUND_845719
+#else
+	alternative_insn						\
+	"nop",								\
+	"msr contextidr_el1, xzr; 1:",					\
+	ARM64_WORKAROUND_845719
+#endif
+#endif
 	.endif
 	msr	elr_el1, x21			// set up the return data
 	msr	spsr_el1, x22
-- 
2.1.4
