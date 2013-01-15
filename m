From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 15 Jan 2013 16:48:17 +0000
Subject: [RFC PATCH 3/4] ARM: bL_entry: Match memory barriers to architectural
 requirements
In-Reply-To: <1358268498-8086-1-git-send-email-dave.martin@linaro.org>
References: <1358268498-8086-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1358268498-8086-4-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For architectural correctness even Strongly-Ordered memory accesses
require barriers in order to guarantee that multiple CPUs have a
coherent view of the ordering of memory accesses.

Virtually everything done by this early code is done via explicit
memory access only, so DSBs are seldom required.  Existing barriers
are demoted to DMB, except where a DSB is needed to synchronise
non-memory signalling (i.e., before a SEV).  If a particular
platform performs cache maintenance in its power_up_setup function,
it should force it to complete explicitly including a DSB, instead
of relying on the bL_head framework code to do it.

Some additional DMBs are added to ensure all the memory ordering
properties required by the race avoidance algorithm.  DMBs are also
moved out of loops, and for clarity some are moved so that most
directly follow the memory operation which needs to be
synchronised.

The setting of a CPU's bL_entry_vectors[] entry is also required to
act as a synchronisation point, so a DMB is added after checking
that entry to ensure that other CPUs do not observe gated
operations leaking across the opening of the gate.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/common/bL_head.S |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/common/bL_head.S b/arch/arm/common/bL_head.S
index fd71ff6..a4a20e5 100644
--- a/arch/arm/common/bL_head.S
+++ b/arch/arm/common/bL_head.S
@@ -87,8 +87,7 @@ ENTRY(bL_entry_point)
 	mov	r5, #BL_SYNC_CPU_SIZE
 	mla	r5, r9, r5, r8			@ r5 = bL_sync cpu address
 	strb	r0, [r5]
-
-	dsb
+	dmb
 
 	@ At this point, the cluster cannot unexpectedly enter the GOING_DOWN
 	@ state, because there is at least one active CPU (this CPU).
@@ -97,7 +96,7 @@ ENTRY(bL_entry_point)
 	mla	r11, r0, r10, r11		@ r11 = cluster first man lock
 	mov	r0, r11
 	mov	r1, r9				@ cpu
-	bl	vlock_trylock
+	bl	vlock_trylock			@ implies DSB
 
 	cmp	r0, #0				@ failed to get the lock?
 	bne	cluster_setup_wait		@ wait for cluster setup if so
@@ -115,11 +114,12 @@ cluster_setup:
 	@ Wait for any previously-pending cluster teardown operations to abort
 	@ or complete:
 
-	dsb
-	ldrb	r0, [r8, #BL_SYNC_CLUSTER_CLUSTER]
+	dmb
+0:	ldrb	r0, [r8, #BL_SYNC_CLUSTER_CLUSTER]
 	cmp	r0, #CLUSTER_GOING_DOWN
 	wfeeq
-	beq	cluster_setup
+	beq	0b
+	dmb
 
 	@ If the outbound gave up before teardown started, skip cluster setup:
 
@@ -131,8 +131,8 @@ cluster_setup:
 	cmp	r7, #0
 	mov	r0, #1		@ second (cluster) affinity level
 	blxne	r7		@ Call power_up_setup if defined
+	dmb
 
-	dsb
 	mov	r0, #CLUSTER_UP
 	strb	r0, [r8, #BL_SYNC_CLUSTER_CLUSTER]
 	dsb
@@ -146,11 +146,11 @@ cluster_setup_leave:
 	@ In the contended case, non-first men wait here for cluster setup
 	@ to complete:
 cluster_setup_wait:
-	dsb
 	ldrb	r0, [r8, #BL_SYNC_CLUSTER_CLUSTER]
 	cmp	r0, #CLUSTER_UP
 	wfene
 	bne	cluster_setup_wait
+	dmb
 
 cluster_setup_complete:
 	@ If a platform-specific CPU setup hook is needed, it is
@@ -162,13 +162,14 @@ cluster_setup_complete:
 
 	@ Mark the CPU as up:
 
-	dsb
+	dmb
 	mov	r0, #CPU_UP
 	strb	r0, [r5]
+	dmb
 
 bL_entry_gated:
-	dsb
 	ldr	r5, [r6, r4, lsl #2]		@ r5 = CPU entry vector
+	dmb
 	cmp	r5, #0
 	wfeeq
 	beq	bL_entry_gated
-- 
1.7.4.1
