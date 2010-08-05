From: eric.miao@canonical.com (Eric Miao)
Date: Thu, 5 Aug 2010 16:45:25 +0800
Subject: [PATCH] [ARM] Introduce patching of phys_to_virt and vice versa
In-Reply-To: <20100720211629.GB10553@n2100.arm.linux.org.uk>
References: <1277542025-19881-1-git-send-email-eric.miao@canonical.com>
	<1278083164.15298.55.camel@ra7055-laptop>
	<20100720211629.GB10553@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimyif7CCoNwdKMCA=P+y=0e9uhwfhRchbMuB7eY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 21, 2010 at 5:16 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jul 02, 2010 at 10:06:04AM -0500, Rob Herring wrote:
>> Should something more generic like the x86 alternative code be done for
>> ARM? It's very likely we will need patching in other places like for UP
>> and SMP in one kernel.
>
> I think yes, we need to - I can't see how we can sensibly combine
> kernels without this.
>
> However, the effect of this is that XIP can't use this - as the
> kernel text is read-only.
>

Hi Russell,

Sorry for late update on this. I've addressed your comments as below,
and really hope this can get into this merge window, so I'm also sending
this to your patch system right now ;-)

    [ARM] Introduce patching of phys_to_virt and vice versa

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

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 98922f7..4e87b16 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -189,6 +189,16 @@ config VECTORS_BASE
 	help
 	  The base address of exception vectors.

+config ARM_PATCH_PHYS_VIRT
+	def_bool n
+	help
+	  Note this is only for non-XIP and non-Thumb2 kernels. And there
+	  is CPU support which needs to read data in order to writeback
+	  dirty entries in the cache. (e.g. StrongARM, ebsa110, footbridge,
+	  rpc, sa1100, and shark). The mapping in the above case does not
+	  exist before paging_init() has completed. Thus this option does
+	  not support these CPUs at this moment.
+
 source "init/Kconfig"

 source "kernel/Kconfig.freezer"
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 4312ee5..a91fe15 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -173,6 +173,37 @@
  */
 #define PHYS_PFN_OFFSET	(PHYS_OFFSET >> PAGE_SHIFT)

+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
+
+#define PATCH_TYPE_PHYS_TO_VIRT		(0)
+#define PATCH_TYPE_VIRT_TO_PHYS		(1)
+
+#define __patch_stub(from,to,type)			\
+	__asm__ __volatile__(				\
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
@@ -188,6 +219,7 @@ static inline void *phys_to_virt(unsigned long x)
 {
 	return (void *)(__phys_to_virt((unsigned long)(x)));
 }
+#endif

 /*
  * Drivers should NOT use these either.
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 122d999..6e16067 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -663,12 +663,62 @@ static int __init customize_machine(void)
 }
 arch_initcall(customize_machine);

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
