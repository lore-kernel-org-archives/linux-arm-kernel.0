From: horms@verge.net.au (Simon Horman)
Date: Wed, 12 Sep 2012 16:14:56 +0900
Subject: [PATCH 1/2] arm: Add ARM ERRATA 775420 workaround
In-Reply-To: <1347434097-7924-1-git-send-email-horms@verge.net.au>
References: <1347434097-7924-1-git-send-email-horms@verge.net.au>
Message-ID: <1347434097-7924-2-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kouei Abe <kouei.abe.cp@rms.renesas.com>

Signed-off-by: Kouei Abe <kouei.abe.cp@rms.renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/Kconfig             |   10 ++++++++++
 arch/arm/kernel/entry-armv.S |   17 +++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2f88d8d..74fbdf7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1413,6 +1413,16 @@ config PL310_ERRATA_769419
 	  on systems with an outer cache, the store buffer is drained
 	  explicitly.
 
+config ARM_ERRATA_775420
+       bool "ARM errata: A data cache maintenance operation which aborts, might lead to deadlock"
+       depends on CPU_V7
+       help
+         This option enables the workaround for the 775420 Cortex-A9 (r2p2,
+         r2p6,r2p8,r2p10,r3p0) erratum. In case a date cache maintenance
+         operation aborts with MMU exception, it might cause the processor
+         deadlock. This workaround puts DSB before executing ISB at the
+         beginning of the abort exception handler.
+
 endmenu
 
 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 0f82098..070fa62 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -989,10 +989,19 @@ __kuser_helper_end:
  * SP points to a minimal amount of processor-private memory, the address
  * of which is copied into r0 for the mode specific abort handler.
  */
+#ifdef CONFIG_ARM_ERRATA_775420
+	.macro	vector_stub, name, mode, correction=0, abort=0
+#else
 	.macro	vector_stub, name, mode, correction=0
+#endif
 	.align	5
 
 vector_\name:
+#ifdef CONFIG_ARM_ERRATA_775420
+	.if \abort
+	dsb
+	.endif
+#endif
 	.if \correction
 	sub	lr, lr, #\correction
 	.endif
@@ -1056,7 +1065,11 @@ __stubs_start:
  * Data abort dispatcher
  * Enter in ABT mode, spsr = USR CPSR, lr = USR PC
  */
+#ifdef CONFIG_ARM_ERRATA_775420
+	vector_stub	dabt, ABT_MODE, 8, 1
+#else
 	vector_stub	dabt, ABT_MODE, 8
+#endif
 
 	.long	__dabt_usr			@  0  (USR_26 / USR_32)
 	.long	__dabt_invalid			@  1  (FIQ_26 / FIQ_32)
@@ -1079,7 +1092,11 @@ __stubs_start:
  * Prefetch abort dispatcher
  * Enter in ABT mode, spsr = USR CPSR, lr = USR PC
  */
+#ifdef CONFIG_ARM_ERRATA_775420
+	vector_stub	pabt, ABT_MODE, 4, 1
+#else
 	vector_stub	pabt, ABT_MODE, 4
+#endif
 
 	.long	__pabt_usr			@  0 (USR_26 / USR_32)
 	.long	__pabt_invalid			@  1 (FIQ_26 / FIQ_32)
-- 
1.7.10.4
