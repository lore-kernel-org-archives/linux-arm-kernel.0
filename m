From: apinski@cavium.com (Andrew Pinski)
Date: Fri, 18 Dec 2015 20:17:35 -0800
Subject: [PATCH] ARM64: Fix compiling with GCC 6 and Atomics enabled
Message-ID: <1450498655-3820-1-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The problem here is that GCC 6 and above emits .arch now
for each function so now the global .arch_extension has
no effect.  This fixes the problem by putting
.arch_extension inside ARM64_LSE_ATOMIC_INSN so
it is enabled for each place where LSE is used.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/include/asm/lse.h |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
index 3de42d6..625601f 100644
--- a/arch/arm64/include/asm/lse.h
+++ b/arch/arm64/include/asm/lse.h
@@ -17,8 +17,6 @@
 
 #else	/* __ASSEMBLER__ */
 
-__asm__(".arch_extension	lse");
-
 /* Move the ll/sc atomics out-of-line */
 #define __LL_SC_INLINE
 #define __LL_SC_PREFIX(x)	__ll_sc_##x
@@ -29,7 +27,7 @@ __asm__(".arch_extension	lse");
 
 /* In-line patching at runtime */
 #define ARM64_LSE_ATOMIC_INSN(llsc, lse)				\
-	ALTERNATIVE(llsc, lse, ARM64_HAS_LSE_ATOMICS)
+	ALTERNATIVE(".arch_extension        lse\n" llsc, lse, ARM64_HAS_LSE_ATOMICS)
 
 #endif	/* __ASSEMBLER__ */
 #else	/* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
-- 
1.7.2.5
