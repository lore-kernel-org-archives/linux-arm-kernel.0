From: eric.miao@canonical.com (Eric Miao)
Date: Fri, 8 Oct 2010 15:36:35 +0800
Subject: [PATCH v2] ARM: Introduce patching of phys_to_virt and vice versa
Message-ID: <AANLkTimKt+y6sLi85dYJs2G3Uke3gzpWAJ9PCKO4R3-E@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

** In this v2 version, the __volatile__ keyword of the patch stub assembly is
removed. That prevents gcc from doing a good optimization. The test build
result showed an acceptable optimized code generation.

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
   possible when PHYS_OFFSET goes a variable)

2. flush_cache_all() when patching done is brute but simple enough here,
   provided it's done only once during startup.

3. thumb2 can be supported in a same way, but will leave that for future
   enhancement.

The general idea comes from Nicolas Pitre, and is drafted at
    https://wiki.ubuntu.com/Specs/ARMSingleKernel

Signed-off-by: Nicolas Pitre <nicolas.pitre@canonical.com>
Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/Kconfig              |   10 ++++++++
 arch/arm/include/asm/memory.h |   32 ++++++++++++++++++++++++++
 arch/arm/kernel/setup.c       |   50 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/vmlinux.lds.S |    4 +++
 4 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 553b7cf..5c856d9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -187,6 +187,16 @@ config VECTORS_BASE
 	help
 	  The base address of exception vectors.

+config ARM_PATCH_PHYS_VIRT
+	def_bool n
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
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 23c2e8e..9cf6d3f 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -182,6 +182,37 @@
  */
 #define PHYS_PFN_OFFSET	(PHYS_OFFSET >> PAGE_SHIFT)

+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
+
+#define PATCH_TYPE_PHYS_TO_VIRT		(0)
+#define PATCH_TYPE_VIRT_TO_PHYS		(1)
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
@@ -197,6 +228,7 @@ static inline void *phys_to_virt(unsigned long x)
 {
 	return (void *)(__phys_to_virt((unsigned long)(x)));
 }
+#endif

 /*
  * Drivers should NOT use these either.
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d5231ae..6d024ad 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -764,12 +764,62 @@ static void __init squash_mem_tags(struct tag *tag)
 			tag->hdr.tag = ATAG_NONE;
 }

+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
+
+#define PATCH_INSTR_ADD		(0x00800000)
+#define PATCH_INSTR_SUB		(0x00400000)
+
+#define PATCH_STUB_MASK		(0xffe000ff)
+#define PATCH_STUB_PHYS_TO_VIRT	(0xe2800000 | PATCH_TYPE_PHYS_TO_VIRT)
+#define PATCH_STUB_VIRT_TO_PHYS	(0xe2800000 | PATCH_TYPE_VIRT_TO_PHYS)
+
+/* patch_phys_virt - patch the stub instructions with the delta between
+ * PHYS_OFFSET and PAGE_OFFSET, which is assumed to be 16MiB aligned and
+ * can be expressed by an immediate shifter operand. The stub instruction
+ * has a form of 'add rd, rn, #imm', where the lowest 8-bit of #imm is
+ * used to identify the type of patching.
+ */
+static void __init patch_phys_virt(void)
+{
+	extern unsigned int *__patch_table_begin, *__patch_table_end;
+	unsigned int **p;
+	unsigned int imm, instr[2];
+
+	if (PHYS_OFFSET & 0x00ffffff)
+		panic("Physical memory start is not 16MiB aligned\n");
+
+	if (likely(PHYS_OFFSET < PAGE_OFFSET)) {
+		imm = 0x400 | ((PAGE_OFFSET >> 24) - (PHYS_OFFSET >> 24));
+		instr[0] = PATCH_INSTR_ADD | imm;
+		instr[1] = PATCH_INSTR_SUB | imm;
+	} else {
+		imm = 0x400 | ((PHYS_OFFSET >> 24) - (PAGE_OFFSET >> 24));
+		instr[0] = PATCH_INSTR_SUB | imm;
+		instr[1] = PATCH_INSTR_ADD | imm;
+	}
+
+	for (p = &__patch_table_begin; p < &__patch_table_end; p++) {
+		unsigned int *inptr = *p;
+
+		if ((*inptr & PATCH_STUB_MASK) == PATCH_STUB_PHYS_TO_VIRT)
+			*inptr = (*inptr & ~0x00e00fff) | instr[0];
+		if ((*inptr & PATCH_STUB_MASK) == PATCH_STUB_VIRT_TO_PHYS)
+			*inptr = (*inptr & ~0x00e00fff) | instr[1];
+	}
+	flush_cache_all();
+}
+#else
+static inline void patch_phys_virt(void) {}
+#endif
+
 void __init setup_arch(char **cmdline_p)
 {
 	struct tag *tags = (struct tag *)&init_tags;
 	struct machine_desc *mdesc;
 	char *from = default_command_line;

+	patch_phys_virt();
+
 	unwind_init();

 	setup_processor();
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index b16c079..c48c754 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -41,6 +41,10 @@ SECTIONS
 			*(.taglist.init)
 		__tagtable_end = .;

+		__patch_table_begin = .;
+			*(__patch_table)
+		__patch_table_end = .;
+
 		INIT_SETUP(16)

 		INIT_CALLS
-- 
1.7.0.4
