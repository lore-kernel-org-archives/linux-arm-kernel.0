From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 16 Nov 2010 13:12:20 +0000
Subject: [PATCH 1/2] ARM: kexec: Add missing memory clobber to inline asm in
	crash_setup_regs()
Message-ID: <1289913141-8559-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the inline asm is passed &newregs->ARM_r0 as in input,
when modifying multiple fields of newregs.

It's plausible to assume that GCC will assume newregs->ARM_r0 is modified
when passed the address, but unfortunately this assumption is incorrect.

Also, GCC has no way to guess that the other ARM_r* fields are modified
without the addition of a "memory" clobber.

Applies cleanly on v2.6.37-rc1.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/kexec.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/kexec.h b/arch/arm/include/asm/kexec.h
index 8ec9ef5..b37e02c 100644
--- a/arch/arm/include/asm/kexec.h
+++ b/arch/arm/include/asm/kexec.h
@@ -34,7 +34,7 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 		memcpy(newregs, oldregs, sizeof(*newregs));
 	} else {
 		__asm__ __volatile__ ("stmia %0, {r0 - r15}"
-				      : : "r" (&newregs->ARM_r0));
+				      : : "r" (&newregs->ARM_r0) : "memory");
 		__asm__ __volatile__ ("mrs %0, cpsr"
 				      : "=r" (newregs->ARM_cpsr));
 	}
-- 
1.7.1
