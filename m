From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Wed, 7 Jul 2010 10:29:38 +0300
Subject: [PATCH v2 0/8] Initial implementation of kdump for ARM
In-Reply-To: <4C32E9BD.4090001@stericsson.com>
References: <20100705082835.GA32178@gw.healthdatacare.com>
	<4C31AD62.6070805@stericsson.com>
	<20100705101852.GA19338@n2100.arm.linux.org.uk>
	<4C31B527.8060401@stericsson.com>
	<20100705135552.GB19338@n2100.arm.linux.org.uk>
	<4C31E6C4.8030200@stericsson.com>
	<20100705141926.GA23860@n2100.arm.linux.org.uk>
	<4C31FC27.4010102@stericsson.com>
	<20100705181421.GA27771@n2100.arm.linux.org.uk>
	<4C32E9BD.4090001@stericsson.com>
Message-ID: <20100707072938.GQ25358@esdhcp04058.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 06, 2010 at 10:30:53AM +0200, ext Per Fransson wrote:
> 
> Can't we set up the identity mapping for only the entry containing
> relocate_new_kernel() and then add enough NOPs at the start of that routine to
> cover all implementations? That way only one entry in the L1 table is
> over-written while keeping the MMU handling code in the different
> arch/arm/mm/proc-<cpu_or_arch>.S?

Did you mean something like the patch at the end of this mail? It doesn't turn
off the MMU but sets up the identity mapping for the control page only. I
quickly tested it on our platform and it seems to work:

crash> bt
PID: 1505   TASK: ddc51d40  CPU: 0   COMMAND: "sh"
 #0 [<c00890b0>] (crash_kexec) from [<c037ecd0>]
 #1 [<c037ecd0>] (panic) from [<c0030544>]
 #2 [<c0030544>] (die) from [<c0032630>]
 #3 [<c0032630>] (__do_kernel_fault) from [<c0032804>]
 #4 [<c0032804>] (do_page_fault) from [<c002c2b4>]
 #5 [<c002c2b4>] (do_DataAbort) from [<c002ca6c>]
    pc : [<c0252d74>]    lr : [<c0252f54>]    psr: 600000d3
    sp : ddca1f18  ip : 00005d75  fp : bede761c
    r10: 00000000  r9 : ddca0000  r8 : 00000007
    r7 : 00000063  r6 : 00000000  r5 : 60000053  r4 : c04e0a10
    r3 : 00000001  r2 : 00000000  r1 : 00000000  r0 : 00000063
    Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM
 #6 [<c002ca6c>] (__dabt_svc) from [<c0252f54>]
 #7 [<c0252d74>] (sysrq_handle_crash) from [<c0252f54>]
 #8 [<c0252f54>] (__handle_sysrq) from [<c0253050>]
 #9 [<c0253050>] (write_sysrq_trigger) from [<c010e9bc>]
#10 [<c010e9bc>] (proc_reg_write) from [<c00ca0a0>]
#11 [<c00ca0a0>] (vfs_write) from [<c00ca1f4>]
#12 [<c00ca1f4>] (sys_write) from [<c002cf40>]

crash> ps -a 1505
PID: 1505   TASK: ddc51d40  CPU: 0   COMMAND: "sh"
ARG: -sh 
ENV: TERM=linux
     PATH=/sbin:/usr/sbin:/bin:/usr/bin
     USER=root
     LOGNAME=root
     HOME=/root
     SHELL=/bin/sh

So we can at least access the user stack.

However, I'm not sure what is happening with these kdump patches. If they are
going in at some point maybe we can do this stuff later on as separate patches
or should post a new version of the patches?

> Also, couldn't the L1 page table entry in question be saved for 
> posterity in a variable inside the kernel before the table is modified, 
> together with another variable to hold information on the index in the 
> table the entry came from.

Yeah, I think that we want to have full user-space mappings for post-mortem
analysis.

Regards,
MW

>From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH] ARM: kexec: make identity mapping for control page only

With current implementation we setup 1:1 mapping for all user-space pages in
order to softboot to a new kernel. This has a drawback that we cannot access
those pages later on during post-mortem analysis.

This patch changes kexec to setup identity mapping for only the control page
(this takes 2 PMD entries) and leaves rest of the mappings intact.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/kernel/machine_kexec.c |   42 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 81e9898..518c1ad 100644
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
@@ -16,8 +17,6 @@
 extern const unsigned char relocate_new_kernel[];
 extern const unsigned int relocate_new_kernel_size;
 
-extern void setup_mm_for_reboot(char mode);
-
 extern unsigned long kexec_start_address;
 extern unsigned long kexec_indirection_page;
 extern unsigned long kexec_mach_type;
@@ -49,6 +48,43 @@ void machine_crash_shutdown(struct pt_regs *regs)
 	printk(KERN_INFO "Loading crashdump kernel...\n");
 }
 
+/**
+ * setup_identity_mapping() - sets up 1:1 identity mapping for a control page
+ * @phys: physical address of the control page
+ *
+ * Sets up necessary 1:1 identity mapping for user-space pages covering kexec
+ * control page. Other user-space mappings are kept intact.
+ *
+ * TODO: We could save these 2 PMD entries and restore them in
+ *       relocate_new_kernel() when we are sure that the MMU is off.
+ *       This would allow us to have complete user-space mappings
+ *       for post-mortem analysis.
+ */
+static void setup_identity_mapping(unsigned long phys)
+{
+	unsigned long pmdval = phys & PMD_MASK;
+	pgd_t *pgd;
+	pmd_t *pmd;
+
+	/*
+	 * We need to access to user-mode page tables here. For kernel threads
+	 * we don't have any user-mode mappings so we use the context that we
+	 * "borrowed".
+	 */
+	pgd = pgd_offset(current->active_mm, phys);
+	pmd = pmd_offset(pgd, phys);
+
+	pmdval |= PMD_SECT_AP_WRITE | PMD_SECT_AP_READ | PMD_TYPE_SECT;
+	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
+		pmdval |= PMD_BIT4;
+
+	pmd[0] = __pmd(pmdval);
+	pmd[1] = __pmd(pmdval + (1 << (PGDIR_SHIFT - 1)));
+
+	flush_pmd_entry(pmd);
+	local_flush_tlb_all();
+}
+
 void machine_kexec(struct kimage *image)
 {
 	unsigned long page_list;
@@ -79,6 +115,6 @@ void machine_kexec(struct kimage *image)
 	printk(KERN_INFO "Bye!\n");
 
 	cpu_proc_fin();
-	setup_mm_for_reboot(0); /* mode is not used, so just pass 0*/
+	setup_identity_mapping(reboot_code_buffer_phys);
 	cpu_reset(reboot_code_buffer_phys);
 }
-- 
1.5.6.5
