From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 22 Jul 2015 12:21:03 +0100
Subject: [PATCH v3 3/5] arm64: kernel: Adopt new alternative assembler macros
In-Reply-To: <1437564065-4356-1-git-send-email-daniel.thompson@linaro.org>
References: <1436536130-31438-1-git-send-email-daniel.thompson@linaro.org>
 <1437564065-4356-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1437564065-4356-4-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the dynamic patching for ARM64_WORKAROUND_845719 over to
the newly added alternative assembler macros.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/kernel/entry.S | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index a7691a378668..be8a70d4028c 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -122,26 +122,23 @@
 	ct_user_enter
 	ldr	x23, [sp, #S_SP]		// load return stack pointer
 	msr	sp_el0, x23
-
 #ifdef CONFIG_ARM64_ERRATUM_845719
-
-#undef SEQUENCE_ORG
-#undef SEQUENCE_ALT
-
+alternative_if_not ARM64_WORKAROUND_845719
+	nop
+	nop
 #ifdef CONFIG_PID_IN_CONTEXTIDR
-
-#define SEQUENCE_ORG	"nop ; nop ; nop"
-#define SEQUENCE_ALT	"tbz x22, #4, 1f ; mrs x29, contextidr_el1; msr contextidr_el1, x29; 1:"
-
+	nop
+#endif
+alternative_else
+	tbz	x22, #4, 1f
+#ifdef CONFIG_PID_IN_CONTEXTIDR
+	mrs	x29, contextidr_el1
+	msr	contextidr_el1, x29
 #else
-
-#define SEQUENCE_ORG	"nop ; nop"
-#define SEQUENCE_ALT	"tbz x22, #4, 1f ; msr contextidr_el1, xzr; 1:"
-
+	msr contextidr_el1, xzr
 #endif
-
-	alternative_insn SEQUENCE_ORG, SEQUENCE_ALT, ARM64_WORKAROUND_845719
-
+1:
+alternative_endif
 #endif
 	.endif
 	msr	elr_el1, x21			// set up the return data
-- 
2.4.3
