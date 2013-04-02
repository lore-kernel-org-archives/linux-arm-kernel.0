From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  2 Apr 2013 14:25:14 +0100
Subject: [PATCH 6/7] ARM: KVM: switch to a dual-step HYP init code
In-Reply-To: <1364909115-3810-1-git-send-email-marc.zyngier@arm.com>
References: <1364909115-3810-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1364909115-3810-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our HYP init code suffers from two major design issues:
- it cannot support CPU hotplug, as we tear down the idmap very early
- it cannot perform a TLB invalidation when switching from init to
  runtime mappings, as pages are manipulated from PL1 exclusively

The hotplug problem mandates that we keep two sets of page tables
(boot and runtime). The TLB problem mandates that we're able to
transition from one PGD to another while in HYP, invalidating the TLBs
in the process.

To be able to do this, we need to share a page between the two page
tables. A page that will have the same VA in both configurations. All we
need is a VA that has the following properties:
- This VA can't be used to represent a kernel mapping.
- This VA will not conflict with the physical address of the kernel text

The vectors page seems to satisfy this requirement:
- The kernel never maps anything else there
- The kernel text being copied at the beginning of the physical memory,
  it is unlikely to use the last 64kB (I doubt we'll ever support KVM
  on a system with something like 4MB of RAM, but patches are very
  welcome).

Let's call this VA the trampoline VA.

Now, we map our init page at 3 locations:
- idmap in the boot pgd
- trampoline VA in the boot pgd
- trampoline VA in the runtime pgd

The init scenario is now the following:
- We jump in HYP with four parameters: boot HYP pgd, runtime HYP pgd,
  runtime stack, runtime vectors
- Enable the MMU with the boot pgd
- Jump to a target into the trampoline page (remember, this is the same
  physical page!)
- Now switch to the runtime pgd (same VA, and still the same physical
  page!)
- Invalidate TLBs
- Set stack and vectors
- Profit! (or eret, if you only care about the code).

Note that we keep the boot mapping permanently (it is not strictly an
idmap anymore) to allow for CPU hotplug in later patches.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h | 18 ++++++++---
 arch/arm/include/asm/kvm_mmu.h  | 21 ++++++++++--
 arch/arm/kvm/arm.c              |  9 ++----
 arch/arm/kvm/init.S             | 29 +++++++++++++++--
 arch/arm/kvm/mmu.c              | 71 ++++++++++++++++++++++-------------------
 5 files changed, 101 insertions(+), 47 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index a7a0bb5..3556684 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -190,22 +190,32 @@ int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
 int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		int exception_index);
 
-static inline void __cpu_init_hyp_mode(unsigned long long pgd_ptr,
+static inline void __cpu_init_hyp_mode(unsigned long long boot_pgd_ptr,
+				       unsigned long long pgd_ptr,
 				       unsigned long hyp_stack_ptr,
 				       unsigned long vector_ptr)
 {
 	unsigned long pgd_low, pgd_high;
 
-	pgd_low = (pgd_ptr & ((1ULL << 32) - 1));
-	pgd_high = (pgd_ptr >> 32ULL);
+	pgd_low = (boot_pgd_ptr & ((1ULL << 32) - 1));
+	pgd_high = (boot_pgd_ptr >> 32ULL);
 
 	/*
 	 * Call initialization code, and switch to the full blown
 	 * HYP code. The init code doesn't need to preserve these registers as
-	 * r1-r3 and r12 are already callee save according to the AAPCS.
+	 * r1-r3 and r12 are already callee saved according to the AAPCS.
 	 * Note that we slightly misuse the prototype by casing the pgd_low to
 	 * a void *.
+	 *
+	 * We don't have enough registers to perform the full init in one go.
+	 * Install the boot PGD first, and then install the runtime PGD,
+	 * stack pointer and vectors.
 	 */
+	kvm_call_hyp((void *)pgd_low, pgd_high, 0, 0);
+
+	pgd_low = (pgd_ptr & ((1ULL << 32) - 1));
+	pgd_high = (pgd_ptr >> 32ULL);
+
 	kvm_call_hyp((void *)pgd_low, pgd_high, hyp_stack_ptr, vector_ptr);
 }
 
diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 92eb20d..3567a49 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -19,17 +19,29 @@
 #ifndef __ARM_KVM_MMU_H__
 #define __ARM_KVM_MMU_H__
 
-#include <asm/cacheflush.h>
-#include <asm/pgalloc.h>
+#include <asm/memory.h>
+#include <asm/page.h>
 
 /*
  * We directly use the kernel VA for the HYP, as we can directly share
  * the mapping (HTTBR "covers" TTBR1).
  */
-#define HYP_PAGE_OFFSET_MASK	(~0UL)
+#define HYP_PAGE_OFFSET_MASK	UL(~0)
 #define HYP_PAGE_OFFSET		PAGE_OFFSET
 #define KERN_TO_HYP(kva)	(kva)
 
+/*
+ * Our virtual mapping for the boot-time MMU-enable code. Must be
+ * shared across all the page-tables. Conveniently, we use the vectors
+ * page, where no kernel data will ever be shared with HYP.
+ */
+#define TRAMPOLINE_VA		UL(CONFIG_VECTORS_BASE)
+
+#ifndef __ASSEMBLY__
+
+#include <asm/cacheflush.h>
+#include <asm/pgalloc.h>
+
 int create_hyp_mappings(void *from, void *to);
 int create_hyp_io_mappings(void *from, void *to, phys_addr_t);
 void free_hyp_pgds(void);
@@ -44,6 +56,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run);
 void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
 
 phys_addr_t kvm_mmu_get_httbr(void);
+phys_addr_t kvm_mmu_get_boot_httbr(void);
 int kvm_mmu_init(void);
 void kvm_clear_hyp_idmap(void);
 
@@ -113,4 +126,6 @@ static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
 	}
 }
 
+#endif	/* !__ASSEMBLY__ */
+
 #endif /* __ARM_KVM_MMU_H__ */
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 6eba879..f0f3290 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -795,6 +795,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 
 static void cpu_init_hyp_mode(void *vector)
 {
+	unsigned long long boot_pgd_ptr;
 	unsigned long long pgd_ptr;
 	unsigned long hyp_stack_ptr;
 	unsigned long stack_page;
@@ -803,12 +804,13 @@ static void cpu_init_hyp_mode(void *vector)
 	/* Switch from the HYP stub to our own HYP init vector */
 	__hyp_set_vectors((unsigned long)vector);
 
+	boot_pgd_ptr = (unsigned long long)kvm_mmu_get_boot_httbr();
 	pgd_ptr = (unsigned long long)kvm_mmu_get_httbr();
 	stack_page = __get_cpu_var(kvm_arm_hyp_stack_page);
 	hyp_stack_ptr = stack_page + PAGE_SIZE;
 	vector_ptr = (unsigned long)__kvm_hyp_vector;
 
-	__cpu_init_hyp_mode(pgd_ptr, hyp_stack_ptr, vector_ptr);
+	__cpu_init_hyp_mode(boot_pgd_ptr, pgd_ptr, hyp_stack_ptr, vector_ptr);
 }
 
 /**
@@ -862,11 +864,6 @@ static int init_hyp_mode(void)
 	}
 
 	/*
-	 * Unmap the identity mapping
-	 */
-	kvm_clear_hyp_idmap();
-
-	/*
 	 * Map the Hyp-code called directly from the host
 	 */
 	err = create_hyp_mappings(__kvm_hyp_code_start, __kvm_hyp_code_end);
diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
index 35a463f..b2c6967 100644
--- a/arch/arm/kvm/init.S
+++ b/arch/arm/kvm/init.S
@@ -21,6 +21,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_arm.h>
+#include <asm/kvm_mmu.h>
 
 /********************************************************************
  * Hypervisor initialization
@@ -47,6 +48,9 @@ __kvm_hyp_init:
 	W(b)	.
 
 __do_hyp_init:
+	cmp	r2, #0			@ We have a SP?
+	bne	phase2			@ Yes, second stage init
+
 	@ Set the HTTBR to point to the hypervisor PGD pointer passed
 	mcrr	p15, 4, r0, r1, c2
 
@@ -96,14 +100,35 @@ __do_hyp_init:
 	orr	r0, r0, r1
 	isb
 	mcr	p15, 4, r0, c1, c0, 0	@ HSCR
-	isb
 
-	@ Set stack pointer and return to the kernel
+	eret
+
+phase2:
+	@ Set stack pointer
 	mov	sp, r2
 
 	@ Set HVBAR to point to the HYP vectors
 	mcr	p15, 4, r3, c12, c0, 0	@ HVBAR
 
+	@ Jump to the trampoline page
+	ldr	r2, =#PAGE_MASK
+	adr	r3, target
+	bic	r3, r3, r2
+	ldr	r2, =#TRAMPOLINE_VA
+	add	r3, r3, r2
+	mov	pc, r3
+
+	nop
+
+target:	@ We're now in the trampoline code, switch page tables
+	mcrr	p15, 4, r0, r1, c2
+	isb
+
+	@ Invalidate the old TLBs
+	mcr	p15, 4, r0, c8, c7, 0	@ TLBIALLH
+	dsb
+	isb
+
 	eret
 
 	.ltorg
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 85b3553..ed5587f 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -32,6 +32,7 @@
 
 extern char  __hyp_idmap_text_start[], __hyp_idmap_text_end[];
 
+static pgd_t *boot_hyp_pgd;
 static pgd_t *hyp_pgd;
 static DEFINE_MUTEX(kvm_hyp_pgd_mutex);
 
@@ -111,6 +112,8 @@ static void free_hyp_pgd_entry(pgd_t *pgdp, unsigned long addr)
  * Assumes hyp_pgd is a page table used strictly in Hyp-mode and therefore contains
  * either mappings in the kernel memory area (above PAGE_OFFSET), or
  * device mappings in the vmalloc range (from VMALLOC_START to VMALLOC_END).
+ *
+ * boot_hyp_pgd should only map two pages for the init code.
  */
 void free_hyp_pgds(void)
 {
@@ -118,6 +121,12 @@ void free_hyp_pgds(void)
 
 	mutex_lock(&kvm_hyp_pgd_mutex);
 
+	if (boot_hyp_pgd) {
+		free_hyp_pgd_entry(boot_hyp_pgd, virt_to_phys(__hyp_idmap_text_start));
+		free_hyp_pgd_entry(boot_hyp_pgd, TRAMPOLINE_VA);
+		kfree(boot_hyp_pgd);
+	}
+
 	if (hyp_pgd) {
 		for (addr = PAGE_OFFSET; virt_addr_valid(addr); addr += PGDIR_SIZE)
 			free_hyp_pgd_entry(hyp_pgd, KERN_TO_HYP(addr));
@@ -718,6 +727,12 @@ phys_addr_t kvm_mmu_get_httbr(void)
 	return virt_to_phys(hyp_pgd);
 }
 
+phys_addr_t kvm_mmu_get_boot_httbr(void)
+{
+	VM_BUG_ON(!virt_addr_valid(boot_hyp_pgd));
+	return virt_to_phys(boot_hyp_pgd);
+}
+
 int kvm_mmu_init(void)
 {
 	unsigned long hyp_idmap_start = virt_to_phys(__hyp_idmap_text_start);
@@ -725,7 +740,8 @@ int kvm_mmu_init(void)
 	int err;
 
 	hyp_pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
-	if (!hyp_pgd) {
+	boot_hyp_pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
+	if (!hyp_pgd || !boot_hyp_pgd) {
 		kvm_err("Hyp mode PGD not allocated\n");
 		err = -ENOMEM;
 		goto out;
@@ -743,39 +759,30 @@ int kvm_mmu_init(void)
 		goto out;
 	}
 
+	/* Map the very same page at the trampoline VA */
+	err = 	__create_hyp_mappings(boot_hyp_pgd,
+				      TRAMPOLINE_VA, TRAMPOLINE_VA + PAGE_SIZE,
+				      __phys_to_pfn(hyp_idmap_start),
+				      PAGE_HYP);
+	if (err) {
+		kvm_err("Failed to map trampoline @%lx into boot HYP pgd\n",
+			TRAMPOLINE_VA);
+		goto out;
+	}
+
+	/* Map the same page again into the runtime page tables */
+	err = 	__create_hyp_mappings(hyp_pgd,
+				      TRAMPOLINE_VA, TRAMPOLINE_VA + PAGE_SIZE,
+				      __phys_to_pfn(hyp_idmap_start),
+				      PAGE_HYP);
+	if (err) {
+		kvm_err("Failed to map trampoline @%lx into runtime HYP pgd\n",
+			TRAMPOLINE_VA);
+		goto out;
+	}
+
 	return 0;
 out:
 	free_hyp_pgds();
 	return err;
 }
-
-/**
- * kvm_clear_idmap - remove all idmaps from the hyp pgd
- *
- * Free the underlying pmds for all pgds in range and clear the pgds (but
- * don't free them) afterwards.
- */
-void kvm_clear_hyp_idmap(void)
-{
-	unsigned long addr, end;
-	unsigned long next;
-	pgd_t *pgd = hyp_pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-
-	addr = virt_to_phys(__hyp_idmap_text_start);
-	end = virt_to_phys(__hyp_idmap_text_end);
-
-	pgd += pgd_index(addr);
-	do {
-		next = pgd_addr_end(addr, end);
-		if (pgd_none_or_clear_bad(pgd))
-			continue;
-		pud = pud_offset(pgd, addr);
-		pmd = pmd_offset(pud, addr);
-
-		pud_clear(pud);
-		kvm_clean_pmd_entry(pmd);
-		pmd_free(NULL, (pmd_t *)((unsigned long)pmd & PAGE_MASK));
-	} while (pgd++, addr = next, addr < end);
-}
-- 
1.8.1.4
