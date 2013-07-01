From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon,  1 Jul 2013 12:04:00 +0100
Subject: [PATCH 02/10] ARM: asm: Add ARM_BE8() assembly helper
In-Reply-To: <1372676648-9254-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1372676648-9254-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1372676648-9254-3-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARM_BE8() helper to wrap any code conditional on being
compile when CONFIG_ARM_ENDIAN_BE8 is selected and convert
existing places where this is to use it.

Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/compressed/head.S  |    8 ++------
 arch/arm/include/asm/assembler.h |    7 +++++++
 arch/arm/kernel/entry-armv.S     |    5 ++---
 arch/arm/kernel/entry-common.S   |    4 +---
 arch/arm/mm/abort-ev6.S          |    5 ++---
 arch/arm/mm/proc-v6.S            |    4 +---
 arch/arm/mm/proc-v7.S            |    4 +---
 7 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 032a8d9..4eb8364 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -679,9 +679,7 @@ __armv4_mmu_cache_on:
 		mrc	p15, 0, r0, c1, c0, 0	@ read control reg
 		orr	r0, r0, #0x5000		@ I-cache enable, RR cache replacement
 		orr	r0, r0, #0x0030
-#ifdef CONFIG_CPU_ENDIAN_BE8
-		orr	r0, r0, #1 << 25	@ big-endian page tables
-#endif
+ ARM_BE8(	orr	r0, r0, #1 << 25 )	@ big-endian page tables
 		bl	__common_mmu_cache_on
 		mov	r0, #0
 		mcr	p15, 0, r0, c8, c7, 0	@ flush I,D TLBs
@@ -708,9 +706,7 @@ __armv7_mmu_cache_on:
 		orr	r0, r0, #1 << 22	@ U (v6 unaligned access model)
 						@ (needed for ARM1176)
 #ifdef CONFIG_MMU
-#ifdef CONFIG_CPU_ENDIAN_BE8
-		orr	r0, r0, #1 << 25	@ big-endian page tables
-#endif
+ ARM_BE8(	orr	r0, r0, #1 << 25 )	@ big-endian page tables
 		mrcne   p15, 0, r6, c2, c0, 2   @ read ttb control reg
 		orrne	r0, r0, #1		@ MMU enabled
 		movne	r1, #0xfffffffd		@ domain 0 = client
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 05ee9ee..e780afb 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -53,6 +53,13 @@
 #define put_byte_3      lsl #0
 #endif
 
+/* Select code for any configuration running in BE8 mode */
+#ifdef CONFIG_CPU_ENDIAN_BE8
+#define ARM_BE8(code...) code
+#else
+#define ARM_BE8(code...)
+#endif
+
 /*
  * Data preload for architectures that support it
  */
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 582b405..09130e2 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -415,9 +415,8 @@ __und_usr:
 	bne	__und_usr_thumb
 	sub	r4, r2, #4			@ ARM instr@LR - 4
 1:	ldrt	r0, [r4]
-#ifdef CONFIG_CPU_ENDIAN_BE8
-	rev	r0, r0				@ little endian instruction
-#endif
+ ARM_BE8(rev	r0, r0)				@ little endian instruction
+
 	@ r0 = 32-bit ARM instruction which caused the exception
 	@ r2 = PC value for the following instruction (:= regs->ARM_pc)
 	@ r4 = PC value for the faulting instruction
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index bc5bc0a..8c79344 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -379,9 +379,7 @@ ENTRY(vector_swi)
 #else
 	ldr	r10, [lr, #-4]			@ get SWI instruction
 #endif
-#ifdef CONFIG_CPU_ENDIAN_BE8
-	rev	r10, r10			@ little endian instruction
-#endif
+ ARM_BE8(rev	r10, r10)			@ little endian instruction
 
 #elif defined(CONFIG_AEABI)
 
diff --git a/arch/arm/mm/abort-ev6.S b/arch/arm/mm/abort-ev6.S
index 8074199..3815a82 100644
--- a/arch/arm/mm/abort-ev6.S
+++ b/arch/arm/mm/abort-ev6.S
@@ -38,9 +38,8 @@ ENTRY(v6_early_abort)
 	bne	do_DataAbort
 	bic	r1, r1, #1 << 11		@ clear bit 11 of FSR
 	ldr	r3, [r4]			@ read aborted ARM instruction
-#ifdef CONFIG_CPU_ENDIAN_BE8
-	rev	r3, r3
-#endif
+ ARM_BE8(rev	r3, r3)
+
 	do_ldrd_abort tmp=ip, insn=r3
 	tst	r3, #1 << 20			@ L = 0 -> write
 	orreq	r1, r1, #1 << 11		@ yes.
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 919405e..f2e43e8 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -218,9 +218,7 @@ __v6_setup:
 #endif /* CONFIG_MMU */
 	adr	r5, v6_crval
 	ldmia	r5, {r5, r6}
-#ifdef CONFIG_CPU_ENDIAN_BE8
-	orr	r6, r6, #1 << 25		@ big-endian page tables
-#endif
+ ARM_BE8(orr	r6, r6, #1 << 25)		@ big-endian page tables
 	mrc	p15, 0, r0, c1, c0, 0		@ read control register
 	bic	r0, r0, r5			@ clear bits them
 	orr	r0, r0, r6			@ set them
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index e35fec3..8338ba4 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -351,9 +351,7 @@ __v7_setup:
 #endif
 	adr	r5, v7_crval
 	ldmia	r5, {r5, r6}
-#ifdef CONFIG_CPU_ENDIAN_BE8
-	orr	r6, r6, #1 << 25		@ big-endian page tables
-#endif
+ ARM_BE8(orr	r6, r6, #1 << 25)		@ big-endian page tables
 #ifdef CONFIG_SWP_EMULATE
 	orr     r5, r5, #(1 << 10)              @ set SW bit in "clear"
 	bic     r6, r6, #(1 << 10)              @ clear it in "mmuset"
-- 
1.7.10.4
