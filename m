From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Mon, 12 Jul 2010 11:20:18 +0300
Subject: [PATCH v2 0/8] Initial implementation of kdump for ARM
In-Reply-To: <4C3591DA.8030902@stericsson.com>
References: <20100705101852.GA19338@n2100.arm.linux.org.uk>
	<4C31B527.8060401@stericsson.com>
	<20100705135552.GB19338@n2100.arm.linux.org.uk>
	<4C31E6C4.8030200@stericsson.com>
	<20100705141926.GA23860@n2100.arm.linux.org.uk>
	<4C31FC27.4010102@stericsson.com>
	<20100705181421.GA27771@n2100.arm.linux.org.uk>
	<4C32E9BD.4090001@stericsson.com>
	<20100707072938.GQ25358@esdhcp04058.research.nokia.com>
	<4C3591DA.8030902@stericsson.com>
Message-ID: <20100712082018.GI4247@esdhcp04058.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 08, 2010 at 10:52:42AM +0200, ext Per Fransson wrote:
> 
> Yes, that's what I had in mind. A delay will have to be introduced at 
> the start of relocate_new_kernel as well. And we have to make sure that 
> it's not possible for this code to straddle two L1 page table entries, 
> which might be the case already, I don't know. Finally, the overwritten 
> entry needs to be stored somewhere before cleaning the caches.

Hi,

Now that I (hopefully) understand this little bit better, I made a small change
to kexec code according what you proposed. It, however creates identity mapping
for the cpu_reset() function instead of relocate_new_kernel(). At least if I
understand ARMv7 specs correctly, it is recommended to run the code which
disables/enables the MMU with VA == PA. I also tried to just disable the MMU but
if I'm not running with VA == PA, it hangs.

I'm not sure whether the MMU disabling code is correct, should we do something
else before switching the MMU off? In OMAP3 it seems to work as is.

Regards,
MW

Subject: ARM: kexec: create identity mapping for cpu_reset

With current implementation we setup 1:1 mapping for all user-space pages in
order to softboot to a new kernel. This has a drawback that we cannot access
those pages later on during post-mortem analysis. We also leave MMU on when
calling the secondary kernel.

This patch makes identity mapping for the cpu_reset() function only. This way we
can be sure that we are running with VA == PA when the MMU is disabled.

relocate_new_kernel() restores the trashed 2 PMD entries which can be then used
for post-mortem analysis.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/kernel/machine_kexec.c   |   62 ++++++++++++++++++++++++++++++++++---
 arch/arm/kernel/relocate_kernel.S |   26 +++++++++++++++
 arch/arm/mm/proc-v7.S             |   18 +++++++++++
 3 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 81e9898..4cfad60 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/io.h>
+#include <asm/cputype.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
@@ -16,12 +17,13 @@
 extern const unsigned char relocate_new_kernel[];
 extern const unsigned int relocate_new_kernel_size;
 
-extern void setup_mm_for_reboot(char mode);
-
 extern unsigned long kexec_start_address;
 extern unsigned long kexec_indirection_page;
 extern unsigned long kexec_mach_type;
 extern unsigned long kexec_boot_atags;
+extern unsigned long kexec_pmd_addr;
+extern unsigned long kexec_pmd_val0;
+extern unsigned long kexec_pmd_val1;
 
 /*
  * Provide a dummy crash_notes definition while crash dump arrives to arm.
@@ -49,12 +51,59 @@ void machine_crash_shutdown(struct pt_regs *regs)
 	printk(KERN_INFO "Loading crashdump kernel...\n");
 }
 
+/**
+ * setup_identity_mapping() - set up identity mapping for given address
+ * @paddr: physical address which is mapped
+ *
+ * This function sets up indentity mapping for the given CPU reset function. We
+ * do the worst case and allocate 2 PMD entries. This is due the fact that
+ * cpu_reset() might be split into subsequent sections. Original PMD entries are
+ * placed in @kexec_pmd_val0 and @kexec_pmd_val1, and address of the first PMD
+ * is placed in @kexec_pmd_addr.
+ */
+static void setup_identity_mapping(unsigned long paddr)
+{
+	unsigned long pmdval = paddr & SECTION_MASK;
+	pgd_t *pgd;
+	pmd_t *pmd;
+
+	/*
+	 * We need to access to user-mode page tables here. For kernel threads
+	 * we don't have any user-mode mappings so we use the context that we
+	 * "borrowed".
+	 */
+	pgd = pgd_offset(current->active_mm, paddr);
+	pmd = pmd_offset(pgd, paddr);
+
+	/*
+	 * Store the both original PMD entries. These are restored later on by
+	 * relocate_new_kernel().
+	 */
+	kexec_pmd_addr = __pa(pmd);
+	kexec_pmd_val0 = pmd[0];
+	kexec_pmd_val1 = pmd[1];
+
+	pmdval |= PMD_SECT_AP_WRITE | PMD_SECT_AP_READ | PMD_TYPE_SECT;
+	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
+		pmdval |= PMD_BIT4;
+
+	/*
+	 * Place identity mapping for the 2 sections.
+	 */
+	pmd[0] = __pmd(pmdval);
+	pmd[1] = __pmd(pmdval + (1 << (PGDIR_SHIFT - 1)));
+
+	flush_pmd_entry(pmd);
+}
+
 void machine_kexec(struct kimage *image)
 {
 	unsigned long page_list;
 	unsigned long reboot_code_buffer_phys;
 	void *reboot_code_buffer;
+	void (*reset_fn)(unsigned long);
 
+	reset_fn = (void (*)(unsigned long))__pa(cpu_reset);
 
 	page_list = image->head & PAGE_MASK;
 
@@ -69,16 +118,19 @@ void machine_kexec(struct kimage *image)
 	kexec_mach_type = machine_arch_type;
 	kexec_boot_atags = image->start - KEXEC_ARM_ZIMAGE_OFFSET + KEXEC_ARM_ATAGS_OFFSET;
 
+	setup_identity_mapping(__pa(cpu_reset));
+	local_flush_tlb_all();
+
 	/* copy our kernel relocation code to the control code page */
 	memcpy(reboot_code_buffer,
 	       relocate_new_kernel, relocate_new_kernel_size);
 
-
 	flush_icache_range((unsigned long) reboot_code_buffer,
 			   (unsigned long) reboot_code_buffer + KEXEC_CONTROL_PAGE_SIZE);
 	printk(KERN_INFO "Bye!\n");
 
 	cpu_proc_fin();
-	setup_mm_for_reboot(0); /* mode is not used, so just pass 0*/
-	cpu_reset(reboot_code_buffer_phys);
+
+	/* call the CPU reset function through the identity mapping */
+	(*reset_fn)(reboot_code_buffer_phys);
 }
diff --git a/arch/arm/kernel/relocate_kernel.S b/arch/arm/kernel/relocate_kernel.S
index fd26f8d..028f889 100644
--- a/arch/arm/kernel/relocate_kernel.S
+++ b/arch/arm/kernel/relocate_kernel.S
@@ -11,6 +11,17 @@ relocate_new_kernel:
 	ldr	r1,kexec_start_address
 
 	/*
+	 * First restore the 2 PMD entries that were thrashed when identity
+	 * mapping was created for CPU reset function. These are needed for
+	 * possible post-mortem analysis.
+	 */
+	ldr	r2, kexec_pmd_addr
+	ldr	r3, kexec_pmd_val0
+	ldr	r4, kexec_pmd_val1
+	str	r3, [r2], #4
+	str	r4, [r2]
+
+	/*
 	 * If there is no indirection page (we are doing crashdumps)
 	 * skip any relocation.
 	 */
@@ -76,6 +87,21 @@ kexec_mach_type:
 kexec_boot_atags:
 	.long	0x0
 
+/*
+ * machine_kexec() changes user-space mappings for cpu_reset() function. The 2
+ * original values are stored here, and will be restored when
+ * relocate_new_kernel is called (with MMU off).
+ */
+	.globl kexec_pmd_addr
+	.globl kexec_pmd_val0
+	.globl kexec_pmd_val1
+kexec_pmd_addr:
+	.long	0x0
+kexec_pmd_val0:
+	.long	0x0
+kexec_pmd_val1:
+	.long	0x0
+
 relocate_new_kernel_end:
 
 	.globl relocate_new_kernel_size
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 7aaf88a..f5092cb 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -62,10 +62,28 @@ ENDPROC(cpu_v7_proc_fin)
  *	same state as it would be if it had been reset, and branch
  *	to what would be the reset vector.
  *
+ *	This function should be called only when VA == PA (e.g make indentity
+ *	mapping for the function and jump into __pa(cpu_v7_reset)).
+ *
  *	- loc   - location to jump to for soft reset
  */
 	.align	5
 ENTRY(cpu_v7_reset)
+#ifdef CONFIG_MMU
+	mcr	p15, 0, ip, c8, c7, 0	@ invalidate I & D TLBs
+#endif
+	mrc	p15, 0, ip, c1, c0
+	bic	ip, ip, #0x0001
+	mcr	p15, 0, ip, c1, c0	@ turn MMU off
+
+	/*
+	 * Now provide a small delay which should guarantee that MMU is really
+	 * switched off.
+	 */
+	nop; nop; nop
+	nop; nop; nop
+
+	/* and jump to the reset address */
 	mov	pc, r0
 ENDPROC(cpu_v7_reset)
 
-- 
1.5.6.5
