From: ddaney.cavm@gmail.com (David Daney)
Date: Tue, 23 Feb 2016 16:08:54 -0800
Subject: [PATCH v3] arm64: Add workaround for Cavium erratum 27456
Message-ID: <1456272534-21692-1-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

On ThunderX T88 pass 1.x through 2.1 parts, broadcast TLBI
instructions may cause the icache to become corrupted if it contains
data for a non-current ASID.

This patch implements the workaround (which flushes the local icache
when switching the mm) by using code patching.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     | 11 +++++++++++
 arch/arm64/include/asm/cpufeature.h    |  3 ++-
 arch/arm64/kernel/cpu_errata.c         |  9 +++++++++
 arch/arm64/mm/proc.S                   | 12 ++++++++++++
 5 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 58b71dd..ba4b6ac 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -56,3 +56,4 @@ stable kernels.
 |                |                 |                 |                         |
 | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375    |
 | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154    |
+| Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456    |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8cc6228..39f2203 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -432,6 +432,17 @@ config CAVIUM_ERRATUM_23154
 
 	  If unsure, say Y.
 
+config CAVIUM_ERRATUM_27456
+	bool "Cavium erratum 27456: Broadcast TLBI instructions may cause the icache corruption"
+	default y
+	help
+	  On ThunderX T88 pass 1.x through 2.1 parts, broadcast TLBI
+	  instructions may cause the icache to become corrupted if it
+	  contains data for a non-current ASID.  The fix is to flush
+	  the icache when changing the mm context.
+
+	  If unsure, say Y.
+
 endmenu
 
 
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 8f271b8..8136afc 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -30,8 +30,9 @@
 #define ARM64_HAS_LSE_ATOMICS			5
 #define ARM64_WORKAROUND_CAVIUM_23154		6
 #define ARM64_WORKAROUND_834220			7
+#define ARM64_WORKAROUND_CAVIUM_27456		8
 
-#define ARM64_NCAPS				8
+#define ARM64_NCAPS				9
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index feb6b4e..a3e846a 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -100,6 +100,15 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		MIDR_RANGE(MIDR_THUNDERX, 0x00, 0x01),
 	},
 #endif
+#ifdef CONFIG_CAVIUM_ERRATUM_27456
+	{
+	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
+		.desc = "Cavium erratum 27456",
+		.capability = ARM64_WORKAROUND_CAVIUM_27456,
+		MIDR_RANGE(MIDR_THUNDERX, 0x00,
+			   (1 << MIDR_VARIANT_SHIFT) | 1),
+	},
+#endif
 	{
 	}
 };
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index c164d2c..0f3be00 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -25,6 +25,8 @@
 #include <asm/hwcap.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/pgtable.h>
+#include <asm/cpufeature.h>
+#include <asm/alternative.h>
 
 #include "proc-macros.S"
 
@@ -137,7 +139,17 @@ ENTRY(cpu_do_switch_mm)
 	bfi	x0, x1, #48, #16		// set the ASID
 	msr	ttbr0_el1, x0			// set TTBR0
 	isb
+alternative_if_not ARM64_WORKAROUND_CAVIUM_27456
 	ret
+	nop
+	nop
+	nop
+alternative_else
+	ic	iallu
+	dsb	nsh
+	isb
+	ret
+alternative_endif
 ENDPROC(cpu_do_switch_mm)
 
 /*
-- 
1.8.3.1
