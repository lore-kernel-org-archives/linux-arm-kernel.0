From: james.morse@arm.com (James Morse)
Date: Fri,  1 Apr 2016 17:53:39 +0100
Subject: [PATCH v7 15/16] arm64: kernel: Add support for
 hibernate/suspend-to-disk
In-Reply-To: <1459529620-22150-1-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
Message-ID: <1459529620-22150-16-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for hibernate/suspend-to-disk.

Suspend borrows code from cpu_suspend() to write cpu state onto the stack,
before calling swsusp_save() to save the memory image.

Restore creates a set of temporary page tables, covering only the
linear map, copies the restore code to a 'safe' page, then uses the copy to
restore the memory image. The copied code executes in the lower half of the
address space, and once complete, restores the original kernel's page
tables. It then calls into cpu_resume(), and follows the normal
cpu_suspend() path back into the suspend code.

To restore a kernel using KASLR, the address of the page tables, and
cpu_resume() are stored in the hibernate arch-header and the el2
vectors are pivotted via the 'safe' page in low memory. This also permits
us to resume using a different version of the kernel to the version that
hibernated, but because the MMU isn't turned off during resume, the
MMU settings must be the same between both kernels. To ensure this, the
value of the translation control register (TCR_EL1) is also included in the
hibernate arch-header, this means your resume kernel must have the same
page size, and virtual address space size.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Kevin Hilman <khilman@baylibre.com> # Tested on Juno R2
---
 arch/arm64/Kconfig                |   7 +
 arch/arm64/include/asm/suspend.h  |   7 +
 arch/arm64/kernel/Makefile        |   1 +
 arch/arm64/kernel/asm-offsets.c   |   5 +
 arch/arm64/kernel/hibernate-asm.S | 166 +++++++++++++
 arch/arm64/kernel/hibernate.c     | 503 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S   |  15 ++
 7 files changed, 704 insertions(+)
 create mode 100644 arch/arm64/kernel/hibernate-asm.S
 create mode 100644 arch/arm64/kernel/hibernate.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4f436220384f..7f4ad0075b97 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -953,6 +953,13 @@ menu "Power management options"
 
 source "kernel/power/Kconfig"
 
+config ARCH_HIBERNATION_POSSIBLE
+	def_bool y
+
+config ARCH_HIBERNATION_HEADER
+	def_bool y
+	depends on HIBERNATION
+
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index 29d3c71433e1..024d623f662e 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -40,4 +40,11 @@ extern int cpu_suspend(unsigned long arg, int (*fn)(unsigned long));
 extern void cpu_resume(void);
 int __cpu_suspend_enter(struct sleep_stack_data *state);
 void __cpu_suspend_exit(void);
+void _cpu_resume(void);
+
+int swsusp_arch_suspend(void);
+int swsusp_arch_resume(void);
+int arch_hibernation_header_save(void *addr, unsigned int max_size);
+int arch_hibernation_header_restore(void *addr);
+
 #endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 3793003e16a2..2173149d8954 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -45,6 +45,7 @@ arm64-obj-$(CONFIG_ACPI)		+= acpi.o
 arm64-obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
 arm64-obj-$(CONFIG_PARAVIRT)		+= paravirt.o
 arm64-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
+arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index ac742ef0fde0..f8e5d47f0880 100644
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
@@ -124,5 +125,9 @@ int main(void)
 #endif
   DEFINE(ARM_SMCCC_RES_X0_OFFS,	offsetof(struct arm_smccc_res, a0));
   DEFINE(ARM_SMCCC_RES_X2_OFFS,	offsetof(struct arm_smccc_res, a2));
+  BLANK();
+  DEFINE(HIBERN_PBE_ORIG,	offsetof(struct pbe, orig_address));
+  DEFINE(HIBERN_PBE_ADDR,	offsetof(struct pbe, address));
+  DEFINE(HIBERN_PBE_NEXT,	offsetof(struct pbe, next));
   return 0;
 }
diff --git a/arch/arm64/kernel/hibernate-asm.S b/arch/arm64/kernel/hibernate-asm.S
new file mode 100644
index 000000000000..28c814aee608
--- /dev/null
+++ b/arch/arm64/kernel/hibernate-asm.S
@@ -0,0 +1,166 @@
+#include <linux/linkage.h>
+#include <linux/errno.h>
+
+#include <asm/asm-offsets.h>
+#include <asm/assembler.h>
+#include <asm/cputype.h>
+#include <asm/memory.h>
+#include <asm/page.h>
+#include <asm/virt.h>
+
+/*
+ * Corrupt memory.
+ *
+ * Loads temporary page tables then restores the memory image.
+ * Finally branches to cpu_resume() to restore the state saved by
+ * swsusp_arch_suspend().
+ *
+ * Because this code has to be copied to a safe_page, it can't call out to
+ * other functions by PC-relative address. Also remember that it may be
+ * mid-way through over-writing other functions. For this reason it contains
+ * code from flush_icache_range() and uses the copy_page() macro.
+ *
+ * All of memory gets written to, including code. We need to clean the kernel
+ * text to the Point of Coherence (PoC) before secondary cores can be booted.
+ * Because the kernel modules and executable pages mapped to user space are
+ * also written as data, we clean all pages we touch to the Point of
+ * Unification (PoU).
+ *
+ * We use el2_setup() to reconfigure el2. This code needs cleaning to PoC by VA,
+ * but called with its physical address, as we left el2 with the MMU turned off.
+ *
+ * x0: physical address of temporary page tables
+ * x1: physical address of swapper page tables
+ * x2: address of cpu_resume
+ * x3: linear map address of restore_pblist in the current kernel
+ * x4: virtual address of the page containing el2_setup, used to clean to PoC
+ * x5: physical address of el2_setup, used to execute at el2
+ */
+.pushsection    ".hibernate_exit.text", "ax"
+ENTRY(swsusp_arch_suspend_exit)
+	/* Temporary page tables are a copy, so no need for a trampoline here */
+	msr	ttbr1_el1, x0
+	isb
+	tlbi	vmalle1is	/* invalidate intermediate caching entries */
+	dsb	ish
+
+	mov	x21, x1
+	mov	x30, x2		/* el2_setup() will eret to the lr directly */
+	mov	x24, x4
+	mov	x25, x5
+
+	/* walk the restore_pblist and use copy_page() to over-write memory */
+	mov	x19, x3
+
+1:	ldr	x10, [x19, #HIBERN_PBE_ORIG]
+	mov	x0, x10
+	ldr	x1, [x19, #HIBERN_PBE_ADDR]
+
+	copy_page	x0, x1, x2, x3, x4, x5, x6, x7, x8, x9
+
+	add	x1, x10, #PAGE_SIZE
+	/* Clean the copied page to PoU - based on flush_icache_range() */
+	dcache_line_size x2, x3
+	sub	x3, x2, #1
+	bic	x4, x10, x3
+2:	dc	cvau, x4	/* clean D line / unified line */
+	add	x4, x4, x2
+	cmp	x4, x1
+	b.lo	2b
+
+	ldr	x19, [x19, #HIBERN_PBE_NEXT]
+	cbnz	x19, 1b
+
+
+	/* switch to the restored kernels page tables, to reconfigure el2 */
+	msr	ttbr1_el1, x21  /* physical address of swapper page tables */
+	isb
+	tlbi	vmalle1is	/* invalidate intermediate caching entries */
+	ic	ialluis
+	dsb	ish		/* also waits for PoU cleaning to finish */
+	isb
+
+
+	cbz	x24, 4f		/* Did we boot at el1? */
+	/* Clean el2_setup's page to PoC */
+	mov	x0, x24
+	/*
+	 * We don't know if el2_setup() overlaps a page boundary, clean two
+	 * pages, just in case.
+	 */
+	add	x1, x0, #2*PAGE_SIZE
+	dcache_line_size x2, x3
+	sub	x3, x2, #1
+	bic	x4, x0, x3
+3:	dc	cvac, x4
+	add	x4, x4, x2
+	cmp	x4, x1
+	b.lo	3b
+
+	/* reconfigure el2 */
+	mrs	x0, sctlr_el1
+	hvc	#0
+
+	/*
+	 * el2_setup() will eret to the location in x30, so we
+	 * only get here if we booted at el1.
+	 */
+
+4:	ret
+
+	.ltorg
+ENDPROC(swsusp_arch_suspend_exit)
+
+/*
+ * Restore the hyp stub. Once we know where in memory el2_setup is, we
+ * can use it to re-initialise el2. This must be done before the hibernate
+ * page is unmapped.
+ *
+ * x0: The current sctlr_el1 value, to be re-loaded
+ * x25: The physical address of el2_setup __pa(el2_setup)
+ * x30: Where el2_setup() should eret to
+ */
+el1_sync:
+	br	x25
+ENDPROC(el1_sync)
+
+.macro invalid_vector	label
+\label:
+	b \label
+ENDPROC(\label)
+.endm
+
+	invalid_vector	el2_sync_invalid
+	invalid_vector	el2_irq_invalid
+	invalid_vector	el2_fiq_invalid
+	invalid_vector	el2_error_invalid
+	invalid_vector	el1_sync_invalid
+	invalid_vector	el1_irq_invalid
+	invalid_vector	el1_fiq_invalid
+	invalid_vector	el1_error_invalid
+
+/* el2 vectors - switch el2 here while we restore the memory image. */
+	.align 11
+ENTRY(hibernate_el2_vectors)
+	ventry	el2_sync_invalid		// Synchronous EL2t
+	ventry	el2_irq_invalid			// IRQ EL2t
+	ventry	el2_fiq_invalid			// FIQ EL2t
+	ventry	el2_error_invalid		// Error EL2t
+
+	ventry	el2_sync_invalid		// Synchronous EL2h
+	ventry	el2_irq_invalid			// IRQ EL2h
+	ventry	el2_fiq_invalid			// FIQ EL2h
+	ventry	el2_error_invalid		// Error EL2h
+
+	ventry	el1_sync			// Synchronous 64-bit EL1
+	ventry	el1_irq_invalid			// IRQ 64-bit EL1
+	ventry	el1_fiq_invalid			// FIQ 64-bit EL1
+	ventry	el1_error_invalid		// Error 64-bit EL1
+
+	ventry	el1_sync_invalid		// Synchronous 32-bit EL1
+	ventry	el1_irq_invalid			// IRQ 32-bit EL1
+	ventry	el1_fiq_invalid			// FIQ 32-bit EL1
+	ventry	el1_error_invalid		// Error 32-bit EL1
+END(hibernate_el2_vectors)
+
+.popsection
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
new file mode 100644
index 000000000000..279c556ee24b
--- /dev/null
+++ b/arch/arm64/kernel/hibernate.c
@@ -0,0 +1,503 @@
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
+#include <asm/pgtable-hwdef.h>
+#include <asm/sections.h>
+#include <asm/suspend.h>
+#include <asm/virt.h>
+
+/* These are necessary to build without ifdefery */
+#ifndef pmd_index
+#define pmd_index(x)	0
+#endif
+#ifndef pud_index
+#define pud_index(x)	0
+#endif
+
+#define TCR_IPS_BITS (0x7UL<<32)
+
+/*
+ * Hibernate core relies on this value being 0 on resume, and marks it
+ * __nosavedata assuming it will keep the resume kernel's '0' value. This
+ * doesn't happen with either KASLR or resuming with a different kernel.
+ *
+ * defined as "__visible int in_suspend __nosavedata" in
+ * kernel/power/hibernate.c
+ */
+extern int in_suspend;
+
+/*
+ * This value is written to the hibernate arch header, and prevents resuming
+ * from a hibernate image produced by an incompatible kernel. If you change
+ * a value that isn't saved/restored by hibernate, you should change this value.
+ *
+ * For example, if the mair_el1 values used by the kernel are changed, you
+ * should prevent resuming from a kernel with incompatible attributes, as these
+ * aren't saved/restored.
+ */
+#define HIBERNATE_VERSION	KERNEL_VERSION(4, 6, 0)
+
+/* Find a symbols alias in the linear map */
+#define LMADDR(x)	phys_to_virt(virt_to_phys(x))
+
+/*
+ * Start/end of the hibernate exit code, this must be copied to a 'safe'
+ * location in memory, and executed from there.
+ */
+extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
+
+/* temporary el2 vectors in the __hibernate_exit_text section. */
+extern char hibernate_el2_vectors[];
+
+/* el2_setup(), in head.S, use to re-configure el2 */
+extern char el2_setup[];
+
+struct arch_hibernate_hdr_invariants {
+	unsigned long	version;
+	unsigned long	tcr_el1;	/* page_size, va bit etc */
+};
+
+/* These values need to be know across a hibernate/restore. */
+static struct arch_hibernate_hdr {
+	struct arch_hibernate_hdr_invariants invariants;
+
+	/* These are needed to find the relocated kernel if built with kaslr */
+	phys_addr_t	ttbr1_el1;
+	void		(*reenter_kernel)(void);
+
+	/*
+	 * We need to know where el2_setup() is after restore to re-configure
+	 * el2. But first, we need to clean it to PoC by va, as we left el2 with
+	 * the MMU off. Both values will be 0 if we booted@el1.
+	 */
+	phys_addr_t	el2_setup_phys;
+	unsigned long	el2_setup_page;
+} resume_hdr;
+
+static inline void arch_hdr_invariants(struct arch_hibernate_hdr_invariants *i)
+{
+	i->version = HIBERNATE_VERSION;
+	asm volatile("mrs	%0, tcr_el1" : "=r"(i->tcr_el1));
+
+	/* IPS bits vary on big/little systems, mask them out */
+	i->tcr_el1 &= ~TCR_IPS_BITS;
+}
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
+}
+
+void notrace restore_processor_state(void)
+{
+}
+
+int arch_hibernation_header_save(void *addr, unsigned int max_size)
+{
+	struct arch_hibernate_hdr *hdr = addr;
+
+	if (max_size < sizeof(*hdr))
+		return -EOVERFLOW;
+
+	arch_hdr_invariants(&hdr->invariants);
+	hdr->ttbr1_el1		= virt_to_phys(swapper_pg_dir);
+	hdr->reenter_kernel	= _cpu_resume;
+	if (is_hyp_mode_available()) {
+		hdr->el2_setup_page	= (unsigned long)el2_setup & PAGE_MASK;
+		hdr->el2_setup_phys	= virt_to_phys(el2_setup);
+	} else {
+		hdr->el2_setup_page = 0;
+		hdr->el2_setup_phys = 0;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(arch_hibernation_header_save);
+
+int arch_hibernation_header_restore(void *addr)
+{
+	struct arch_hibernate_hdr_invariants invariants;
+	struct arch_hibernate_hdr *hdr = addr;
+
+	/*
+	 * If this header is ancient, it may be smaller than we expect.
+	 * Test the version first.
+	 */
+	if (hdr->invariants.version != HIBERNATE_VERSION) {
+		pr_crit("Hibernate image not compatible with this kernel version!\n");
+		return -EINVAL;
+	}
+
+	arch_hdr_invariants(&invariants);
+	if (memcmp(&hdr->invariants, &invariants, sizeof(invariants))) {
+		pr_crit("Hibernate image not compatible with this kernel configuration!\n");
+		return -EINVAL;
+	}
+
+	if ((is_hyp_mode_available() && !hdr->el2_setup_page) ||
+	    (!is_hyp_mode_available() && hdr->el2_setup_page)) {
+		pr_crit("Hibernate/resume kernels booted with differing virtualisation support. (EL1/EL2) ");
+		return -EINVAL;
+	}
+
+	resume_hdr = *hdr;
+
+	return 0;
+}
+EXPORT_SYMBOL(arch_hibernation_header_restore);
+
+/*
+ * Copies length bytes, starting at src_start into an new page,
+ * perform cache maintentance, then map it (nearly) at the bottom of memory
+ * as executable.
+ *
+ * This is used by hibernate to copy the code it needs to execute when
+ * overwriting the kernel text. This function generates a new set of page
+ * tables, which it loads into ttbr0.
+ *
+ * Length is provided as we probably only want 4K of data, even on a 64K
+ * page system. We don't use the very bottom page, so that dereferencing
+ * NULL continues to have the expected behaviour.
+ */
+static int create_safe_exec_page(void *src_start, size_t length,
+				 void **dst_addr, phys_addr_t *phys_dst_addr,
+				 unsigned long (*allocator)(gfp_t mask),
+				 gfp_t mask)
+{
+	int rc = 0;
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	unsigned long dst = allocator(mask);
+
+	if (!dst) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	memcpy((void *)dst, src_start, length);
+	flush_icache_range(dst, dst + length);
+
+	pgd = (pgd_t *)allocator(mask) + pgd_index(PAGE_SIZE);
+	if (PTRS_PER_PGD > 1) {
+		pud = (pud_t *)allocator(mask);
+		if (!pud) {
+			rc = -ENOMEM;
+			goto out;
+		}
+		set_pgd(pgd, __pgd(virt_to_phys(pud) | PUD_TYPE_TABLE));
+	}
+
+	pud = pud_offset(pgd, PAGE_SIZE);
+	if (PTRS_PER_PUD > 1) {
+		pmd = (pmd_t *)allocator(mask);
+		if (!pmd) {
+			rc = -ENOMEM;
+			goto out;
+		}
+		set_pud(pud, __pud(virt_to_phys(pmd) | PUD_TYPE_TABLE));
+	}
+
+	pmd = pmd_offset(pud, PAGE_SIZE);
+	if (PTRS_PER_PMD > 1) {
+		pte = (pte_t *)allocator(mask);
+		if (!pte) {
+			rc = -ENOMEM;
+			goto out;
+		}
+		set_pmd(pmd, __pmd(virt_to_phys(pte) | PMD_TYPE_TABLE));
+	}
+
+	pte = pte_offset_kernel(pmd, PAGE_SIZE);
+	set_pte_at(&init_mm, dst, pte,
+		   __pte(virt_to_phys((void *)dst) |
+			 pgprot_val(PAGE_KERNEL_EXEC)));
+
+	/* Load our new page tables */
+	asm volatile("msr	ttbr0_el1, %0;"
+		     "isb;"
+		     "tlbi	vmalle1is;"
+		     "dsb	ish" : : "r"(virt_to_phys(pgd)));
+
+	*dst_addr = (void *)(PAGE_SIZE);
+	*phys_dst_addr = virt_to_phys((void *)dst);
+
+out:
+	return rc;
+}
+
+
+int swsusp_arch_suspend(void)
+{
+	int ret = 0;
+	unsigned long flags;
+	struct sleep_stack_data state;
+
+	local_dbg_save(flags);
+
+	if (__cpu_suspend_enter(&state)) {
+		ret = swsusp_save();
+	} else {
+		void *lm_kernel_start;
+
+		/* Clean kernel to PoC for secondary core startup */
+		lm_kernel_start = LMADDR(KERNEL_START);
+		__flush_dcache_area(lm_kernel_start, KERNEL_END - KERNEL_START);
+
+		/*
+		 * Tell the hibernation core that we've just restored
+		 * the memory
+		 */
+		in_suspend = 0;
+
+		__cpu_suspend_exit();
+	}
+
+	local_dbg_restore(flags);
+
+	return ret;
+}
+
+static int copy_pte(pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long start,
+		    unsigned long end)
+{
+	unsigned long next;
+	unsigned long addr = start;
+	pte_t *src_pte = pte_offset_kernel(src_pmd, start);
+	pte_t *dst_pte = pte_offset_kernel(dst_pmd, start);
+
+	do {
+		next = addr + PAGE_SIZE;
+		if (pte_val(*src_pte))
+			set_pte(dst_pte,
+				__pte(pte_val(*src_pte) & ~PTE_RDONLY));
+	} while (dst_pte++, src_pte++, addr = next, addr != end);
+
+	return 0;
+}
+
+static int copy_pmd(pud_t *dst_pud, pud_t *src_pud, unsigned long start,
+		    unsigned long end)
+{
+	int rc = 0;
+	pte_t *dst_pte;
+	unsigned long next;
+	unsigned long addr = start;
+	pmd_t *src_pmd = pmd_offset(src_pud, start);
+	pmd_t *dst_pmd = pmd_offset(dst_pud, start);
+
+	do {
+		next = pmd_addr_end(addr, end);
+		if (!pmd_val(*src_pmd))
+			continue;
+
+		if (pmd_table(*(src_pmd))) {
+			dst_pte = (pte_t *)get_safe_page(GFP_ATOMIC);
+			if (!dst_pte) {
+				rc = -ENOMEM;
+				break;
+			}
+
+			set_pmd(dst_pmd, __pmd(virt_to_phys(dst_pte)
+					       | PMD_TYPE_TABLE));
+
+			rc = copy_pte(dst_pmd, src_pmd, addr, next);
+			if (rc)
+				break;
+		} else {
+			set_pmd(dst_pmd,
+				__pmd(pmd_val(*src_pmd) & ~PMD_SECT_RDONLY));
+		}
+	} while (dst_pmd++, src_pmd++, addr = next, addr != end);
+
+	return rc;
+}
+
+static int copy_pud(pgd_t *dst_pgd, pgd_t *src_pgd, unsigned long start,
+		    unsigned long end)
+{
+	int rc = 0;
+	pmd_t *dst_pmd;
+	unsigned long next;
+	unsigned long addr = start;
+	pud_t *src_pud = pud_offset(src_pgd, start);
+	pud_t *dst_pud = pud_offset(dst_pgd, start);
+
+	do {
+		next = pud_addr_end(addr, end);
+		if (!pud_val(*src_pud))
+			continue;
+
+		if (pud_table(*(src_pud))) {
+			if (PTRS_PER_PMD != 1) {
+				dst_pmd = (pmd_t *)get_safe_page(GFP_ATOMIC);
+				if (!dst_pmd) {
+					rc = -ENOMEM;
+					break;
+				}
+
+				set_pud(dst_pud, __pud(virt_to_phys(dst_pmd)
+						       | PUD_TYPE_TABLE));
+			}
+
+			rc = copy_pmd(dst_pud, src_pud, addr, next);
+			if (rc)
+				break;
+		} else {
+			set_pud(dst_pud,
+				__pud(pud_val(*src_pud) & ~PMD_SECT_RDONLY));
+		}
+	} while (dst_pud++, src_pud++, addr = next, addr != end);
+
+	return rc;
+}
+
+static int copy_page_tables(pgd_t *dst_pgd, unsigned long start,
+			    unsigned long end)
+{
+	int rc = 0;
+	pud_t *dst_pud;
+	unsigned long next;
+	unsigned long addr = start;
+	pgd_t *src_pgd = pgd_offset_k(start);
+
+	dst_pgd += pgd_index(start);
+
+	do {
+		next = pgd_addr_end(addr, end);
+		if (!pgd_val(*src_pgd))
+			continue;
+
+		if (PTRS_PER_PUD != 1) {
+			dst_pud = (pud_t *)get_safe_page(GFP_ATOMIC);
+			if (!dst_pud) {
+				rc = -ENOMEM;
+				break;
+			}
+
+			set_pgd(dst_pgd, __pgd(virt_to_phys(dst_pud)
+					       | PUD_TYPE_TABLE));
+		}
+
+		rc = copy_pud(dst_pgd, src_pgd, addr, next);
+		if (rc)
+			break;
+	} while (dst_pgd++, src_pgd++, addr = next, addr != end);
+
+	return rc;
+}
+
+/*
+ * Setup then Resume from the hibernate image using swsusp_arch_suspend_exit().
+ *
+ * Memory allocated by get_safe_page() will be dealt with by the hibernate code,
+ * we don't need to free it here.
+ */
+int swsusp_arch_resume(void)
+{
+	int rc = 0;
+	size_t exit_size;
+	pgd_t *tmp_pg_dir;
+	void *lm_restore_pblist;
+	phys_addr_t phys_hibernate_exit;
+	void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t, void *,
+					  void *, unsigned long, phys_addr_t);
+
+	/*
+	 * Copy swsusp_arch_suspend_exit() to a safe page. This will generate
+	 * a new set of ttbr0 page tables and load them.
+	 */
+	exit_size = __hibernate_exit_text_end - __hibernate_exit_text_start;
+	rc = create_safe_exec_page(__hibernate_exit_text_start, exit_size,
+				   (void **)&hibernate_exit,
+				   &phys_hibernate_exit,
+				   get_safe_page, GFP_ATOMIC);
+	if (rc) {
+		pr_err("Failed to create safe executable page for hibernate_exit code.");
+		goto out;
+	}
+
+	/*
+	 * The hibernate exit text contains a set of el2 vectors, that will
+	 * be executed at el2 with the mmu off in order to reload hyp-stub.
+	 */
+	__flush_dcache_area(hibernate_exit, exit_size);
+
+	/*
+	 * Restoring the memory image will overwrite the ttbr1 page tables.
+	 * Create a second copy of just the linear map, and use this when
+	 * restoring.
+	 */
+	tmp_pg_dir = (pgd_t *)get_safe_page(GFP_ATOMIC);
+	if (!tmp_pg_dir) {
+		pr_err("Failed to allocate memory for temporary page tables.");
+		rc = -ENOMEM;
+		goto out;
+	}
+	rc = copy_page_tables(tmp_pg_dir, PAGE_OFFSET, 0);
+	if (rc)
+		goto out;
+
+	/*
+	 * Since we only copied the linear map, we need to find restore_pblist's
+	 * linear map address.
+	 */
+	lm_restore_pblist = LMADDR(restore_pblist);
+
+	/*
+	 * Both KASLR and restoring with a different kernel version will cause
+	 * the el2 vectors to be in a different location in the resumed kernel.
+	 * Load hibernate's temporary copy into el2.
+	 */
+	if (is_hyp_mode_available()) {
+		phys_addr_t el2_vectors = phys_hibernate_exit;  /* base */
+		el2_vectors += hibernate_el2_vectors -
+			       __hibernate_exit_text_start;     /* offset */
+
+		__hyp_set_vectors(el2_vectors);
+	}
+
+	hibernate_exit(virt_to_phys(tmp_pg_dir), resume_hdr.ttbr1_el1,
+		       resume_hdr.reenter_kernel, lm_restore_pblist,
+		       resume_hdr.el2_setup_page, resume_hdr.el2_setup_phys);
+
+out:
+	return rc;
+}
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 5a1939a74ff3..48fab0553872 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -46,6 +46,16 @@ jiffies = jiffies_64;
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
@@ -109,6 +119,7 @@ SECTIONS
 			LOCK_TEXT
 			HYPERVISOR_TEXT
 			IDMAP_TEXT
+			HIBERNATE_TEXT
 			*(.fixup)
 			*(.gnu.warning)
 		. = ALIGN(16);
@@ -201,6 +212,10 @@ ASSERT(__hyp_idmap_text_end - (__hyp_idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
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
2.8.0.rc3
