From: Dave.Martin@arm.com (Dave Martin)
Date: Mon,  5 Aug 2013 13:42:53 +0100
Subject: [RFC PATCH] ARM: vectors: fix poison for BE8 endianness
Message-ID: <1375706573-7685-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Writing instructions using data accesses or .word will result in
the wrong instruction endianness on BE8.

This patch uses the opcodes.h macros to insert the poison
instruction instead.  This adapts correctly to all endianness
variants.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
Build+disassemble tested to check correct kuser instruction byte order
and correct code generation in early_trap_init().

Byte order for the injected instruction in the kuser helpers is LE
for LE, BE8 and BE for BE32.

Operand byte order in early_trap_init() is native for LE, BE32 and
swabbed for BE8.


In BE32, the Thumb view of the poison is transposed, reducing the
effective size of the poison by a halfword.


 arch/arm/kernel/entry-armv.S |    3 ++-
 arch/arm/kernel/traps.c      |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index d40d0ef..d457583 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -23,6 +23,7 @@
 #ifndef CONFIG_MULTI_IRQ_HANDLER
 #include <mach/entry-macro.S>
 #endif
+#include <asm/opcodes.h>
 #include <asm/thread_notify.h>
 #include <asm/unwind.h>
 #include <asm/unistd.h>
@@ -749,7 +750,7 @@ ENDPROC(__switch_to)
 	.endr
 	.endif
 	.rept	(\size - (. - \sym)) / 4
-	.word	0xe7fddef1
+	__inst_arm(0xe7fddef1)
 	.endr
 	.endm
 
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index ab517fc..dc49356 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -29,6 +29,7 @@
 #include <linux/atomic.h>
 #include <asm/cacheflush.h>
 #include <asm/exception.h>
+#include <asm/opcodes.h>
 #include <asm/unistd.h>
 #include <asm/traps.h>
 #include <asm/unwind.h>
@@ -836,7 +837,7 @@ void __init early_trap_init(void *vectors_base)
 	 * branch back to the undefined instruction.
 	 */
 	for (i = 0; i < PAGE_SIZE / sizeof(u32); i++)
-		((u32 *)vectors_base)[i] = 0xe7fddef1;
+		((u32 *)vectors_base)[i] = __opcode_to_mem_arm(0xe7fddef1);
 
 	/*
 	 * Copy the vectors, stubs and kuser helpers (in entry-armv.S)
-- 
1.7.9.5
