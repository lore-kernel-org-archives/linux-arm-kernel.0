From: eric.miao@canonical.com (Eric Miao)
Date: Sat, 6 Nov 2010 02:40:46 +0800
Subject: [RFC PATCH v3] ARM: Introduce patching of phys_to_virt and vice versa
Message-ID: <AANLkTikhcHTRYQki3cCYbWFY_POWX4E26Jau8nYpuDs0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since last version, fixup of the patching stub instructions is now
performed in assembly code before MMU is on, that means no flush cache is
necessary.

Found myself clumsy in handling assembly. The load of PHYS_OFFSET needs
to be handled differently if that's going to be made into a variable
though. This
is not verified to work, and just for overview, I'll have a bit time
for that the next
week.


commit 89609f0d15a582d393576438038234898e49820c
Author: Eric Miao <eric.miao@canonical.com>
Date:   Thu Aug 5 17:23:36 2010 +0800

    ARM: Introduce patching of phys_to_virt and vice versa

    In most cases, the delta between PHYS_OFFSET and PAGE_OFFSET is normally
    16MiB aligned, which means the difference can be handled by a simple ADD
    or SUB instruction with an immediate shift operand in ARM.  This will be
    a bit more efficient and generic when PHYS_OFFSET goes run-time.

    This idea can be made generic to allow conversions more than phys_to_virt
    and virt_to_phys. A stub instruction is inserted where applicable, and it
    has a form of 'add rn, rd, #imm', where the lowest 8-bit of #imm is used
    to identify the type of patching.  Currently, only two types are defined,
    but could be expanded in my POV to definitions like __io(), __mem_pci()
    and so on. A __patch_table section is introduced to include the addresses
    of all these stub instructions.

    There are several places for improvement:

    1. constant parameters which can be optimized by the compiler now needs
       one additional instruction (although the optimization is neither
       possible when PHYS_OFFSET goes as a variable)

    2. thumb2 can be supported in a same way, but will leave that for future
       enhancement.

    The general idea comes from Nicolas Pitre, and is drafted at
        https://wiki.ubuntu.com/Specs/ARMSingleKernel

    Signed-off-by: Nicolas Pitre <nicolas.pitre@canonical.com>
    Signed-off-by: Eric Miao <eric.miao@canonical.com>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b527bf5..fc9b96e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -187,6 +187,16 @@ config VECTORS_BASE
 	help
 	  The base address of exception vectors.

+config ARM_PATCH_PHYS_VIRT
+	bool
+	help
+	  Note this is only for non-XIP and non-Thumb2 kernels. And there
+	  is CPU support which needs to read data in order to writeback
+	  dirty entries in the cache. (e.g. StrongARM, ebsa110, footbridge,
+	  rpc, sa1100, and shark). The mappings in the above cases do not
+	  exist before paging_init() has completed. Thus this option does
+	  not support these CPUs at this moment.
+
 source "init/Kconfig"

 source "kernel/Kconfig.freezer"
@@ -590,6 +600,7 @@ config ARCH_PXA
 	select TICK_ONESHOT
 	select PLAT_PXA
 	select SPARSE_IRQ
+	select ARM_PATCH_PHYS_VIRT
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 23c2e8e..4b8b8da 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -154,6 +154,11 @@
 #define page_to_phys(page)	(__pfn_to_phys(page_to_pfn(page)))
 #define phys_to_page(phys)	(pfn_to_page(__phys_to_pfn(phys)))

+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
+#define PATCH_TYPE_PHYS_TO_VIRT		(0)
+#define PATCH_TYPE_VIRT_TO_PHYS		(1)
+#endif
+
 #ifndef __ASSEMBLY__

 /*
@@ -182,6 +187,34 @@
  */
 #define PHYS_PFN_OFFSET	(PHYS_OFFSET >> PAGE_SHIFT)

+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
+
+#define __patch_stub(from,to,type)			\
+	__asm__(					\
+	"1:	add	%0, %1, %2\n"			\
+	"\n"						\
+	"	.pushsection __patch_table,\"a\"\n"	\
+	"	.long	1b\n"				\
+	"	.popsection\n"				\
+	: "=r" (to)					\
+	: "r" (from), "I" (type))
+
+static inline unsigned long virt_to_phys(void *x)
+{
+	unsigned long t;
+
+	__patch_stub(x, t, PATCH_TYPE_VIRT_TO_PHYS);
+	return t;
+}
+
+static inline void *phys_to_virt(unsigned long x)
+{
+	void *t;
+
+	__patch_stub(x, t, PATCH_TYPE_PHYS_TO_VIRT);
+	return t;
+}
+#else
 /*
  * These are *only* valid on the kernel direct mapped RAM memory.
  * Note: Drivers should NOT use these.  They are the wrong
@@ -197,6 +230,7 @@ static inline void *phys_to_virt(unsigned long x)
 {
 	return (void *)(__phys_to_virt((unsigned long)(x)));
 }
+#endif

 /*
  * Drivers should NOT use these either.
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index dd6b369..973efcc 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -426,4 +426,67 @@ smp_on_up:

 #endif

+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
+
+#define PATCH_INSTR_ADD		(0x00800000)
+#define PATCH_INSTR_SUB		(0x00400000)
+
+/* __fixup_phys_virt - patch the stub instructions with the delta between
+ * PHYS_OFFSET and PAGE_OFFSET, which is assumed to be 16MiB aligned and
+ * can be expressed by an immediate shifter operand. The stub instruction
+ * has a form of 'add rd, rn, #imm', where the lowest 8-bit of #imm is
+ * used to identify the type of patching.
+ */
+__fixup_phys_virt:
+ 	/*
+	 * r0 - PHYS_OFFSET
+	 * r6 - bits to set in phys_to_virt stub instructions
+	 * r7 - bits to set in virt_to_phys stub instructions
+	 */
+	ldr	r0, =PHYS_OFFSET
+	cmp	r0, #PAGE_OFFSET
+	subhi	r1, r0, #PAGE_OFFSET
+	rsbls	r1, r0, #PAGE_OFFSET
+	lsr	r1, r1, #24
+	orr	r1, r1, #0x400
+	orrhi	r6, r1, #PATCH_INSTR_SUB
+	orrhi	r7, r1, #PATCH_INSTR_ADD
+	orrls	r6, r1, #PATCH_INSTR_ADD
+	orrls	r7, r1, #PATCH_INSTR_SUB
+
+	/* r0 - instruction to patch
+	 * r1 - address offset
+	 * r2 - index into __patch_table
+	 * r3 - __patch_table_end
+	 */
+	adr	r0, 1f
+	ldmia	r0, {r1, r2, r3}
+	sub	r1, r0, r1
+	add	r2, r2, r1
+	add	r3, r3, r1
+	cmp	r2, r3
+	bhs	3f
+2:	ldr	ip, [r2]
+	add	r2, r2, #4
+	ldr	r0, [ip, r1]
+	and	r9, r0, #0x000000ff		@ to decide the patch type
+	bic	r0, r0, #0x00e00000
+	bic	r0, r0, #0x00000fc0
+	bic	r0, r0, #0x0000003f
+	cmp	r9, #PATCH_TYPE_PHYS_TO_VIRT
+	orreq	r0, r0, r6
+	cmp	r9, #PATCH_TYPE_VIRT_TO_PHYS
+	orreq	r0, r0, r7
+	str	r0, [ip, r1]
+	cmp	r2, r3
+	blo	2b
+3:
+	mov	pc, lr
+ENDPROC(__fixup_phys_virt)
+
+1:	.word	.
+	.word	__patch_table_begin
+	.word	__patch_table_end
+#endif
+
 #include "head-common.S"
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 1953e3d..c221b61 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -57,6 +57,10 @@ SECTIONS
 		__smpalt_end = .;
 #endif

+		__patch_table_begin = .;
+			*(__patch_table)
+		__patch_table_end = .;
+
 		INIT_SETUP(16)

 		INIT_CALLS
