From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 27 Mar 2012 14:54:02 +0100
Subject: [PATCH v2 1/4] ARM: opcodes: Don't define the thumb32 byteswapping
 macros for BE32
In-Reply-To: <1332856445-7007-1-git-send-email-dave.martin@linaro.org>
References: <1332856445-7007-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1332856445-7007-2-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The existing __mem_to_opcode_thumb32() is incorrect for BE32
platforms.  However, these don't support Thumb-2 kernels, so this
option is not so relevant for those platforms anyway.

This operation is complicated by the lack of unaligned memory
access support prior to ARMv6.

Rather than provide a "working" macro which will probably won't get
used (or worse, will get misused), this patch removes the macro for
BE32 kernels.  People manipulating Thumb opcodes prior to ARMv6
should almost certainly be splitting these operations into
halfwords anyway, using __opcode_thumb32_{first,second,compose}()
and the 16-bit opcode transformations.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/opcodes.h |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
index 19c48de..6bf54f9 100644
--- a/arch/arm/include/asm/opcodes.h
+++ b/arch/arm/include/asm/opcodes.h
@@ -49,18 +49,31 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 #include <linux/swab.h>
 
 #ifdef CONFIG_CPU_ENDIAN_BE8
+
 #define __opcode_to_mem_arm(x) swab32(x)
 #define __opcode_to_mem_thumb16(x) swab16(x)
 #define __opcode_to_mem_thumb32(x) swahb32(x)
-#else
+
+#else /* ! CONFIG_CPU_ENDIAN_BE8 */
+
 #define __opcode_to_mem_arm(x) ((u32)(x))
 #define __opcode_to_mem_thumb16(x) ((u16)(x))
+#ifndef CONFIG_CPU_ENDIAN_BE32
+/*
+ * On BE32 systems, using 32-bit accesses to store Thumb instructions will not
+ * work in all cases, due to alignment constraints.  For now, a correct
+ * version is not provided for BE32.
+ */
 #define __opcode_to_mem_thumb32(x) swahw32(x)
 #endif
 
+#endif /* ! CONFIG_CPU_ENDIAN_BE8 */
+
 #define __mem_to_opcode_arm(x) __opcode_to_mem_arm(x)
 #define __mem_to_opcode_thumb16(x) __opcode_to_mem_thumb16(x)
+#ifndef CONFIG_CPU_ENDIAN_BE32
 #define __mem_to_opcode_thumb32(x) __opcode_to_mem_thumb32(x)
+#endif
 
 /* Operations specific to Thumb opcodes */
 
-- 
1.7.4.1
