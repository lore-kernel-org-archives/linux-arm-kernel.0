From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Nov 2011 18:04:56 +0000
Subject: [PATCH] ARM: unwind: add unwind directives to bitops assembly macros
Message-ID: <1321553096-11859-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bitops functions (e.g. _test_and_set_bit) on ARM do not have unwind
annotations and therefore the kernel cannot backtrace out of them on a
fatal error (for example, NULL pointer dereference).

This patch annotates the bitops assembly macros with UNWIND annotations
so that we can produce a meaningful backtrace on error.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/lib/bitops.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index 10d868a..640ce58 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -1,5 +1,8 @@
+#include <asm/unwind.h>
+
 #if __LINUX_ARM_ARCH__ >= 6
 	.macro	bitop, instr
+UNWIND(	.fnstart	)
 	ands	ip, r1, #3
 	strneb	r1, [ip]		@ assert word-aligned
 	mov	r2, #1
@@ -13,9 +16,11 @@
 	cmp	r0, #0
 	bne	1b
 	bx	lr
+UNWIND(	.fnend		)
 	.endm
 
 	.macro	testop, instr, store
+UNWIND(	.fnstart	)
 	ands	ip, r1, #3
 	strneb	r1, [ip]		@ assert word-aligned
 	mov	r2, #1
@@ -34,9 +39,11 @@
 	cmp	r0, #0
 	movne	r0, #1
 2:	bx	lr
+UNWIND(	.fnend		)
 	.endm
 #else
 	.macro	bitop, instr
+UNWIND(	.fnstart	)
 	ands	ip, r1, #3
 	strneb	r1, [ip]		@ assert word-aligned
 	and	r2, r0, #31
@@ -49,6 +56,7 @@
 	str	r2, [r1, r0, lsl #2]
 	restore_irqs ip
 	mov	pc, lr
+UNWIND(	.fnend		)
 	.endm
 
 /**
@@ -60,6 +68,7 @@
  * to avoid dirtying the data cache.
  */
 	.macro	testop, instr, store
+UNWIND(	.fnstart	)
 	ands	ip, r1, #3
 	strneb	r1, [ip]		@ assert word-aligned
 	and	r3, r0, #31
@@ -73,5 +82,6 @@
 	moveq	r0, #0
 	restore_irqs ip
 	mov	pc, lr
+UNWIND(	.fnend		)
 	.endm
 #endif
-- 
1.7.4.1
