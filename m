From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 16 Nov 2010 13:12:21 +0000
Subject: [PATCH 2/2] ARM: kexec: Fix crash_setup_regs() for ARMv7 and
	CONFIG_THUMB2_KERNEL
In-Reply-To: <1289913141-8559-1-git-send-email-dave.martin@linaro.org>
References: <1289913141-8559-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1289913141-8559-2-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 * Fix kexec build failure with CONFIG_THUMB2_KERNEL.

 * Avoids deprecated/forbidden sp and pc usage in for ARMv7 onwards,
retaining compatibility with older architecture versions.

 * The pc value saved to newregs is now aligned on a predictable
instruction boundary.

(stmia { ... pc } or str pc has implementation-defined results
in most versions of the ARM architecutre, and is prohibited
(unpredictable) in Thumb-2.)

 * Switch to named inline asm arguments (else I get readily confused ...)

The resulting code should be compatible with all architecture versions >= v3,
with or without CONFIG_THUMB2_KERNEL.

Applies cleanly on v2.6.37-rc1.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/kexec.h |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/kexec.h b/arch/arm/include/asm/kexec.h
index b37e02c..c0094d8 100644
--- a/arch/arm/include/asm/kexec.h
+++ b/arch/arm/include/asm/kexec.h
@@ -33,10 +33,20 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 	if (oldregs) {
 		memcpy(newregs, oldregs, sizeof(*newregs));
 	} else {
-		__asm__ __volatile__ ("stmia %0, {r0 - r15}"
-				      : : "r" (&newregs->ARM_r0) : "memory");
-		__asm__ __volatile__ ("mrs %0, cpsr"
-				      : "=r" (newregs->ARM_cpsr));
+		__asm__ __volatile__ (
+			"stmia	%[regs_base], {r0-r12}\n\t"
+			"mov	%[_ARM_sp], sp\n\t"
+			"str	lr, %[_ARM_lr]\n\t"
+			"adr	%[_ARM_pc], 1f\n\t"
+			"mrs	%[_ARM_cpsr], cpsr\n\t"
+		"1:"
+			: [_ARM_pc] "=r" (newregs->ARM_pc),
+			  [_ARM_cpsr] "=r" (newregs->ARM_cpsr),
+			  [_ARM_sp] "=r" (newregs->ARM_sp),
+			  [_ARM_lr] "=o" (newregs->ARM_lr)
+			: [regs_base] "r" (&newregs->ARM_r0)
+			: "memory"
+		);
 	}
 }
 
-- 
1.7.1
