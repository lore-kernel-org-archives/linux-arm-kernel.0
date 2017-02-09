From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Thu, 09 Feb 2017 12:18:50 +0000
Subject: [PATCH 4/4] ARM: kuser: split the kuser support for Thumb-capable and
 ARM-only
In-Reply-To: <20170209121756.GC27312@n2100.armlinux.org.uk>
References: <20170209121756.GC27312@n2100.armlinux.org.uk>
Message-ID: <E1cbngY-00026G-HA@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to build the kuser code differently for Thumb-capable CPUs vs
ARM-capable CPUs.  However, we do not want to require two different
kernel configurations to support this - we want to choose between the
two variants at run time.

In order to achieve this, we build the kuser.S code differently, and
choose to copy the appropriate version into the kuser page.

However, there is a twist - there are fixups within this code that are
needed for supporting some of the operations, and these end up
duplicated, which leads to a linker error.  Thankfully, the fixups
result in identical code, so we choose to drop one set of these.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/Makefile   | 10 +++++++++-
 arch/arm/kernel/kuser-t.S  | 13 ++++++++++++
 arch/arm/kernel/kuser-v4.S | 11 +++++++++++
 arch/arm/kernel/kuser.S    | 49 +++++++++++++++++++++++++---------------------
 arch/arm/kernel/traps.c    | 37 ++++++++++++++++++++++++++++++----
 5 files changed, 93 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm/kernel/kuser-t.S
 create mode 100644 arch/arm/kernel/kuser-v4.S

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index a7c21ce534e3..2f3683723157 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -30,7 +30,15 @@ else
 obj-y		+= entry-armv.o
 endif
 
-obj-$(CONFIG_KUSER_HELPERS)	+= kuser.o
+# Build non-Thumb variant for non-Thumb CPUs
+kuser-$(CONFIG_CPU_32v3)	+= kuser-v4.o
+kuser-$(CONFIG_CPU_32v4)	+= kuser-v4.o
+
+# Always build kuser-t for an arch that includes Thumb support
+AFLAGS_kuser-t.o		:= -march=armv7-a
+kuser-$(CONFIG_CPU_THUMB_CAPABLE) += kuser-t.o
+
+obj-$(CONFIG_KUSER_HELPERS)	+= $(kuser-y)
 
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_ISA_DMA_API)	+= dma.o
diff --git a/arch/arm/kernel/kuser-t.S b/arch/arm/kernel/kuser-t.S
new file mode 100644
index 000000000000..59eebf27a462
--- /dev/null
+++ b/arch/arm/kernel/kuser-t.S
@@ -0,0 +1,13 @@
+#include <asm/assembler.h>
+
+#if !(defined(CONFIG_CPU_32v3) || defined(CONFIG_CPU_32v4))
+#define GENERATE_FIXUPS
+#endif
+
+#define SYM(x) x##_thumb
+
+	.macro	usr_ret, reg
+	bx	\reg
+	.endm
+
+#include "kuser.S"
diff --git a/arch/arm/kernel/kuser-v4.S b/arch/arm/kernel/kuser-v4.S
new file mode 100644
index 000000000000..5a357fa33521
--- /dev/null
+++ b/arch/arm/kernel/kuser-v4.S
@@ -0,0 +1,11 @@
+#include <asm/assembler.h>
+
+#define GENERATE_FIXUPS
+
+#define SYM(x) x##_v4
+
+	.macro	usr_ret, reg
+	mov	pc, \reg
+	.endm
+
+#include "kuser.S"
diff --git a/arch/arm/kernel/kuser.S b/arch/arm/kernel/kuser.S
index d7081a4761fe..1b8d87776e1d 100644
--- a/arch/arm/kernel/kuser.S
+++ b/arch/arm/kernel/kuser.S
@@ -1,11 +1,19 @@
 #include <linux/init.h>
 
-#include <asm/assembler.h>
-
 #if defined(CONFIG_SMP) && !defined(CONFIG_CPU_32v6K)
 #error "incoherent kernel configuration"
 #endif
 
+#ifdef GENERATE_FIXUPS
+/*
+ * The .text section in this file is used for fixups of the various
+ * helpers.  Do not place anything else in the .text section within
+ * this file.
+ */
+	.globl kuser_cmpxchg64_fixup
+kuser_cmpxchg64_fixup:
+#endif
+
 	__INIT
 
 /*
@@ -20,14 +28,6 @@
  */
  THUMB(	.arm	)
 
-	.macro	usr_ret, reg
-#ifdef CONFIG_ARM_THUMB
-	bx	\reg
-#else
-	ret	\reg
-#endif
-	.endm
-
 	.macro	kuser_pad, sym, size
 	.if	(. - \sym) & 3
 	.rept	4 - (. - \sym) & 3
@@ -40,8 +40,8 @@
 	.endm
 
 	.align	5
-	.globl	__kuser_helper_start
-__kuser_helper_start:
+	.globl	SYM(__kuser_helper_start)
+SYM(__kuser_helper_start):
 
 /*
  * Due to the length of some sequences, __kuser_cmpxchg64 spans 2 regular
@@ -85,9 +85,8 @@ __kuser_cmpxchg64:				@ 0xffff0f60
 	rsbs	r0, r3, #0			@ set return val and C flag
 	ldmfd	sp!, {r4, r5, r6, pc}
 
+#ifdef GENERATE_FIXUPS
 	.text
-	.globl kuser_cmpxchg64_fixup
-kuser_cmpxchg64_fixup:
 	@ Called from kuser_cmpxchg_check macro.
 	@ r4 = address of interrupted insn (must be preserved).
 	@ sp = saved regs. r7 and r8 are clobbered.
@@ -98,11 +97,9 @@ __kuser_cmpxchg64:				@ 0xffff0f60
 	subs	r8, r4, r7
 	rsbcss	r8, r8, #(2b - 1b)
 	strcs	r7, [sp, #S_PC]
-#if __LINUX_ARM_ARCH__ < 6
-	bcc	kuser_cmpxchg32_fixup
-#endif
-	ret	lr
+	retcs	lr
 	.previous
+#endif
 
 #else
 #warning "NPTL on non MMU needs fixing"
@@ -151,6 +148,7 @@ __kuser_cmpxchg:				@ 0xffff0fc0
 	rsbs	r0, r3, #0			@ set return val and C flag
 	usr_ret	lr
 
+#ifdef GENERATE_FIXUPS
 	.text
 kuser_cmpxchg32_fixup:
 	@ Called from kuser_cmpxchg64_fixup above via kuser_cmpxchg_check macro.
@@ -163,8 +161,9 @@ __kuser_cmpxchg:				@ 0xffff0fc0
 	subs	r8, r4, r7
 	rsbcss	r8, r8, #(2b - 1b)
 	strcs	r7, [sp, #S_PC]
-	ret	lr
+	retcs	lr
 	.previous
+#endif
 
 #else
 #warning "NPTL on non MMU needs fixing"
@@ -185,7 +184,13 @@ __kuser_get_tls:				@ 0xffff0fe0
 	.endr				@ pad up to __kuser_helper_version
 
 __kuser_helper_version:				@ 0xffff0ffc
-	.word	((__kuser_helper_end - __kuser_helper_start) >> 5)
+	.word	((SYM(__kuser_helper_end) - SYM(__kuser_helper_start)) >> 5)
+
+	.globl	SYM(__kuser_helper_end)
+SYM(__kuser_helper_end):
 
-	.globl	__kuser_helper_end
-__kuser_helper_end:
+#ifdef GENERATE_FIXUPS
+	.text
+	/* Kuser fixups finishing instruction */
+	ret	lr
+#endif
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index ff2ae872d555..1a7aa28a0074 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -792,12 +792,41 @@ void __init trap_init(void)
 }
 
 #ifdef CONFIG_KUSER_HELPERS
-static void __init kuser_init(void *vectors)
+#ifdef CONFIG_CPU_THUMB_CAPABLE
+static void __init kuser_thumb_init(void *vectors)
+{
+	extern char __kuser_helper_start_thumb[], __kuser_helper_end_thumb[];
+	int kuser_sz = __kuser_helper_end_thumb - __kuser_helper_start_thumb;
+
+	memcpy(vectors + 0x1000 - kuser_sz, __kuser_helper_start_thumb,
+	       kuser_sz);
+}
+#else
+static void __init kuser_thumb_init(void *vectors)
+{
+}
+#endif
+
+#if defined(CONFIG_CPU_32v3) || defined(CONFIG_CPU_32v4)
+static void __init kuser_v4_init(void *vectors)
 {
-	extern char __kuser_helper_start[], __kuser_helper_end[];
-	int kuser_sz = __kuser_helper_end - __kuser_helper_start;
+	extern char __kuser_helper_start_v4[], __kuser_helper_end_v4[];
+	int kuser_sz = __kuser_helper_end_v4 - __kuser_helper_start_v4;
 
-	memcpy(vectors + 0x1000 - kuser_sz, __kuser_helper_start, kuser_sz);
+	memcpy(vectors + 0x1000 - kuser_sz, __kuser_helper_start_v4, kuser_sz);
+}
+#else
+static void __init kuser_v4_init(void *vectors)
+{
+}
+#endif
+
+static void __init kuser_init(void *vectors)
+{
+	if (!(elf_hwcap & HWCAP_THUMB))
+		kuser_v4_init(vectors);
+	else
+		kuser_thumb_init(vectors);
 
 	/*
 	 * vectors + 0xfe0 = __kuser_get_tls
-- 
2.7.4
