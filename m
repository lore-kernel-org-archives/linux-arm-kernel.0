From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue,  4 Mar 2014 18:23:33 +0000
Subject: [PATCH] arm: kernel: sleep: restore HYP mode configuration in
 cpu_resume
Message-ID: <1393957413-2962-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On CPUs with virtualization extensions the kernel installs HYP mode
configuration on both primary and secondary cpus upon cold boot.

On platforms where CPUs are shutdown in idle paths (ie CPU core gating),
when a CPU resumes from low-power states it currently does not execute
code that reinstalls the HYP configuration, which means that the kernel
cannot run eg KVM properly on such machines.

This patch, mirroring cold-boot behaviour, executes position independent
code that reinstalls HYP configuration and drops to SVC mode safely on
warmboot, so that deep idle states can be enabled in kernel running as
hosts on platforms with power management HW.

Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Dave Martin <dave.martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/kernel/sleep.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index b907d9b..1b880db 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -127,6 +127,10 @@ ENDPROC(cpu_resume_after_mmu)
 	.align
 ENTRY(cpu_resume)
 ARM_BE8(setend be)			@ ensure we are in BE mode
+#ifdef CONFIG_ARM_VIRT_EXT
+	bl	__hyp_stub_install_secondary
+#endif
+	safe_svcmode_maskall r1
 	mov	r1, #0
 	ALT_SMP(mrc p15, 0, r0, c0, c0, 5)
 	ALT_UP_B(1f)
@@ -144,7 +148,6 @@ ARM_BE8(setend be)			@ ensure we are in BE mode
 	ldr	r0, [r0, #SLEEP_SAVE_SP_PHYS]
 	ldr	r0, [r0, r1, lsl #2]
 
-	setmode	PSR_I_BIT | PSR_F_BIT | SVC_MODE, r1  @ set SVC, irqs off
 	@ load phys pgd, stack, resume fn
   ARM(	ldmia	r0!, {r1, sp, pc}	)
 THUMB(	ldmia	r0!, {r1, r2, r3}	)
-- 
1.8.2.2
