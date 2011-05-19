From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 19 May 2011 09:35:58 +0900
Subject: [PATCH] ARM: SMP build fix for entry-macro-multi.S
Message-ID: <20110519003558.9353.56399.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The assembly code in entry-macro-multi.S does not build without
the include asm/assembler.h in the case of CONFIG_SMP=y.

Fixes the rather theoretical SMP build of mach-shmobile/entry-intc.c:

arch/arm/include/asm/entry-macro-multi.S: Assembler messages:
arch/arm/include/asm/entry-macro-multi.S:20: Error: bad instruction `alt_smp(test_for_ipi r0,r6,r5,lr)'
arch/arm/include/asm/entry-macro-multi.S:20: Error: bad instruction `alt_up_b(9997f)'
make[1]: *** [arch/arm/mach-shmobile/entry-intc.o] Error 1
make: *** [arch/arm/mach-shmobile] Error 2
make: *** Waiting for unfinished jobs....

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 This could also be fixed by adding the following line to entry-intc.c:
 #include <asm/assembler.h>
 But that would require all users of entry-macro-multi to do the same.

 arch/arm/include/asm/assembler.h         |    4 ++++
 arch/arm/include/asm/entry-macro-multi.S |    2 ++
 2 files changed, 6 insertions(+)

--- 0001/arch/arm/include/asm/assembler.h
+++ work/arch/arm/include/asm/assembler.h	2011-05-19 08:57:17.000000000 +0900
@@ -13,6 +13,9 @@
  *  Do not include any C declarations in this file - it is included by
  *  assembler source.
  */
+#ifndef __ASM_ASSEMBLER_H__
+#define __ASM_ASSEMBLER_H__
+
 #ifndef __ASSEMBLY__
 #error "Only include this from assembly code"
 #endif
@@ -290,3 +293,4 @@
 	.macro	ldrusr, reg, ptr, inc, cond=al, rept=1, abort=9001f
 	usracc	ldr, \reg, \ptr, \inc, \cond, \rept, \abort
 	.endm
+#endif /* __ASM_ASSEMBLER_H__ */
--- 0001/arch/arm/include/asm/entry-macro-multi.S
+++ work/arch/arm/include/asm/entry-macro-multi.S	2011-05-19 08:53:26.000000000 +0900
@@ -1,3 +1,5 @@
+#include <asm/assembler.h>
+
 /*
  * Interrupt handling.  Preserves r7, r8, r9
  */
