From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  2 Jul 2018 14:17:53 +0100
Subject: [PATCH] arm64: kexec: always reset to EL2 if present
Message-ID: <20180702131753.12949-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently machine_kexec() doesn't reset to EL2 in the case of a
crashdump kernel. This leaves potentially dodgy state active at EL2, and
means that if the crashdump kernel attempts to online secondary CPUs,
these will be booted as mismatched ELs.

Let's reset to EL2, as we do in all other cases, and simplify things. If
EL2 state is corrupt, things are already sufficiently bad that kdump is
unlikely to work, and it's best-effort regardless.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/cpu-reset.h     | 9 +++++----
 arch/arm64/kernel/machine_kexec.c | 3 +--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index 6c2b1b4f57c9..fad90e4935fb 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -16,13 +16,14 @@
 void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
 	unsigned long arg0, unsigned long arg1, unsigned long arg2);
 
-static inline void __noreturn cpu_soft_restart(unsigned long el2_switch,
-	unsigned long entry, unsigned long arg0, unsigned long arg1,
-	unsigned long arg2)
+static inline void __noreturn cpu_soft_restart(unsigned long entry,
+					       unsigned long arg0,
+					       unsigned long arg1,
+					       unsigned long arg2)
 {
 	typeof(__cpu_soft_restart) *restart;
 
-	el2_switch = el2_switch && !is_kernel_in_hyp_mode() &&
+	unsigned long el2_switch = !is_kernel_in_hyp_mode() &&
 		is_hyp_mode_available();
 	restart = (void *)__pa_symbol(__cpu_soft_restart);
 
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index f76ea92dff91..f62effc6e064 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -207,8 +207,7 @@ void machine_kexec(struct kimage *kimage)
 	 * relocation is complete.
 	 */
 
-	cpu_soft_restart(kimage != kexec_crash_image,
-		reboot_code_buffer_phys, kimage->head, kimage->start, 0);
+	cpu_soft_restart(reboot_code_buffer_phys, kimage->head, kimage->start, 0);
 
 	BUG(); /* Should never get here. */
 }
-- 
2.11.0
