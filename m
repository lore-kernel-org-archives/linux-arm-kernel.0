From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 29 Jan 2013 02:51:00 -0500
Subject: [PATCH v3 05/15] ARM: mcpm_head.S: vlock-based first man election
In-Reply-To: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1359445870-18925-6-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@linaro.org>

Instead of requiring the first man to be elected in advance (which
can be suboptimal in some situations), this patch uses a per-
cluster mutex to co-ordinate selection of the first man.

This should also make it more feasible to reuse this code path for
asynchronous cluster resume (as in CPUidle scenarios).

We must ensure that the vlock data doesn't share a cacheline with
anything else, or dirty cache eviction could corrupt it.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/common/Makefile    |  2 +-
 arch/arm/common/mcpm_head.S | 41 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 23e85b1fae..c901a38c59 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -13,4 +13,4 @@ obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
 obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
 obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
-obj-$(CONFIG_CLUSTER_PM)	+= mcpm_head.o mcpm_entry.o
+obj-$(CONFIG_CLUSTER_PM)	+= mcpm_head.o mcpm_entry.o vlock.o
diff --git a/arch/arm/common/mcpm_head.S b/arch/arm/common/mcpm_head.S
index 65db7ec87e..a2a2bb6bf0 100644
--- a/arch/arm/common/mcpm_head.S
+++ b/arch/arm/common/mcpm_head.S
@@ -16,6 +16,8 @@
 #include <linux/linkage.h>
 #include <asm/mcpm_entry.h>
 
+#include "vlock.h"
+
 .if MCPM_SYNC_CLUSTER_CPUS
 .error "cpus must be the first member of struct mcpm_sync_struct"
 .endif
@@ -69,10 +71,11 @@ ENTRY(mcpm_entry_point)
 	 * position independent way.
 	 */
 	adr	r5, 3f
-	ldmia	r5, {r6, r7, r8}
+	ldmia	r5, {r6, r7, r8, r11}
 	add	r6, r5, r6			@ r6 = mcpm_entry_vectors
 	ldr	r7, [r5, r7]			@ r7 = mcpm_power_up_setup_phys
 	add	r8, r5, r8			@ r8 = mcpm_sync
+	add	r11, r5, r11			@ r11 = first_man_locks
 
 	mov	r0, #MCPM_SYNC_CLUSTER_SIZE
 	mla	r8, r0, r10, r8			@ r8 = sync cluster base
@@ -86,13 +89,22 @@ ENTRY(mcpm_entry_point)
 	@ At this point, the cluster cannot unexpectedly enter the GOING_DOWN
 	@ state, because there is at least one active CPU (this CPU).
 
-	@ Note: the following is racy as another CPU might be testing
-	@ the same flag at the same moment.  That'll be fixed later.
+	mov	r0, #VLOCK_SIZE
+	mla	r11, r0, r10, r11		@ r11 = cluster first man lock
+	mov	r0, r11
+	mov	r1, r9				@ cpu
+	bl	vlock_trylock			@ implies DMB
+
+	cmp	r0, #0				@ failed to get the lock?
+	bne	mcpm_setup_wait		@ wait for cluster setup if so
+
 	ldrb	r0, [r8, #MCPM_SYNC_CLUSTER_CLUSTER]
 	cmp	r0, #CLUSTER_UP			@ cluster already up?
 	bne	mcpm_setup			@ if not, set up the cluster
 
-	@ Otherwise, skip setup:
+	@ Otherwise, release the first man lock and skip setup:
+	mov	r0, r11
+	bl	vlock_unlock
 	b	mcpm_setup_complete
 
 mcpm_setup:
@@ -142,6 +154,19 @@ mcpm_setup_leave:
 	dsb
 	sev
 
+	mov	r0, r11
+	bl	vlock_unlock	@ implies DMB
+	b	mcpm_setup_complete
+
+	@ In the contended case, non-first men wait here for cluster setup
+	@ to complete:
+mcpm_setup_wait:
+	ldrb	r0, [r8, #MCPM_SYNC_CLUSTER_CLUSTER]
+	cmp	r0, #CLUSTER_UP
+	wfene
+	bne	mcpm_setup_wait
+	dmb
+
 mcpm_setup_complete:
 	@ If a platform-specific CPU setup hook is needed, it is
 	@ called from here.
@@ -173,11 +198,17 @@ mcpm_entry_gated:
 3:	.word	mcpm_entry_vectors - .
 	.word	mcpm_power_up_setup_phys - 3b
 	.word	mcpm_sync - 3b
+	.word	first_man_locks - 3b
 
 ENDPROC(mcpm_entry_point)
 
 	.bss
-	.align	5
+
+	.align	__CACHE_WRITEBACK_ORDER
+	.type	first_man_locks, #object
+first_man_locks:
+	.space	VLOCK_SIZE * MAX_NR_CLUSTERS
+	.align	__CACHE_WRITEBACK_ORDER
 
 	.type	mcpm_entry_vectors, #object
 ENTRY(mcpm_entry_vectors)
-- 
1.8.1.2
