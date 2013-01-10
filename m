From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 09 Jan 2013 19:20:40 -0500
Subject: [PATCH 05/16] ARM: bL_head: vlock-based first man election
In-Reply-To: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1357777251-13541-6-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@linaro.org>

Instead of requiring the first man to be elected in advance (which
can be suboptimal in some situations), this patch uses a per-
cluster mutex to co-ordinate selection of the first man.

This should also make it more feasible to reuse this code path for
asynchronous cluster resume (as in CPUidle scenarios).

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/common/Makefile  |  2 +-
 arch/arm/common/bL_head.S | 91 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 80 insertions(+), 13 deletions(-)

diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 50880c494f..894c2ddf9b 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -15,4 +15,4 @@ obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
 obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
 obj-$(CONFIG_FIQ_GLUE)		+= fiq_glue.o fiq_glue_setup.o
 obj-$(CONFIG_FIQ_DEBUGGER)	+= fiq_debugger.o
-obj-$(CONFIG_BIG_LITTLE)	+= bL_head.o bL_entry.o
+obj-$(CONFIG_BIG_LITTLE)	+= bL_head.o bL_entry.o vlock.o
diff --git a/arch/arm/common/bL_head.S b/arch/arm/common/bL_head.S
index f7a64ac127..e70dd432e8 100644
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
@@ -83,11 +86,25 @@ ENTRY(bL_entry_point)
 	@ At this point, the cluster cannot unexpectedly enter the GOING_DOWN
 	@ state, because there is at least one active CPU (this CPU).
 
-	@ Check if the cluster has been set up yet:
+	mov	r0, #.Lvlock_size
+	mla	r11, r0, r10, r11		@ r11 = cluster first man lock
+	mov	r0, r11
+	mov	r1, r9				@ cpu
+	bl	vlock_trylock
+
+	cmp	r0, #0				@ failed to get the lock?
+	bne	cluster_setup_wait		@ wait for cluster setup if so
+
 	ldrb	r0, [r8, #BL_SYNC_CLUSTER_CLUSTER]
-	cmp	r0, #CLUSTER_UP
-	beq	cluster_already_up
+	cmp	r0, #CLUSTER_UP			@ cluster already up?
+	bne	cluster_setup			@ if not, set up the cluster
+
+	@ Otherwise, release the first man lock and skip setup:
+	mov	r0, r11
+	bl	vlock_unlock
+	b	cluster_setup_complete
 
+cluster_setup:
 	@ Signal that the cluster is being brought up:
 	mov	r0, #INBOUND_COMING_UP
 	strb	r0, [r8, #BL_SYNC_CLUSTER_INBOUND]
@@ -102,26 +119,47 @@ ENTRY(bL_entry_point)
 cluster_teardown_wait:
 	ldrb	r0, [r8, #BL_SYNC_CLUSTER_CLUSTER]
 	cmp	r0, #CLUSTER_GOING_DOWN
-	wfeeq
-	beq	cluster_teardown_wait
+	bne	first_man_setup
+	wfe
+	b	cluster_teardown_wait
+
+first_man_setup:
+	@ If the outbound gave up before teardown started, skip cluster setup:
 
-	@ power_up_setup is responsible for setting up the cluster:
+	cmp	r0, #CLUSTER_UP
+	beq	cluster_setup_leave
+
+	@ power_up_setup is now responsible for setting up the cluster:
 
 	cmp	r7, #0
 	mov	r0, #1		@ second (cluster) affinity level
 	blxne	r7		@ Call power_up_setup if defined
 
+	dsb
+	mov	r0, #CLUSTER_UP
+	strb	r0, [r8, #BL_SYNC_CLUSTER_CLUSTER]
+
+cluster_setup_leave:
 	@ Leave the cluster setup critical section:
 
-	dsb
 	mov	r0, #INBOUND_NOT_COMING_UP
 	strb	r0, [r8, #BL_SYNC_CLUSTER_INBOUND]
-	mov	r0, #CLUSTER_UP
-	strb	r0, [r8, #BL_SYNC_CLUSTER_CLUSTER]
 	dsb
 	sev
 
-cluster_already_up:
+	mov	r0, r11
+	bl	vlock_unlock
+	b	cluster_setup_complete
+
+	@ In the contended case, non-first men wait here for cluster setup
+	@ to complete:
+cluster_setup_wait:
+	ldrb	r0, [r8, #BL_SYNC_CLUSTER_CLUSTER]
+	cmp	r0, #CLUSTER_UP
+	wfene
+	bne	cluster_setup_wait
+
+cluster_setup_complete:
 	@ If a platform-specific CPU setup hook is needed, it is
 	@ called from here.
 
@@ -150,11 +188,40 @@ bL_entry_gated:
 3:	.word	bL_entry_vectors - .
 	.word	bL_power_up_setup_phys - 3b
 	.word	bL_sync - 3b
+	.word	first_man_locks - 3b
 
 ENDPROC(bL_entry_point)
 
 	.bss
-	.align	5
+
+	@ Magic to size and align the first-man vlock structures
+	@ so that each does not cross a 1KB boundary.
+	@ We also must ensure that none of these shares a cacheline with
+	@ any data which might be accessed through the cache.
+
+	.equ	.Log2, 0
+	.rept	11
+		.if (1 << .Log2) < VLOCK_SIZE
+			.equ .Log2, .Log2 + 1
+		.endif
+	.endr
+	.if	.Log2 > 10
+		.error "vlock struct is too large for guaranteed barrierless access ordering"
+	.endif
+	.equ	.Lvlock_size, 1 << .Log2
+
+	@ The presence of two .align directives here is deliberate: we must
+	@ align to whichever of the two boundaries is larger:
+	.align	__CACHE_WRITEBACK_ORDER
+	.align	.Log2
+first_man_locks:
+	.rept	BL_NR_CLUSTERS
+	.space	.Lvlock_size
+	.endr
+	.size	first_man_locks, . - first_man_locks
+	.type	first_man_locks, #object
+
+	.align	__CACHE_WRITEBACK_ORDER
 
 	.type	bL_entry_vectors, #object
 ENTRY(bL_entry_vectors)
-- 
1.8.0
