From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Nov 2010 17:55:49 +0000
Subject: [RFC PATCH v3] ARM: Introduce patching of phys_to_virt and
	vice versa
In-Reply-To: <20101110164508.GB27571@n2100.arm.linux.org.uk>
References: <AANLkTikhcHTRYQki3cCYbWFY_POWX4E26Jau8nYpuDs0@mail.gmail.com>
	<20101108114948.GC14138@n2100.arm.linux.org.uk>
	<20101110164508.GB27571@n2100.arm.linux.org.uk>
Message-ID: <20101110175549.GD27571@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 10, 2010 at 04:45:08PM +0000, Russell King - ARM Linux wrote:
> Here's something which uses the above ideas (untested).  I think this is
> something we can (and should) do unconditionally for the !XIP cases.

Second version - let's get _all_ v:p translations, not just virt_to_phys
and phys_to_virt (iow, __phys_to_virt/__virt_to_phys/__pa/__va) which will
include all the page table manipulations, default bus<->virt translations.
This results in a _much_ bigger fixup table.

It also results in no fixup table being generated for platforms which
have complex v:p translations (cns3xxx, iop13xx, ixp2xxx, ks8695,
realview, s3c24a0).

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8ae3d48..6758df1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -187,6 +187,18 @@ config VECTORS_BASE
 	help
 	  The base address of exception vectors.
 
+config ARM_PATCH_PHYS_VIRT
+	bool
+	depends on EXPERIMENTAL
+	depends on !XIP && !THUMB2_KERNEL
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
@@ -590,6 +602,7 @@ config ARCH_PXA
 	select TICK_ONESHOT
 	select PLAT_PXA
 	select SPARSE_IRQ
+	select ARM_PATCH_PHYS_VIRT
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 23c2e8e..219d125 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -133,16 +133,6 @@
 #endif
 
 /*
- * Physical vs virtual RAM address space conversion.  These are
- * private definitions which should NOT be used outside memory.h
- * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
- */
-#ifndef __virt_to_phys
-#define __virt_to_phys(x)	((x) - PAGE_OFFSET + PHYS_OFFSET)
-#define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)
-#endif
-
-/*
  * Convert a physical address to a Page Frame Number and back
  */
 #define	__phys_to_pfn(paddr)	((paddr) >> PAGE_SHIFT)
@@ -157,6 +147,45 @@
 #ifndef __ASSEMBLY__
 
 /*
+ * Physical vs virtual RAM address space conversion.  These are
+ * private definitions which should NOT be used outside memory.h
+ * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
+ */
+#ifndef __virt_to_phys
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
+static inline unsigned long __virt_to_phys(unsigned long x)
+{
+	unsigned long t;
+
+	__pv_stub(x, t, "add");
+	return t;
+}
+
+static inline unsigned long __phys_to_virt(unsigned long x)
+{
+	unsigned long t;
+
+	__pv_stub(x, t, "sub");
+	return t;
+}
+#else
+#define __virt_to_phys(x)	((x) - PAGE_OFFSET + PHYS_OFFSET)
+#define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)
+#endif
+#endif
+
+/*
  * The DMA mask corresponding to the maximum bus address allocatable
  * using GFP_DMA.  The default here places no restriction on DMA
  * allocations.  This must be the smallest DMA mask in the system,
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
