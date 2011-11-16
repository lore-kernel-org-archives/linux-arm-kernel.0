From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Nov 2011 17:54:17 +0000
Subject: [PATCH v6 5/5] ARM: kexec: use soft_restart for branching to the
 reboot buffer
In-Reply-To: <1321466057-19721-1-git-send-email-will.deacon@arm.com>
References: <1321466057-19721-1-git-send-email-will.deacon@arm.com>
Message-ID: <1321466057-19721-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that there is a common way to reset the machine, let's use it
instead of reinventing the wheel in the kexec backend.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/machine_kexec.c |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 29620b6..764bd45 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -12,12 +12,11 @@
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 #include <asm/mach-types.h>
+#include <asm/system.h>
 
 extern const unsigned char relocate_new_kernel[];
 extern const unsigned int relocate_new_kernel_size;
 
-extern void setup_mm_for_reboot(void);
-
 extern unsigned long kexec_start_address;
 extern unsigned long kexec_indirection_page;
 extern unsigned long kexec_mach_type;
@@ -111,14 +110,6 @@ void machine_kexec(struct kimage *image)
 
 	if (kexec_reinit)
 		kexec_reinit();
-	local_irq_disable();
-	local_fiq_disable();
-	setup_mm_for_reboot();
-	flush_cache_all();
-	outer_flush_all();
-	outer_disable();
-	cpu_proc_fin();
-	outer_inv_all();
-	flush_cache_all();
-	cpu_reset(reboot_code_buffer_phys);
+
+	soft_restart(reboot_code_buffer_phys);
 }
-- 
1.7.4.1
