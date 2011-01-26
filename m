From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 26 Jan 2011 16:05:33 +0000
Subject: [PATCH v4] ARM: Thumb-2: Symbol manipulation macros for function
	body copying
In-Reply-To: <20110117160136.GA25829@n2100.arm.linux.org.uk>
References: <1295039877-7976-1-git-send-email-dave.martin@linaro.org>
	<AANLkTintFe4V6BxrUxh-gwvhoa=RcH0tkHjYbfyGHKD=@mail.gmail.com>
	<20110117160136.GA25829@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimZGvsEEnLqYoNkZ1L0Rw+5K5O2Gsc0x-5Lj-dx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I tried to send this patch to your patch system, but I've received no
response or any bounce.  On my end the mail appears to have been sent,
and previous submissions made via the same route have succeeded.

The patch doesn't seem to be in the patch system, but I'm not sure
what went wrong ... hopefully I'm not doing anything stupid.

Do you have any ideas what might have gone wrong?

Cheers
---Dave

---------- Forwarded message ----------
From: Dave Martin <dave.martin@linaro.org>
Date: Wed, Jan 26, 2011 at 11:57 AM
Subject: [PATCH v4] ARM: Thumb-2: Symbol manipulation macros for
function body copying
To: patches at arm.linux.org.uk
Cc: Dave Martin <dave.martin@linaro.org>


In low-level board support code, there is sometimes a need to
copy a function body to another location at run-time.

A straightforward call to memcpy doesn't work in Thumb-2,
because bit 0 of external Thumb function symbols is set to 1,
indicating that the function is Thumb.  Without corrective
measures, this will cause an off-by-one copy, and the copy
may be called using the wrong instruction set.

This patch adds an fncpy() macro to help with such copies.

Particular care is needed, because C doesn't guarantee any
defined behaviour when casting a function pointer to any other
type.  This has been observed to lead to strange optimisation
side-effects when doing the arithmetic which is required in
order to copy/move function bodies correctly in Thumb-2.

Thanks to Russell King and Nicolas Pitre for their input
on this patch.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Tested-by: Jean Pihet <j-pihet@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Kevin Hilman <khilman@ti.com>
--
KernelVersion: 2.6.37

diff --git a/arch/arm/include/asm/fncpy.h b/arch/arm/include/asm/fncpy.h
new file mode 100644
index 0000000..8b94b5f
--- /dev/null
+++ b/arch/arm/include/asm/fncpy.h
@@ -0,0 +1,96 @@
+/*
+ * arch/arm/include/asm/fncpy.h - helper macros for function body copying
+ *
+ * Copyright (C) 2011 Linaro Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+/*
+ * These macros are intended for use when there is a need to copy a low-level
+ * function body into special memory.
+ *
+ * For example, when reconfiguring the SDRAM controller, the code doing the
+ * reconfiguration may need to run from SRAM.
+ *
+ * NOTE: that the copied function body must be entirely self-contained and
+ * position-independent in order for this to work properly.
+ *
+ * NOTE: in order for embedded literals and data to get referenced correctly,
+ * the alignment of functions must be preserved when copying.  To ensure this,
+ * the source and destination addresses for fncpy() must be aligned to a
+ * multiple of 8 bytes: you will be get a BUG() if this condition is not met.
+ * You will typically need a ".align 3" directive in the assembler where the
+ * function to be copied is defined, and ensure that your allocator for the
+ * destination buffer returns 8-byte-aligned pointers.
+ *
+ * Typical usage example:
+ *
+ * extern int f(args);
+ * extern uint32_t size_of_f;
+ * int (*copied_f)(args);
+ * void *sram_buffer;
+ *
+ * copied_f = fncpy(sram_buffer, &f, size_of_f);
+ *
+ * ... later, call the function: ...
+ *
+ * copied_f(args);
+ *
+ * The size of the function to be copied can't be determined from C:
+ * this must be determined by other means, such as adding assmbler directives
+ * in the file where f is defined.
+ */
+
+#ifndef __ASM_FNCPY_H
+#define __ASM_FNCPY_H
+
+#include <linux/types.h>
+#include <linux/string.h>
+
+#include <asm/bug.h>
+#include <asm/cacheflush.h>
+
+/*
+ * Minimum alignment requirement for the source and destination addresses
+ * for function copying.
+ */
+#define FNCPY_ALIGN 8
+
+#define fncpy(dest_buf, funcp, size) ({
         \
+       uintptr_t __funcp_address;                                      \
+       typeof(funcp) __result;                                         \
+                                                                       \
+       asm("" : "=r" (__funcp_address) : "0" (funcp));                 \
+                                                                       \
+       /*                                                              \
+        * Ensure alignment of source and destination addresses,        \
+        * disregarding the function's Thumb bit:                       \
+        */                                                             \
+       BUG_ON((uintptr_t)(dest_buf) & (FNCPY_ALIGN - 1) ||             \
+               (__funcp_address & ~(uintptr_t)1 & (FNCPY_ALIGN - 1))); \
+                                                                       \
+       memcpy(dest_buf, (void const *)(__funcp_address & ~1), size);   \
+       flush_icache_range((unsigned long)(dest_buf),                   \
+               (unsigned long)(dest_buf) + (size));                    \
+                                                                       \
+       asm("" : "=r" (__result)                                        \
+               : "0" ((uintptr_t)(dest_buf) | (__funcp_address & 1))); \
+                                                                       \
+       __result;                                                       \
+})
+
+#endif /* !__ASM_FNCPY_H */
--
1.7.1
