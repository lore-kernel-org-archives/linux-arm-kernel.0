From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 26 Jan 2016 18:21:29 +0000
Subject: [PATCH 2/2] ARM: use virt_to_idmap() for soft_restart()
Message-ID: <E1aO8F7-00074T-I5@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code run via soft_restart() is run with the MMU disabled, so we need to
pass the identity map physical address rather than the address obtained
from virt_to_phys().  Therefore, replace virt_to_phys() with
virt_to_idmap() for all callers of soft_restart().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/hibernate.c     |  4 ++--
 arch/arm/kernel/machine_kexec.c | 16 ++++++----------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kernel/hibernate.c b/arch/arm/kernel/hibernate.c
index a71501ff6f18..b09561a6d06a 100644
--- a/arch/arm/kernel/hibernate.c
+++ b/arch/arm/kernel/hibernate.c
@@ -62,7 +62,7 @@ static int notrace arch_save_image(unsigned long unused)
 
 	ret = swsusp_save();
 	if (ret == 0)
-		_soft_restart(virt_to_phys(cpu_resume), false);
+		_soft_restart(virt_to_idmap(cpu_resume), false);
 	return ret;
 }
 
@@ -87,7 +87,7 @@ static void notrace arch_restore_image(void *unused)
 	for (pbe = restore_pblist; pbe; pbe = pbe->next)
 		copy_page(pbe->orig_address, pbe->address);
 
-	_soft_restart(virt_to_phys(cpu_resume), false);
+	_soft_restart(virt_to_idmap(cpu_resume), false);
 }
 
 static u64 resume_stack[PAGE_SIZE/2/sizeof(u64)] __nosavedata;
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 8bf3b7c09888..59fd0e24c56b 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -143,10 +143,8 @@ void (*kexec_reinit)(void);
 
 void machine_kexec(struct kimage *image)
 {
-	unsigned long page_list;
-	unsigned long reboot_code_buffer_phys;
-	unsigned long reboot_entry = (unsigned long)relocate_new_kernel;
-	unsigned long reboot_entry_phys;
+	unsigned long page_list, reboot_entry_phys;
+	void (*reboot_entry)(void);
 	void *reboot_code_buffer;
 
 	/*
@@ -159,9 +157,6 @@ void machine_kexec(struct kimage *image)
 
 	page_list = image->head & PAGE_MASK;
 
-	/* we need both effective and real address here */
-	reboot_code_buffer_phys =
-	    page_to_pfn(image->control_code_page) << PAGE_SHIFT;
 	reboot_code_buffer = page_address(image->control_code_page);
 
 	/* Prepare parameters for reboot_code_buffer*/
@@ -174,10 +169,11 @@ void machine_kexec(struct kimage *image)
 
 	/* copy our kernel relocation code to the control code page */
 	reboot_entry = fncpy(reboot_code_buffer,
-			     reboot_entry,
+			     &relocate_new_kernel,
 			     relocate_new_kernel_size);
-	reboot_entry_phys = (unsigned long)reboot_entry +
-		(reboot_code_buffer_phys - (unsigned long)reboot_code_buffer);
+
+	/* get the identity mapping physical address for the reboot code */
+	reboot_entry_phys = virt_to_idmap(reboot_entry);
 
 	pr_info("Bye!\n");
 
-- 
2.1.0
