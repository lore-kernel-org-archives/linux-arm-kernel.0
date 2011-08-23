From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Aug 2011 22:46:51 +0100
Subject: [PATCH v4 7/8] ARM: kexec: use arm_machine_reset for branching to the
	reboot buffer
In-Reply-To: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
References: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
Message-ID: <1314136012-20533-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that there is a common way to reset the machine, let's use it
instead of reinventing the wheel in the kexec backend.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/machine_kexec.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index dfc1784..f84567c 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -16,8 +16,6 @@
 extern const unsigned char relocate_new_kernel[];
 extern const unsigned int relocate_new_kernel_size;
 
-extern void setup_mm_for_reboot(char mode, pgd_t *pgd);
-
 extern unsigned long kexec_start_address;
 extern unsigned long kexec_indirection_page;
 extern unsigned long kexec_mach_type;
@@ -111,14 +109,6 @@ void machine_kexec(struct kimage *image)
 
 	if (kexec_reinit)
 		kexec_reinit();
-	local_irq_disable();
-	local_fiq_disable();
-	setup_mm_for_reboot(0, NULL); /* mode is not used, so just pass 0*/
-	flush_cache_all();
-	outer_flush_all();
-	outer_disable();
-	cpu_proc_fin();
-	outer_inv_all();
-	flush_cache_all();
-	cpu_reset(reboot_code_buffer_phys);
+
+	arm_machine_reset(reboot_code_buffer_phys);
 }
-- 
1.7.0.4
