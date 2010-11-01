From: per.xx.fransson@stericsson.com (Per Fransson)
Date: Mon, 1 Nov 2010 17:36:54 +0100
Subject: [RFC 2/2] Selective MMU identity mapping for kexec
In-Reply-To: <1288629414-19406-1-git-send-email-per.xx.fransson@stericsson.com>
References: <1288629414-19406-1-git-send-email-per.xx.fransson@stericsson.com>
Message-ID: <1288629414-19406-3-git-send-email-per.xx.fransson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>
---
 arch/arm/kernel/machine_kexec.c   |   27 +++++++++++++++++++++-
 arch/arm/kernel/relocate_kernel.S |   23 +++++++++++++++++++
 arch/arm/mm/mmu.c                 |   44 +++++++++++++++++++++++++++++++++++++
 arch/arm/mm/proc-v7.S             |    1 +
 4 files changed, 94 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 3a8fd51..d5bb12f 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -17,12 +17,20 @@ extern const unsigned char relocate_new_kernel[];
 extern const unsigned int relocate_new_kernel_size;
 
 extern void setup_mm_for_reboot(char mode);
+extern void identity_map(unsigned long, pgd_t*, pgd_t**);
 
 extern unsigned long kexec_start_address;
 extern unsigned long kexec_indirection_page;
 extern unsigned long kexec_mach_type;
 extern unsigned long kexec_boot_atags;
 
+typedef struct {
+	pgd_t *ptr;
+	pgd_t store;
+} kexec_mmu_ent_t;
+
+extern kexec_mmu_ent_t kexec_mmu_ents[4];
+
 /*
  * Provide a dummy crash_notes definition while crash dump arrives to arm.
  * This prevents breakage of crash_notes attribute in kernel/ksysfs.c.
@@ -51,6 +59,7 @@ void machine_kexec(struct kimage *image)
 	unsigned long reboot_code_buffer_phys;
 	void *reboot_code_buffer;
 
+	unsigned long cpu_reset_phys;
 
 	page_list = image->head & PAGE_MASK;
 
@@ -65,18 +74,34 @@ void machine_kexec(struct kimage *image)
 	kexec_mach_type = machine_arch_type;
 	kexec_boot_atags = image->start - KEXEC_ARM_ZIMAGE_OFFSET + KEXEC_ARM_ATAGS_OFFSET;
 
+	/* Identity map the code which turns off the mmu (cpu_reset) and
+	   the code which will be executed immediately afterwards
+	   (relocate_new_kernel).
+	   Store the old entries so they can be restored. */
+	/* cpu_reset cannot be used directly when MULTI_CPU is true, see
+	   cpu-multi32.h, instead processor.reset will have to be used */
+	cpu_reset_phys = virt_to_phys(cpu_reset);
+	identity_map(cpu_reset_phys, &kexec_mmu_ents[0].store,
+		     &kexec_mmu_ents[0].ptr);
+	identity_map(((char *)cpu_reset_phys)+PGDIR_SIZE,
+		     &kexec_mmu_ents[1].store, &kexec_mmu_ents[1].ptr);
+	identity_map(reboot_code_buffer_phys,
+		     &kexec_mmu_ents[2].store, &kexec_mmu_ents[2].ptr);
+	identity_map(((char *)reboot_code_buffer_phys)+PGDIR_SIZE,
+		     &kexec_mmu_ents[3].store, &kexec_mmu_ents[3].ptr);
+
 	/* copy our kernel relocation code to the control code page */
 	memcpy(reboot_code_buffer,
 	       relocate_new_kernel, relocate_new_kernel_size);
 
 
+
 	flush_icache_range((unsigned long) reboot_code_buffer,
 			   (unsigned long) reboot_code_buffer + KEXEC_CONTROL_PAGE_SIZE);
 	printk(KERN_INFO "Bye!\n");
 
 	local_irq_disable();
 	local_fiq_disable();
-	setup_mm_for_reboot(0); /* mode is not used, so just pass 0*/
 	flush_cache_all();
 	outer_flush_all();
 	outer_disable();
diff --git a/arch/arm/kernel/relocate_kernel.S b/arch/arm/kernel/relocate_kernel.S
index fd26f8d..36b1268 100644
--- a/arch/arm/kernel/relocate_kernel.S
+++ b/arch/arm/kernel/relocate_kernel.S
@@ -7,6 +7,23 @@
 	.globl relocate_new_kernel
 relocate_new_kernel:
 
+	/* We get here when the MMU is in a transitional state.
+	   Wait for the virtual address mapping to wear off before
+	   overwriting the identity mappings (set up for the sake
+	   of MMU disabling) with the previous mappings. */
+	ldr	r0, =100
+0:	subs	r0, r0, #1
+	beq	0b
+
+	adr	r0, kexec_mmu_ents
+	.rept 4
+	ldr	r1, [r0], #4
+	ldr	r2, [r0], #4
+	str	r2, [r1], #4
+	ldr	r2, [r0], #4
+	str	r2, [r1], #4
+	.endr
+
 	ldr	r0,kexec_indirection_page
 	ldr	r1,kexec_start_address
 
@@ -67,6 +84,12 @@ kexec_start_address:
 kexec_indirection_page:
 	.long	0x0
 
+
+	.globl kexec_mmu_ents
+kexec_mmu_ents:
+	.space 4*12, 0
+
+
 	.globl kexec_mach_type
 kexec_mach_type:
 	.long	0x0
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index de3afc7..64f3f05 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1080,3 +1080,47 @@ void setup_mm_for_reboot(char mode)
 
 	local_flush_tlb_all();
 }
+
+
+/*
+ * In order to soft-boot, we need to insert a 1:1 mapping in place of
+ * the user-mode pages.  This will then ensure that we have predictable
+ * results when turning the mmu off
+ */
+void identity_map(unsigned long phys_addr, pmd_t *pmd_store, pmd_t **pmd_ptr)
+{
+	unsigned long base_pmdval;
+	pgd_t *pgd;
+	pmd_t *pmd;
+	int i;
+	unsigned long pmdval;
+
+	/*
+	 * We need to access to user-mode page tables here. For kernel threads
+	 * we don't have any user-mode mappings so we use the context that we
+	 * "borrowed".
+	 */
+	pgd = current->active_mm->pgd;
+
+	base_pmdval = PMD_SECT_AP_WRITE | PMD_SECT_AP_READ | PMD_TYPE_SECT;
+	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
+		base_pmdval |= PMD_BIT4;
+
+	/* Where to modify */
+	pmd = pgd + (phys_addr >> PGDIR_SHIFT);
+
+	/* Save old value */
+	pmd_store[0] = pmd[0];
+	pmd_store[1] = pmd[1];
+
+	*pmd_ptr = virt_to_phys(pmd);
+
+	/* Set new value */
+	pmdval = ((phys_addr >> PGDIR_SHIFT) << PGDIR_SHIFT) | base_pmdval;
+	pmd[0] = __pmd(pmdval);
+	pmd[1] = __pmd(pmdval + (1 << (PGDIR_SHIFT - 1)));
+
+	flush_pmd_entry(pmd);
+	local_flush_tlb_all();
+}
+
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index b249143..37ee55b 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -61,6 +61,7 @@ ENDPROC(cpu_v7_proc_fin)
  */
 	.align	5
 ENTRY(cpu_v7_reset)
+	sub	pc, pc, #PAGE_OFFSET+4		@ go to physical addresses
 	mrc	p15, 0, ip, c1, c0, 0		@ ctrl register
 	bic	ip, ip, #0x0001			@ ...............m
 	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
-- 
1.7.2.2
