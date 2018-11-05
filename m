From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  5 Nov 2018 19:44:36 +0100
Subject: [PATCH 4/6] ARM: compressed: move BE32 handling into head.S
In-Reply-To: <20181105184438.19494-1-ard.biesheuvel@linaro.org>
References: <20181105184438.19494-1-ard.biesheuvel@linaro.org>
Message-ID: <20181105184438.19494-5-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BE switch only takes 3 instructions, and is currently pulled into
the main startup code by the linker, which is not the nicest way to
do this. Let's just pull the code into head.S and enable it using
preprocessor conditionals.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/boot/compressed/Makefile     |  8 --------
 arch/arm/boot/compressed/big-endian.S | 14 --------------
 arch/arm/boot/compressed/head.S       |  5 +++++
 3 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 01bf2585a0fa..d1862621556f 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -47,14 +47,6 @@ ifeq ($(CONFIG_PXA_SHARPSL_DETECT_MACH_ID),y)
 OBJS		+= head-sharpsl.o
 endif
 
-ifeq ($(CONFIG_CPU_ENDIAN_BE32),y)
-ifeq ($(CONFIG_CPU_CP15),y)
-OBJS		+= big-endian.o
-else
-# The endian should be set by h/w design.
-endif
-endif
-
 #
 # We now have a PIC decompressor implementation.  Decompressors running
 # from RAM should not define ZTEXTADDR.  Decompressors running directly
diff --git a/arch/arm/boot/compressed/big-endian.S b/arch/arm/boot/compressed/big-endian.S
deleted file mode 100644
index 88e2a88d324b..000000000000
--- a/arch/arm/boot/compressed/big-endian.S
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  linux/arch/arm/boot/compressed/big-endian.S
- *
- *  Switch CPU into big endian mode.
- *  Author: Nicolas Pitre
- */
-
-	.section ".start", #alloc, #execinstr
-
-	mrc	p15, 0, r0, c1, c0, 0	@ read control reg
-	orr	r0, r0, #(1 << 7)	@ enable big endian mode
-	mcr	p15, 0, r0, c1, c0, 0	@ write control reg
-
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index da93f419d1f4..55c227077207 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -222,6 +222,11 @@ not_angel:
 #ifdef CONFIG_CPU_XSCALE
 		bl	__XScale_start
 #endif
+#if defined(CONFIG_CPU_ENDIAN_BE32) && defined(CONFIG_CPU_CP15)
+		mrc	p15, 0, r0, c1, c0, 0	@ read control reg
+		orr	r0, r0, #(1 << 7)	@ enable big endian mode
+		mcr	p15, 0, r0, c1, c0, 0	@ write control reg
+#endif
 
 #ifdef CONFIG_AUTO_ZRELADDR
 		/*
-- 
2.19.1
