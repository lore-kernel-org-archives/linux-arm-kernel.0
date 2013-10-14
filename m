From: zonque@gmail.com (Daniel Mack)
Date: Mon, 14 Oct 2013 15:44:22 +0200
Subject: [PATCH RFC 1/1] ARM: head-common.S: relocate atags area if necessary
In-Reply-To: <1381758262-31159-1-git-send-email-zonque@gmail.com>
References: <1381758262-31159-1-git-send-email-zonque@gmail.com>
Message-ID: <1381758262-31159-2-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the supplied atags/dtb pointer is located at memory inside the bss
section, it will be erased by __mmap_switched. The problem is that the
code that sets up the pointer can't know about a safe value unless it
examines the kernel's symbol tables, so we should care about that case
and relocate the area if necessary.

This patch does that from inside __vet_atags. In order to determine the
size of the section in dtb cases, it reads the next word after the dtb
binary magic, and also has to convert that value from big to CPU
endianess. For the atags case, a total size of up to 4k is assumed for
now.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/kernel/head-common.S | 58 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 47cd974..36f0e7e 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -36,12 +36,18 @@
  * that the pointer be aligned, in the first 16k of physical RAM and
  * that the ATAG_CORE marker is first and present.  If CONFIG_OF_FLATTREE
  * is selected, then it will also accept a dtb pointer.  Future revisions
- * of this function may be more lenient with the physical address and
- * may also be able to move the ATAGS block if necessary.
+ * of this function may be more lenient with the physical address.
+ *
+ * It is also checked whether the atags/dtb area is located before the
+ * end of the kernel's bss section and would hence be overridden by zeros
+ * later. In that case, the atags area is relocated to the '_end' symbol.
+ *
+ * r2 = atags or dtb
+ * r8 = phys_offset
  *
  * Returns:
  *  r2 either valid atags pointer, valid dtb pointer, or zero
- *  r5, r6 corrupted
+ *  r3, r5 - r7 corrupted
  */
 __vet_atags:
 	tst	r2, #0x3			@ aligned?
@@ -51,21 +57,61 @@ __vet_atags:
 #ifdef CONFIG_OF_FLATTREE
 	ldr	r6, =OF_DT_MAGIC		@ is it a DTB?
 	cmp	r5, r6
-	beq	2f
-#endif
-	cmp	r5, #ATAG_CORE_SIZE		@ is first tag ATAG_CORE?
+	bne	5f
+
+	ldreq	r5, [r2, #4]			@ fdt total size is at offset 4 ...
+#ifndef CONFIG_CPU_BIG_ENDIAN
+	eor	r6, r5, r5, ror #16		@ ... and stored in be32 order
+	mov	r6, r6, lsr #8
+	bic	r6, r6, #0xff00
+	eor	r5, r6, r5, ror #8
+#endif /* !CONFIG_CPU_BIG_ENDIAN */
+
+	add	r5, r5, #4			@ align the size to 32bit
+	bic	r5, r5, #3
+	b	4f
+#endif /* CONFIG_OF_FLATTREE */
+
+5:	cmp	r5, #ATAG_CORE_SIZE		@ is first tag ATAG_CORE?
 	cmpne	r5, #ATAG_CORE_SIZE_EMPTY
 	bne	1f
 	ldr	r5, [r2, #4]
 	ldr	r6, =ATAG_CORE
 	cmp	r5, r6
+	movne	r5, #4096			@ FIXME: we should walk the atags and
+						@ determine the real size.
 	bne	1f
 
+4:	adr	r3, 6f
+	ldmia	r3!, {r6, r7}
+
+	@ The kernel end address is stored in virtual address space, but we're
+	@ still in flat mapping. Hence, we have to do virt_to_phys() manually.
+	subs	r6, r6, r7			@ r7 = PAGE_OFFSET
+	add	r6, r6, r8			@ r8 = PHYS_OFFET
+
+	cmp	r2, r6				@ is the atags pointer inside the
+						@ kernel area?
+	bgt	2f
+
+	mov	r3, r6				@ relocate start
+	add	r6, r6, r5			@ relocate end
+3:	cmp	r3, r6
+	ldrne	fp, [r2], #4
+	strne	fp, [r3], #4
+	bne	3b
+
+	subs	r2, r6, r5			@ rewind back to the new
+						@ atags/dtb image start
+
 2:	mov	pc, lr				@ atag/dtb pointer is ok
 
 1:	mov	r2, #0
 	mov	pc, lr
 ENDPROC(__vet_atags)
+	.align
+6:	.long	_end				@ r6
+	.long	PAGE_OFFSET			@ r7
 
 /*
  * The following fragment of code is executed with the MMU on in MMU mode,
-- 
1.8.3.1
