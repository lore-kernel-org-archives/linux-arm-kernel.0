From: james.morse@arm.com (James Morse)
Date: Mon, 12 Oct 2015 14:17:38 +0100
Subject: [PATCH 6/6] arm64: kernel: Add support for hibernate/suspend-to-disk.
In-Reply-To: <1444655858-26083-1-git-send-email-james.morse@arm.com>
References: <1444655858-26083-1-git-send-email-james.morse@arm.com>
Message-ID: <1444655858-26083-7-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for hibernate/suspend-to-disk.

Suspend borrows code from cpu_suspend() to write cpu state onto the stack,
before calling swusp_save() to save the memory image.

Restore creates a set of temporary page tables, covering only the linear
map, and copies the restore code to a 'safe' page, then
uses the copy to restore the memory image. It calls into cpu_resume(),
and then follows the normal cpu_suspend() path back into the suspend code.

The suspend C code also includes some post-hibernate cache cleanup.

The implementation assumes that exactly the same kernel is booted on the
same hardware, and that the kernel is loaded at the same physical address.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/Kconfig                |   3 +
 arch/arm64/include/asm/suspend.h  |   5 +
 arch/arm64/kernel/Makefile        |   1 +
 arch/arm64/kernel/asm-offsets.c   |   4 +
 arch/arm64/kernel/hibernate-asm.S | 133 ++++++++++++
 arch/arm64/kernel/hibernate.c     | 441 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/sleep.S         |   1 +
 arch/arm64/kernel/vmlinux.lds.S   |  15 ++
 8 files changed, 603 insertions(+)
 create mode 100644 arch/arm64/kernel/hibernate-asm.S
 create mode 100644 arch/arm64/kernel/hibernate.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 07d1811aa03f..d081dbc35335 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -707,6 +707,9 @@ menu "Power management options"
 
 source "kernel/power/Kconfig"
 
+config ARCH_HIBERNATION_POSSIBLE
+	def_bool y
+
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index 36f35ba41fa2..d7405ca4e6c8 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -22,6 +22,11 @@ struct sleep_stack_data {
 	unsigned long		callee_saved_regs[NR_CALLEE_SAVED_REGS];
 };
 
+extern int swsusp_arch_suspend(void);
+extern int swsusp_arch_resume(void);
+int swsusp_arch_suspend_enter(struct cpu_suspend_ctx *ptr);
+void __noreturn swsusp_arch_suspend_exit(phys_addr_t tmp_pg_dir,
+					 phys_addr_t swapper_pg_dir);
 extern int cpu_suspend(unsigned long arg, int (*fn)(unsigned long));
 extern void cpu_resume(void);
 int __cpu_suspend_enter(struct sleep_stack_data *state);
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 22dc9bc781be..b9151ae4a7ae 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -36,6 +36,7 @@ arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
 arm64-obj-$(CONFIG_PCI)			+= pci.o
 arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
 arm64-obj-$(CONFIG_ACPI)		+= acpi.o
+arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 3cb1383d3deb..b5d9495a94a1 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
 #include <linux/kvm_host.h>
+#include <linux/suspend.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/smp_plat.h>
@@ -160,5 +161,8 @@ int main(void)
   DEFINE(SLEEP_STACK_DATA_SYSTEM_REGS,	offsetof(struct sleep_stack_data, system_regs));
   DEFINE(SLEEP_STACK_DATA_CALLEE_REGS,	offsetof(struct sleep_stack_data, callee_saved_regs));
 #endif
+  DEFINE(HIBERN_PBE_ORIG,	offsetof(struct pbe, orig_address));
+  DEFINE(HIBERN_PBE_ADDR,	offsetof(struct pbe, address));
+  DEFINE(HIBERN_PBE_NEXT,	offsetof(struct pbe, next));
   return 0;
 }
diff --git a/arch/arm64/kernel/hibernate-asm.S b/arch/arm64/kernel/hibernate-asm.S
new file mode 100644
index 000000000000..267510138d78
--- /dev/null
+++ b/arch/arm64/kernel/hibernate-asm.S
@@ -0,0 +1,133 @@
+#include <linux/linkage.h>
+#include <linux/errno.h>
+
+#include <asm/asm-offsets.h>
+#include <asm/assembler.h>
+#include <asm/cputype.h>
+#include <asm/memory.h>
+#include <asm/page.h>
+
+#define KERNEL_START      _text
+#define KERNEL_END        _end
+
+/*
+ * void __clean_dcache_pou(unsigned long kaddr, unsigned long size)
+ *
+ * Clean the data held in kaddr to the PoU, for later execution.
+ * Based on flush_icache_range().
+ * N.B This function does not invalidate the icache, or provide a barrier,
+ *     use flush_icache_range() if that is what you wanted.
+ *
+ * x0: kaddr
+ * x1: size
+ */
+ENTRY(__clean_dcache_pou)
+	dcache_line_size x2, x3
+	add	x1, x0, x1
+	sub	x3, x2, #1
+	bic	x0, x0, x3
+1:	dc	cvau, x0	// clean D line / unified line
+	add	x0, x0, x2
+	cmp	x0, x1
+	b.lo	1b
+	ret
+ENDPROC(__clean_dcache_pou)
+
+
+/*
+ * Corrupt memory.
+ *
+ * Loads temporary page tables then restores the memory image.
+ * Finally branches to cpu_resume() to restore the state saved by
+ * swsusp_arch_suspend().
+ *
+ * Because this code has to be copied to a safe_page, it can't call out to
+ * other functions by pc-relative address. Also remember that it may be
+ * mid-way through over-writing other functions. For this reason it contains
+ * a copy of copy_page() and code from flush_icache_range().
+ *
+ * All of memory gets written to, including code. We need to clean the kernel
+ * text to the PoC before secondary cores can be booted. The modules range and
+ * userspace are somewhat tricky, and are done after we return into
+ * swsusp_arch_suspend().
+ *
+ * x0: physical address of temporary page tables.
+ * x1: physical address of swapper page tables.
+ */
+.pushsection    ".hibernate_exit.text", "ax"
+ENTRY(swsusp_arch_suspend_exit)
+	/* Temporary page tables are a copy, so no need for a trampoline here */
+	msr	ttbr1_el1, x0
+	isb
+	tlbi	vmalle1is
+	ic	ialluis
+	isb
+
+	mov	x20, x1
+
+	/* walk the restore_pblist and use copy_page() to over-write memory */
+	ldr	x19, =restore_pblist
+	ldr	x19, [x19]
+
+2:	ldr	x0, [x19, #HIBERN_PBE_ORIG]
+	ldr	x1, [x19, #HIBERN_PBE_ADDR]
+
+	/* arch/arm64/lib/copy_page.S:copy_page() */
+	prfm	pldl1strm, [x1, #64]
+3:	ldp	x2, x3, [x1]
+	ldp	x4, x5, [x1, #16]
+	ldp	x6, x7, [x1, #32]
+	ldp	x8, x9, [x1, #48]
+	add	x1, x1, #64
+	prfm	pldl1strm, [x1, #64]
+	stnp	x2, x3, [x0]
+	stnp	x4, x5, [x0, #16]
+	stnp	x6, x7, [x0, #32]
+	stnp	x8, x9, [x0, #48]
+	add	x0, x0, #64
+	tst	x1, #(PAGE_SIZE - 1)
+	b.ne	3b
+
+	ldr	x19, [x19, #HIBERN_PBE_NEXT]
+	cbnz	x19, 2b
+
+	dsb	ish		// memory restore must finish before cleaning
+
+	ldr	x0, =KERNEL_START
+	ldr	x1, =KERNEL_END
+	/* Clean the kernel text to PoC - based on flush_icache_range() */
+	dcache_line_size x2, x3
+	sub	x3, x2, #1
+	bic	x4, x0, x3
+4:	dc	cvac, x4
+	add	x4, x4, x2
+	cmp	x4, x1
+	b.lo	4b
+
+	dsb	ish
+
+	/*
+	 * branch into the restored kernel - so that when we restore the page
+	 * tables, code continues to be executable.
+	 */
+	ldr	x1, =__hibernate_exit
+	br	x1
+
+	.ltorg
+ENDPROC(swsusp_arch_suspend_exit)
+.popsection
+
+/*
+ * Reset the page tables, and wake up in cpu_resume().
+ * Temporary page tables were a copy, so again, no trampoline here.
+ *
+ * x20: physical address of swapper_pg_dir
+ */
+ENTRY(__hibernate_exit)
+	msr	ttbr1_el1, x20
+	isb
+	tlbi	vmalle1is
+	ic	ialluis
+	isb
+	b	_cpu_resume
+ENDPROC(__hibernate_exit)
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
new file mode 100644
index 000000000000..5e0683752dbf
--- /dev/null
+++ b/arch/arm64/kernel/hibernate.c
@@ -0,0 +1,441 @@
+/*:
+ * Hibernate support specific for ARM64
+ *
+ * Derived from work on ARM hibernation support by:
+ *
+ * Ubuntu project, hibernation support for mach-dove
+ * Copyright (C) 2010 Nokia Corporation (Hiroshi Doyu)
+ * Copyright (C) 2010 Texas Instruments, Inc. (Teerth Reddy et al.)
+ *  https://lkml.org/lkml/2010/6/18/4
+ *  https://lists.linux-foundation.org/pipermail/linux-pm/2010-June/027422.html
+ *  https://patchwork.kernel.org/patch/96442/
+ *
+ * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+#define pr_fmt(x) "hibernate: " x
+#include <linux/kvm_host.h>
+#include <linux/mm.h>
+#include <linux/pm.h>
+#include <linux/sched.h>
+#include <linux/suspend.h>
+#include <linux/version.h>
+
+#include <asm/barrier.h>
+#include <asm/cacheflush.h>
+#include <asm/irqflags.h>
+#include <asm/memory.h>
+#include <asm/mmu_context.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <asm/sections.h>
+#include <asm/suspend.h>
+
+/*
+ * for_each_vma() - iterate through each vma in use by an mm.
+ * @mm: struct mm_struct * to read.
+ * @vma: struct vm_area_struct *, the current vma.
+ *
+ * Iterates through an mm's vma map. You should hold mm->mmap_sem for reading.
+ */
+#define for_each_vma(mm, vma)	\
+	for (vma = mm->mmap; vma->vm_next != NULL; vma = vma->vm_next)
+
+/* These are necessary to build without ifdefery */
+#ifndef pmd_index
+#define pmd_index(x)	0
+#endif
+#ifndef pud_index
+#define pud_index(x)	0
+#endif
+
+/*
+ * Clean the provided range to the PoU - used on the modules+user space ranges.
+ */
+void __clean_dcache_pou(unsigned long kaddr, unsigned long size);
+
+/*
+ * Start/end of the hibernate exit code, this must be copied to a 'safe'
+ * location in memory, and executed from there.
+ */
+extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
+
+int pfn_is_nosave(unsigned long pfn)
+{
+	unsigned long nosave_begin_pfn = virt_to_pfn(&__nosave_begin);
+	unsigned long nosave_end_pfn = virt_to_pfn(&__nosave_end - 1);
+
+	return (pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn);
+}
+
+void notrace save_processor_state(void)
+{
+	WARN_ON(num_online_cpus() != 1);
+	local_fiq_disable();
+}
+
+void notrace restore_processor_state(void)
+{
+	local_fiq_enable();
+}
+
+/*
+ * Heavily-based on the version in /arch/x86.
+ * TODO: move this out of /arch/
+ */
+pte_t *lookup_address(pgd_t *pgd, unsigned long address, size_t *length)
+{
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	*length = PGDIR_SIZE;
+	if (pgd_none(*pgd))
+		return NULL;
+
+	*length = PUD_SIZE;
+	pud = pud_offset(pgd, address);
+	if (pud_none(*pud))
+		return NULL;
+
+	if (pud_sect(*pud) || !pud_present(*pud))
+		return (pte_t *)pud;
+
+	*length = PMD_SIZE;
+	pmd = pmd_offset(pud, address);
+	if (pmd_none(*pmd))
+		return NULL;
+
+	if (pmd_sect(*pmd) || !pmd_present(*pmd))
+		return (pte_t *)pmd;
+
+	*length = PAGE_SIZE;
+	pte = pte_offset_kernel(pmd, address);
+	if (pte_none(*pte))
+		return NULL;
+	return pte;
+}
+
+/*
+ * Walk the provided mm's page tables, from start_addr to end_addr. Translate
+ * each page to its alias in the linear map, and clean that to the PoU.
+ * This is safe to call on user-space mm's, as all the access is to page tables
+ * and kernel linear-map addresses.
+ *
+ * Uses __clean_dcache_pou(), which does not provide any barriers or icache
+ * maintenance. Ensure start_addr is page aligned.
+ */
+static void clean_mapped_range(struct mm_struct *mm, unsigned long start_addr,
+			       unsigned long end_addr)
+{
+	pte_t *pte;
+	size_t length;
+	unsigned long map_addr;
+	unsigned long linear_addr;
+
+	for (map_addr = start_addr; map_addr < end_addr; map_addr += length) {
+		pte = lookup_address(pgd_offset(mm, map_addr), map_addr,
+				     &length);
+		/* length is valid, even if pte is NULL */
+		if (!pte || !pte_valid(*pte))
+			continue;
+
+		linear_addr = (unsigned long)pfn_to_kaddr(pte_pfn(*pte));
+		__clean_dcache_pou(linear_addr, linear_addr+length);
+	}
+}
+
+int swsusp_arch_suspend(void)
+{
+	int ret = 0;
+	unsigned long flags;
+	struct task_struct *p;
+	struct vm_area_struct *vma;
+	struct sleep_stack_data state;
+	struct mm_struct *mm = current->active_mm;
+
+	local_dbg_save(flags);
+
+	if (__cpu_suspend_enter(&state))
+		ret = swsusp_save();
+	else {
+		__cpu_suspend_exit(mm);
+
+		pr_info("Performing cache maintenance.\n");
+
+		/*
+		 * We clean the 'tricky' cache ranges here. Modules and user
+		 * space executable code may have been written to via its
+		 * alias in the kernel linear mapping.
+		 *
+		 * To clean these ranges, we walk the page tables to find the
+		 * physical pages, and then their position in the linear map.
+		 *
+		 * The restore_pblist used during restore only contains pages
+		 * that were in use - other pages containing executable code
+		 * may have been written by core hibernate code.
+		 */
+		clean_mapped_range(&init_mm, MODULES_VADDR, MODULES_END);
+
+		/*
+		 * Any user space executable code that isn't going to be
+		 * reloaded from disk (e.g. jit code) is now potentially
+		 * in the data cache, and needs cleaning.
+		 *
+		 * TODO: Some pages are mapped to user-space many times.
+		 *       Implement a 'cleaned' bitmap so we only clean each
+		 *       page once.
+		 */
+		read_lock(&tasklist_lock);
+		for_each_process(p) {
+			if (!p->mm || p->mm == &init_mm)
+				continue;
+
+			down_read(&p->mm->mmap_sem);
+			for_each_vma(p->mm, vma) {
+				if (!(vma->vm_flags & VM_EXEC))
+					continue;
+
+				clean_mapped_range(p->mm, vma->vm_start,
+						   vma->vm_end);
+			}
+			up_read(&p->mm->mmap_sem);
+		}
+		read_unlock(&tasklist_lock);
+
+		/* page tables may still be cached -how does this affect dma? */
+
+		/* all cache cleaning should have finished */
+		dsb(ish);
+		__flush_icache_all();
+	}
+
+	local_dbg_restore(flags);
+
+	return ret;
+}
+
+static int copy_pte(pmd_t *dst, pmd_t *src, unsigned long start_addr)
+{
+	int i;
+	pte_t *old_pte = pte_offset_kernel(src, start_addr);
+	pte_t *new_pte = pte_offset_kernel(dst, start_addr);
+
+	for (i = pte_index(start_addr); i < PTRS_PER_PTE;
+	     i++, old_pte++, new_pte++) {
+		if (pte_val(*old_pte))
+			set_pte(new_pte,
+				__pte(pte_val(*old_pte) & ~PTE_RDONLY));
+	}
+
+	return 0;
+}
+
+static int copy_pmd(pud_t *dst, pud_t *src, unsigned long start_addr)
+{
+	int i;
+	int rc = 0;
+	pte_t *new_pte;
+	pmd_t *old_pmd = pmd_offset(src, start_addr);
+	pmd_t *new_pmd = pmd_offset(dst, start_addr);
+
+	for (i = pmd_index(start_addr); i < PTRS_PER_PMD;
+	     i++, start_addr += PMD_SIZE, old_pmd++, new_pmd++) {
+		if (!pmd_val(*old_pmd))
+			continue;
+
+		if (pmd_table(*(old_pmd))) {
+			new_pte = (pte_t *)get_safe_page(GFP_ATOMIC);
+			if (!new_pte) {
+				rc = -ENOMEM;
+				break;
+			}
+
+			set_pmd(new_pmd, __pmd(virt_to_phys(new_pte)
+					       | PMD_TYPE_TABLE));
+
+			rc = copy_pte(new_pmd, old_pmd, start_addr);
+			if (rc)
+				break;
+		} else
+			set_pmd(new_pmd,
+				__pmd(pmd_val(*old_pmd) & ~PMD_SECT_RDONLY));
+	}
+
+	return rc;
+}
+
+static int copy_pud(pgd_t *dst, pgd_t *src, unsigned long start_addr)
+{
+	int i;
+	int rc = 0;
+	pmd_t *new_pmd;
+	pud_t *old_pud = pud_offset(src, start_addr);
+	pud_t *new_pud = pud_offset(dst, start_addr);
+
+	for (i = pud_index(start_addr); i < PTRS_PER_PUD;
+	     i++, start_addr += PUD_SIZE, old_pud++, new_pud++) {
+		if (!pud_val(*old_pud))
+			continue;
+
+		if (pud_table(*(old_pud))) {
+			if (PTRS_PER_PMD != 1) {
+				new_pmd = (pmd_t *)get_safe_page(GFP_ATOMIC);
+				if (!new_pmd) {
+					rc = -ENOMEM;
+					break;
+				}
+
+				set_pud(new_pud, __pud(virt_to_phys(new_pmd)
+						       | PUD_TYPE_TABLE));
+			}
+
+			rc = copy_pmd(new_pud, old_pud, start_addr);
+			if (rc)
+				break;
+		} else
+			set_pud(new_pud,
+				__pud(pud_val(*old_pud) & ~PMD_SECT_RDONLY));
+	}
+
+	return rc;
+}
+
+static int copy_linear_map(pgd_t *new_pgd)
+{
+	int i;
+	int rc = 0;
+	pud_t *new_pud;
+	unsigned long start_addr = PAGE_OFFSET;
+	pgd_t *old_pgd = pgd_offset_k(start_addr);
+
+	new_pgd += pgd_index(start_addr);
+
+	for (i = pgd_index(start_addr); i < PTRS_PER_PGD;
+	     i++, start_addr += PGDIR_SIZE, old_pgd++, new_pgd++) {
+		if (!pgd_val(*old_pgd))
+			continue;
+
+		if (PTRS_PER_PUD != 1) {
+			new_pud = (pud_t *)get_safe_page(GFP_ATOMIC);
+			if (!new_pud) {
+				rc = -ENOMEM;
+				break;
+			}
+
+			set_pgd(new_pgd, __pgd(virt_to_phys(new_pud)
+					       | PUD_TYPE_TABLE));
+		}
+
+		rc = copy_pud(new_pgd, old_pgd, start_addr);
+		if (rc)
+			break;
+	}
+
+	return rc;
+}
+
+/*
+ * Setup then Resume from the hibernate image using swsusp_arch_suspend_exit().
+ *
+ * Memory allocated by get_safe_page() will be dealt with by the hibernate code,
+ * we don't need to free it here.
+ *
+ * Allocate a safe zero page to use as ttbr0, as all existing page tables, and
+ * even the empty_zero_page will be overwritten.
+ */
+int swsusp_arch_resume(void)
+{
+	int rc = 0;
+	pgd_t *pgd;
+	size_t length;
+	size_t exit_size;
+	pgd_t *tmp_pg_dir;
+	pte_t *exit_page_pte;
+	pte_t exit_page_pte_orig;
+	unsigned long exit_page;
+	void *safe_zero_page_mem;
+	void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t);
+
+	/* Copy swsusp_arch_suspend_exit() to a safe page. */
+	exit_page = get_safe_page(GFP_ATOMIC);
+	if (!exit_page) {
+		pr_err("Failed to allocate memory for hibernate_exit code.");
+		rc = -ENOMEM;
+		goto out;
+	}
+	exit_size = __hibernate_exit_text_end - __hibernate_exit_text_start;
+	memcpy((void *)exit_page, __hibernate_exit_text_start, exit_size);
+	flush_icache_range(exit_page, exit_page + exit_size);
+	if (IS_ENABLED(CONFIG_DEBUG_RODATA)) {
+		/*
+		 * set_memory_x() is only for the module ranges. We only have
+		 * the linear-map mapped - so need to make the copied page
+		 * executable now, and when we run with the copied page tables.
+		 * The process of restoring the hibernate kernel will undo
+		 * this change.
+		 */
+		pgd = pgd_offset(&init_mm, exit_page);
+		exit_page_pte = lookup_address(pgd, exit_page, &length);
+		if (exit_page_pte) {
+			exit_page_pte_orig = pte_val(*exit_page_pte);
+			set_pte_at(&init_mm, exit_page, exit_page_pte,
+				  __pte(pte_val(*exit_page_pte) & ~PTE_PXN));
+			flush_tlb_kernel_range(exit_page, exit_page + PAGE_SIZE);
+		}
+		else {
+			pr_err("Failed to find page table entry for hibernate_exit code!");
+			rc = -EFAULT;
+			goto out;
+		}
+	}
+	hibernate_exit = (void *)exit_page;
+
+	/*
+	 * Even the zero page may get overwritten during restore.
+	 * get_safe_page() only returns zero'd pages.
+	 */
+	safe_zero_page_mem = (void *)get_safe_page(GFP_ATOMIC);
+	if (!safe_zero_page_mem) {
+		pr_err("Failed to allocate memory for zero page.");
+		rc = -ENOMEM;
+		goto pte_undo;
+	}
+	empty_zero_page = virt_to_page(safe_zero_page_mem);
+	cpu_set_reserved_ttbr0();
+
+	/*
+	 * Restoring the memory image will overwrite the ttbr1 page tables.
+	 * Create a second copy, of just the linear map, and use this when
+	 * restoring.
+	 */
+	tmp_pg_dir = (pgd_t *)get_safe_page(GFP_ATOMIC);
+	if (!tmp_pg_dir) {
+		pr_err("Failed to allocate memory for temporary page tables.");
+		rc = -ENOMEM;
+		goto pte_undo;
+	}
+	rc = copy_linear_map(tmp_pg_dir);
+	if (rc)
+		goto pte_undo;
+
+	/*
+	 * EL2 may get upset if we overwrite its page-tables/stack.
+	 * kvm_reset_cpu() returns EL2 to the hyp stub. This isn't needed
+	 * on normal suspend/resume as PSCI prevents us from ruining EL2.
+	 */
+	if (IS_ENABLED(CONFIG_KVM_ARM_HOST))
+		kvm_reset_cpu();
+
+	hibernate_exit(virt_to_phys(tmp_pg_dir), virt_to_phys(swapper_pg_dir));
+
+pte_undo:
+	if (IS_ENABLED(CONFIG_DEBUG_RODATA)) {
+		set_pte_at(&init_mm, exit_page, exit_page_pte,
+			   exit_page_pte_orig);
+		flush_tlb_kernel_range(exit_page, exit_page + PAGE_SIZE);
+	}
+out:
+	return rc;
+}
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index da4405062d83..f58008d6dadf 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -2,6 +2,7 @@
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/assembler.h>
+#include <asm/memory.h>
 
 	.text
 /*
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 98073332e2d0..3d8284d91f4c 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -44,6 +44,16 @@ jiffies = jiffies_64;
 	*(.idmap.text)					\
 	VMLINUX_SYMBOL(__idmap_text_end) = .;
 
+#ifdef CONFIG_HIBERNATION
+#define HIBERNATE_TEXT					\
+	. = ALIGN(SZ_4K);				\
+	VMLINUX_SYMBOL(__hibernate_exit_text_start) = .;\
+	*(.hibernate_exit.text)				\
+	VMLINUX_SYMBOL(__hibernate_exit_text_end) = .;
+#else
+#define HIBERNATE_TEXT
+#endif
+
 /*
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from stext to _edata, must be a round multiple of the PE/COFF
@@ -102,6 +112,7 @@ SECTIONS
 			LOCK_TEXT
 			HYPERVISOR_TEXT
 			IDMAP_TEXT
+			HIBERNATE_TEXT
 			*(.fixup)
 			*(.gnu.warning)
 		. = ALIGN(16);
@@ -181,6 +192,10 @@ ASSERT(__hyp_idmap_text_end - (__hyp_idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
 	"HYP init code too big or misaligned")
 ASSERT(__idmap_text_end - (__idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
 	"ID map text too big or misaligned")
+#ifdef CONFIG_HIBERNATION
+ASSERT(__hibernate_exit_text_end - (__hibernate_exit_text_start & ~(SZ_4K - 1))
+	<= SZ_4K, "Hibernate exit text too big or misaligned")
+#endif
 
 /*
  * If padding is applied before .head.text, virt<->phys conversions will fail.
-- 
2.1.4
