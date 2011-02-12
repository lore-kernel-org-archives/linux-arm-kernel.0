From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 12 Feb 2011 13:33:42 -0500 (EST)
Subject: [PATCH 2/2] P2V: Thumb2 support
Message-ID: <alpine.LFD.2.00.1102121331220.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

Adding Thumb2 support to the runtime patching of the virt_to_phys and
phys_to_virt opcodes.

Tested both the 8-bit and the 16-bit fixups, using different placements
in memory to exercize all code paths.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig       |    4 ++--
 arch/arm/kernel/head.S |   48 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d5eb308..8d5643d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -194,13 +194,13 @@ config VECTORS_BASE
 config ARM_PATCH_PHYS_VIRT
 	bool "Patch physical to virtual translations at runtime (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
-	depends on !XIP_KERNEL && !THUMB2_KERNEL && MMU
+	depends on !XIP_KERNEL && MMU
 	depends on !ARCH_REALVIEW || !SPARSEMEM
 	help
 	  Patch phys-to-virt translation functions at runtime according to
 	  the position of the kernel in system memory.
 
-	  This can only be used with non-XIP, non-Thumb2, MMU kernels where
+	  This can only be used with non-XIP with MMU kernels where
 	  the base of physical memory is at a 16MB boundary.
 
 config ARM_PATCH_PHYS_VIRT_16BIT
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 8f96ca0..575bb3e 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -475,7 +475,8 @@ __fixup_pv_table:
 	sub	r3, r0, r3	@ PHYS_OFFSET - PAGE_OFFSET
 	add	r4, r4, r3	@ adjust table start address
 	add	r5, r5, r3	@ adjust table end address
-	str	r8, [r7, r3]!	@ save computed PHYS_OFFSET to __pv_phys_offset
+	add	r7, r7, r3	@ adjust __pv_phys_offset address
+	str	r8, [r7]	@ save computed PHYS_OFFSET to __pv_phys_offset
 #ifndef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
 	mov	r6, r3, lsr #24	@ constant for add/sub instructions
 	teq	r3, r6, lsl #24 @ must be 16MiB aligned
@@ -483,6 +484,7 @@ __fixup_pv_table:
 	mov	r6, r3, lsr #16	@ constant for add/sub instructions
 	teq	r3, r6, lsl #16	@ must be 64kiB aligned
 #endif
+THUMB(	it	ne		@ cross section branch )
 	bne	__error
 	str	r6, [r7, #4]	@ save to __pv_offset
 	b	__fixup_a_pv_table
@@ -496,6 +498,49 @@ ENDPROC(__fixup_pv_table)
 
 	.text
 __fixup_a_pv_table:
+#ifdef CONFIG_THUMB2_KERNEL
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
+	lsls	r0, r6, #24
+	lsr	r6, #8
+	beq	1f
+	clz	r7, r0
+	lsrs	r0, #24
+	lsls	r0, r7
+	bic	r0, 0x0080
+	lsrs	r7, #1
+	orrcs   r0, #0x0080
+	orr	r0, r0, r7, lsl #12
+#endif
+1:	lsls	r6, #24
+	beq	4f
+	clz	r7, r6
+	lsrs	r6, #24
+	lsls	r6, r7
+	bic	r6, #0x0080
+	lsrs	r7, #1
+	orrcs	r6, #0x0080
+	orr	r6, r6, r7, lsl #12
+	orr	r6, #0x4000
+	b	4f
+2:	add     r7, r3
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
+	ldrh	ip, [r7]
+	tst	ip, 0x0400	@ the i bit tells us LS or MS byte
+	beq	3f
+	cmp	r0, #0		@ set C flag, and ...
+	biceq	ip, 0x0400	@ immediate zero value has a special encoding
+	streqh	ip, [r7]	@ that requires the i bit cleared
+#endif
+3:	ldrh	ip, [r7, #2]
+	and	ip, 0x8f00
+	orrcc	ip, r6	@ mask in offset bits 31-24
+	orrcs	ip, r0	@ mask in offset bits 23-16
+	strh	ip, [r7, #2]
+4:	cmp	r4, r5
+        ldrcc   r7, [r4], #4	@ use branch for delay slot
+        bcc	2b
+        bx	lr
+#else
 #ifdef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
 	and	r0, r6, #255	@ offset bits 23-16
 	mov	r6, r6, lsr #8	@ offset bits 31-24
@@ -513,6 +558,7 @@ __fixup_a_pv_table:
 	ldrcc	r7, [r4], #4	@ use branch for delay slot
 	bcc	2b
 	mov	pc, lr
+#endif
 ENDPROC(__fixup_a_pv_table)
 
 ENTRY(fixup_pv_table)
-- 
1.7.4
