From: rabin@rab.in (Rabin Vincent)
Date: Sun, 14 Feb 2010 01:18:32 +0530
Subject: [PATCH 04/10] ARM: ftrace: allow building without frame pointers
In-Reply-To: <1266090518-31120-1-git-send-email-rabin@rab.in>
References: <1266090518-31120-1-git-send-email-rabin@rab.in>
Message-ID: <1266090518-31120-5-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With a new enough GCC, ARM function tracing can be supported without the
need for frame pointers.  This is essential for Thumb-2 support, since
frame pointers aren't available then.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/Kconfig.debug         |    5 +++++
 arch/arm/kernel/armksyms.c     |    2 ++
 arch/arm/kernel/entry-common.S |    7 +++++++
 kernel/trace/Kconfig           |    2 +-
 4 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 5cb9326..5501253 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -27,6 +27,11 @@ config ARM_UNWIND
 	  the performance is not affected. Currently, this feature
 	  only works with EABI compilers. If unsure say Y.
 
+config OLD_MCOUNT
+	bool
+	depends on FUNCTION_TRACER && FRAME_POINTER
+	default y
+
 config DEBUG_USER
 	bool "Verbose user fault messages"
 	help
diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 8214bfe..e5e1e53 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -165,6 +165,8 @@ EXPORT_SYMBOL(_find_next_bit_be);
 #endif
 
 #ifdef CONFIG_FUNCTION_TRACER
+#ifdef CONFIG_OLD_MCOUNT
 EXPORT_SYMBOL(mcount);
+#endif
 EXPORT_SYMBOL(__gnu_mcount_nc);
 #endif
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index d412d7c..c98e3a3 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -169,6 +169,12 @@ gnu_trace:
 	ldmia	sp!, {r0-r3, ip, lr}
 	mov	pc, ip
 
+#ifdef CONFIG_OLD_MCOUNT
+/*
+ * This is under an ifdef in order to force link-time errors for people trying
+ * to build with !FRAME_POINTER with a GCC which doesn't use the new-style
+ * mcount.
+ */
 ENTRY(mcount)
 	stmdb	sp!, {r0-r3, lr}
 	ldr	r0, =ftrace_trace_function
@@ -187,6 +193,7 @@ trace:
 	mov	pc, r2
 	ldr	lr, [fp, #-4]			@ restore lr
 	ldmia	sp!, {r0-r3, pc}
+#endif
 
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 6c22d8a..7468ffe 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -126,7 +126,7 @@ if FTRACE
 config FUNCTION_TRACER
 	bool "Kernel Function Tracer"
 	depends on HAVE_FUNCTION_TRACER
-	select FRAME_POINTER
+	select FRAME_POINTER if (!ARM_UNWIND)
 	select KALLSYMS
 	select GENERIC_TRACER
 	select CONTEXT_SWITCH_TRACER
-- 
1.6.6
