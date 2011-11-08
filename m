From: will.deacon@arm.com (Will Deacon)
Date: Tue,  8 Nov 2011 15:52:56 +0000
Subject: [PATCH v5 1/8] Revert "ARM: 7098/1: kdump: copy kernel relocation
 code at the kexec prepare stage"
In-Reply-To: <1320767583-21162-1-git-send-email-will.deacon@arm.com>
References: <1320767583-21162-1-git-send-email-will.deacon@arm.com>
Message-ID: <1320767583-21162-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 2b034922af2caa19df86f0c502e76cb6f6e910f9.
---
 arch/arm/kernel/machine_kexec.c |   35 +++++++++++++++++------------------
 1 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index cc40b96..29620b6 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -32,24 +32,6 @@ static atomic_t waiting_for_crash_ipi;
 
 int machine_kexec_prepare(struct kimage *image)
 {
-	unsigned long page_list;
-	void *reboot_code_buffer;
-	page_list = image->head & PAGE_MASK;
-
-	reboot_code_buffer = page_address(image->control_code_page);
-
-	/* Prepare parameters for reboot_code_buffer*/
-	kexec_start_address = image->start;
-	kexec_indirection_page = page_list;
-	kexec_mach_type = machine_arch_type;
-	kexec_boot_atags = image->start - KEXEC_ARM_ZIMAGE_OFFSET + KEXEC_ARM_ATAGS_OFFSET;
-
-	/* copy our kernel relocation code to the control code page */
-	memcpy(reboot_code_buffer,
-	       relocate_new_kernel, relocate_new_kernel_size);
-
-	flush_icache_range((unsigned long) reboot_code_buffer,
-			   (unsigned long) reboot_code_buffer + KEXEC_CONTROL_PAGE_SIZE);
 	return 0;
 }
 
@@ -100,14 +82,31 @@ void (*kexec_reinit)(void);
 
 void machine_kexec(struct kimage *image)
 {
+	unsigned long page_list;
 	unsigned long reboot_code_buffer_phys;
 	void *reboot_code_buffer;
 
+
+	page_list = image->head & PAGE_MASK;
+
 	/* we need both effective and real address here */
 	reboot_code_buffer_phys =
 	    page_to_pfn(image->control_code_page) << PAGE_SHIFT;
 	reboot_code_buffer = page_address(image->control_code_page);
 
+	/* Prepare parameters for reboot_code_buffer*/
+	kexec_start_address = image->start;
+	kexec_indirection_page = page_list;
+	kexec_mach_type = machine_arch_type;
+	kexec_boot_atags = image->start - KEXEC_ARM_ZIMAGE_OFFSET + KEXEC_ARM_ATAGS_OFFSET;
+
+	/* copy our kernel relocation code to the control code page */
+	memcpy(reboot_code_buffer,
+	       relocate_new_kernel, relocate_new_kernel_size);
+
+
+	flush_icache_range((unsigned long) reboot_code_buffer,
+			   (unsigned long) reboot_code_buffer + KEXEC_CONTROL_PAGE_SIZE);
 	printk(KERN_INFO "Bye!\n");
 
 	if (kexec_reinit)
-- 
1.7.4.1
