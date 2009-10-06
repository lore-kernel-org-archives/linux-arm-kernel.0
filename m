From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 06 Oct 2009 17:58:51 +0100
Subject: [PATCH] Thumb-2: Correct "mov.w pc,
	lr" instruction which is unpredictable
Message-ID: <20091006165850.6368.17770.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32-bit wide variant of "mov pc, reg" in Thumb-2 is unpredictable
causing improper handling of the undefined instructions not caught by
the kernel. This patch adds a movw_pc macro for such situations
(currently only used in call_fpe).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/kernel/entry-armv.S   |   28 ++++++++++++++--------------
 arch/arm/kernel/entry-header.S |   15 +++++++++++++++
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 322410b..0022b4d 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -608,33 +608,33 @@ call_fpe:
  THUMB(	add	pc, r8			)
 	nop
 
-	W(mov)	pc, lr				@ CP#0
+	movw_pc	lr				@ CP#0
 	W(b)	do_fpe				@ CP#1 (FPE)
 	W(b)	do_fpe				@ CP#2 (FPE)
-	W(mov)	pc, lr				@ CP#3
+	movw_pc	lr				@ CP#3
 #ifdef CONFIG_CRUNCH
 	b	crunch_task_enable		@ CP#4 (MaverickCrunch)
 	b	crunch_task_enable		@ CP#5 (MaverickCrunch)
 	b	crunch_task_enable		@ CP#6 (MaverickCrunch)
 #else
-	W(mov)	pc, lr				@ CP#4
-	W(mov)	pc, lr				@ CP#5
-	W(mov)	pc, lr				@ CP#6
+	movw_pc	lr				@ CP#4
+	movw_pc	lr				@ CP#5
+	movw_pc	lr				@ CP#6
 #endif
-	W(mov)	pc, lr				@ CP#7
-	W(mov)	pc, lr				@ CP#8
-	W(mov)	pc, lr				@ CP#9
+	movw_pc	lr				@ CP#7
+	movw_pc	lr				@ CP#8
+	movw_pc	lr				@ CP#9
 #ifdef CONFIG_VFP
 	W(b)	do_vfp				@ CP#10 (VFP)
 	W(b)	do_vfp				@ CP#11 (VFP)
 #else
-	W(mov)	pc, lr				@ CP#10 (VFP)
-	W(mov)	pc, lr				@ CP#11 (VFP)
+	movw_pc	lr				@ CP#10 (VFP)
+	movw_pc	lr				@ CP#11 (VFP)
 #endif
-	W(mov)	pc, lr				@ CP#12
-	W(mov)	pc, lr				@ CP#13
-	W(mov)	pc, lr				@ CP#14 (Debug)
-	W(mov)	pc, lr				@ CP#15 (Control)
+	movw_pc	lr				@ CP#12
+	movw_pc	lr				@ CP#13
+	movw_pc	lr				@ CP#14 (Debug)
+	movw_pc	lr				@ CP#15 (Control)
 
 #ifdef CONFIG_NEON
 	.align	6
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index ac34c0d..7e9ed1e 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -110,6 +110,13 @@
 	mov	\rd, sp, lsr #13
 	mov	\rd, \rd, lsl #13
 	.endm
+
+	@
+	@ 32-bit wide "mov pc, reg"
+	@
+	.macro	movw_pc, reg
+	mov	pc, \reg
+	.endm
 #else	/* CONFIG_THUMB2_KERNEL */
 	.macro	svc_exit, rpsr
 	clrex					@ clear the exclusive monitor
@@ -146,6 +153,14 @@
 	lsr	\rd, \rd, #13
 	mov	\rd, \rd, lsl #13
 	.endm
+
+	@
+	@ 32-bit wide "mov pc, reg"
+	@
+	.macro	movw_pc, reg
+	mov	pc, \reg
+	nop
+	.endm
 #endif	/* !CONFIG_THUMB2_KERNEL */
 
 /*
