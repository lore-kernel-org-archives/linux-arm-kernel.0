From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Nov 2010 16:45:08 +0000
Subject: [RFC PATCH v3] ARM: Introduce patching of phys_to_virt and
	vice versa
In-Reply-To: <20101108114948.GC14138@n2100.arm.linux.org.uk>
References: <AANLkTikhcHTRYQki3cCYbWFY_POWX4E26Jau8nYpuDs0@mail.gmail.com>
	<20101108114948.GC14138@n2100.arm.linux.org.uk>
Message-ID: <20101110164508.GB27571@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 08, 2010 at 11:49:48AM +0000, Russell King - ARM Linux wrote:
> Also note that r1 here is (PHYS_OFFSET - PAGE_OFFSET) - r0 was the physical
> address of '1f', and the loaded value of r1 is the virtual address of '1f'.
> 
> So, I think the above code can be replaced by:
> 
> 	adr	r0, 1f
> 	ldmia	r0, {r1-r3}
> 	sub	r1, r0, r1
> 	mov	r4, r1, lsr #24
> 	orr	r4, r4, #0x0400
> 	orr	r6, r4, #PATCH_INSTR_SUB
> 	orr	r7, r4, #PATCH_INSTR_ADD
> 	teq	r1, r4, lsl #24
> 	bne	error
> 
> noting that:
> 
> 	add	rd, rn, #PAGE_OFFSET - PHYS_OFFSET
> 	sub	rd, rn, #PHYS_OFFSET - PAGE_OFFSET
> 
> are equivalent.
> 
> We can do better than this - just make sure that all virt_to_phys() are an
> add instruction, and all phys_to_virt() are a sub struction.  Then we only
> need to fixup the constant.  IOW, virt_to_phys() is:
> 
> 	add	rd, rn, #PHYS_OFFSET - PAGE_OFFSET
> 
> and phys_to_virt() is:
> 
> 	sub	rd, rn, #PHYS_OFFSET - PAGE_OFFSET

Here's something which uses the above ideas (untested).  I think this is
something we can (and should) do unconditionally for the !XIP cases.  We
also need to fixup modules in a similar manner, so we want to place the
__fixup_pv_table function in the .text, and give it a wrapper along the
lines of:

fixup_pv_table:
	stmfd	sp!, {r4 - r7, lr}
	mov	r3, #0		@ offset (zero as we're in virtual space)
	mov	r4, r0		@ loop start
	mov	r5, r1		@ loop end
	orr	r6, r2, #0x400	@ mask in rotate right 8 bits
	bl	2		@ branch to __fixup_pv_table loop
	ldmfd	sp!, {r4 - r7, pc}

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8ae3d48..b6b6dcf 100644
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
index 23c2e8e..3c1d3e3 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -182,6 +182,34 @@
  */
 #define PHYS_PFN_OFFSET	(PHYS_OFFSET >> PAGE_SHIFT)
 
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
+
+#define __pv_stub(from,to,instr)			\
+	__asm__(					\
+	"1:	" instr "	%0, %1, %2\n"		\
+	"\n"						\
+	"	.pushsection .pv_table,\"a\"\n"		\
+	"	.long	1b\n"				\
+	"	.popsection\n"				\
+	: "=r" (to)					\
+	: "r" (from), "I" (1))
+
+static inline unsigned long virt_to_phys(void *x)
+{
+	unsigned long t;
+
+	__pv_stub(x, t, "add");
+	return t;
+}
+
+static inline void *phys_to_virt(unsigned long x)
+{
+	void *t;
+
+	__pv_stub(x, t, "sub");
+	return t;
+}
+#else
 /*
  * These are *only* valid on the kernel direct mapped RAM memory.
  * Note: Drivers should NOT use these.  They are the wrong
@@ -197,6 +225,7 @@ static inline void *phys_to_virt(unsigned long x)
 {
 	return (void *)(__phys_to_virt((unsigned long)(x)));
 }
+#endif
 
 /*
  * Drivers should NOT use these either.
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index dd6b369..bcc502f 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -93,6 +93,9 @@ ENTRY(stext)
 #ifdef CONFIG_SMP_ON_UP
 	bl	__fixup_smp
 #endif
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
+	bl	__fixup_pv_table
+#endif
 	bl	__create_page_tables
 
 	/*
@@ -426,4 +429,37 @@ smp_on_up:
 
 #endif
 
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
+
+/* __fixup_pv_table - patch the stub instructions with the delta between
+ * PHYS_OFFSET and PAGE_OFFSET, which is assumed to be 16MiB aligned and
+ * can be expressed by an immediate shifter operand. The stub instruction
+ * has a form of '(add|sub) rd, rn, #imm'.
+ */
+__fixup_pv_table:
+	adr	r0, 1f
+	ldmia	r0, {r3-r5}
+	sub	r3, r0, r3	@ PHYS_OFFSET - PAGE_OFFSET
+	mov	r6, r3, lsr #24	@ constant for add/sub instructions
+	teq	r3, r6, lsl #24 @ must be 16MiB aligned
+	bne	__error
+	orr	r6, r6, #0x400	@ mask in rotate right 8 bits
+	add	r4, r4, r3
+	add	r5, r5, r3
+2:	cmp	r4, r5
+	ldrlo	r7, [r4], #4
+	ldrlo	ip, [r7, r3]
+	bic	ip, ip, #0x000000ff
+	bic	ip, ip, #0x00000f00
+	orr	ip, ip, r6
+	strlo	ip, [r7, r3]
+	blo	2b
+	mov	pc, lr
+ENDPROC(__fixup_phys_virt)
+
+1:	.word	.
+	.word	__pv_table_begin
+	.word	__pv_table_end
+#endif
+
 #include "head-common.S"
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index cead889..fb32c9d 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -57,6 +57,10 @@ SECTIONS
 		__smpalt_end = .;
 #endif
 
+		__pv_table_begin = .;
+			*(.pv_table)
+		__pv_table_end = .;
+
 		INIT_SETUP(16)
 
 		INIT_CALLS
