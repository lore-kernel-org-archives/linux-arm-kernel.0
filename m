From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 10 Aug 2011 11:13:39 +0100
Subject: [RFC PATCH 1/5] ARM: Make cpu_alignment into a global variable
In-Reply-To: <1312971223-28165-1-git-send-email-dave.martin@linaro.org>
References: <1312971223-28165-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1312971223-28165-2-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU architecture really should not be changing at runtime, so
make it a global variable instead of a function.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/include/asm/system.h |    2 +-
 arch/arm/kernel/elf.c         |    4 +++-
 arch/arm/kernel/setup.c       |   12 +++++++-----
 arch/arm/kernel/thumbee.c     |    4 ++--
 arch/arm/mm/alignment.c       |    9 +++++----
 arch/arm/mm/fault.c           |    4 ++--
 arch/arm/mm/idmap.c           |    3 ++-
 arch/arm/mm/ioremap.c         |    3 ++-
 arch/arm/mm/mmu.c             |   31 +++++++++++++++++--------------
 arch/arm/vfp/vfpmodule.c      |    4 ++--
 10 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 832888d..e7acb6e 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -104,7 +104,7 @@ struct mm_struct;
 extern void show_pte(struct mm_struct *mm, unsigned long addr);
 extern void __show_regs(struct pt_regs *);
 
-extern int cpu_architecture(void);
+extern int cpu_architecture;
 extern void cpu_init(void);
 
 void arm_machine_restart(char mode, const char *cmd);
diff --git a/arch/arm/kernel/elf.c b/arch/arm/kernel/elf.c
index 9b05c6a..174e90d 100644
--- a/arch/arm/kernel/elf.c
+++ b/arch/arm/kernel/elf.c
@@ -4,6 +4,8 @@
 #include <linux/binfmts.h>
 #include <linux/elf.h>
 
+#include <asm/system.h>
+
 int elf_check_arch(const struct elf32_hdr *x)
 {
 	unsigned int eflags;
@@ -83,7 +85,7 @@ int arm_elf_read_implies_exec(const struct elf32_hdr *x, int executable_stack)
 {
 	if (executable_stack != EXSTACK_DISABLE_X)
 		return 1;
-	if (cpu_architecture() < CPU_ARCH_ARMv6)
+	if (cpu_architecture < CPU_ARCH_ARMv6)
 		return 1;
 	return 0;
 }
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 70bca64..db67274 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -42,6 +42,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cachetype.h>
 #include <asm/tlbflush.h>
+#include <asm/system.h>
 
 #include <asm/prom.h>
 #include <asm/mach/arch.h>
@@ -114,6 +115,7 @@ struct cpu_cache_fns cpu_cache __read_mostly;
 struct outer_cache_fns outer_cache __read_mostly;
 EXPORT_SYMBOL(outer_cache);
 #endif
+int cpu_architecture __read_mostly;
 
 struct stack {
 	u32 irq[3];
@@ -210,7 +212,7 @@ static const char *proc_arch[] = {
 	"?(17)",
 };
 
-int cpu_architecture(void)
+static int __init __cpu_architecture(void)
 {
 	int cpu_arch;
 
@@ -275,9 +277,8 @@ static int cpu_has_aliasing_icache(unsigned int arch)
 static void __init cacheid_init(void)
 {
 	unsigned int cachetype = read_cpuid_cachetype();
-	unsigned int arch = cpu_architecture();
 
-	if (arch >= CPU_ARCH_ARMv6) {
+	if (cpu_architecture >= CPU_ARCH_ARMv6) {
 		if ((cachetype & (7 << 29)) == 4 << 29) {
 			/* ARMv7 register format */
 			cacheid = CACHEID_VIPT_NONALIASING;
@@ -413,6 +414,7 @@ static void __init setup_processor(void)
 	}
 
 	cpu_name = list->cpu_name;
+	cpu_architecture = __cpu_architecture();
 
 #ifdef MULTI_CPU
 	processor = *list->proc;
@@ -429,7 +431,7 @@ static void __init setup_processor(void)
 
 	printk("CPU: %s [%08x] revision %d (ARMv%s), cr=%08lx\n",
 	       cpu_name, read_cpuid_id(), read_cpuid_id() & 15,
-	       proc_arch[cpu_architecture()], cr_alignment);
+	       proc_arch[cpu_architecture], cr_alignment);
 
 	sprintf(init_utsname()->machine, "%s%c", list->arch_name, ENDIANNESS);
 	sprintf(elf_platform, "%s%c", list->elf_name, ENDIANNESS);
@@ -1026,7 +1028,7 @@ static int c_show(struct seq_file *m, void *v)
 			seq_printf(m, "%s ", hwcap_str[i]);
 
 	seq_printf(m, "\nCPU implementer\t: 0x%02x\n", read_cpuid_id() >> 24);
-	seq_printf(m, "CPU architecture: %s\n", proc_arch[cpu_architecture()]);
+	seq_printf(m, "CPU architecture: %s\n", proc_arch[cpu_architecture]);
 
 	if ((read_cpuid_id() & 0x0008f000) == 0x00000000) {
 		/* pre-ARM7 */
diff --git a/arch/arm/kernel/thumbee.c b/arch/arm/kernel/thumbee.c
index 9cb7aac..12ac868 100644
--- a/arch/arm/kernel/thumbee.c
+++ b/arch/arm/kernel/thumbee.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
+#include <asm/system.h>
 #include <asm/thread_notify.h>
 
 /*
@@ -61,9 +62,8 @@ static struct notifier_block thumbee_notifier_block = {
 static int __init thumbee_init(void)
 {
 	unsigned long pfr0;
-	unsigned int cpu_arch = cpu_architecture();
 
-	if (cpu_arch < CPU_ARCH_ARMv7)
+	if (cpu_architecture < CPU_ARCH_ARMv7)
 		return 0;
 
 	/* processor feature register 0 */
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index be7c638..7188c81 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -23,6 +23,7 @@
 #include <linux/uaccess.h>
 
 #include <asm/unaligned.h>
+#include <asm/system.h>
 
 #include "fault.h"
 
@@ -102,7 +103,7 @@ static int alignment_proc_show(struct seq_file *m, void *v)
 	seq_printf(m, "Skipped:\t%lu\n", ai_skipped);
 	seq_printf(m, "Half:\t\t%lu\n", ai_half);
 	seq_printf(m, "Word:\t\t%lu\n", ai_word);
-	if (cpu_architecture() >= CPU_ARCH_ARMv5TE)
+	if (cpu_architecture >= CPU_ARCH_ARMv5TE)
 		seq_printf(m, "DWord:\t\t%lu\n", ai_dword);
 	seq_printf(m, "Multi:\t\t%lu\n", ai_multi);
 	seq_printf(m, "User faults:\t%i (%s)\n", ai_usermode,
@@ -737,7 +738,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (thumb_mode(regs)) {
 		fault = __get_user(tinstr, (u16 *)(instrptr & ~1));
 		if (!fault) {
-			if (cpu_architecture() >= CPU_ARCH_ARMv7 &&
+			if (cpu_architecture >= CPU_ARCH_ARMv7 &&
 			    IS_T32(tinstr)) {
 				/* Thumb-2 32-bit */
 				u16 tinst2 = 0;
@@ -935,7 +936,7 @@ static int __init alignment_init(void)
 	 * CPUs since we spin re-faulting the instruction without
 	 * making any progress.
 	 */
-	if (cpu_architecture() >= CPU_ARCH_ARMv6 && (cr_alignment & CR_U)) {
+	if (cpu_architecture >= CPU_ARCH_ARMv6 && (cr_alignment & CR_U)) {
 		cr_alignment &= ~CR_A;
 		cr_no_alignment &= ~CR_A;
 		set_cr(cr_alignment);
@@ -952,7 +953,7 @@ static int __init alignment_init(void)
 	 * TODO: handle ARMv6K properly. Runtime check for 'K' extension is
 	 * needed.
 	 */
-	if (cpu_architecture() <= CPU_ARCH_ARMv6) {
+	if (cpu_architecture <= CPU_ARCH_ARMv6) {
 		hook_fault_code(3, do_alignment, SIGBUS, BUS_ADRALN,
 				"alignment exception");
 	}
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 3b5ea68..72ab66b 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -642,12 +642,12 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
 
 static int __init exceptions_init(void)
 {
-	if (cpu_architecture() >= CPU_ARCH_ARMv6) {
+	if (cpu_architecture >= CPU_ARCH_ARMv6) {
 		hook_fault_code(4, do_translation_fault, SIGSEGV, SEGV_MAPERR,
 				"I-cache maintenance fault");
 	}
 
-	if (cpu_architecture() >= CPU_ARCH_ARMv7) {
+	if (cpu_architecture >= CPU_ARCH_ARMv7) {
 		/*
 		 * TODO: Access flag faults introduced in ARMv6K.
 		 * Runtime check for 'K' extension is needed
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 2be9139..78cfebf 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -3,6 +3,7 @@
 #include <asm/cputype.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
+#include <asm/system.h>
 
 static void idmap_add_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 	unsigned long prot)
@@ -33,7 +34,7 @@ void identity_mapping_add(pgd_t *pgd, unsigned long addr, unsigned long end)
 	unsigned long prot, next;
 
 	prot = PMD_TYPE_SECT | PMD_SECT_AP_WRITE;
-	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
+	if (cpu_architecture <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
 		prot |= PMD_BIT4;
 
 	pgd += pgd_index(addr);
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index ab50627..1ee99a2 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -32,6 +32,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/sizes.h>
+#include <asm/system.h>
 
 #include <asm/mach/map.h>
 #include "mm.h"
@@ -223,7 +224,7 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
 
 #ifndef CONFIG_SMP
 	if (DOMAIN_IO == 0 &&
-	    (((cpu_architecture() >= CPU_ARCH_ARMv6) && (get_cr() & CR_XP)) ||
+	    (((cpu_architecture >= CPU_ARCH_ARMv6) && (get_cr() & CR_XP)) ||
 	       cpu_is_xsc3()) && pfn >= 0x100000 &&
 	       !((__pfn_to_phys(pfn) | size | addr) & ~SUPERSECTION_MASK)) {
 		area->flags |= VM_ARM_SECTION_MAPPING;
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 594d677..f969675 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -25,6 +25,7 @@
 #include <asm/tlb.h>
 #include <asm/highmem.h>
 #include <asm/traps.h>
+#include <asm/system.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -122,7 +123,7 @@ static int __init early_cachepolicy(char *p)
 	 * change these attributes once the initial assembly has setup the
 	 * page tables.
 	 */
-	if (cpu_architecture() >= CPU_ARCH_ARMv6) {
+	if (cpu_architecture >= CPU_ARCH_ARMv6) {
 		printk(KERN_WARNING "Only cachepolicy=writeback supported on ARMv6 and later\n");
 		cachepolicy = CPOLICY_WRITEBACK;
 	}
@@ -289,10 +290,9 @@ static void __init build_mem_type_table(void)
 	struct cachepolicy *cp;
 	unsigned int cr = get_cr();
 	unsigned int user_pgprot, kern_pgprot, vecs_pgprot;
-	int cpu_arch = cpu_architecture();
 	int i;
 
-	if (cpu_arch < CPU_ARCH_ARMv6) {
+	if (cpu_architecture < CPU_ARCH_ARMv6) {
 #if defined(CONFIG_CPU_DCACHE_DISABLE)
 		if (cachepolicy > CPOLICY_BUFFERED)
 			cachepolicy = CPOLICY_BUFFERED;
@@ -301,7 +301,7 @@ static void __init build_mem_type_table(void)
 			cachepolicy = CPOLICY_WRITETHROUGH;
 #endif
 	}
-	if (cpu_arch < CPU_ARCH_ARMv5) {
+	if (cpu_architecture < CPU_ARCH_ARMv5) {
 		if (cachepolicy >= CPOLICY_WRITEALLOC)
 			cachepolicy = CPOLICY_WRITEBACK;
 		ecc_mask = 0;
@@ -314,10 +314,11 @@ static void __init build_mem_type_table(void)
 	 * Pre-ARMv5 CPUs don't have TEX bits.  Pre-ARMv6 CPUs or those
 	 * without extended page tables don't have the 'Shared' bit.
 	 */
-	if (cpu_arch < CPU_ARCH_ARMv5)
+	if (cpu_architecture < CPU_ARCH_ARMv5)
 		for (i = 0; i < ARRAY_SIZE(mem_types); i++)
 			mem_types[i].prot_sect &= ~PMD_SECT_TEX(7);
-	if ((cpu_arch < CPU_ARCH_ARMv6 || !(cr & CR_XP)) && !cpu_is_xsc3())
+	if ((cpu_architecture < CPU_ARCH_ARMv6 || !(cr & CR_XP)) &&
+	    !cpu_is_xsc3())
 		for (i = 0; i < ARRAY_SIZE(mem_types); i++)
 			mem_types[i].prot_sect &= ~PMD_SECT_S;
 
@@ -331,7 +332,7 @@ static void __init build_mem_type_table(void)
 			mem_types[i].prot_sect &= ~PMD_BIT4;
 			mem_types[i].prot_l1 &= ~PMD_BIT4;
 		}
-	} else if (cpu_arch < CPU_ARCH_ARMv6) {
+	} else if (cpu_architecture < CPU_ARCH_ARMv6) {
 		for (i = 0; i < ARRAY_SIZE(mem_types); i++) {
 			if (mem_types[i].prot_l1)
 				mem_types[i].prot_l1 |= PMD_BIT4;
@@ -343,7 +344,8 @@ static void __init build_mem_type_table(void)
 	/*
 	 * Mark the device areas according to the CPU/architecture.
 	 */
-	if (cpu_is_xsc3() || (cpu_arch >= CPU_ARCH_ARMv6 && (cr & CR_XP))) {
+	if (cpu_is_xsc3() ||
+	    (cpu_architecture >= CPU_ARCH_ARMv6 && (cr & CR_XP))) {
 		if (!cpu_is_xsc3()) {
 			/*
 			 * Mark device regions on ARMv6+ as execute-never
@@ -354,7 +356,7 @@ static void __init build_mem_type_table(void)
 			mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_XN;
 			mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_XN;
 		}
-		if (cpu_arch >= CPU_ARCH_ARMv7 && (cr & CR_TRE)) {
+		if (cpu_architecture >= CPU_ARCH_ARMv7 && (cr & CR_TRE)) {
 			/*
 			 * For ARMv7 with TEX remapping,
 			 * - shared device is SXCB=1100
@@ -404,7 +406,8 @@ static void __init build_mem_type_table(void)
 	/*
 	 * Only use write-through for non-SMP systems
 	 */
-	if (!is_smp() && cpu_arch >= CPU_ARCH_ARMv5 && cachepolicy > CPOLICY_WRITETHROUGH)
+	if (!is_smp() && cpu_architecture >= CPU_ARCH_ARMv5 &&
+	    cachepolicy > CPOLICY_WRITETHROUGH)
 		vecs_pgprot = cache_policies[CPOLICY_WRITETHROUGH].pte;
 
 	/*
@@ -420,7 +423,7 @@ static void __init build_mem_type_table(void)
 	/*
 	 * ARMv6 and above have extended page tables.
 	 */
-	if (cpu_arch >= CPU_ARCH_ARMv6 && (cr & CR_XP)) {
+	if (cpu_architecture >= CPU_ARCH_ARMv6 && (cr & CR_XP)) {
 		/*
 		 * Mark cache clean areas and XIP ROM read only
 		 * from SVC mode and no access from userspace.
@@ -452,8 +455,8 @@ static void __init build_mem_type_table(void)
 	 * Non-cacheable Normal - intended for memory areas that must
 	 * not cause dirty cache line writebacks when used
 	 */
-	if (cpu_arch >= CPU_ARCH_ARMv6) {
-		if (cpu_arch >= CPU_ARCH_ARMv7 && (cr & CR_TRE)) {
+	if (cpu_architecture >= CPU_ARCH_ARMv6) {
+		if (cpu_architecture >= CPU_ARCH_ARMv7 && (cr & CR_TRE)) {
 			/* Non-cacheable Normal is XCB = 001 */
 			mem_types[MT_MEMORY_NONCACHED].prot_sect |=
 				PMD_SECT_BUFFERED;
@@ -606,7 +609,7 @@ static void __init create_36bit_mapping(struct map_desc *md,
 	phys = __pfn_to_phys(md->pfn);
 	length = PAGE_ALIGN(md->length);
 
-	if (!(cpu_architecture() >= CPU_ARCH_ARMv6 || cpu_is_xsc3())) {
+	if (!(cpu_architecture >= CPU_ARCH_ARMv6 || cpu_is_xsc3())) {
 		printk(KERN_ERR "MM: CPU does not support supersection "
 		       "mapping for 0x%08llx at 0x%08lx\n",
 		       (long long)__pfn_to_phys((u64)md->pfn), addr);
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 79bcb43..128ce18 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -20,6 +20,7 @@
 
 #include <asm/cputype.h>
 #include <asm/thread_notify.h>
+#include <asm/system.h>
 #include <asm/vfp.h>
 
 #include "vfpinstr.h"
@@ -541,9 +542,8 @@ static int vfp_hotplug(struct notifier_block *b, unsigned long action,
 static int __init vfp_init(void)
 {
 	unsigned int vfpsid;
-	unsigned int cpu_arch = cpu_architecture();
 
-	if (cpu_arch >= CPU_ARCH_ARMv6)
+	if (cpu_architecture >= CPU_ARCH_ARMv6)
 		vfp_enable(NULL);
 
 	/*
-- 
1.7.4.1
