From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Feb 2016 11:01:20 +0100
Subject: [PATCH v2] ARM: move __kuser_cmpxchg{32,64} into .kprobes.text
Message-ID: <1455789689-2839463-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When kprobes is used, most of the entry-armv.S file is put into the .kprobes.text
section rather than .text, but the kuser_cmpxchg64_fixup and kuser_cmpxchg32_fixup
code is not, which can lead to a link error when extremely large kernels get
built (typically for randconfig):

arch/arm/kernel/built-in.o: In function `__dabt_usr':
:(.kprobes.text+0x47c): relocation truncated to fit: R_ARM_JUMP24 against `.text'
arch/arm/kernel/built-in.o: In function `__irq_usr':
:(.kprobes.text+0x4e4): relocation truncated to fit: R_ARM_JUMP24 against `.text'
arch/arm/kernel/built-in.o: In function `__fiq_usr':
:(.kprobes.text+0x740): relocation truncated to fit: R_ARM_JUMP24 against `.text'

This moves the two remaining functions into the same section as the rest
using a new macro suggested by Nicolas Pitre, which avoids the link error.

The current behavior has existed for many years and has not caused problems in
practice except for extreme randconfig builds, so the patch should not need to
get backported.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b49c0f24cf67 ("[ARM] 4659/1: remove possibilities for spurious false negative with __kuser_cmpxchg")
Fixes: 785d3cd286f0 ("ARM kprobes: prevent some functions involved with kprobes from being probed")
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/kernel/entry-armv.S | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index e2550500486d..3bc1a196cb53 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -83,11 +83,12 @@
 	.endm
 
 #ifdef CONFIG_KPROBES
-	.section	.kprobes.text,"ax",%progbits
+#define KPROBE_TEXT	.section .kprobes.text,"ax",%progbits
 #else
-	.text
+#define KPROBE_TEXT	.text
 #endif
 
+	KPROBE_TEXT
 /*
  * Invalid mode handlers
  */
@@ -895,7 +896,7 @@ __kuser_cmpxchg64:				@ 0xffff0f60
 	rsbs	r0, r3, #0			@ set return val and C flag
 	ldmfd	sp!, {r4, r5, r6, pc}
 
-	.text
+	KPROBE_TEXT
 kuser_cmpxchg64_fixup:
 	@ Called from kuser_cmpxchg_fixup.
 	@ r4 = address of interrupted insn (must be preserved).
@@ -953,7 +954,7 @@ __kuser_cmpxchg:				@ 0xffff0fc0
 	rsbs	r0, r3, #0			@ set return val and C flag
 	usr_ret	lr
 
-	.text
+	KPROBE_TEXT
 kuser_cmpxchg32_fixup:
 	@ Called from kuser_cmpxchg_check macro.
 	@ r4 = address of interrupted insn (must be preserved).
-- 
2.7.0
