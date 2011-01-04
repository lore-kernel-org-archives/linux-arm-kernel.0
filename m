From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Jan 2011 03:20:07 -0500
Subject: [PATCH 3/4] ARM: module support for CONFIG_ARM_PATCH_PHYS_VIRT
In-Reply-To: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
References: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
Message-ID: <1294129208-15201-4-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks to Russell King for his contribution to this patch.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/include/asm/memory.h |    4 ++++
 arch/arm/kernel/head.S        |   35 +++++++++++++++++++++++++++++------
 arch/arm/kernel/module.c      |   13 +++++++++++++
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index acc3126..f83be97 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -185,6 +185,10 @@ static inline unsigned long __phys_to_virt(unsigned long x)
 #undef PHYS_OFFSET
 #define PHYS_OFFSET		__virt_to_phys(PAGE_OFFSET)
 
+extern void fixup_pv_table(void *table_start, void *table_end, long v2p_offset);
+#define fixup_pv_table(start, end) \
+	fixup_pv_table(start, end, PHYS_OFFSET - PAGE_OFFSET)
+
 #else
 #define __virt_to_phys(x)	((x) - PAGE_OFFSET + PHYS_OFFSET)
 #define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index eaaf0ad..621c792 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -447,12 +447,22 @@ __fixup_pv_table:
 	adr	r0, 1f
 	ldmia	r0, {r3-r5}
 	sub	r3, r0, r3	@ PHYS_OFFSET - PAGE_OFFSET
+	add	r4, r4, r3
+	add	r5, r5, r3
 	mov	r6, r3, lsr #24	@ constant for add/sub instructions
 	teq	r3, r6, lsl #24 @ must be 16MiB aligned
 	bne	__error
+	b	__fixup_pv_table_loop
+ENDPROC(__fixup_phys_virt)
+
+1:	.word	.
+	.word	__pv_table_begin
+	.word	__pv_table_end
+
+	.pushsection .text
+
+ENTRY(__fixup_pv_table_loop)
 	orr	r6, r6, #0x400	@ mask in rotate right 8 bits
-	add	r4, r4, r3
-	add	r5, r5, r3
 2:	cmp	r4, r5
 	ldrlo	r7, [r4], #4
 	ldrlo	ip, [r7, r3]
@@ -461,11 +471,24 @@ __fixup_pv_table:
 	strlo	ip, [r7, r3]
 	blo	2b
 	mov	pc, lr
-ENDPROC(__fixup_phys_virt)
+ENDPROC(__fixup_phys_virt_loop)
+
+/*
+ * This is the C callable version used to fixup modules.
+ * void fixup_pv_table(void *table_start, void *table_end, long v2p_offset)
+ */
+ENTRY(fixup_pv_table)
+	stmfd	sp!, {r4 - r7, lr}
+	mov	r3, #0		@ offset (zero as we're in virtual space)
+	mov	r4, r0		@ loop start
+	mov	r5, r1		@ loop end
+	mov     r6, r2, lsr #24	@ constant for add/sub instructions		
+	bl      __fixup_pv_table_loop
+	ldmfd	sp!, {r4 - r7, pc}
+ENDPROC(fixup_pv_table)
+
+	.popsection
 
-1:	.word	.
-	.word	__pv_table_begin
-	.word	__pv_table_end
 #endif
 
 #include "head-common.S"
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index d9bd786..6fef8d2 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -329,6 +329,19 @@ int
 module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
 		struct module *module)
 {
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
+	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+        const Elf_Shdr *s;
+
+	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++)
+		if (!strcmp(".pv_table", secstrings + s->sh_name)) {
+			void *pv_table_begin = (void *)s->sh_addr;
+			void *pv_table_end = pv_table_begin + s->sh_size;
+			fixup_pv_table(pv_table_begin, pv_table_end);
+			break;
+		}
+#endif
+
 	register_unwind_tables(module);
 	return 0;
 }
-- 
1.7.3.2.193.g78bbb
