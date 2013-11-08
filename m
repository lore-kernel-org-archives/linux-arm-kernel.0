From: Dave.Martin@arm.com (Dave Martin)
Date: Fri,  8 Nov 2013 12:24:04 +0000
Subject: [PATCH v2] ARM: kexec: Use the right ISA for relocate_new_kernel
Message-ID: <1383913444-9153-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copying a function with memcpy() and then trying to execute the
result isn't trivially portable to Thumb.

This patch modifies the kexec soft restart code to copy its
assembler trampoline relocate_new_kernel() using fncpy() instead,
so that relocate_new_kernel can be in the same ISA as the rest of
the kernel without problems.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
Changes since v1:

  * Move ENDPROC() after relocate_new_kernel's literals, to be
    consistent the location of relocate_new_kernel_end and with the way
    GCC sets ELF symbol sizes for functions.  This is just a tidyup,
    with no functional impact.

 arch/arm/kernel/machine_kexec.c   |   17 ++++++++++-------
 arch/arm/kernel/relocate_kernel.S |    8 ++++++--
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 57221e3..f0d180d 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -14,11 +14,12 @@
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
+#include <asm/fncpy.h>
 #include <asm/mach-types.h>
 #include <asm/smp_plat.h>
 #include <asm/system_misc.h>
 
-extern const unsigned char relocate_new_kernel[];
+extern void relocate_new_kernel(void);
 extern const unsigned int relocate_new_kernel_size;
 
 extern unsigned long kexec_start_address;
@@ -142,6 +143,8 @@ void machine_kexec(struct kimage *image)
 {
 	unsigned long page_list;
 	unsigned long reboot_code_buffer_phys;
+	unsigned long reboot_entry = (unsigned long)relocate_new_kernel;
+	unsigned long reboot_entry_phys;
 	void *reboot_code_buffer;
 
 	/*
@@ -168,16 +171,16 @@ void machine_kexec(struct kimage *image)
 
 
 	/* copy our kernel relocation code to the control code page */
-	memcpy(reboot_code_buffer,
-	       relocate_new_kernel, relocate_new_kernel_size);
+	reboot_entry = fncpy(reboot_code_buffer,
+			     reboot_entry,
+			     relocate_new_kernel_size);
+	reboot_entry_phys = (unsigned long)reboot_entry +
+		(reboot_code_buffer_phys - (unsigned long)reboot_code_buffer);
 
-
-	flush_icache_range((unsigned long) reboot_code_buffer,
-			   (unsigned long) reboot_code_buffer + KEXEC_CONTROL_PAGE_SIZE);
 	printk(KERN_INFO "Bye!\n");
 
 	if (kexec_reinit)
 		kexec_reinit();
 
-	soft_restart(reboot_code_buffer_phys);
+	soft_restart(reboot_entry_phys);
 }
diff --git a/arch/arm/kernel/relocate_kernel.S b/arch/arm/kernel/relocate_kernel.S
index d0cdedf..9585896 100644
--- a/arch/arm/kernel/relocate_kernel.S
+++ b/arch/arm/kernel/relocate_kernel.S
@@ -2,10 +2,12 @@
  * relocate_kernel.S - put the kernel image in place to boot
  */
 
+#include <linux/linkage.h>
 #include <asm/kexec.h>
 
-	.globl relocate_new_kernel
-relocate_new_kernel:
+	.align	3	/* not needed for this code, but keeps fncpy() happy */
+
+ENTRY(relocate_new_kernel)
 
 	ldr	r0,kexec_indirection_page
 	ldr	r1,kexec_start_address
@@ -79,6 +81,8 @@ kexec_mach_type:
 kexec_boot_atags:
 	.long	0x0
 
+ENDPROC(relocate_new_kernel)
+
 relocate_new_kernel_end:
 
 	.globl relocate_new_kernel_size
-- 
1.7.9.5
