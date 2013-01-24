From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 24 Jan 2013 01:27:49 -0500
Subject: [PATCH v2 06/16] ARM: bL_head.S: vlock-based first man election
In-Reply-To: <1359008879-9015-1-git-send-email-nicolas.pitre@linaro.org>
References: <1359008879-9015-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1359008879-9015-7-git-send-email-nicolas.pitre@linaro.org>
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
 arch/arm/common/Makefile  |  2 +-
 arch/arm/common/bL_head.S | 41 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 8025899a20..aa797237a7 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -13,4 +13,4 @@ obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
 obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
 obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
-obj-$(CONFIG_BIG_LITTLE)	+= bL_head.o bL_entry.o
+obj-$(CONFIG_BIG_LITTLE)	+= bL_head.o bL_entry.o vlock.o
diff --git a/arch/arm/common/bL_head.S b/arch/arm/common/bL_head.S
index a226cdf4ce..86bcc8a003 100644
--- a/arch/arm/common/bL_head.S
+++ b/arch/arm/common/bL_head.S
@@ -16,6 +16,8 @@
 #include <linux/linkage.h>
 #include <asm/bL_entry.h>
 
+#include "vlock.h"
+
 .if BL_SYNC_CLUSTER_CPUS
 .error "cpus must be the first member of struct bL_cluster_sync_struct"
 .endif
@@ -64,10 +66,11 @@ ENTRY(bL_entry_point)
 	 * position independent way.
 	 */
 	adr	r5, 3f
-	ldmia	r5, {r6, r7, r8}
+	ldmia	r5, {r6, r7, r8, r11}
 	add	r6, r5, r6			@ r6 = bL_entry_vectors
 	ldr	r7, [r5, r7]			@ r7 = bL_power_up_setup_phys
 	add	r8, r5, r8			@ r8 = bL_sync
+	add	r11, r5, r11			@ r11 = first_man_locks
 
 	mov	r0, #BL_SYNC_CLUSTER_SIZE
 	mla	r8, r0, r10, r8			@ r8 = bL_sync cluster base
@@ -81,13 +84,22 @@ ENTRY(bL_entry_point)
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
+	bne	cluster_setup_wait		@ wait for cluster setup if so
+
 	ldrb	r0, [r8, #BL_SYNC_CLUSTER_CLUSTER]
 	cmp	r0, #CLUSTER_UP			@ cluster already up?
 	bne	cluster_setup			@ if not, set up the cluster
 
-	@ Otherwise, skip setup:
+	@ Otherwise, release the first man lock and skip setup:
+	mov	r0, r11
+	bl	vlock_unlock
 	b	cluster_setup_complete
 
 cluster_setup:
@@ -137,6 +149,19 @@ cluster_setup_leave:
 	dsb
 	sev
 
+	mov	r0, r11
+	bl	vlock_unlock	@ implies DMB
+	b	cluster_setup_complete
+
+	@ In the contended case, non-first men wait here for cluster setup
+	@ to complete:
+cluster_setup_wait:
+	ldrb	r0, [r8, #BL_SYNC_CLUSTER_CLUSTER]
+	cmp	r0, #CLUSTER_UP
+	wfene
+	bne	cluster_setup_wait
+	dmb
+
 cluster_setup_complete:
 	@ If a platform-specific CPU setup hook is needed, it is
 	@ called from here.
@@ -168,11 +193,17 @@ bL_entry_gated:
 3:	.word	bL_entry_vectors - .
 	.word	bL_power_up_setup_phys - 3b
 	.word	bL_sync - 3b
+	.word	first_man_locks - 3b
 
 ENDPROC(bL_entry_point)
 
 	.bss
-	.align	5
+
+	.align	__CACHE_WRITEBACK_ORDER
+	.type	first_man_locks, #object
+first_man_locks:
+	.space	VLOCK_SIZE * BL_MAX_CLUSTERS
+	.align	__CACHE_WRITEBACK_ORDER
 
 	.type	bL_entry_vectors, #object
 ENTRY(bL_entry_vectors)
-- 
1.8.0
