From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Jun 2016 17:58:17 +0100
Subject: [PATCH] arm64: s/CONFIG_AS_LSE/AS_HAVE_LSE/
Message-ID: <1466009897-2597-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michal objected to the use of the CONFIG_ prefix on definitions which
are not sourced from .config or Kconfig files, as these cannot be found
in the usual places.

Following the example of CC_HAVE_ASM_GOTO, replace CONFIG_AS_LSE with
AS_HAVE_LSE. This avoids confusion w.r.t. the CONFIG_* namespace, and
more accurately describes what the symbol represents.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Michal Marek <mmarek@suse.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Makefile             | 2 +-
 arch/arm64/include/asm/atomic.h | 2 +-
 arch/arm64/include/asm/lse.h    | 6 +++---
 arch/arm64/kernel/cpufeature.c  | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

This follows from Michal's reply [1] to a KCOV patch that followed the idiom
set by CONFIG_AS_LSE.

Mark.

[1] http://lkml.kernel.org/r/5761806F.5020103 at suse.com

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 354d754..44a8e04 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -22,7 +22,7 @@ endif
 KBUILD_DEFCONFIG := defconfig
 
 # Check for binutils support for specific extensions
-lseinstr := $(call as-instr,.arch_extension lse,-DCONFIG_AS_LSE=1)
+lseinstr := $(call as-instr,.arch_extension lse,-DAS_HAVE_LSE=1)
 
 ifeq ($(CONFIG_ARM64_LSE_ATOMICS), y)
   ifeq ($(lseinstr),)
diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index f3a3586..48b7c71 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -30,7 +30,7 @@
 
 #define __ARM64_IN_ATOMIC_IMPL
 
-#if defined(CONFIG_ARM64_LSE_ATOMICS) && defined(CONFIG_AS_LSE)
+#if defined(CONFIG_ARM64_LSE_ATOMICS) && defined(AS_HAVE_LSE)
 #include <asm/atomic_lse.h>
 #else
 #include <asm/atomic_ll_sc.h>
diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
index 23acc00..2affb5e 100644
--- a/arch/arm64/include/asm/lse.h
+++ b/arch/arm64/include/asm/lse.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_LSE_H
 #define __ASM_LSE_H
 
-#if defined(CONFIG_AS_LSE) && defined(CONFIG_ARM64_LSE_ATOMICS)
+#if defined(AS_HAVE_LSE) && defined(CONFIG_ARM64_LSE_ATOMICS)
 
 #include <linux/stringify.h>
 #include <asm/alternative.h>
@@ -33,7 +33,7 @@ __asm__(".arch_extension	lse");
 	ALTERNATIVE(llsc, lse, ARM64_HAS_LSE_ATOMICS)
 
 #endif	/* __ASSEMBLER__ */
-#else	/* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
+#else	/* AS_HAVE_LSE && CONFIG_ARM64_LSE_ATOMICS */
 
 #ifdef __ASSEMBLER__
 
@@ -50,5 +50,5 @@ __asm__(".arch_extension	lse");
 #define ARM64_LSE_ATOMIC_INSN(llsc, lse)	llsc
 
 #endif	/* __ASSEMBLER__ */
-#endif	/* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
+#endif	/* AS_HAVE_LSE && CONFIG_ARM64_LSE_ATOMICS */
 #endif	/* __ASM_LSE_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 811773d..45f875d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -750,7 +750,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.enable = cpu_enable_pan,
 	},
 #endif /* CONFIG_ARM64_PAN */
-#if defined(CONFIG_AS_LSE) && defined(CONFIG_ARM64_LSE_ATOMICS)
+#if defined(AS_HAVE_LSE) && defined(CONFIG_ARM64_LSE_ATOMICS)
 	{
 		.desc = "LSE atomic instructions",
 		.capability = ARM64_HAS_LSE_ATOMICS,
@@ -761,7 +761,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 2,
 	},
-#endif /* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
+#endif /* AS_HAVE_LSE && CONFIG_ARM64_LSE_ATOMICS */
 	{
 		.desc = "Software prefetching using PRFM",
 		.capability = ARM64_HAS_NO_HW_PREFETCH,
-- 
1.9.1
