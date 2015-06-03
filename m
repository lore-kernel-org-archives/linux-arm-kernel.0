From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  3 Jun 2015 14:36:23 +0100
Subject: [PATCH] arm64: Rework alternate sequence for ARM erratum 845719
Message-ID: <1433338583-16445-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The workaround for erratum 845719 is currently using
a branch between two alternate sequences, which is
quite fragile, and that we are going to break as we
rework the alternative code.

This patch reworks the workaround to fit in a single
alternative sequence. The generated code itself is
unchanged.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/entry.S | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 00df926..d369ccf 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -124,21 +124,24 @@
 	msr	sp_el0, x23
 
 #ifdef CONFIG_ARM64_ERRATUM_845719
-	alternative_insn						\
-	"nop",								\
-	"tbz x22, #4, 1f",						\
-	ARM64_WORKAROUND_845719
+
+#undef SEQUENCE_ORG
+#undef SEQUENCE_ALT
+
 #ifdef CONFIG_PID_IN_CONTEXTIDR
-	alternative_insn						\
-	"nop; nop",							\
-	"mrs x29, contextidr_el1; msr contextidr_el1, x29; 1:",		\
-	ARM64_WORKAROUND_845719
+
+#define SEQUENCE_ORG	"nop ; nop ; nop"
+#define SEQUENCE_ALT	"tbz x22, #4, 1f ; mrs x29, contextidr_el1; msr contextidr_el1, x29; 1:"
+
 #else
-	alternative_insn						\
-	"nop",								\
-	"msr contextidr_el1, xzr; 1:",					\
-	ARM64_WORKAROUND_845719
+
+#define SEQUENCE_ORG	"nop ; nop"
+#define SEQUENCE_ALT	"tbz x22, #4, 1f ; msr contextidr_el1, xzr; 1:"
+
 #endif
+
+	alternative_insn SEQUENCE_ORG, SEQUENCE_ALT, ARM64_WORKAROUND_845719
+
 #endif
 	.endif
 	msr	elr_el1, x21			// set up the return data
-- 
2.1.4
