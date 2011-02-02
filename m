From: ecc@cmu.edu (Eric Cooper)
Date: Wed,  2 Feb 2011 17:16:09 -0500
Subject: [PATCH v2 1/3] add machine-specific hook to machine_kexec
Message-ID: <1296684971-10577-1-git-send-email-ecc@cmu.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide the option to call a machine-specific function
before kexec'ing a new kernel.

Signed-off-by: Eric Cooper <ecc@cmu.edu>
---
 arch/arm/kernel/machine_kexec.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 30ead13..e59bbd4 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -75,6 +75,11 @@ void machine_crash_shutdown(struct pt_regs *regs)
 	printk(KERN_INFO "Loading crashdump kernel...\n");
 }
 
+/*
+ * Function pointer to optional machine-specific reinitialization
+ */
+void (*kexec_reinit)(void);
+
 void machine_kexec(struct kimage *image)
 {
 	unsigned long page_list;
@@ -104,6 +109,8 @@ void machine_kexec(struct kimage *image)
 			   (unsigned long) reboot_code_buffer + KEXEC_CONTROL_PAGE_SIZE);
 	printk(KERN_INFO "Bye!\n");
 
+	if (kexec_reinit)
+		kexec_reinit();
 	local_irq_disable();
 	local_fiq_disable();
 	setup_mm_for_reboot(0); /* mode is not used, so just pass 0*/
-- 
1.7.2.3
