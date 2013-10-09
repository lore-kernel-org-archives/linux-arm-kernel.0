From: Dave.Martin@arm.com (Dave Martin)
Date: Wed,  9 Oct 2013 15:29:50 +0100
Subject: [RFC PATCH 1/4] ARM: Allow assembler.h to be used with inline asm
In-Reply-To: <1381328993-12724-1-git-send-email-Dave.Martin@arm.com>
References: <1381328993-12724-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1381328993-12724-2-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a few things in assembler.h that would be useful with
inline asm, but currently assembler.h refuses to be included into C
files.

In particular, the optional feature macros (PLD() and friends) can
be used sensibly with inline asm, with a string argument.

This patch enables the relevant parts of aassembler.h to be
included in C files and used in inline asm.

Since assembler.h by definition can't be included in any C file up
to now, this should not introduce any namespace clashes.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm/include/asm/assembler.h |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index fcc1b5b..a71d117 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -16,14 +16,12 @@
 #ifndef __ASM_ASSEMBLER_H__
 #define __ASM_ASSEMBLER_H__
 
-#ifndef __ASSEMBLY__
-#error "Only include this from assembly code"
-#endif
-
 #include <asm/ptrace.h>
 #include <asm/domain.h>
 #include <asm/opcodes-virt.h>
 
+#ifdef __ASSEMBLY__
+
 #define IOMEM(x)	(x)
 
 /*
@@ -53,6 +51,8 @@
 #define put_byte_3      lsl #0
 #endif
 
+#endif /* __ASSEMBLY__ */
+
 /*
  * Data preload for architectures that support it
  */
@@ -77,6 +77,8 @@
 #define CALGN(code...)
 #endif
 
+#ifdef __ASSEMBLY__
+
 /*
  * Enable and disable interrupts
  */
@@ -376,4 +378,6 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 #endif
 	.endm
 
+#endif /* __ASSEMBLY__ */
+
 #endif /* __ASM_ASSEMBLER_H__ */
-- 
1.7.9.5
