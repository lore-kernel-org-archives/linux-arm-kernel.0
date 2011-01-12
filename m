From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 11 Jan 2011 18:02:31 -0600
Subject: [PATCH 1/1] ARM: Thumb-2: Symbol manipulation macros for function
	body copying
In-Reply-To: <1294790551-17069-1-git-send-email-dave.martin@linaro.org>
References: <1294790551-17069-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1294790551-17069-2-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In low-level board support code, there is sometimes a need to
copy a function body to another location at run-time.

A straightforward call to memcpy doesn't work in Thumb-2,
because bit 0 of external Thumb function symbols is set to 1,
indicating that the function is Thumb.  Without corrective
measures, this will cause an off-by-one copy, and the copy
may be called using the wrong instruction set.

This patch adds macros to help with such cases.

Particular care is needed, because C doesn't guarantee any
defined behaviour when casting a function pointer to any other
type.  This has been observed to lead to strange optimisation
side-effects when doing the arithmetic which is required in
order to copy/move function bodies correctly in Thumb-2.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
KernelVersion: next-20110111

 arch/arm/include/asm/unified.h |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
index bc63116..636a765 100644
--- a/arch/arm/include/asm/unified.h
+++ b/arch/arm/include/asm/unified.h
@@ -24,6 +24,32 @@
 	.syntax unified
 #endif
 
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+#define __funcp_to_uint(funcp) ({				\
+		uintptr_t __result;				\
+								\
+		asm("" : "=r" (__result) : "0" (funcp));	\
+		__result;					\
+	})
+#define __uint_to_funcp(i, funcp) ({			\
+		typeof(funcp) __result;			\
+							\
+		asm("" : "=r" (__result) : "0" (i));	\
+		__result;				\
+	})
+#define FSYM_REBASE(funcp, dest_buf)					\
+	__uint_to_funcp((uintptr_t)(dest_buf) | FSYM_TYPE(funcp), funcp)
+
+#ifdef CONFIG_THUMB2_KERNEL
+#define FSYM_BASE(funcp) ((void *)(__funcp_to_uint(funcp) & ~(uintptr_t)1))
+#define FSYM_TYPE(funcp) (__funcp_to_uint(funcp) & 1)
+#else /* !CONFIG_THUMB2_KERNEL */
+#define FSYM_BASE(funcp) ((void *)__funcp_to_uint(funcp))
+#define FSYM_TYPE(funcp) 0
+#endif /* !CONFIG_THUMB2_KERNEL */
+#endif /* !__ASSEMBLY__ */
+
 #ifdef CONFIG_THUMB2_KERNEL
 
 #if __GNUC__ < 4
-- 
1.7.1
