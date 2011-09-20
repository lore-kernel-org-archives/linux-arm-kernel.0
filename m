From: leiwen@marvell.com (Lei Wen)
Date: Tue, 20 Sep 2011 20:00:43 +0800
Subject: [PATCH V2] ARM: kdump: copy kernel relocation code at the kexec
	prepare stage
In-Reply-To: <1316151129-30491-1-git-send-email-leiwen@marvell.com>
References: <1316151129-30491-1-git-send-email-leiwen@marvell.com>
Message-ID: <1316520043-14619-1-git-send-email-leiwen@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This copy really don't need to do at the very second before the kernel
would crash.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Acked-by: Simon Horman <horms@verge.net.au>
---
Changelog:
V2: move the flush_icache_range after the memcpy operation to ensure I/D cache
    coherency for the relocation code

 arch/arm/kernel/machine_kexec.c |   35 ++++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index e59bbd4..c1b4463 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -32,6 +32,24 @@ static atomic_t waiting_for_crash_ipi;
 
 int machine_kexec_prepare(struct kimage *image)
 {
+	unsigned long page_list;
+	void *reboot_code_buffer;
+	page_list = image->head & PAGE_MASK;
+
+	reboot_code_buffer = page_address(image->control_code_page);
+
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
+	flush_icache_range((unsigned long) reboot_code_buffer,
+			   (unsigned long) reboot_code_buffer + KEXEC_CONTROL_PAGE_SIZE);
 	return 0;
 }
 
@@ -82,31 +100,14 @@ void (*kexec_reinit)(void);
 
 void machine_kexec(struct kimage *image)
 {
-	unsigned long page_list;
 	unsigned long reboot_code_buffer_phys;
 	void *reboot_code_buffer;
 
-
-	page_list = image->head & PAGE_MASK;
-
 	/* we need both effective and real address here */
 	reboot_code_buffer_phys =
 	    page_to_pfn(image->control_code_page) << PAGE_SHIFT;
 	reboot_code_buffer = page_address(image->control_code_page);
 
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
-
-	flush_icache_range((unsigned long) reboot_code_buffer,
-			   (unsigned long) reboot_code_buffer + KEXEC_CONTROL_PAGE_SIZE);
 	printk(KERN_INFO "Bye!\n");
 
 	if (kexec_reinit)
-- 
1.7.0.4
