From: salyzyn@android.com (Mark Salyzyn)
Date: Wed,  1 Nov 2017 09:58:33 -0700
Subject: [PATCH] arm64: write_sysreg asm illegal for aarch32
Message-ID: <20171101170014.20931-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cross compiling to aarch32 (for vdso32) using clang correctly
identifies that (the unused) write_sysreg inline asm directive is
illegal in that architectural context:

arch/arm64/include/asm/arch_timer.h: error: invalid input constraint 'rZ' in asm
        write_sysreg(cntkctl, cntkctl_el1);
        ^
arch/arm64/include/asm/sysreg.h: note: expanded from macro 'write_sysreg'
                     : : "rZ" (__val));
                         ^

GCC normally checks for correctness everywhere. But uniquely for
unused asm, will optimize out and suppress the error report.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Christoffer Dall <cdall@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Stefan Traby <stefan@hello-penguin.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm64/include/asm/sysreg.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index f707fed5886f..a7b61c9327db 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -492,11 +492,15 @@ asm(
  * The "Z" constraint normally means a zero immediate, but when combined with
  * the "%x0" template means XZR.
  */
+#if defined(__aarch64__)
 #define write_sysreg(v, r) do {					\
 	u64 __val = (u64)(v);					\
 	asm volatile("msr " __stringify(r) ", %x0"		\
 		     : : "rZ" (__val));				\
 } while (0)
+#else
+#define write_sysreg(v, r) BUG()
+#endif
 
 /*
  * For registers without architectural names, or simply unsupported by
-- 
2.15.0.403.gc27cc4dac6-goog
